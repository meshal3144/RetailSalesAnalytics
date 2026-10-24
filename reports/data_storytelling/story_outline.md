# RetailSalesAnalytics — Story Outline

**Phase:** 5 — Data Storytelling  
**Status:** Draft — Pending Evidence Mapping  
**Analysis Period:** 2024–2025  
**Audience:** Business Management / Executive Stakeholders

## Central Business Question

How did retail sales perform between 2024 and 2025, what patterns explain the composition of the observed change, and which areas warrant further business investigation?

## Core Narrative

Total completed-order revenue increased by only 0.14% between 2024 and 2025. This small net change masks substantial monthly and product-level variation, offsetting revenue changes across customer segments and categories, and a shift in order-status rates.

The analysis identifies where changes occurred and how they contributed arithmetically to overall results. It does not establish their underlying causes or financial profitability.

## 01 — Business Context

**Key Message:** Completed-order revenue remained nearly unchanged between 2024 and 2025.

**Evidence:**
- Revenue 2024: 12,864,362.4090
- Revenue 2025: 12,881,909.6065
- Net Change: +17,547.1975
- Growth Rate: +0.13640161045%

**Narrative Role:** Establish the business question and overall performance.

## 02 — Monthly Revenue Variation

**Key Message:** Near-flat annual growth hides substantial differences between individual months.

**Evidence:**
- 5 months increased; 7 months declined year over year.
- Largest monthly increase: August, +218,012.5425 (+19.033096%).
- Largest monthly decline: January, -272,891.7690 (-22.268973%).
- Positive monthly changes: +705,679.9220.
- Negative monthly changes: -688,132.7245.

**Narrative Role:** Demonstrate why annual KPIs alone are insufficient.

### Evidence Mapping — Executive Overview

**Power BI Page:** Executive Overview

**Visual 01:** Year-over-Year Comparison
- Status: Reuse
- Purpose: Show near-flat annual completed-order revenue.
- Evidence: 2024 = 12,864,362.4090; 2025 = 12,881,909.6065; YoY = +0.13640161045%.

**Visual 02:** Monthly Sales Trend
- Status: Reuse as Supporting Visual
- Purpose: Show chronological monthly revenue movement across 2024–2025.
- Limitation: The existing 24-month line does not directly display same-month year-over-year comparisons.

**Visual 03:** Monthly YoY Change
- Status: New Visual for Storytelling
- Purpose: Show differences between the same months of 2024 and 2025.
- Evidence: 5 months increased and 7 decreased; August +218,012.5425; January -272,891.7690.
- Source: Verified monthly sales table derived from cleaned CSV data.

**Dashboard Filters:** Year = All; Region = All; Category = All, as displayed in the reviewed screenshot.

**Currency Note:** Dashboard labels revenue as SAR; confirm currency definition in the underlying model before final publication.

**DAX Validation:** Pending direct reconciliation with Power BI model measures.

### Narrative Draft — Revenue Performance

### Revenue Performance — النمو السنوي يخفي تفاوتًا في الأداء الشهري

سجل المتجر نموًا محدودًا في إيرادات الطلبات المكتملة بين عامي 2024 و2025، حيث ارتفعت الإيرادات من **12.86 مليون ريال** إلى **12.88 مليون ريال**، بزيادة قدرها **17.55 ألف ريال**، تعادل نحو **0.14%**.

ورغم هذا التقارب السنوي، كشف التحليل الشهري عن تفاوت ملحوظ في الأداء؛ إذ ارتفعت الإيرادات في **خمسة أشهر** وانخفضت في **سبعة أشهر** مقارنة بالفترات المناظرة من العام السابق. وسجل أغسطس أكبر زيادة بقيمة **218.01 ألف ريال (+19.03%)**، بينما شهد يناير أكبر انخفاض بقيمة **272.89 ألف ريال (−22.27%)**.

وتشير هذه النتائج إلى أن النمو السنوي المحدود هو محصلة ارتفاعات وانخفاضات شهرية متقابلة، وليس دليلًا على ثبات المبيعات خلال جميع أشهر السنة. ولذلك فإن الاعتماد على المؤشرات السنوية وحدها قد يحجب اختلافات مهمة في الأداء.

