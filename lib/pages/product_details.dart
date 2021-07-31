import 'package:flutter/material.dart';
import 'package:we_deliver_bd/models/product.dart';
import 'package:we_deliver_bd/pages/base_page.dart';
import 'package:we_deliver_bd/widgets/widget_product_details.dart';

class ProductDetails extends BasePage {
  ProductDetails({Key key, this.product}) : super(key: key);

  Product product;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends BasePageState<ProductDetails> {
  @override
  Widget pageUI() {
    return ProductDetailsWidget(
      data: this.widget.product,
    );
  }
}
