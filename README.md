# RetailSalesAnalytics

### End-to-End Retail Sales Analytics Project

مشروع تطبيقي متكامل لتحليل بيانات مبيعات التجزئة، يغطي دورة تحليل البيانات من إعداد قواعد البيانات ومعالجة البيانات الخام، مرورًا بالتحليل الاستكشافي والإحصائي وبناء لوحات المعلومات التنفيذية وسرد البيانات، وصولًا إلى تطوير نموذج تعلم آلي للتنبؤ بالإيرادات الشهرية.

يعتمد المشروع على بيانات اصطناعية (Synthetic Data) تغطي عامي 2024 و2025، ويستخدم مجموعة من الأدوات والتقنيات ضمن مسار تحليلي مترابط، مع توثيق النتائج والتحقق من اتساق المؤشرات عبر المراحل المختلفة.

---

## Project Objectives — أهداف المشروع

- تطبيق دورة تحليل البيانات بصورة متكاملة باستخدام مجموعة من الأدوات والتقنيات.
- بناء قاعدة بيانات علائقية وتحليل المبيعات باستخدام SQL.
- تنظيف البيانات ومعالجتها باستخدام Python وPandas.
- استكشاف البيانات واستخراج المؤشرات وإجراء التحليلات الإحصائية.
- تطوير لوحة معلومات تفاعلية باستخدام Power BI.
- تحويل النتائج التحليلية إلى رؤى وتوصيات تنفيذية من خلال Data Storytelling.
- بناء نموذج Machine Learning باستخدام scikit-learn وتقييم قدرته على التنبؤ بالإيرادات الشهرية.

---

## Project Roadmap — مراحل المشروع

| المرحلة | المجال | المخرجات الرئيسية |
|---|---|---|
| Phase 1 | SQL | قاعدة البيانات، العلاقات، الاستعلامات والمؤشرات |
| Phase 2 | Python & Pandas | تنظيف البيانات وتجهيز ملفات التحليل |
| Phase 3 | EDA & Statistics | التحليل الاستكشافي، المؤشرات والاختبارات الإحصائية |
| Phase 4 | Power BI | لوحة معلومات تنفيذية تفاعلية من أربع صفحات |
| Phase 5 | Data Storytelling | الرؤى التحليلية، الملخص التنفيذي والعرض النهائي |
| Phase 6 | Predictive Analytics | نموذج Ridge Regression وتقييم التوقعات الزمنية |

**حالة المشروع: مكتمل — Completed**

---

## Dataset Overview — نظرة عامة على البيانات

تتكون قاعدة البيانات من خمسة جداول رئيسية:

| Dataset | الوصف |
|---|---|
| Orders | بيانات الطلبات وتواريخها وحالاتها |
| OrderItems | تفاصيل المنتجات والكميات والأسعار والخصومات لكل طلب |
| Customers | بيانات العملاء وشرائحهم |
| Products | معلومات المنتجات وتصنيفاتها |
| Regions | المناطق الجغرافية |

تتضمن البيانات الأصلية 5,000 طلب و1,000 سجل عميل و100 منتج، وتغطي الفترة من يناير 2024 إلى ديسمبر 2025.

خضعت البيانات لعمليات فحص وتنظيف قبل استخدامها في المراحل التحليلية، مع الاحتفاظ بنسخة البيانات الخام ونسخة البيانات المعالجة بصورة منفصلة.

**Data Source:** Synthetic Data — بيانات اصطناعية مخصصة للتطبيق والتعلم، وليست بيانات معاملات تجارية حقيقية.

---

## Technologies & Tools — التقنيات المستخدمة

| التقنية | الاستخدام |
|---|---|
| SQL Server / T-SQL | قواعد البيانات والاستعلامات والتحليل |
| Python | المعالجة والتحليل والبرمجة |
| Pandas | تنظيف البيانات والتحويل والتجميع |
| NumPy | العمليات العددية |
| Matplotlib | الرسوم البيانية والتحليلات البصرية |
| Jupyter Notebook | تنفيذ وتوثيق التحليلات |
| Power BI | بناء لوحات المعلومات التفاعلية |
| scikit-learn | بناء وتقييم نموذج Machine Learning |
| Markdown | توثيق التحليلات والنتائج |

