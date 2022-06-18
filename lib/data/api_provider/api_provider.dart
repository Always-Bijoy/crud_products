class ApiProvider {
  // static const String baseUrl = "https://stg-zero.propertyproplus.com.au/api/TokenAuth/Authenticate";
  static const String baseUrl = "https://stg-zero.propertyproplus.com.au/api";
  static const String loginUrl = "$baseUrl/TokenAuth/Authenticate";
  static const String productsUrl =
      "$baseUrl/services/app/ProductSync/GetAllproduct";
  static const String createProduct = "$baseUrl/services/app/ProductSync/CreateOrEdit";
}
