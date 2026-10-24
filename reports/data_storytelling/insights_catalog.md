# RetailSalesAnalytics — Insights Catalog

**Phase:** 05 — Data Storytelling  
**Document:** Insights Catalog  
**Version:** 0.2 — Sales KPI evidence review  
**Status:** In progress — sales KPI arithmetic cross-checked; source and Power BI model verification outstanding  

> هذا الملف مرجع لحصر النتائج وتقييم صلاحيتها للسرد القصصي. في تحديث v0.2 قُدمت أدلة موثقة من المستخدم للمؤشرات السبعة، وتم التحقق حسابيًا من العلاقات القابلة لإعادة الحساب بينها. لم تُفحص ملفات CSV أو Notebook الأصلية مباشرة في بيئة هذه المراجعة، ولم تُحسم مطابقة مقاييس DAX في نموذج Power BI.

## 1. Business Question — السؤال التجاري

**كيف كان أداء مبيعات المتجر خلال الفترة المدروسة، وما الأنماط المرتبطة بهذا الأداء، وأين توجد فرص التحسين المدعومة بالبيانات؟**

### هدف السرد
تحويل نتائج SQL وPython وPower BI إلى رسائل تنفيذية واضحة، تميز بين ما تثبته البيانات وما يحتاج تحليلًا إضافيًا، وتربط النتائج بقرارات تجارية قابلة للدراسة.

## 2. Insights Categories — محاور النتائج

| ID Prefix | المحور | Power BI Page | أمثلة على الأسئلة |
|---|---|---|---|
| SAL | أداء المبيعات | Executive Overview | ما مستوى الإيرادات؟ وكيف تغير عبر الزمن؟ |
| PRD | المنتجات | Product Analysis | ما المنتجات والفئات الأعلى والأقل مساهمة؟ |
| CUS | العملاء | Customer Analysis | كيف يختلف الأداء بين شرائح العملاء والمناطق؟ |
| ORD | الطلبات | Order Analysis | ما أنماط حالة الطلب وطريقة الدفع والشحن؟ |
| STA | الاختبارات الإحصائية | Python — Statistics | ما النتائج ذات الدلالة، وما حدود تفسيرها؟ |

## 3. Findings Register — سجل النتائج

### 3.1 Sales KPI evidence — مراجعة مؤشرات المبيعات (Step 1.2)

**قواعد الحساب حسب التقرير الوارد:** `OrderStatus == "Completed"`، ربط داخلي `inner join` بين `Orders_clean.csv` و`OrderItems_clean.csv` على `OrderID`، وحساب `SalesAmount = Quantity × UnitPrice × (1 − DiscountPercent / 100)` دون تقريب البنود قبل التجميع. الفترة: العامان 2024 و2025 كاملان، دون مرشحات للمنطقة أو فئة المنتج. **لم يُثبت رمز العملة في الأدلة المقدمة.**

| ID | Metric | Exact verified/reported value | Display value | Evidence | Status |
|---|---|---:|---:|---|---|
| SAL-01 | Total Revenue | 25,746,272.0155 | 25,746,272.02 | `03_eda.ipynb` خلايا 14–21؛ مجموع إيرادات العامين | Arithmetic Cross-Checked / Source Reported |
| SAL-02 | Completed Orders | 4,038 | 4,038 | `03_eda.ipynb` خلايا 10 و14؛ `nunique(OrderID)` | Source Reported |
| SAL-03 | Average Order Value | 6,375.996041480931 | 6,376.00 | `03_eda.ipynb` خلايا 23–24، `04_statistics.ipynb` خلايا 9–11؛ `Revenue / 4,038` | Arithmetic Cross-Checked / Source Reported |
| SAL-04 | Growth Rate (2025 vs 2024) | 0.13640161045% | +0.14% | `03_eda.ipynb` خلية 36؛ `(2025−2024)/2024×100` | Arithmetic Cross-Checked / Source Reported |
| SAL-05 | Total Quantity Sold | 20,367 | 20,367 | `03_eda.ipynb` خلية 26؛ `sum(Quantity)` | Source Reported |
| SAL-06 | Total Sales for 2024 | 12,864,362.4090 | 12,864,362.41 | `03_eda.ipynb` خلايا 35–36 | Source Reported |
| SAL-07 | Total Sales for 2025 | 12,881,909.6065 | 12,881,909.61 | `03_eda.ipynb` خلايا 35–36 | Source Reported |

