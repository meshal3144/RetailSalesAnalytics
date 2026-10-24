# RetailSalesAnalytics — Executive Presentation Plan

**Phase:** 5 — Data Storytelling
**Status:** Draft — Ready for Slide Development
**Audience:** Executive / Business Management
**Language:** Arabic
**Period:** 2024–2025
**Format:** PowerPoint, 16:9
**Planned Slides:** 10

## Slide 01 — Cover
**Title:** Retail Sales Performance | 2024–2025
**Purpose:** Introduce the executive analysis.
**Content:** Project title, period, Data Storytelling presentation.
**Visual:** Clean cover layout.

## Slide 02 — Executive Summary
**Headline:** النمو السنوي المحدود يخفي اختلافات مهمة في الأداء
**Core Message:** Near-flat revenue growth masks variation across months, customer segments, products, and order statuses.
**Key Evidence:** Revenue 25.75M; YoY Growth +0.14%; Completed Orders 4,038.
**Visual:** Key KPI cards and concise insight summaries.
**Takeaway:** Annual revenue alone is insufficient to evaluate overall performance.

## Slide 03 — Annual Revenue Performance
**Headline:** إيرادات المتجر ارتفعت بنسبة 0.14% فقط
**Core Message:** Completed-order revenue remained nearly unchanged from 2024 to 2025.
**Key Evidence:**
- 2024 Revenue: 12,864,362.4090
- 2025 Revenue: 12,881,909.6065
- Net Change: +17,547.1975
- YoY Growth: +0.13640161045%
**Visual:** Annual revenue comparison / KPI.
**Takeaway:** The annual result provides context but not a complete performance explanation.

## Slide 04 — Monthly Revenue Variation
**Headline:** الاستقرار السنوي يخفي ارتفاعات وانخفاضات شهرية متقابلة
**Core Message:** Monthly performance varied despite limited annual growth.
**Key Evidence:** 5 months increased; 7 declined; August +218,012.5425; January -272,891.7690.
**Visual:** visuals/01_monthly_yoy_change.png
**Takeaway:** Monitor the same-month year-over-year differences rather than annual growth alone.

## Slide 05 — Customer Segment Growth
**Headline:** نمو Premium عوّض انخفاض إيرادات الشرائح الأخرى
**Core Message:** Premium contributed the largest positive segment-level annual change.
**Key Evidence:**
- Premium: +207,735.0155
- Regular: -123,030.9750
- Corporate: -67,156.8430
**Visual:** visuals/03_segment_yoy_change.png
**Takeaway:** Revenue share and annual growth contribution are different measures.

## Slide 06 — Average Order Value
**Headline:** Corporate تحقق أعلى متوسط قيمة طلب رغم تصدر Regular للإيرادات
**Core Message:** The segment with highest revenue is not the one with highest AOV.
**Key Evidence:**
- Corporate AOV: 7,099.554213
- Premium AOV: 6,376.977118
- Regular AOV: 6,284.120996
- Regular share of total revenue: 65.998927%
**Visual:** visuals/04_segment_aov.png
**Takeaway:** Use multiple metrics to evaluate segment performance.
**Statistical Note:** Do not claim confirmed ANOVA/Tukey significance; assumptions and repeated-customer dependence have not been fully assessed.

## Slide 07 — Product Category Growth
**Headline:** Office Supplies أكبر مساهم إيجابي في تغير الإيرادات بين الفئات
**Core Message:** Highest revenue share does not imply largest annual growth contribution.
**Key Evidence:**
- Electronics share: 55.692039%
- Office Supplies change: +32,921.9910
- Electronics change: -11,588.2900
**Visual:** visuals/02_category_yoy_change.png
**Takeaway:** Monitor both category size and growth.

## Slide 08 — Product-Level Changes
**Headline:** تغيرات المنتجات الفردية قد تتعارض مع اتجاه الفئة ككل
**Core Message:** Large increases in individual products were offset by declines elsewhere.
**Key Evidence:**
- ProductID 21 (موجه شبكة): +276,121.9450
- ProductID 7 (شاشة 24 بوصة): -107,082.0740
- Electronics net change: -11,588.2900
**Visual:** visuals/05_product_yoy_change.png
**Takeaway:** Evaluate individual product changes before drawing category-wide conclusions.

## Slide 09 — Order Status Performance
**Headline:** ثبات الطلبات المكتملة يقابله ارتفاع في معدلات الإلغاء والمرتجعات
**Core Message:** Completed orders remained constant, while cancellation and return rates increased.
**Key Evidence:**
- Completed: 2,019 in each year.
- Cancellation rate: 6.870229% to 7.646356%.
- Return rate: 5.825633% to 7.088809%.
**Visual:** visuals/06_order_status_rates.png
**Takeaway:** Monitor order statuses alongside completed-order revenue.
**Limitation:** Current statuses grouped by OrderDate year, not historical year-end status snapshots.

## Slide 10 — Executive Recommendations
**Headline:** أربع أولويات لتعزيز فهم الأداء وتحسين القرارات
**Recommendations:**
1. Monthly YoY revenue monitoring.
2. Segment-level order count, AOV, and product-mix analysis.
3. Product-level quantity, price, and discount analysis.
4. Cancellation and return reason tracking.
**Visual:** Four-priority action roadmap.
**Takeaway:** Investigate documented patterns before making commercial or operational interventions.

## Presentation Rules
- Use evidence-based Arabic headlines.
- Do not present revenue as profit.
- Do not invent causal explanations or financial loss estimates.
- Use full-precision values for validation, rounded values for presentation.
- Preserve source citations or evidence references in presenter notes where practical.
- Six prepared storytelling visuals are the main analytical charts.
- Direct DAX reconciliation remains pending.
- Confirm currency definition before final publication.
