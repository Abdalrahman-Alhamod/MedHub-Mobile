import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_products_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/category.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';

class Products {
  static final _format = DateFormat('yyyy/MM/dd', Intl.getCurrentLocale());
  static final _date = _format.format(DateTime.now()).toString();
  static final Product Amoxil = Product(
    id: 0,
    type: ProductType.Antibiotics,
    name: "Amoxil".tr,
    scientificName: "Amoxicillin".tr,
    brand: "GlaxoSmithKline".tr,
    description: "desc".tr,
    expirationDate: _date,
    price: 17500,
    popularity: 520,
    image: AppProductsImages.amoxil,
    inStock: 52,
    isFavourate: false,
    discount: 50,
  );
  static final Product Excedrin = Product(
    id: 1,
    type: ProductType.PainAndRelief,
    name: "Excedrin",
    scientificName: "Acetaminophen",
    brand: "GlaxoSmithKline",
    description:
        "Excedrin is a brand of over-the-counter headache pain reliever that typically combines acetaminophen, aspirin, and caffeine to provide relief from various types of headaches, including tension headaches and migraines",
    expirationDate: _date,
    price: 22300,
    popularity: 520,
    image: AppProductsImages.excedrin,
    inStock: 64,
    isFavourate: false,
    discount: 50,
  );
  static final Product Benadryl = Product(
    id: 3,
    type: ProductType.AllergyMedications,
    name: "Benadryl",
    scientificName: "Diphenhydramine",
    brand: "Johnson & Johnson",
    description:
        "Benadryl is an antihistamine medication that alleviates symptoms of allergies, such as sneezing, runny nose, itching, and watery eyes, by blocking the effects of histamine, a natural substance produced by the body in response to allergens",
    expirationDate: _date,
    price: 26500,
    popularity: 520,
    image: AppProductsImages.benadryl,
    inStock: 96,
    isFavourate: false,
    discount: 50,
  );
  static final Product PeptoBismol = Product(
    id: 4,
    type: ProductType.DigestiveHealth,
    name: "Pepto-Bismol",
    scientificName: "Bismuth subsalicylate",
    brand: "Procter & Gamble",
    description:
        "Pepto-Bismol is an over-the-counter medication that provides relief from digestive discomfort, including indigestion, upset stomach, heartburn, nausea, and diarrhea, by coating and soothing the gastrointestinal tract",
    expirationDate: _date,
    price: 8500,
    popularity: 520,
    image: AppProductsImages.peptoBismol,
    inStock: 123,
    isFavourate: false,
    discount: 50,
  );
  static final Product Robitussin = Product(
    id: 2,
    type: ProductType.ColdAndFlu,
    name: "Robitussin",
    scientificName: "Dextromethorphan",
    brand: "Pfizer",
    description:
        "Robitussin is a cough medicine that helps relieve cough symptoms by thinning and loosening mucus in the airways, making it easier to cough out and providing relief from chest congestion",
    expirationDate: _date,
    price: 13200,
    popularity: 520,
    image: AppProductsImages.robitussin,
    inStock: 32,
    isFavourate: false,
    discount: 50,
  );
  static final Product Lipitor = Product(
    id: 5,
    type: ProductType.CardiovascularMedications,
    name: "Lipitor",
    scientificName: "Atorvastatin",
    brand: "Pfizer",
    description:
        "Lipitor is a prescription medication used to lower cholesterol levels and reduce the risk of cardiovascular events by inhibiting the production of cholesterol in the liver",
    expirationDate: _date,
    price: 32500,
    popularity: 520,
    image: AppProductsImages.lipitor,
    inStock: 21,
    isFavourate: false,
    discount: 50,
  );
  static final Product Lantus = Product(
    id: 6,
    type: ProductType.DiabetesManagement,
    name: "Lantus",
    scientificName: "Insulin glargine",
    brand: "Sanofi",
    description:
        "Lantus is a long-acting insulin analogue used to manage diabetes by helping control blood sugar levels throughout the day and night",
    expirationDate: _date,
    price: 38500,
    popularity: 520,
    image: AppProductsImages.lantus,
    inStock: 15,
    isFavourate: false,
    discount: 50,
  );
  static final Product Cortizone = Product(
    id: 7,
    type: ProductType.DermatologicalProducts,
    name: "Cortizone",
    scientificName: "Hydrocortisone",
    brand: "Bayer",
    description:
        "Cortizone is a topical corticosteroid that helps relieve itching, redness, and inflammation associated with various skin conditions, providing effective relief for skin irritation",
    expirationDate: _date,
    price: 26500,
    popularity: 520,
    image: AppProductsImages.cortizone,
    inStock: 86,
    isFavourate: false,
    discount: 50,
  );
  static final Product Centrum = Product(
    id: 8,
    type: ProductType.VitaminsAndSupplements,
    name: "Centrum",
    scientificName: "Multivitamins",
    brand: "Pfizer",
    description:
        "Centrum is a comprehensive multivitamin supplement that supports overall health by providing essential vitamins and minerals, promoting vitality and well-being",
    expirationDate: _date,
    price: 31500,
    popularity: 520,
    image: AppProductsImages.centrum,
    inStock: 49,
    isFavourate: false,
    discount: 50,
  );
  static final Product OrthoTriCyclen = Product(
    id: 9,
    type: ProductType.WomenHealth,
    name: "Ortho Tri-Cyclen",
    scientificName: "Ethinyl estradiol",
    brand: "Janssen Pharmaceuticals",
    description:
        "Ortho Tri-Cyclen is an oral contraceptive (birth control pill) that combines different hormones to prevent ovulation and alter the cervical mucus and uterine lining, providing effective contraception for women",
    expirationDate: _date,
    price: 52000,
    popularity: 520,
    image: AppProductsImages.orthoTriCyclen,
    inStock: 26,
    isFavourate: false,
    discount: 50,
  );
}

class AppData {
  const AppData._();
  static List<Product> products = [
    Products.Amoxil,
    Products.Excedrin,
    Products.Benadryl,
    Products.PeptoBismol,
    Products.Robitussin,
    Products.Lipitor,
    Products.Lantus,
    Products.Cortizone,
    Products.Centrum,
    Products.OrthoTriCyclen
  ];
  static List<Category> categories = [
    Category(id: 0, name: "All", image: ""),
    Category(id: 1, name: ProductType.Antibiotics, image: ""),
    Category(id: 2, name: ProductType.AllergyMedications, image: ""),
    Category(id: 3, name: ProductType.CardiovascularMedications, image: ""),
    Category(id: 4, name: ProductType.ColdAndFlu, image: ""),
    Category(id: 5, name: ProductType.DermatologicalProducts, image: ""),
    Category(id: 6, name: ProductType.DiabetesManagement, image: ""),
    Category(id: 7, name: ProductType.DigestiveHealth, image: ""),
    Category(id: 8, name: ProductType.PainAndRelief, image: ""),
    Category(id: 9, name: ProductType.VitaminsAndSupplements, image: ""),
    Category(id: 10, name: ProductType.WomenHealth, image: ""),
  ];
  static List<List<Product>> filteredProducts = [
    products,
    [],
    [Products.Benadryl],
    [Products.Lipitor],
    [Products.Robitussin],
    [Products.Cortizone],
    [Products.Lantus],
    [Products.PeptoBismol],
    [Products.Excedrin],
    [Products.Centrum],
    [Products.OrthoTriCyclen],
  ];
}
