import csv
import random
import os
from datetime import date, timedelta


# ============================================================
# إعدادات المشروع
# ============================================================

random.seed(42)

CUSTOMERS_COUNT = 1000
PRODUCTS_COUNT = 100
ORDERS_COUNT = 5000

START_DATE = date(2024, 1, 1)
END_DATE = date(2025, 12, 31)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
OUTPUT_DIR = os.path.join(BASE_DIR, "..", "data", "raw")

os.makedirs(OUTPUT_DIR, exist_ok=True)


# ============================================================
# دوال مساعدة
# ============================================================

def random_date(start, end):
    days = (end - start).days
    return start + timedelta(days=random.randint(0, days))


def save_csv(filename, headers, rows):
    filepath = os.path.join(OUTPUT_DIR, filename)

    with open(filepath, "w", newline="", encoding="utf-8-sig") as file:
        writer = csv.writer(file)
        writer.writerow(headers)
        writer.writerows(rows)

    print(f"Created: {filename} ({len(rows):,} rows)")


# ============================================================
# 1. المناطق
# ============================================================

regions = [
    [1, "الرياض"],
    [2, "مكة المكرمة"],
    [3, "المنطقة الشرقية"],
    [4, "المدينة المنورة"],
    [5, "القصيم"],
]

save_csv(
    "Regions.csv",
    ["RegionID", "RegionName"],
    regions
)


# ============================================================
# 2. المنتجات
# ============================================================

product_groups = {
    "Electronics": {
        "Laptops": [
            "حاسب محمول أعمال",
            "حاسب محمول خفيف",
            "حاسب محمول احترافي",
            "حاسب محمول اقتصادي",
            "حاسب محمول متقدم",
        ],
        "Monitors": [
            "شاشة 22 بوصة",
            "شاشة 24 بوصة",
            "شاشة 27 بوصة",
            "شاشة عريضة",
            "شاشة احترافية",
        ],
        "Tablets": [
            "جهاز لوحي أساسي",
            "جهاز لوحي متقدم",
            "جهاز لوحي للأعمال",
            "جهاز لوحي خفيف",
            "جهاز لوحي احترافي",
        ],
        "Printers": [
            "طابعة ليزر",
            "طابعة ألوان",
            "طابعة متعددة الوظائف",
            "طابعة مكتبية",
            "طابعة شبكية",
        ],
        "Networking": [
            "موجه شبكة",
            "موزع شبكة",
            "نقطة وصول لاسلكية",
            "مقوي شبكة",
            "مبدل شبكة",
        ],
    },

    "Accessories": {
        "Keyboards": [
            "لوحة مفاتيح لاسلكية",
            "لوحة مفاتيح سلكية",
            "لوحة مفاتيح ميكانيكية",
            "لوحة مفاتيح مكتبية",
            "لوحة مفاتيح صغيرة",
        ],
        "Mice": [
            "فأرة لاسلكية",
            "فأرة سلكية",
            "فأرة احترافية",
            "فأرة مكتبية",
            "فأرة صغيرة",
        ],
        "Headsets": [
            "سماعة رأس لاسلكية",
            "سماعة رأس مكتبية",
            "سماعة رأس احترافية",
            "سماعة مكالمات",
            "سماعة رأس خفيفة",
        ],
        "Storage": [
            "قرص تخزين خارجي",
            "ذاكرة فلاش",
            "قرص SSD خارجي",
            "وحدة تخزين متنقلة",
            "بطاقة ذاكرة",
        ],
        "Bags": [
            "حقيبة حاسب محمول",
            "حقيبة أعمال",
            "حقيبة أجهزة",
            "حقيبة ظهر للحاسب",
            "حقيبة حماية",
        ],
    },

    "Furniture": {
        "Chairs": [
            "كرسي مكتبي اقتصادي",
            "كرسي مكتبي احترافي",
            "كرسي اجتماعات",
            "كرسي مريح",
            "كرسي إداري",
        ],
        "Desks": [
            "مكتب عمل صغير",
            "مكتب عمل متوسط",
            "مكتب تنفيذي",
            "مكتب زاوية",
            "مكتب قابل للتعديل",
        ],
        "Tables": [
            "طاولة اجتماعات صغيرة",
            "طاولة اجتماعات كبيرة",
            "طاولة جانبية",
            "طاولة عمل",
            "طاولة متعددة الاستخدام",
        ],
        "Storage": [
            "خزانة ملفات",
            "خزانة مكتبية",
            "وحدة أدراج",
            "رف تخزين",
            "خزانة جانبية",
        ],
        "Workstations": [
            "محطة عمل فردية",
            "محطة عمل مزدوجة",
            "محطة عمل مكتبية",
            "محطة عمل مفتوحة",
            "محطة عمل احترافية",
        ],
    },

    "Office Supplies": {
        "Paper": [
            "ورق طباعة A4",
            "ورق طباعة A3",
            "ورق ملون",
            "ورق ملاحظات",
            "دفتر ملاحظات",
        ],
        "Ink": [
            "حبر طابعة أسود",
            "حبر طابعة ملون",
            "خرطوشة حبر كبيرة",
            "خرطوشة حبر اقتصادية",
            "حبر طابعة احترافي",
        ],
        "Writing": [
            "أقلام حبر",
            "أقلام رصاص",
            "أقلام تحديد",
            "طقم كتابة",
            "أقلام سبورة",
        ],
        "Organization": [
            "منظم مكتب",
            "ملف مستندات",
            "حافظة أوراق",
            "صندوق أرشيف",
            "منظم ملفات",
        ],
        "Equipment": [
            "آلة تمزيق أوراق",
            "آلة تغليف",
            "آلة حاسبة مكتبية",
            "مثقاب أوراق",
            "دباسة مكتبية",
        ],
    },
}