**ملفات البيانات المذكورة كمصادر:** `data/processed/Orders_clean.csv` و`data/processed/OrderItems_clean.csv`. جميع الإحالات إلى الخلايا تبدأ من 1 وتشمل خلايا Markdown بحسب التقرير الوارد.

**Checks:**
- `12,864,362.4090 + 12,881,909.6065 = 25,746,272.0155` ✓
- `25,746,272.0155 / 4,038 = 6,375.996041480931...` ✓
- `12,881,909.6065 − 12,864,362.4090 = 17,547.1975` ✓
- `(17,547.1975 / 12,864,362.4090) × 100 = 0.13640161045...%` ✓

**Power BI alignment:** ملخص `powerbi/README.md` متسق من حيث التقريب مع المؤشرات الأربعة الأولى، بحسب التقرير الوارد. لكن فحص مخرجات DAX المحسوبة أو صيغ المقاييس داخل نموذج `.pbix` لم يكتمل؛ لذلك `Power BI Model Match = Pending` للمؤشرات السبعة، ولا نعد التوافق الحسابي إثباتًا لهذه المطابقة.

**Interpretation candidate — not yet approved as main insight:** إيرادات 2025 أعلى من 2024 بنسبة طفيفة (+0.14%)؛ وهذه ملاحظة عن تغير الإيرادات وليست تفسيرًا سببيًا للنمو أو حكمًا على الربحية. لم يُعتمد تصنيف Main/Supporting بعد.

### 3.2 Statistical findings — نتائج إحصائية لم تُراجع بعد

| ID | النتيجة المبدئية كما وردت | المحور | المصدر المطلوب للتحقق | الحالة |
|---|---|---|---|---|
| STA-01 | Order Value: Right-Skewed؛ Skewness = 1.559 | STA | Notebook الإحصاء، تعريف المتغير والعينة | Pending Verification |
| STA-02 | Corr(UnitPrice, SalesAmount) ≈ 0.763 | STA | Notebook الإحصاء ومستوى التحليل/التجميع | Pending Verification |
| STA-03 | Corr(Quantity, SalesAmount) ≈ 0.460 | STA | Notebook الإحصاء ومستوى التحليل/التجميع | Pending Verification |
| STA-04 | ANOVA: فروق ذات دلالة بين Customer Segments | STA | فرضيات الاختبار والقيم الإحصائية وحجم العينة | Pending Verification |
| STA-05 | Tukey HSD: الفرق الدال بين Corporate وRegular | STA | مخرجات المقارنات المتعددة ومستوى الدلالة | Pending Verification |
| STA-06 | Chi-Square: لا توجد دلالة إحصائية بين PaymentMethod وOrderStatus | STA | جدول التوافق ومخرجات الاختبار وافتراضاته | Pending Verification |

### 3.3 Additional analyses awaiting concrete findings

- Monthly Sales Trend
- Sales by Category
- Top / Bottom Products
- Top Customers
- Customer Segments
- Cities and Regions
- Payment Methods
- Shipping Methods
- Order Status

## 4. Insight Record Template — نموذج توثيق كل نتيجة

انسخ النموذج لكل نتيجة مرشحة بعد مراجعة مصدرها:

