import 'package:get/get.dart';

class AppLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {
          // start
          "welcomeMessage": "أهلاً بعودتك",

          // auth
          "enterCredentials": "من فضلك أدخل بياناتك الائتمانية",
          "signIn": "تسجيل الدخول",
          "userNumber": "رقم المستخدم",
          "password": "كلمة المرور",
          "notAMember": " لست عضواً؟ ",
          "alreadyHaveAnAccount": "تملك حساباً مسبقاً؟ ",
          "register": "إنشاء حساب",
          "signUp": "التسجيل",
          "pharmacyName": "اسم الصيدلية",
          "userName": "اسم المستخدم",
          "confirmPassword": "تأكيد كلمة المرور",
          "fieldIsRequired": "هذا الحقل مطلوب",
          "phoneNumberShouldStart": "رقم الهاتف يجب أن يبدأ ب 09",
          "phoneNumberLength": "يجب أن يتألف رقم الهاتف من 10 خانات",
          "enterValidNumber": "من فضلك ادخل رقماً صالحاً",
          "passwordShouldBe8": "يجب أن تتألف كلمة المرور من 8 محارف على الأقل",
          "passwordsDontMatch": "كلمتا المرور لا تتطابقان",
          "letsCreateAnAccount": "لننشئ حساباً من أجلك",

          // snack bar messages
          "signedInSuccess": "تم تسجيل الدخول بنجاح !",
          "registerSuccess": "تم تسجيل الحساب بنجاح !",
          "close": "أغلق",

          // botton nav bar
          "home": "الرئيسية",
          "search": "البحث",
          "cart": "سلة المشتريات",
          "orders": "الطلبات",
          "favourite": "المفضلة",
        },
        "en": {
          //start
          "welcomeMessage": "Welcome back",

          // auth
          "enterCredentials": "Please enter your credentials to Login",
          "signIn": "Sign in",
          "userNumber": "User Number",
          "password": "Password",
          "alreadyHaveAnAccount": "Already have an account? ",
          "register": "Register",
          "notAMember": "Not a member? ",
          "signUp": "Sign up",
          "pharmacyName": "Pharmacy Name",
          "userName": "User Name",
          "confirmPassword": "Confirm Password",
          "fieldIsRequired": "Field is required",
          "phoneNumberShouldStart": "Phone number should start with 09",
          "phoneNumberLength": "Phone number length should be 10 digits",
          "enterValidNumber": "Please enter a valid number",
          "passwordShouldBe8": "Password should be at least 8 characters",
          "passwordsDontMatch": "Passwords don't match",
          "letsCreateAnAccount": "Let's create an account for you",

          // snack bar messages
          "signedInSuccess": "Signed in successfully !",
          "registerSuccess": "Signed up successfully! ",
          "close": "Close",

          // botton nav bar
          "home": "Home",
          "search": "Search",
          "cart": "Cart",
          "orders": "Orders",
          "favourite": "Favourite",
        },
      };
}