price_ranges = {
    "Electronics": (500, 5000),
    "Accessories": (50, 800),
    "Furniture": (300, 2500),
    "Office Supplies": (15, 1000),
}


products = []
product_id = 1

for category, subcategories in product_groups.items():

    for subcategory, names in subcategories.items():

        for name in names:

            min_price, max_price = price_ranges[category]

            unit_price = round(
                random.uniform(min_price, max_price),
                2
            )

            # التكلفة بين 55% و80% من سعر البيع
            unit_cost = round(
                unit_price * random.uniform(0.55, 0.80),
                2
            )

            # جزء بسيط من المنتجات غير نشط
            is_active = 0 if random.random() < 0.06 else 1

            products.append([
                product_id,
                name,
                category,
                subcategory,
                unit_price,
                unit_cost,
                is_active,
            ])

            product_id += 1


save_csv(
    "Products.csv",
    [
        "ProductID",
        "ProductName",
        "Category",
        "SubCategory",
        "UnitPrice",
        "UnitCost",
        "IsActive",
    ],
    products,
)


# ============================================================
# 3. العملاء
# ============================================================

male_names = [
    "أحمد",
    "محمد",
    "خالد",
    "عبدالله",
    "سعود",
    "فيصل",
    "تركي",
    "ماجد",
    "ناصر",
    "سلطان",
    "عبدالعزيز",
    "فهد",
]

female_names = [
    "نورة",
    "سارة",
    "ريم",
    "الجوهرة",
    "دانة",
    "هند",
    "أمل",
    "شهد",
    "ليان",
    "منى",
    "عبير",
    "لطيفة",
]

last_names = [
    "العتيبي",
    "القحطاني",
    "الدوسري",
    "الشمري",
    "الحربي",
    "المطيري",
    "الغامدي",
    "الزهراني",
    "العنزي",
    "الرشيدي",
    "السبيعي",
    "المالكي",
]

cities = [
    ("الرياض", 1),
    ("الخرج", 1),
    ("جدة", 2),
    ("مكة", 2),
    ("الطائف", 2),
    ("الدمام", 3),
    ("الخبر", 3),
    ("الظهران", 3),
    ("المدينة المنورة", 4),
    ("بريدة", 5),
    ("عنيزة", 5),
]

segments = [
    "Regular",
    "Premium",
    "Corporate",
]


customers = []