```text
Insight ID:
Business Question:
Finding (what was observed):
Metric / Calculation Definition:
Period / Population / Filters:
Evidence (numbers, test or figure):
Source File / Notebook / Power BI Page:
Business Meaning (supported interpretation):
Limits / Alternative Explanations:
Potential Business Impact (qualitative or quantified with assumptions):
Recommended Next Action (if supported):
Storytelling Priority: Main / Supporting / Appendix / Exclude
Verification Status: Pending Verification / Verified / Needs Revision
```

## 5. Selection Criteria — معايير اختيار النتائج

قيّم كل نتيجة بعد التحقق منها وفق المحاور التالية، من 1 (منخفض) إلى 3 (مرتفع):

| المعيار | السؤال |
|---|---|
| Business Relevance | هل ترتبط بسؤال أو قرار تجاري مهم؟ |
| Evidence Strength | هل القياس واضح والدليل موثوق وحدود الاستنتاج معروفة؟ |
| Decision Usefulness | هل تساعد في اتخاذ إجراء أو تحديد تحقيق لاحق؟ |
| Clarity | هل يمكن إيصال معناها بوضوح لصاحب القرار؟ |

**ملاحظة:** المجموع أداة مساعدة للفرز، وليس قاعدة آلية لقبول النتائج. صحة الدليل شرط مستقل لا يعوضه ارتفاع النقاط الأخرى.

### Storytelling Priority

- **Main:** رسالة رئيسية تخدم السؤال التجاري ومدعومة بأدلة كافية.
- **Supporting:** نتيجة تدعم الرسالة أو تشرح تفاصيلها.
- **Appendix:** تفاصيل فنية أو إحصائية مهمة للشفافية وليست محور العرض التنفيذي.
- **Exclude:** لا تضيف قيمة للقرار، أو تكرر غيرها، أو يضعف دليلها؛ مع الاحتفاظ بها في سجل التحليل عند الحاجة.

### Verification Status

- **Pending Verification:** نتيجة مذكورة ولم يُراجع مصدرها الأصلي.
- **Source Reported:** أرسل صاحب المشروع قيمتها وتعريفها ومصدرها، دون فحص المصدر مباشرة في هذه المراجعة.
- **Arithmetic Cross-Checked / Source Reported:** أُعيد حساب العلاقات الرقمية بنجاح من الأرقام الواردة، لكن لم يُفحص ملف المصدر مباشرة.
- **Power BI Model Match = Pending:** لم تُراجع قيم المقاييس المحسوبة وDAX من النموذج نفسه.
- **Verified:** تمت مطابقة القيمة/الاستنتاج مع المصدر وتعريف المقياس والنطاق.
- **Needs Revision:** توجد فجوة أو اختلاف يحتاج تصحيحًا قبل الاستخدام.

## 6. Evidence Rules — ضوابط الدقة

1. لا نستخدم قيمًا تقديرية أو وهمية لملء الفراغات.
2. لا نستنتج علاقة سببية من ارتباط إحصائي وحده.
3. عدم وجود دلالة إحصائية لا يساوي إثبات انعدام العلاقة.
4. الاختلافات الإحصائية لا تعني بالضرورة أهمية تجارية عملية؛ تُراجع الأحجام والأثر.
5. لا نقدّم أثرًا ماليًا كميًا دون طريقة حساب واضحة وافتراضات معلنة.
6. تُذكر الفترة ونطاق البيانات والفلاتر وتعريف المؤشرات عند اعتماد النتائج.
7. يجب أن يمكن تتبع كل رسم أو رسالة تنفيذية إلى دليل موثق في المشروع.

## 7. Next Step — الخطوة التالية

**Step 1.2 — Evidence Verification & Insight Selection**

استُلمت أدلة المؤشرات السبعة (`SAL-01` إلى `SAL-07`) وتمت مراجعة اتساقها الحسابي. الخطوة التالية: فحص مصدر Python مباشرة عند توفره، أو اعتماد تقرير التحقق بوصفه دليلًا منقولًا مع بيان مستواه؛ ثم مراجعة الرسوم الفعلية للاتجاه الشهري والفئات والمنتجات لمعرفة إن كانت تقدم تفسيرًا أو سياقًا للنمو المحدود. لا نعتمد تصنيف Main/Supporting ولا توصية سببية قبل أدلتها.

