class CartResponseModel {
  bool status;
  List<CartItem> data;

  CartResponseModel({this.status, this.data});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(new CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CartItem {
  int productId;
  String productName;
  String productRegularPrice;
  String productSalePrice;
  String thumbnail;
  int qty;
  double lineSubtotal;
  double lineTotal;
  int variationId;
  String attribute;
  String attributeValue;

  CartItem({
    this.productId,
    this.productName,
    this.productRegularPrice,
    this.productSalePrice,
    this.thumbnail,
    this.qty,
    this.lineSubtotal,
    this.lineTotal,
    this.variationId,
    this.attribute,
    this.attributeValue,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productRegularPrice = json['product_regular_price'];
    productSalePrice = json['product_sale_price'];
    thumbnail = json['thumbnail'];
    qty = json['qty'];
    lineSubtotal = double.parse(json['line_subtotal'].toString());
    lineTotal = double.parse(json['line_total'].toString());

    variationId = json['variation_id'];
    attribute = (json['attribute'].toString() != "[]")
        ? Map<String, dynamic>.from(json['attribute']).keys.first.toString()
        : "";
    attributeValue = (json['attribute'].toString() != "[]")
        ? Map<String, dynamic>.from(json['attribute']).values.first.toString()
        : "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_regular_price'] = this.productRegularPrice;
    data['product_sale_price'] = this.productSalePrice;
    data['thumbnail'] = this.thumbnail;
    data['qty'] = this.qty;
    data['line_subtotal'] = this.lineSubtotal;
    data['line_total'] = this.lineTotal;
    data['variation_id'] = this.variationId;
    //not needed, no method for it in api
    // data['attribute' ] = this.attribute;
    // data['attribute' ] =  this.attributeValue;
    return data;
  }
}