for customer_id in range(1, CUSTOMERS_COUNT + 1):

    gender = random.choice(["Male", "Female"])

    if gender == "Male":
        first_name = random.choice(male_names)
    else:
        first_name = random.choice(female_names)

    last_name = random.choice(last_names)

    customer_name = f"{first_name} {last_name}"

    city, region_id = random.choice(cities)

    segment = random.choices(
        segments,
        weights=[65, 25, 10],
        k=1,
    )[0]

    registration_date = random_date(
        START_DATE,
        date(2025, 6, 30),
    )

    email = (
        f"customer{customer_id}@example.com"
        if random.random() > 0.05
        else ""
    )

    phone = (
        f"05{random.randint(10000000, 99999999)}"
        if random.random() > 0.03
        else ""
    )

    is_active = 0 if random.random() < 0.08 else 1

    # مشاكل جودة بيانات مقصودة في أسماء المدن
    if customer_id % 157 == 0:
        city = "Riyadh"

    elif customer_id % 211 == 0:
        city = "RIYADH"

    customers.append([
        customer_id,
        customer_name,
        gender,
        city,
        region_id,
        segment,
        registration_date.isoformat(),
        email,
        phone,
        is_active,
    ])


# إنشاء عدد محدود من السجلات المتشابهة عمدًا
for i in range(5):
    source = customers[i]

    duplicate_customer = source.copy()

    duplicate_customer[0] = CUSTOMERS_COUNT - i

    customers[CUSTOMERS_COUNT - i - 1] = duplicate_customer


save_csv(
    "Customers.csv",
    [
        "CustomerID",
        "CustomerName",
        "Gender",
        "City",
        "RegionID",
        "CustomerSegment",
        "RegistrationDate",
        "Email",
        "Phone",
        "IsActive",
    ],
    customers,
)


# ============================================================
# 4. الطلبات
# ============================================================

statuses = [
    "Completed",
    "Cancelled",
    "Returned",
    "Pending",
]

payment_methods = [
    "Card",
    "Cash",
    "Bank Transfer",
    "Digital Wallet",
]

shipping_methods = [
    "Delivery",
    "Pickup",
    "Express",
]


orders = []

for order_id in range(1, ORDERS_COUNT + 1):

    customer_id = random.randint(
        1,
        CUSTOMERS_COUNT,
    )

    order_date = random_date(
        START_DATE,
        END_DATE,
    )

    status = random.choices(
        statuses,
        weights=[82, 7, 6, 5],
        k=1,
    )[0]

    payment_method = random.choice(
        payment_methods
    )

    shipping_method = random.choices(
        shipping_methods,
        weights=[70, 20, 10],
        k=1,
    )[0]

    orders.append([
        order_id,
        customer_id,
        order_date.isoformat(),
        status,
        payment_method,
        shipping_method,
    ])


save_csv(
    "Orders.csv",
    [
        "OrderID",
        "CustomerID",
        "OrderDate",
        "OrderStatus",
        "PaymentMethod",
        "ShippingMethod",
    ],
    orders,
)


# ============================================================
# 5. تفاصيل الطلبات
# ============================================================

order_items = []
order_item_id = 1

product_lookup = {
    product[0]: product
    for product in products
}


for order in orders:

    order_id = order[0]

    # من 1 إلى 5 منتجات لكل طلب
    items_count = random.choices(
        [1, 2, 3, 4, 5],
        weights=[20, 30, 25, 15, 10],
        k=1,
    )[0]

    selected_products = random.sample(
        range(1, PRODUCTS_COUNT + 1),
        items_count,
    )

    for product_id in selected_products:

        product = product_lookup[product_id]

        quantity = random.choices(
            [1, 2, 3, 4, 5],
            weights=[50, 25, 15, 7, 3],
            k=1,
        )[0]

        # قيمة شاذة مقصودة في عدد قليل جدًا من السجلات
        if random.random() < 0.001:
            quantity = random.randint(25, 60)

        unit_price = product[4]

        discount = random.choices(
            [0, 5, 10, 15, 20, 30],
            weights=[45, 20, 15, 10, 7, 3],
            k=1,
        )[0]

        order_items.append([
            order_item_id,
            order_id,
            product_id,
            quantity,
            unit_price,
            discount,
        ])

        order_item_id += 1


save_csv(
    "OrderItems.csv",
    [
        "OrderItemID",
        "OrderID",
        "ProductID",
        "Quantity",
        "UnitPrice",
        "DiscountPercent",
    ],
    order_items,
)


# ============================================================
# ملخص التنفيذ
# ============================================================

print()
print("=" * 50)
print("Dataset generation completed successfully.")
print("=" * 50)

print(f"Regions:     {len(regions):,}")
print(f"Products:    {len(products):,}")
print(f"Customers:   {len(customers):,}")
print(f"Orders:      {len(orders):,}")
print(f"Order Items: {len(order_items):,}")

print()
print(f"Files location:")
print(os.path.abspath(OUTPUT_DIR))