### Insight — Monthly Sales Variation

**Business Question:** هل يعكس النمو السنوي المحدود استقرارًا في الأداء الشهري؟

**Finding:** بلغ نمو المبيعات من 2024 إلى 2025 نحو 0.14%، رغم وجود تباينات شهرية واضحة. ارتفعت المبيعات في 5 أشهر وانخفضت في 7 أشهر مقارنة بالأشهر المناظرة من العام السابق.

**Evidence:**
- Largest Monthly YoY Increase: August, +218,012.5425 (+19.033096%).
- Largest Monthly YoY Decrease: January, -272,891.7690 (-22.268973%).
- Sum of Positive Monthly Changes: +705,679.9220.
- Sum of Negative Monthly Changes: -688,132.7245.
- Net Annual Change: +17,547.1975 (+0.13640161045%).

**Business Meaning:** النمو السنوي شبه المستقر يخفي اختلافات ملحوظة بين الأشهر، مما يستدعي مراجعة الاتجاهات الشهرية وعدم الاكتفاء بالمؤشر السنوي.

**Recommendation:** متابعة التغيرات الشهرية المقارنة سنويًا، وفحص أداء المنتجات والعملاء والمناطق في الأشهر الأعلى تغيرًا قبل تفسير الأسباب أو اقتراح تدخلات محددة.

**Source:** data/processed/Orders_clean.csv; data/processed/OrderItems_clean.csv; python/notebooks/03_eda.ipynb (cells 28–32).

**Business Rules:** Completed orders only; inner join on OrderID; discounted SalesAmount; full years 2024 and 2025; no additional filters.

**Verification Status:** Verified against reported cleaned-data recalculation and annual reconciliation. Direct Power BI measure reconciliation pending.

**Storytelling Decision:** Candidate — Main Insight.

**Limitations:** Descriptive comparison only; no established causal explanation or recurring seasonality.



### Insight — Category Revenue Contribution

**Business Question:** How did product categories contribute to revenue and annual sales growth?

**Finding:** Revenue was concentrated in Electronics and Furniture, while Office Supplies contributed the largest positive annual revenue change.

**Evidence:**
- Electronics: 14,338,623.7300 (55.692039% of two-year revenue).
- Furniture: 6,641,137.8000 (25.794561%).
- Office Supplies: 2,645,545.5900 (10.275451%).
- Accessories: 2,120,964.8955 (8.237950%).
- Electronics + Furniture: 81.486600% approximately.
- Office Supplies annual change: +32,921.9910 (+2.520225%).
- Electronics annual change: -11,588.2900 (-0.161507%).
- Furniture annual change: +2,450.6740 (+0.073830%).
- Accessories annual change: -6,237.1775 (-0.586421%).
- Total positive category changes: +35,372.6650.
- Total negative category changes: -17,825.4675.
- Net annual change: +17,547.1975.

**Business Meaning:** The highest-revenue category was not the main positive growth contributor. Positive changes in two categories offset negative changes in the other two.

**Recommendation:** Examine product-level quantities, unit prices, discounts, and revenue trends within each category before deciding on commercial interventions.

**Source:** data/processed/Orders_clean.csv; data/processed/OrderItems_clean.csv; data/processed/Products_clean.csv; python/notebooks/03_eda.ipynb (cells 40, 42, 43).

**Business Rules:** Completed orders only; joins on OrderID and ProductID; OrderItems.UnitPrice; discounted SalesAmount without line-level rounding; full calendar years 2024 and 2025.

**Verification Status:** Verified against reported cleaned-data recalculation and reconciled annual totals; independent source-file inspection and direct Power BI DAX reconciliation pending.

