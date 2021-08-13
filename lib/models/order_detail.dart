import 'package:we_deliver_bd/models/customer_detail_mode.dart';

class OrderDetailModel {
  int orderId;
  String orderNumber;
  String paymentMethod;
  String orderStatus;
  DateTime orderDate;
  Shipping shipping;
  List<LineItems> lineItems;
  double totalAmount;
  double shippingTotal;
  double itemtotalAmount;

  OrderDetailModel({
    this.orderId,
    this.orderNumber,
    this.paymentMethod,
    this.orderStatus,
    this.orderDate,
    this.shipping,
    this.lineItems,
    this.totalAmount,
    this.shippingTotal,
  });

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    orderId = json['id'];
    orderNumber = json['order_key'];
    paymentMethod = json['payment_method_title'];
    orderStatus = json['status'];
    orderDate = DateTime.parse(json['date_created']);
    shipping = json['shipping'] != null
        ? new Shipping.fromJson(json['shipping'])
        : null;
    if (json['line_items'] != null) {
      lineItems = [];
      json['line_items'].forEach((v) {
        lineItems.add(LineItems.fromJson(v));
      });

      itemtotalAmount = lineItems != null
          ? lineItems.map<double>((m) => m.totalAmount).reduce((a, b) => a + b)
          : 0;
    }

    totalAmount = double.parse(json['total']);
    shippingTotal = double.parse(json['shipping_total']);
  }
}

class LineItems {
  int productId;
  String productName;
  int quantity;
  int variationId;
  double totalAmount;

  LineItems({
    this.productId,
    this.productName,
    this.quantity,
    this.variationId,
    this.totalAmount,
  });

  LineItems.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['name'];
    variationId = json['variation_id'];
    quantity = json['quantity'];
    totalAmount = double.parse(json['total']);
  }
}