---

## Key Analytical Results — أبرز النتائج التحليلية

تعتمد مؤشرات الإيرادات على الطلبات المكتملة فقط، باستخدام أسعار بنود الطلبات والخصومات المسجلة، دون تقريب قبل التجميع.

| المؤشر | النتيجة |
|---|---:|
| إجمالي الإيرادات 2024–2025 | 25,746,272.02 SAR |
| عدد الطلبات المكتملة | 4,038 |
| متوسط قيمة الطلب المكتمل | 6,376.00 SAR |
| النمو السنوي للإيرادات في 2025 | +0.14% |
| الشريحة الأعلى مساهمة في الإيرادات | Regular |
| الفئة الأعلى مساهمة في الإيرادات | Electronics |

أظهر التحليل أن النمو السنوي المحدود يخفي تفاوتًا بين الأشهر واختلافات في أداء شرائح العملاء والمنتجات، ما استدعى توسيع التحليل من المؤشرات الإجمالية إلى المقارنات التفصيلية وسرد النتائج.

---

## Predictive Analytics — التحليلات التنبؤية

تضمنت المرحلة السادسة تطوير نموذج تعلم آلي للتنبؤ بإيرادات الشهر التالي باستخدام **Ridge Regression** من مكتبة scikit-learn.

اعتمد النموذج على إيرادات الأشهر الثلاثة السابقة (`lag_1`, `lag_2`, `lag_3`)، مع استخدام `StandardScaler` داخل `Pipeline`، وتطبيق تقييم زمني متدرج (Expanding Window Backtesting).

جرت مقارنة نتائج النموذج مع Naive Baseline خلال ستة أشهر من يوليو إلى ديسمبر 2025.

### Model Performance

| المقياس | Naive Baseline | Ridge Regression |
|---|---:|---:|
| MAE | 206,711.60 SAR | 151,517.13 SAR |
| RMSE | 215,580.41 SAR | 173,698.28 SAR |

حقق Ridge انخفاضًا في MAE بنسبة **26.70%** وفي RMSE بنسبة **19.43%** مقارنة بالنموذج المرجعي خلال فترة الاختبار المحددة.

كما أُنتج توقع تجريبي لإيرادات يناير 2026 بقيمة **948,120.11 ريال**.

هذه النتائج محصورة في إطار تجربة تعليمية على بيانات اصطناعية ذات تاريخ زمني محدود. ولا تمثل إثباتًا لموثوقية النموذج مستقبلًا أو صلاحية تشغيلية معتمدة؛ كما لا تتوافر قيمة فعلية مستقلة لإيرادات يناير 2026 ضمن بيانات المشروع للتحقق من التوقع.

---

## Project Structure — هيكلة المشروع

