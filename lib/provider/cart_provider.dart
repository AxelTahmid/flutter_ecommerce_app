import 'package:flutter/material.dart';
import 'package:we_deliver_bd/api_service.dart';
import 'package:we_deliver_bd/models/cart_request_model.dart';
import 'package:we_deliver_bd/models/cart_response_model.dart';

class CartProvider with ChangeNotifier {
  APIService _apiService;
  List<CartItem> _cartItems;

  List<CartItem> get CartItems => _cartItems;
  double get totalRecords => _cartItems.length.toDouble();

  CartProvider() {
    _apiService = APIService();
    _cartItems = [];
  }

  void resetStreams() {
    _apiService = APIService();
    _cartItems = [];
  }

  void addToCart(
    CartProducts product,
    Function onCallback,
  ) async {
    CartRequestModel requestModel = CartRequestModel();
    // requestModel.products = List<CartProducts>() ;
    requestModel.products = [];

    if (_cartItems == null) resetStreams();

    _cartItems.forEach((element) {
      requestModel.products.add(new CartProducts(
          productId: element.productId, quantity: element.qty));
    });

    var isProductExist = requestModel.products.firstWhere(
      (prd) => prd.productId == product.productId,
      orElse: () => null,
    );

    if (isProductExist != null) {
      requestModel.products.remove(isProductExist);
    }

    requestModel.products.add(product);

    await _apiService.addtoCart(requestModel).then((cartResponseModel) {
      if (cartResponseModel != null) {
        _cartItems = [];
        _cartItems.addAll(cartResponseModel.data);
      }
      onCallback(cartResponseModel);
      notifyListeners();
    });
  }
}
