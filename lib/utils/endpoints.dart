import 'package:get_storage/get_storage.dart';

class Endpoints {
  static var box = GetStorage();
  // static String baseUrl = "http://10.0.2.2:9099";
  static String baseUrl = "https://protsahanadmin.dhakadgroup.com/api";
  static String imageUrl = "https://protsahanadmin.dhakadgroup.com/storage/app/";
  static String login = "/login";
    static String editProfile = "/update-profile";

// Contractor
  static String addContractor = "/add-contractor";
  static String getContractor = "/list-contractor";
  static String editContractor = "/edit-contractor";
//product
  static String addProduct = "/add-product";
  static String getProduct = "/list-product";
  static String editProduct = "/edit-product";
//gift
  static String addGift = "/add-gift";
  static String getlistGift = "/list-gift";
  static String editGift = "/edit-gift";
  static String delete = "/delete?";

  //Allocation
  static String addAllocation = "/add-allocation";
  static String getAllocation = "/list-allocation";
  static String editAllocation = "/edit-allocation";

  //redemption
  static String addRedemption = "/add-redemption";
  static String getRedemption = "/list-redemption";

  static String privacyPolicy = "https://dhakadgroup.com/privacy-policy/";
  static String termsCondition = "https://dhakadgroup.com/terms-and-uses/";
  static String disclaimer = "https://dhakadgroup.com/about-us/";
  static String aboutUs = "https://dhakadgroup.com/about-us/";
}