```text
RetailSalesAnalytics/
│
├── README.md
├── untitled.py
│
├── .ipynb_checkpoints/
│   └── untitled-checkpoint.py
│
├── data/
│   ├── processed/
│   │   ├── Customers_clean.csv
│   │   ├── OrderItems_clean.csv
│   │   ├── Orders_clean.csv
│   │   ├── Products_clean.csv
│   │   └── Regions_clean.csv
│   │
│   └── raw/
│       ├── Customers.csv
│       ├── OrderItems.csv
│       ├── Orders.csv
│       ├── Products.csv
│       └── Regions.csv
│
├── database/
│   └── .gitkeep
│
├── powerbi/
│   ├── .gitkeep
│   ├── README.md
│   └── RetailSalesAnalytics_Executive.pbix
│
├── python/
│   ├── generate_data.py
│   │
│   └── notebooks/
│       ├── 01_data_loading.ipynb
│       ├── 02_data_cleaning.ipynb
│       ├── 03_eda.ipynb
│       ├── 04_statistics.ipynb
│       ├── 05_predictive_analytics.ipynb
│       │
│       └── .ipynb_checkpoints/
│           ├── 01_data_loading-checkpoint.ipynb
│           ├── 02_data_cleaning-checkpoint.ipynb
│           ├── 03_eda-checkpoint.ipynb
│           └── 04_statistics-checkpoint.ipynb
│
├── reports/
│   ├── .gitkeep
│   │
│   ├── data_storytelling/
│   │   ├── executive_summary.md
│   │   ├── insights_catalog.md
│   │   ├── presentation_plan.md
│   │   ├── story_outline.md
│   │   │
│   │   ├── branding/
│   │   │   ├── RetailSales_Executive_Story.html
│   │   │   └── RetailSales_Executive_Story.pdf
│   │   │
│   │   └── visuals/
│   │       ├── 01_monthly_yoy_change.png
│   │       ├── 01_monthly_yoy_change.svg
│   │       ├── 02_category_yoy_change.png
│   │       ├── 02_category_yoy_change.svg
│   │       ├── 03_segment_yoy_change.png
│   │       ├── 03_segment_yoy_change.svg
│   │       ├── 04_segment_aov.png
│   │       ├── 04_segment_aov.svg
│   │       ├── 05_product_yoy_change.png
│   │       ├── 05_product_yoy_change.svg
│   │       ├── 06_order_status_rates.png
│   │       └── 06_order_status_rates.svg
│   │
│   └── predictive_analytics/
│       └── predictive_analytics_report.md
│
└── sql/
    ├── 01_create_database.sql
    ├── 02_create_tables.sql
    ├── 03_import_data.sql
    ├── 04_data_exploration.sql
    ├── 05_sales_kpis.sql
    ├── 06_sales_analysis.sql
    ├── 07_product_analysis.sql
    ├── 08_customer_analysis.sql
    ├── 09_data_quality_analysis.sql
    └── 10_sales_analysis_view.sql
```

---

## Project Deliverables — مخرجات المشروع

**SQL Analysis**

استعلامات تحليلية ومؤشرات أداء ومراجعات لجودة البيانات.

**Python & Statistical Analysis**

دفاتر عمل لتجهيز البيانات وتحليلها، وإجراء الاختبارات الإحصائية.

**Power BI Dashboard**

لوحة معلومات تنفيذية تشمل الأداء العام وتحليل المنتجات والعملاء والطلبات.

**Data Storytelling**

ملخص تنفيذي وتحليل للرؤى الرئيسية، ورسوم بيانية وعرض تنفيذي لنتائج عامي 2024 و2025.

**Predictive Analytics**

Notebook لتجربة تعلم الآلة، وتقرير مستقل يوثق إعداد النموذج والتقييم الزمني ومقارنة الأداء وتحليل الأخطاء والتوقع التجريبي.

---

## Documentation — التوثيق

- [SQL Scripts](sql/)
- [Python Notebooks](python/notebooks/)
- [Power BI Dashboard](powerbi/)
- [Data Storytelling Reports](reports/data_storytelling/)
- [Predictive Analytics Report](reports/predictive_analytics/predictive_analytics_report.md)
- [Predictive Analytics Notebook](python/notebooks/05_predictive_analytics.ipynb)

---

## Project Scope & Limitations — نطاق المشروع وحدوده

هذا المشروع تطبيق تحليلي وتعليمي باستخدام بيانات اصطناعية، ويهدف إلى عرض تكامل الأدوات والمنهجيات في دورة تحليل البيانات.

تعكس النتائج خصائص البيانات المستخدمة ولا تمثل استنتاجات قابلة للتعميم على منشآت تجارية فعلية دون بيانات واختبارات إضافية.

كما أن نتائج Machine Learning تعتمد على سجل تاريخي محدود واختبار زمني قصير، ولا تمثل ضمانًا لدقة التوقعات المستقبلية.

---

**RetailSalesAnalytics | End-to-End Data Analytics & Machine Learning Project**