**Storytelling Decision:** Candidate — Main Insight.

**Limitations:** Revenue analysis only; no established causes, margins, profitability, or historical category changes. SQL view may differ due to early line-item rounding.


### Insight — Product Revenue Performance

**Business Question:** How do individual products contribute to revenue and annual sales changes?

**Finding:** Product-level revenue performance varied substantially despite near-flat overall annual revenue growth. All 100 products recorded completed-order sales in both years; 51 increased and 49 decreased in annual revenue.

**Evidence:**
- Unique products: 100.
- Top 10 products' share of total revenue: 32.740485%.
- Top 5 products' share: 17.423325%.
- All Top 10 products by two-year revenue belong to Electronics.
- Top product by revenue: موجه شبكة (ProductID 21), 1,009,145.2250.
- Largest positive annual product change: موجه شبكة, +276,121.9450 (+75.337838%).
- Largest negative annual product change: شاشة 24 بوصة (ProductID 7), -107,082.0740 (-23.309288%).
- Net annual revenue change across all products: +17,547.1975.
- Net annual change across products other than ProductID 21: -258,574.7475.
- Products with rising revenue: 51; falling revenue: 49; unchanged: 0.

**Business Meaning:** Aggregate annual revenue growth conceals substantial variation at the product level. High-revenue products do not necessarily generate positive year-over-year growth.

**Recommendation:** Examine product-level quantities, prices, discounts, and revenue trends for products with the largest increases and decreases. Review profitability and operational factors before making resource-allocation decisions.

**Source:** data/processed/Orders_clean.csv; data/processed/OrderItems_clean.csv; data/processed/Products_clean.csv; python/notebooks/03_eda.ipynb (cells 45–48); sql/07_product_analysis.sql.

**Business Rules:** Completed orders; joins on OrderID and ProductID; discounted SalesAmount based on OrderItems.UnitPrice; no rounding before aggregation; 2024 and 2025.

**Verification Status:** Reported cleaned-data recalculation reconciles all four control totals. Independent source-file inspection and direct Power BI DAX reconciliation pending.

**Storytelling Decision:** Candidate — Main Insight.

**Limitations:** Revenue is not profit. Revenue changes alone do not establish changes in demand or their causes. SQL bottom-profit ranking must not be confused with bottom-revenue ranking.


### Insight — Customer Segment Performance

**Business Question:** How do customer segments differ in revenue contribution, average order value, and annual revenue growth?

**Finding:** Regular generated the highest total revenue, Corporate had the highest average order value, and Premium was the only segment with positive annual revenue growth.

**Evidence:**
- Total customers: 995.
- Customers with completed orders: 979.
- Completed orders: 4,038.
- Top 10 customers' revenue share: 3.465613%.
- Regular: revenue 16,992,263.1730; share 65.998927%; orders 2,704; AOV 6,284.120996.
- Premium: revenue 6,325,961.3015; share 24.570397%; orders 992; AOV 6,376.977118.
- Corporate: revenue 2,428,047.5410; share 9.430676%; orders 342; AOV 7,099.554213.
- Corporate annual revenue change: -67,156.8430 (-5.382873%).
- Premium annual revenue change: +207,735.0155 (+6.790694%).
- Regular annual revenue change: -123,030.9750 (-1.437673%).
- Net annual revenue change: +17,547.1975.

**Business Meaning:** Revenue contribution, order value, and annual growth tell different stories about customer segments. Premium's positive annual change offset the combined negative changes in Corporate and Regular.

**Recommendation:** Monitor revenue, completed-order counts, and AOV separately by segment; investigate the product mix, quantities, discounts, and purchasing patterns underlying the observed differences before recommending interventions.

