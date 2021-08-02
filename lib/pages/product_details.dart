import 'package:flutter/material.dart';
import 'package:we_deliver_bd/api_service.dart';
import 'package:we_deliver_bd/models/product.dart';
import 'package:we_deliver_bd/models/variable_product.dart';
import 'package:we_deliver_bd/pages/base_page.dart';
import 'package:we_deliver_bd/widgets/widget_product_details.dart';

class ProductDetails extends BasePage {
  ProductDetails({Key key, this.product}) : super(key: key);

  Product product;

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends BasePageState<ProductDetails> {
  APIService apiService;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget pageUI() {
    return this.widget.product.type == "variable"
        ? _variableProductsList()
        : ProductDetailsWidget(
            data: this.widget.product,
          );
  }

  Widget _variableProductsList() {
    apiService = APIService();
    return FutureBuilder(
      future: apiService.getVariableProducts(this.widget.product.id),
      builder:
          (BuildContext context, AsyncSnapshot<List<VariableProduct>> model) {
        if (model.hasData) {
          return ProductDetailsWidget(
            data: this.widget.product,
            variableProducts: model.data,
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
} // last