**التوصية:** متابعة التغيرات الشهرية في الإيرادات بالمقارنة السنوية، وإجراء تحليل تفصيلي للأشهر الأعلى ارتفاعًا وانخفاضًا بحسب المنتجات وشرائح العملاء، قبل تحديد أسباب التغير أو اقتراح إجراءات تجارية.



## 03 — Customer Segment Performance

**Key Message:** Premium's positive revenue change offset declines in Regular and Corporate.

**Evidence:**
- Premium YoY: +207,735.0155 (+6.790694%).
- Regular YoY: -123,030.9750 (-1.437673%).
- Corporate YoY: -67,156.8430 (-5.382873%).
- Regular two-year revenue share: 65.998927%.
- Corporate AOV: 7,099.554213 (highest segment AOV).

**Narrative Role:** Explain the composition of annual revenue change by customer segment.

**Statistical Note:** ANOVA/Tukey inference remains provisional due to unverified assumptions and potential dependence between repeated customer orders.

### Evidence Mapping — Customer Analysis

**Power BI Page:** Customer Analysis

**Existing Visual 01:** Sales by Customer Segment
- Status: Reuse
- Purpose: Show revenue contribution by customer segment.
- Evidence: Regular = 16,992,263.1730 (65.998927% of total revenue).
- Limitation: Does not show annual segment changes or average order value.

**New Storytelling Visual 01:** Segment YoY Revenue Change
- Status: New Visual
- Purpose: Show annual revenue changes across customer segments.
- Evidence:
  - Premium: +207,735.0155 (+6.790694%).
  - Regular: -123,030.9750 (-1.437673%).
  - Corporate: -67,156.8430 (-5.382873%).

**New Storytelling Visual 02:** Average Order Value by Segment
- Status: New Visual
- Purpose: Distinguish revenue contribution from average order value.
- Evidence:
  - Corporate AOV: 7,099.554213.
  - Premium AOV: 6,376.977118.
  - Regular AOV: 6,284.120996.
- Statistical Note: Display descriptive means only; ANOVA/Tukey inference remains provisional.

**Supporting Visuals:** Customer Count, Active Accounts, Inactive Accounts, Top 10 Customers by Revenue, Sales by City, Sales by Region.

**Customer Definition Note:**
- Registered customers: 995.
- IsActive = True: 904.
- Customers with at least one completed order in 2024–2025: 979.
- Account status and purchasing activity must not be treated as equivalent.

**Dashboard Filters:** Year = All; Region = All; Segment = All, as displayed in the reviewed screenshot.

**Calculation Scope:** Revenue from completed orders only; 2024–2025; no additional filters.

**Privacy Note:** Prefer aggregate customer insights in the executive presentation instead of disclosing individual customer names.

**DAX Validation:** Direct reconciliation with Power BI measure definitions remains pending.


### Narrative Draft — Customer Segment Performance
### Customer Segment Performance — نمو Premium يعوّض انخفاض إيرادات الشرائح الأخرى

أظهر تحليل شرائح العملاء تفاوتًا في مساهمتها في إيرادات المتجر وتغيرها السنوي. فقد استحوذت شريحة **Regular على نحو 66% من إجمالي إيرادات عامي 2024 و2025**، تلتها Premium بنسبة 24.57%، ثم Corporate بنسبة 9.43%.

ورغم تصدر Regular للإيرادات، فإن شريحة **Premium كانت الوحيدة التي حققت نموًا في 2025**، بزيادة بلغت **207.74 ألف ريال (+6.79%)**، مقابل انخفاض إيرادات Regular بمقدار 123.03 ألف ريال وCorporate بمقدار 67.16 ألف ريال.

وعوّض هذا النمو حسابيًا انخفاض الشريحتين الأخريين، لينتهي العام بصافي زيادة محدود قدره 17.55 ألف ريال.

وتوضح هذه النتائج أن حجم إيرادات الشريحة لا يعكس بالضرورة مساهمتها في النمو، ما يستدعي تقييم الشرائح باستخدام مؤشرات متعددة بدل الاعتماد على إجمالي الإيرادات فقط.

