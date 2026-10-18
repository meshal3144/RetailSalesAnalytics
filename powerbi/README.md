# Power BI Dashboard — RetailSalesAnalytics

## Overview

تم في هذه المرحلة بناء Dashboard تفاعلي باستخدام **Power BI** اعتمادًا على البيانات النظيفة الناتجة من مرحلة **Python + Pandas**.

الهدف من هذه المرحلة ليس مجرد عرض البيانات بصريًا، بل تحويل النتائج إلى تقرير تفاعلي يساعد على:

- متابعة مؤشرات المبيعات الرئيسية
- تحليل الاتجاهات الزمنية
- مقارنة أداء المنتجات والفئات
- تحليل العملاء والمناطق
- متابعة حالات الطلبات وطرق الدفع والشحن
- استخدام الفلاتر للتنقل بين مستويات مختلفة من التحليل

---

## Data Source

تم استخدام ملفات البيانات النظيفة الموجودة داخل:

```text
data/processed/
Regions_clean.csv
Products_clean.csv
Customers_clean.csv
Orders_clean.csv
OrderItems_clean.csv
تمت مراجعة أنواع البيانات داخل Power Query قبل تحميلها إلى نموذج البيانات.

Data Model

تم إنشاء العلاقات بين الجداول باستخدام:
One-to-Many (1:*)
Cross Filter Direction: Single
العلاقات الرئيسية:
Regions_clean[RegionID]
        ↓
Customers_clean[RegionID]

Customers_clean[CustomerID]
        ↓
Orders_clean[CustomerID]

Orders_clean[OrderID]
        ↓
OrderItems_clean[OrderID]

Products_clean[ProductID]
        ↓
OrderItems_clean[ProductID]
تم الحفاظ على نموذج بيانات واضح ومترابط لتسهيل الفلترة والتحليل.




Date Table

تم إنشاء جدول تاريخ مستقل باسم:

DateTable

ويحتوي على:

Date
Year
MonthNumber
MonthName
YearMonth

وتم ربطه مع:

DateTable[Date]
        ↓
Orders_clean[OrderDate]

الهدف من Date Table هو دعم:

التحليل الشهري
التحليل السنوي
المقارنات الزمنية
الفلاتر الزمنية
حسابات Year-over-Year
DAX Measures

تم إنشاء مجموعة من المقاييس باستخدام DAX لدعم التحليل داخل التقرير.

من أهم المقاييس:

Total Revenue
Completed Orders
Average Order Value
Total Quantity Sold

كما تم استخدام مقاييس إضافية لدعم:

Revenue Growth %
Previous Year Revenue
Completed Order %
Cancelled Order %
Returned Order %
Pending Order %
Average Items per Order
Revenue Share %
Total Customers
Active Customers
Inactive Customers
Buying Customers
Revenue per Customer

---

## Validation

تم التحقق من نتائج Power BI ومقارنتها بالنتائج السابقة التي تم الوصول إليها باستخدام Python.

أهم القيم المرجعية:

```text
Total Revenue ≈ 25.75M
Completed Orders = 4,038
Average Order Value ≈ 6.38K
Total Quantity Sold ≈ 20.37K

هذا التحقق ساعد على التأكد من صحة:

العلاقات
الفلاتر
DAX Measures
نموذج البيانات
Dashboard Pages
1. Executive Overview — النظرة التنفيذية

الصفحة الرئيسية في التقرير، وتهدف إلى إعطاء نظرة سريعة عن الأداء العام للمبيعات.

تتضمن:

Total Revenue
Completed Orders
Average Order Value
Total Quantity Sold
Monthly Sales Trend
Year-over-Year Comparison
Revenue by Category
Revenue by Region

كما تحتوي على Slicers مثل:

Year
Region
Category
2. Product Analysis — تحليل المنتجات

تركز هذه الصفحة على تحليل أداء المنتجات والفئات.

تشمل:

Top Products by Revenue
Bottom Products by Revenue
Revenue by Category
Revenue by SubCategory
Quantity Sold by Product
Product Performance Comparison

الهدف من الصفحة هو معرفة:

المنتجات الأعلى مساهمة في الإيرادات
المنتجات الأقل أداءً
الفئات الأكثر تأثيرًا على المبيعات
3. Customer Analysis — تحليل العملاء

تركز هذه الصفحة على سلوك العملاء ومساهمتهم في المبيعات.

تشمل:

Top Customers by Revenue
Revenue by Customer Segment
Revenue by City
Revenue by Region
Total Customers
Active Customers
Inactive Customers
Buying Customers

الهدف من الصفحة هو فهم:

العملاء الأعلى قيمة
شرائح العملاء
التوزيع الجغرافي للمبيعات
مستوى نشاط العملاء
4. Order Analysis — تحليل الطلبات

تركز هذه الصفحة على تحليل دورة الطلبات وسلوكها.

تشمل:

Orders by Status
Orders by Payment Method
Orders by Shipping Method
Completed Orders %
Cancelled Orders %
Returned Orders %
Pending Orders %
Monthly Order Trend

الهدف من الصفحة هو فهم:

توزيع حالات الطلبات
طرق الدفع الأكثر استخدامًا
طرق الشحن
نسب الطلبات المكتملة والملغاة والمرتجعة والمعلقة
Visual Design

تم تصميم التقرير بأسلوب:

Modern
Clean
Executive
Minimal

الألوان الرئيسية المستخدمة:

Primary:    #074D31
Secondary:  #55775D
Accent:     #E1B948
Background: #F6F3EE
Text:       #0D121C

ألوان الحالات:

Completed: #074D31
Cancelled: #C8252F
Pending:   #E1B948
Returned:  #826ACC
Visual Selection

تم اختيار كل Visual بناءً على نوع التحليل وليس لمجرد الشكل.

أمثلة:

Cards
→ لعرض المؤشرات الرئيسية KPI

Line Charts
→ لعرض الاتجاهات الزمنية

Bar Charts
→ للمقارنات بين الفئات والمنتجات والمناطق

Slicers
→ للتحكم التفاعلي في التقرير
Interactivity

تمت إضافة عناصر تفاعلية تسمح للمستخدم بتصفية التقرير حسب:

Year
Region
Category

وتتغير:

KPI Cards
Charts
Trends
Comparisons

تلقائيًا حسب الاختيار.

تم كذلك إضافة Navigation بين صفحات التقرير لتسهيل التنقل بين:

Executive Overview — النظرة التنفيذية

Product Analysis — تحليل المنتجات

Customer Analysis — تحليل العملاء

Order Analysis — تحليل الطلبات
Power BI Workflow

تم تنفيذ مرحلة Power BI بالترتيب التالي:

1. Import Clean Data

2. Validate Data Types

3. Build Relationships

4. Create Date Table

5. Create DAX Measures

6. Validate Results Against Python

7. Build KPI Cards

8. Build Analytical Visuals

9. Add Slicers and Filters

10. Add Page Navigation

11. Apply Visual Identity

12. Final Dashboard Review
Key Principle

الهدف من التقرير لم يكن إنشاء رسوم جميلة فقط.

كل Visual تم اختياره ليجيب عن سؤال تحليلي واضح.

مثال:

Monthly Sales Trend
→ كيف تتغير المبيعات مع الوقت؟

Revenue by Category
→ أي الفئات تحقق أعلى إيرادات؟

Revenue by Region
→ أي المناطق تساهم أكثر في المبيعات؟

Top Customers
→ من هم العملاء الأعلى قيمة؟

Order Status
→ ما نسبة الطلبات المكتملة أو الملغاة أو المرتجعة؟