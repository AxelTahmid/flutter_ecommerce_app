class Config {
  //WeDeliververFlutter
  static String key = "";
  static String secret = "";

  static String url = "https://wedeliver-bd.com//wp-json/wc/v3/";
  static String customerURL = "customers";
  static String tokenURL =
      "https://wedeliver-bd.com//wp-json/jwt-auth/v1/token";
  static String categoriesURL = "products/categories";
  static String productsURL = "products";
  static String offersTagID = '264';
  static String trendingTagID = '265';
  static String addtoCartURL = "addtocart";
  static String cartURL = "cart";
  static int userId = 20; //for testing, picked my id
  static String variableProductsURL = "variations";
  static String orderURL = "orders";
  static String currency = "৳";
}

//max 10 items shown in category lists, top saver, top trending

//token key in auth wp-config
// define('JWT_AUTH_SECRET_KEY', 'jU&f@]6-RN>[9EM:bL^19@@==-,q1G5UW[xF-JDR0^%bRw1rvW~Gq-+T+eAMJG0@');