**التوصية:** متابعة التغير السنوي في الإيرادات وعدد الطلبات ومتوسط قيمة الطلب لكل شريحة، مع تحليل مزيج المنتجات والخصومات وأنماط الشراء لفهم التغيرات قبل تحديد أولويات الاستهداف التجاري.



## 04 — Product Category Performance

**Key Message:** Office Supplies contributed the largest positive category revenue change, despite Electronics having the highest revenue share.

**Evidence:**
- Electronics two-year revenue share: 55.692039%.
- Office Supplies YoY: +32,921.9910 (+2.520225%).
- Electronics YoY: -11,588.2900 (-0.161507%).
- Positive category changes: +35,372.6650.
- Negative category changes: -17,825.4675.

**Narrative Role:** Provide a complementary breakdown of annual revenue change by product category.


### Narrative Draft — Product Category Performance
### Product Category Performance — الفئة الأعلى إيرادًا ليست الأكبر مساهمة في النمو

أظهر تحليل فئات المنتجات أن **Electronics استحوذت على 55.69% من إجمالي إيرادات عامي 2024 و2025**، لتكون الفئة الأعلى مساهمة في مبيعات المتجر، تلتها Furniture بنسبة 25.79%.

ورغم تصدر Electronics للإيرادات، فقد انخفضت مبيعاتها في 2025 بمقدار **11.59 ألف ريال (−0.16%)**، بينما سجلت **Office Supplies أكبر مساهمة إيجابية في التغير السنوي**، بزيادة بلغت **32.92 ألف ريال (+2.52%)**.

وعلى مستوى المنتجات، حقق **موجه الشبكة**، أحد منتجات Electronics، نموًا قدره **276.12 ألف ريال (+75.34%)**، رغم انخفاض إجمالي إيرادات الفئة. ويشير ذلك إلى وجود تفاوت ملحوظ في أداء المنتجات داخل الفئة الواحدة، حيث قابلت الزيادة الكبيرة في هذا المنتج انخفاضات صافية في بقية منتجات Electronics.

وتوضح هذه النتائج أن تصدر الفئة لإجمالي الإيرادات لا يعني بالضرورة تصدرها للنمو، وأن الاكتفاء بالمؤشرات المجمعة قد يحجب تغيرات مهمة على مستوى المنتجات.

**التوصية:** متابعة التغير السنوي للإيرادات على مستوى الفئات والمنتجات، وتحليل الكميات والأسعار والخصومات للمنتجات صاحبة أكبر الزيادات والانخفاضات، قبل تحديد فرص التوسع أو إعادة توزيع الموارد.




## 05 — Individual Product Performance

**Key Message:** Large product-level changes offset one another within an almost unchanged annual total.

**Evidence:**
- 100 products; 51 increased and 49 decreased.
- Network Router (ProductID 21): +276,121.9450 (+75.337838%).
- 24-inch Monitor (ProductID 7): -107,082.0740 (-23.309288%).
- Top 10 products' two-year revenue share: 32.740485%.

**Narrative Role:** Supply a concrete product-level example supporting the category-level analysis.

### Evidence Mapping — Product Analysis

**Power BI Page:** Product Analysis

**Existing Visual 01:** Revenue by Category
- Status: Reuse
- Purpose: Show revenue contribution by category.
- Evidence: Electronics = 14,338,623.7300 (55.692039% of total revenue).
- Limitation: Does not show annual changes by category.

**Existing Visual 02:** Top 10 Products — Revenue
- Status: Reuse
- Purpose: Show highest-revenue products.
- Evidence: ProductID 21 (موجه شبكة) = 1,009,145.2250.
- Limitation: Does not show year-over-year growth.

**New Storytelling Visual 01:** Category YoY Revenue Change
- Status: New Visual
- Purpose: Show how categories contributed to the annual revenue change.
- Evidence: Office Supplies +32,921.9910; Electronics -11,588.2900; Furniture +2,450.6740; Accessories -6,237.1775.

**New Storytelling Visual 02:** Product YoY Revenue Change
- Status: New Visual
- Purpose: Compare product-level annual revenue increases and decreases.
- Evidence: ProductID 21 +276,121.9450; ProductID 7 -107,082.0740.
- Recommended Scope: Largest positive and negative product-level changes.

