import 'package:flutter/material.dart';
import 'package:we_deliver_bd/api_service.dart';
import 'package:we_deliver_bd/models/cart_request_model.dart';
import 'package:we_deliver_bd/models/cart_response_model.dart';
import 'package:we_deliver_bd/models/customer_detail_mode.dart';

class CartProvider with ChangeNotifier {
  APIService _apiService;
  List<CartItem> _cartItems;
  CustomerDetailsModel _customerDetailsModel;

  List<CartItem> get cartItems => _cartItems;
  double get totalRecords => _cartItems.length.toDouble();
  double get totalAmount => _cartItems != null
      ? _cartItems
          .map((e) => e.lineSubtotal)
          .reduce((value, element) => value + element)
      : 0;

  CustomerDetailsModel get customerDetailsModel => _customerDetailsModel;

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
    requestModel.products = <CartProducts>[];

    if (_cartItems == null) {
      await fetchCartItems();
    }

    _cartItems.forEach((e) {
      requestModel.products.add(
        new CartProducts(
          productId: e.productId,
          quantity: e.qty,
          variationId: e.variationId,
        ),
      );
    });

    var isProductExist = requestModel.products.firstWhere(
      (prd) =>
          prd.productId == product.productId &&
          prd.variationId == product.variationId,
      orElse: () => null,
    );

    if (isProductExist != null) {
      requestModel.products.remove(isProductExist);
    }

    requestModel.products.add(product);

    await _apiService.addtoCart(requestModel).then((cartResponseModel) {
      if (cartResponseModel != null) {
        //check with breakpoint
        _cartItems = [];
        _cartItems.addAll(cartResponseModel.data);
      }
      onCallback(cartResponseModel);
      notifyListeners();
    });
  }

  fetchCartItems() async {
    if (_cartItems == null) resetStreams();

    await _apiService.getCartItems().then((cartResponseModel) {
      if (cartResponseModel.data != null) {
        _cartItems.addAll(cartResponseModel.data);
      }
      notifyListeners();
    });
  }

  void updateQty(int productId, int qty, {int variationId = 0}) {
    var isProductExist = _cartItems.firstWhere(
        (prd) => prd.productId == productId && prd.variationId == variationId,
        orElse: () => null);

    if (isProductExist != null) {
      isProductExist.qty = qty;
    }
    notifyListeners();
  }

  void updateCart(Function onCallback) async {
    CartRequestModel requestModel = CartRequestModel();
    // requestModel.products = List<CartProducts>() ;
    requestModel.products = <CartProducts>[];

    if (_cartItems == null) resetStreams();

    _cartItems.forEach((e) {
      requestModel.products.add(
        new CartProducts(
          productId: e.productId,
          quantity: e.qty,
          variationId: e.variationId,
        ),
      );
    });

    await _apiService.addtoCart(requestModel).then((cartResponseModel) {
      if (cartResponseModel != null) {
        _cartItems = [];
        _cartItems.addAll(cartResponseModel.data);
      }
      onCallback(cartResponseModel);
      notifyListeners();
    });
  }

  void removeItem(int productId) {
    var isProductExist = _cartItems
        .firstWhere((prd) => prd.productId == productId, orElse: () => null);

    if (isProductExist != null) {
      _cartItems.remove(isProductExist);
    }
    notifyListeners();
  }

  fetchShippingDetails() async {
    if (_customerDetailsModel == null) {
      _customerDetailsModel = CustomerDetailsModel();
    }
    _customerDetailsModel = await _apiService.customerDetails();
    notifyListeners();
  }
}
