import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:we_deliver_bd/config.dart';
import 'package:we_deliver_bd/models/cart_request_model.dart';
import 'package:we_deliver_bd/models/cart_response_model.dart';
import 'package:we_deliver_bd/models/category.dart';
import 'package:we_deliver_bd/models/customer.dart';
import 'package:we_deliver_bd/models/customer_detail_mode.dart';
import 'package:we_deliver_bd/models/login_model.dart';
import 'package:we_deliver_bd/models/order.dart';
import 'package:we_deliver_bd/models/product.dart';
import 'package:we_deliver_bd/models/variable_product.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel model) async {
    var authToken = base64.encode(
      utf8.encode(Config.key + ":" + Config.secret),
    );

    bool ret = false;

    try {
      var response = await Dio().post(Config.url + Config.customerURL,
          data: model.toJson(),
          options: new Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: "application/json"
          }));

      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      // ! add to response for null safety
      if (e.response.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }

    return ret;
  }

  Future<LoginResponseModel> loginCustomer(
    String username,
    String password,
  ) async {
    LoginResponseModel model;

    try {
      var response = await Dio().post(
        Config.tokenURL,
        data: {
          "username": username,
          "password": password,
        },
        options: new Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
          },
        ),
      );
      if (response.statusCode == 200) {
        model = LoginResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.message);
    }

    return model;
  }

  Future<List<Category>> getCategories() async {
    // List<Category> data = new List<Category>();  //depreaceated
    List<Category> data = [];

    try {
      String url = Config.url +
          Config.categoriesURL +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";

      var response = await Dio().get(
        url,
        options: new Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Category.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      print(e.message);
    }

    return data;
  }

  Future<List<Product>> getProducts({
    int pageNumber,
    int pageSize,
    String strSearch,
    String tagName,
    String categoryId,
    String sortBy,
    String sortOrder = "asc",
    List<int> productsIDs,
  } //curly for optional parameter
      ) async {
    List<Product> data = [];

    try {
      String parameter = "";

      if (strSearch != null) {
        parameter += "&search=$strSearch";
      }

      if (pageSize != null) {
        parameter += "&per_page=$pageSize";
      }

      if (pageNumber != null) {
        parameter += "&page=$pageNumber";
      }

      if (tagName != null) {
        parameter += "&tag=$tagName";
      }

      if (categoryId != null) {
        parameter += "&category=$categoryId";
      }

      if (sortBy != null) {
        parameter += "&orderby=$sortBy";
      }

      if (sortOrder != null) {
        parameter += "&order=$sortOrder";
      }

      if (productsIDs != null) {
        parameter += "&include=${productsIDs.join(",").toString()}";
      }

      String url = Config.url +
          Config.productsURL +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}${parameter.toString()}";

      var response = await Dio().get(
        url,
        options: new Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (i) => Product.fromJson(i),
            )
            .toList();
      }
    } on DioError catch (e) {
      print(e.message);
    }

    return data;
  }

  Future<CartResponseModel> addtoCart(CartRequestModel model) async {
    //turned string to int in config
    model.userId = Config.userId;

    CartResponseModel responseModel;

    try {
      var response = await Dio().post(
        Config.url + Config.addtoCartURL,
        data: model.toJson(),
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        responseModel = CartResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 400) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }

    return responseModel;
  }

  Future<CartResponseModel> getCartItems() async {
    CartResponseModel responseModel;

    try {
      String url = Config.url +
          Config.cartURL +
          "?user_id=${Config.userId}&consumer_key=${Config.key}&consumer_secret=${Config.secret}";
      // print(url);

      var response = await Dio().get(
        url,
        options: Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        responseModel = CartResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.response);
    }

    return responseModel;
  }

  Future<List<VariableProduct>> getVariableProducts(int productId) async {
    List<VariableProduct> responseModel;

    try {
      String url = Config.url +
          Config.productsURL +
          "/${productId.toString()}/${Config.variableProductsURL}?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
      // print(url);

      var response = await Dio().get(url,
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          }));

      if (response.statusCode == 200) {
        responseModel = (response.data as List)
            .map((e) => VariableProduct.fromJson(e))
            .toList();
      }
    } on DioError catch (e) {
      print(e.response);
    }

    return responseModel;
  }

  Future<CustomerDetailsModel> customerDetails() async {
    CustomerDetailsModel responseModel;

    try {
      String url = Config.url +
          Config.customerURL +
          "/${Config.userId}?consumer_key=${Config.key}&consumer_secret=${Config.secret}";

      var response = await Dio().get(
        url,
        options: new Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        responseModel = CustomerDetailsModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }
    return responseModel;
  }

  Future<bool> createOrder(OrderModel model) async {
    model.customerId = Config.userId;

    bool isOrderCreated = false;
    var authtoken = base64.encode(
      utf8.encode(Config.key + ":" + Config.secret),
    );

    try {
      var response = await Dio().post(
        Config.url + Config.orderURL,
        data: model.toJson(),
        options: new Options(
          headers: {
            HttpHeaders.authorizationHeader: "Basic $authtoken",
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        isOrderCreated = true;
      }
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }

    return isOrderCreated;
  }

  Future<List<OrderModel>> getOrders() async {
    List<OrderModel> data = [];

    try {
      String url = Config.url +
          Config.orderURL +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
      print(url);

      var response = await Dio().get(
        url,
        options: new Options(
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
        ),
      );
      if (response.statusCode == 200) {
        data = (response.data as List)
            .map(
              (e) => OrderModel.fromJson(e),
            )
            .toList();
      }
    } on DioError catch (e) {
      print(e.response);
    }

    return data;
  }
} //ends here. methods above