**Supporting Visuals:** Bottom 10 Products — Revenue; Top 10 Products — Quantity; Revenue by Subcategory; Product Performance table.

**Dashboard Filters:** Year = All; Region = All; Category = All, as displayed in the reviewed screenshot.

**Calculation Scope:** Completed orders only; discounted SalesAmount; 2024 and 2025; no additional filters.

**DAX Validation:** Direct reconciliation with Power BI measure definitions remains pending.

## 06 — Order Status Performance

**Key Message:** The number of completed orders remained constant while cancellation and return rates increased.

**Evidence:**
- Completed orders: 2,019 in 2024 and 2,019 in 2025.
- Cancellation rate: 6.870229% to 7.646356%.
- Return rate: 5.825633% to 7.088809%.
- Total orders: 2,489 in 2024; 2,511 in 2025.

**Narrative Role:** Introduce an operational perspective beyond completed-order revenue.

**Limitation:** Status comparisons use current recorded status by OrderDate year, not historical year-end snapshots.

### Evidence Mapping — Order Analysis

**Power BI Page:** Order Analysis

**Existing Visual 01:** Orders by Status
- Status: Reuse
- Purpose: Show the distribution of all orders by status.
- Evidence: Completed = 4,038; Cancelled = 363; Returned = 323; Pending = 276.
- Limitation: Does not show year-over-year status changes.

**Existing Visual 02:** Order Status Share
- Status: Reuse
- Purpose: Show the percentage share of each order status.
- Evidence: Completed 80.76%; Cancelled 7.26%; Returned 6.46%; Pending 5.52%.
- Denominator: All 5,000 unique orders.

**New Storytelling Visual 01:** Order Status Rates — 2024 vs 2025
- Status: New Visual
- Purpose: Show year-over-year changes in order-status rates.
- Evidence:
  - Completed: 81.116914% (2024), 80.406213% (2025).
  - Cancelled: 6.870229% (2024), 7.646356% (2025).
  - Returned: 5.825633% (2024), 7.088809% (2025).
  - Pending: 6.187224% (2024), 4.858622% (2025).
- Denominators: 2,489 orders in 2024 and 2,511 orders in 2025.
- Comparison Basis: Current recorded order status grouped by OrderDate year.

**Supporting Visuals:** Completed/Cancelled/Returned/Pending KPI cards; Orders by Payment Method; Orders by Shipping Method; Monthly Order Trend.

**Dashboard Filters:** Year = All; Region = All; Shipping = All, as displayed in the reviewed screenshot.

**Business Rules:** Order-status distributions use all unique orders, not only Completed orders. Completed-order revenue is calculated separately.

**Statistical Note:** Chi-Square between PaymentMethod and OrderStatus did not reach statistical significance at alpha = 0.05; repeated orders by customers remain a possible independence limitation.

**Limitations:** No status transition dates or cancellation/return reasons. No demonstrated financial losses attributable to cancellations or returns.

**DAX Validation:** Direct reconciliation with Power BI measure definitions remains pending.


### Narrative Draft — Order Performance
### Order Performance — ثبات الطلبات المكتملة يقابله ارتفاع في معدلات الإلغاء والمرتجعات

أظهر تحليل حالات الطلبات أن عدد الطلبات المكتملة استقر عند **2,019 طلبًا في كل من عامي 2024 و2025**، رغم ارتفاع إجمالي الطلبات المسجلة من 2,489 إلى 2,511 طلبًا.

وفي المقابل، ارتفع **معدل الإلغاء من 6.87% إلى 7.65%**، بزيادة تقارب **0.78 نقطة مئوية**، كما ارتفع **معدل المرتجعات من 5.83% إلى 7.09%**، بزيادة تقارب **1.26 نقطة مئوية**.

وتوضح هذه النتائج أن ثبات عدد الطلبات المكتملة لا يعني بالضرورة ثبات توزيع حالات الطلبات، وأن متابعة الإيرادات وأعداد الطلبات المكتملة وحدها قد تحجب تغيرات تشغيلية تستحق المراجعة.