**Statistical Evidence — Preliminary:**
- Corrected order-level ANOVA: F = 3.2093667204; p = 0.0404852831.
- Tukey Corporate vs Regular: adjusted p = 0.0304; Corporate mean order value higher by approximately 815.4332.
- Other Tukey pairwise comparisons were not significant at alpha = 0.05.
- Statistical inference is pending assumption and repeated-customer dependence review.

**Source:** data/processed/Orders_clean.csv; data/processed/OrderItems_clean.csv; data/processed/Customers_clean.csv; python/notebooks/03_eda.ipynb (cells 50, 52, 54); python/notebooks/04_statistics.ipynb (cells 29–35).

**Business Rules:** Completed orders only; joins on OrderID and CustomerID; discounted SalesAmount with no pre-aggregation rounding; 2024 and 2025. AOV calculated at order level. Active buyer means customer with at least one completed order, not Customers.IsActive.

**Verification Status:** Reconciled to the reported cleaned-data recalculation and saved Python results. ANOVA/Tukey calculations replicated; inferential assumptions not established. Direct Power BI DAX reconciliation pending.

**Storytelling Decision:** Candidate — Main Insight (descriptive findings). Statistical significance claim pending methodological review.

**Limitations:** No established causal relationships or profitability conclusions. Repeated orders within the same customer may violate independence assumptions. Two-year aggregate segment labels do not establish customer migration between segments.


### Insight — Order Status Performance

**Business Question:** How did order completion, cancellation, and return rates change between 2024 and 2025?

**Finding:** Completed-order count remained unchanged at 2,019 orders per year, while cancellation and return rates increased in 2025.

**Evidence:**
- Total unique orders: 5,000.
- Completed: 4,038 (80.76%).
- Cancelled: 363 (7.26%).
- Returned: 323 (6.46%).
- Pending: 276 (5.52%).
- 2024 total orders: 2,489; completed: 2,019; cancelled: 171; returned: 145.
- 2025 total orders: 2,511; completed: 2,019; cancelled: 192; returned: 178.
- Cancellation rate: 6.870229% (2024) to 7.646356% (2025), +0.776127 percentage points.
- Return rate: 5.825633% (2024) to 7.088809% (2025), +1.263176 percentage points.
- Completion rate: 81.116914% (2024) to 80.406213% (2025), -0.710701 percentage points.

**Business Meaning:** The distribution of order statuses changed despite a constant completed-order count. Higher cancellation and return rates warrant further operational investigation.

**Recommendation:** Monitor annual and monthly cancellation and return rates, and collect reason codes and status-change timestamps to support diagnosis before implementing interventions.

**Supporting Findings:**
- Payment methods were distributed approximately evenly across all orders.
- Delivery accounted for 70.06% of all orders.
- Pearson Chi-Square (PaymentMethod x OrderStatus): chi-square = 11.1242406385; p = 0.2672889524; df = 9.
- Uncorrected Cramer's V = 0.0272326283.
- Chi-Square inference remains qualified due to potentially dependent orders from repeat customers.

**Source:** data/processed/Orders_clean.csv; data/processed/OrderItems_clean.csv; python/notebooks/03_eda.ipynb (cells 10, 12, 63–68); python/notebooks/04_statistics.ipynb (cells 37, 39–40).

**Business Rules:** Order-status, payment, and shipping rates use all 5,000 unique orders. Revenue uses Completed orders only, with discounted item-level SalesAmount and no rounding before aggregation. Annual comparison uses OrderDate year.

**Verification Status:** Reported CSV recalculation reconciled to saved Python outputs and the 4,038 completed orders / 25,746,272.0155 revenue reference values. Independent raw-file inspection and direct Power BI DAX reconciliation pending.

**Storytelling Decision:** Candidate — Main Insight for order-status trends. Payment/shipping distributions and Chi-Square are supporting findings.

**Limitations:** No cancellation/return reasons, status transition dates, delivery times, or shipping costs. No financial loss attributable to cancellation or returns has been established. Annual status comparison is based on current statuses grouped by original OrderDate, not historical year-end snapshots.