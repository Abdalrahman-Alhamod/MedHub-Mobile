import 'package:get/get.dart';
import 'package:pharmacy_warehouse_store_mobile/core/assets/app_products_images.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/category.dart';
import 'package:pharmacy_warehouse_store_mobile/src/model/product.dart';

class Products {
  static final _date = DateTime.now().toString();
  // ignore: non_constant_identifier_names
  static Product Amoxil = Product(
    id: 0,
    category: AppData.categories[1],
    name: "Amoxil".tr,
    scientificName: "Amoxicillin".tr,
    brand: "GlaxoSmithKline".tr,
    description: "desc".tr,
    expirationDate: _date,
    price: 17500,
    image: AppProductsImages.amoxil,
    inStock: 0,
    isFavorite: false,
  );
  // ignore: non_constant_identifier_names
  static Product Excedrin = Product(
    id: 1,
    category: AppData.categories[8],
    name: "Excedrin",
    scientificName: "Acetaminophen",
    brand: "GlaxoSmithKline",
    description:
        "Excedrin is a brand of over-the-counter headache pain reliever that typically combines acetaminophen, aspirin, and caffeine to provide relief from various types of headaches, including tension headaches and migraines",
    expirationDate: _date,
    price: 22300,
    image: AppProductsImages.excedrin,
    inStock: 3,
    isFavorite: false,
  );
  // ignore: non_constant_identifier_names
  static Product Benadryl = Product(
    id: 3,
    category: AppData.categories[2],
    name: "Benadryl",
    scientificName: "Diphenhydramine",
    brand: "Johnson & Johnson",
    description:
        "Benadryl is an antihistamine medication that alleviates symptoms of allergies, such as sneezing, runny nose, itching, and watery eyes, by blocking the effects of histamine, a natural substance produced by the body in response to allergens",
    expirationDate: _date,
    price: 26500,
    image: AppProductsImages.benadryl,
    inStock: 96,
    isFavorite: false,
  );
  // ignore: non_constant_identifier_names
  static Product PeptoBismol = Product(
    id: 4,
    category: AppData.categories[7],
    name: "Pepto-Bismol",
    scientificName: "Bismuth subsalicylate",
    brand: "Procter & Gamble",
    description:
        "Pepto-Bismol is an over-the-counter medication that provides relief from digestive discomfort, including indigestion, upset stomach, heartburn, nausea, and diarrhea, by coating and soothing the gastrointestinal tract",
    expirationDate: _date,
    price: 8500,
    image: AppProductsImages.peptoBismol,
    inStock: 123,
    isFavorite: false,
  );
  // ignore: non_constant_identifier_names
  static Product Robitussin = Product(
    id: 2,
    category: AppData.categories[4],
    name: "Robitussin",
    scientificName: "Dextromethorphan",
    brand: "Pfizer",
    description:
        "Robitussin is a cough medicine that helps relieve cough symptoms by thinning and loosening mucus in the airways, making it easier to cough out and providing relief from chest congestion",
    expirationDate: _date,
    price: 13200,
    image: AppProductsImages.robitussin,
    inStock: 32,
    isFavorite: false,
  );
  // ignore: non_constant_identifier_names
  static Product Lipitor = Product(
    id: 5,
    category: AppData.categories[3],
    name: "Lipitor",
    scientificName: "Atorvastatin",
    brand: "Pfizer",
    description:
        "Lipitor is a prescription medication used to lower cholesterol levels and reduce the risk of cardiovascular events by inhibiting the production of cholesterol in the liver",
    expirationDate: _date,
    price: 32500,
    image: AppProductsImages.lipitor,
    inStock: 21,
    isFavorite: false,
  );
  // ignore: non_constant_identifier_names
  static Product Lantus = Product(
    id: 6,
    category: AppData.categories[6],
    name: "Lantus",
    scientificName: "Insulin glargine",
    brand: "Sanofi",
    description:
        "Lantus is a long-acting insulin analogue used to manage diabetes by helping control blood sugar levels throughout the day and night",
    expirationDate: _date,
    price: 38500,
    image: AppProductsImages.lantus,
    inStock: 15,
    isFavorite: false,
  );
  // ignore: non_constant_identifier_names
  static Product Cortizone = Product(
    id: 7,
    category: AppData.categories[5],
    name: "Cortizone",
    scientificName: "Hydrocortisone",
    brand: "Bayer",
    description:
        "Cortizone is a topical corticosteroid that helps relieve itching, redness, and inflammation associated with various skin conditions, providing effective relief for skin irritation",
    expirationDate: _date,
    price: 26500,
    image: AppProductsImages.cortizone,
    inStock: 86,
    isFavorite: false,
  );
  // ignore: non_constant_identifier_names
  static Product Centrum = Product(
    id: 8,
    category: AppData.categories[9],
    name: "Centrum",
    scientificName: "Multivitamins",
    brand: "Pfizer",
    description:
        "Centrum is a comprehensive multivitamin supplement that supports overall health by providing essential vitamins and minerals, promoting vitality and well-being",
    expirationDate: _date,
    price: 31500,
    image: AppProductsImages.centrum,
    inStock: 49,
    isFavorite: false,
  );
  // ignore: non_constant_identifier_names
  static Product OrthoTriCyclen = Product(
    id: 9,
    category: AppData.categories[10],
    name: "Ortho Tri-Cyclen",
    scientificName: "Ethinyl estradiol",
    brand: "Janssen Pharmaceuticals",
    description:
        "Ortho Tri-Cyclen is an oral contraceptive (birth control pill) that combines different hormones to prevent ovulation and alter the cervical mucus and uterine lining, providing effective contraception for women",
    expirationDate: _date,
    price: 52000,
    image: AppProductsImages.orthoTriCyclen,
    inStock: 26,
    isFavorite: false,
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
    Category(id: 0, name: "All".tr),
    Category(id: 1, name: ProductType.Antibiotics),
    Category(id: 2, name: ProductType.AllergyMedications),
    Category(id: 3, name: ProductType.CardiovascularMedications),
    Category(id: 4, name: ProductType.ColdAndFlu),
    Category(id: 5, name: ProductType.DermatologicalProducts),
    Category(id: 6, name: ProductType.DiabetesManagement),
    Category(id: 7, name: ProductType.DigestiveHealth),
    Category(id: 8, name: ProductType.PainAndRelief),
    Category(id: 9, name: ProductType.VitaminsAndSupplements),
    Category(id: 10, name: ProductType.WomenHealth),
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