ومع ذلك، لا تسمح البيانات الحالية بتحديد أسباب الإلغاء والمرتجعات أو تقدير خسائر مالية ناتجة عنها، كما أن المقارنة تعتمد على حالات الطلبات المسجلة حاليًا مصنفة حسب سنة إنشاء الطلب، وليس على سجل تاريخي لتغير الحالات.

**التوصية:** إنشاء متابعة دورية لمعدلات الإلغاء والمرتجعات، مع توثيق أسباب الإلغاء والإرجاع وتواريخ تغير الحالات، وتحليلها بحسب الفترات والمنتجات وشرائح العملاء قبل اتخاذ إجراءات تشغيلية محددة.


## 07 — Recommendations and Next Questions

**Key Message:** Prioritize evidence-based investigations rather than premature operational or investment decisions.

**Directions:**
- Monitor monthly year-over-year revenue changes.
- Investigate product-level quantity, price and discount movements.
- Examine segment purchasing patterns and changes.
- Track cancellation and return rates and collect reason codes.
- Evaluate profitability and cost information before recommending resource allocation.

**Narrative Role:** Turn findings into focused follow-up actions.

## Evidence and Validation Rules

- Use Completed orders only for revenue.
- Calculate discounted SalesAmount before aggregation without rounding.
- Use all orders for order-status percentages.
- Do not treat revenue as profit.
- Do not claim statistical significance without methodological qualification.
- Do not infer causation from descriptive changes.
- Direct Power BI DAX reconciliation remains pending.


### Narrative Draft — Executive Recommendations

### Executive Recommendations — التوصيات التنفيذية

استنادًا إلى نتائج تحليل مبيعات المتجر خلال عامي 2024 و2025، توصي الدراسة بالتركيز على أربعة مسارات للتحليل والمتابعة وتحسين جودة القرارات التجارية والتشغيلية:

**1. تعزيز المتابعة الشهرية لأداء المبيعات**

اعتماد مراجعة دورية للتغير السنوي في إيرادات كل شهر، بدل الاكتفاء بمؤشر النمو السنوي الإجمالي، مع إعطاء أولوية لتحليل الأشهر التي سجلت أكبر ارتفاعات وانخفاضات؛ نظرًا إلى أن النمو السنوي البالغ 0.14% أخفى تفاوتًا ملحوظًا في الأداء الشهري.

**2. تعميق تحليل شرائح العملاء**

مراجعة تغير عدد الطلبات ومتوسط قيمتها ومزيج المنتجات والخصومات لكل شريحة، مع التركيز على فهم نمو Premium بنسبة 6.79% مقابل انخفاض إيرادات Regular وCorporate، قبل اتخاذ قرارات متعلقة باستهداف العملاء أو تخصيص الموارد التسويقية.

**3. تحليل الأداء على مستوى المنتجات والفئات**

متابعة التغير السنوي في إيرادات المنتجات، وتحليل أثر الكميات والأسعار والخصومات على النتائج، خصوصًا للمنتجات صاحبة أكبر الزيادات والانخفاضات. ويهدف ذلك إلى تحديد فرص التحسين المحتملة دون افتراض أن المنتجات الأعلى إيرادًا هي الأعلى ربحية.

**4. تطوير متابعة الإلغاء والمرتجعات**

إنشاء آلية منظمة لتوثيق أسباب إلغاء الطلبات وإرجاعها، وتواريخ تغير الحالات، مع متابعة معدلات الإلغاء والمرتجعات دوريًا؛ بهدف فهم العوامل المرتبطة بارتفاعها قبل اختيار التدخلات التشغيلية المناسبة.

**متطلبات إضافية لاتخاذ قرارات استثمارية:**

تحتاج القرارات المتعلقة بتوسيع الفئات أو إعادة توزيع الموارد أو إيقاف المنتجات إلى بيانات إضافية عن تكاليف المنتجات وهوامش الربح والمخزون، وربما تكاليف اكتساب العملاء والاحتفاظ بهم بحسب القرار المطلوب.

وتُعد هذه التوصيات خطوات مبنية على النتائج الوصفية المعتمدة، ولا تمثل تقديرًا لعوائد مالية مستقبلية أو إثباتًا للأسباب التي أدت إلى تغير الأداء.



## Next Step

Evidence Mapping — match each narrative message to an existing Power BI visual or identify a verified visual that must be created.
