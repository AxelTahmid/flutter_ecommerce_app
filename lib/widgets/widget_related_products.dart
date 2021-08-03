import 'package:flutter/material.dart';
import 'package:we_deliver_bd/api_service.dart';
import 'package:we_deliver_bd/models/product.dart';

import '../color_constants.dart';

//does same as home products but with numbers instead of tagname, work on rdudancy later
class WidgetRelatedProducts extends StatefulWidget {
  WidgetRelatedProducts({Key key, this.labelName, this.products})
      : super(key: key);

  String labelName;
  List<int> products;

  @override
  _WidgetRelatedProductsState createState() => _WidgetRelatedProductsState();
}

class _WidgetRelatedProductsState extends State<WidgetRelatedProducts> {
  APIService apiService;

  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF4F7FA),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  this.widget.labelName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'View All',
                    style: TextStyle(color: ColorConstants.kPrimaryLightColor),
                  ),
                ),
              ),
            ],
          ),
          _productsList(),
        ],
      ),
    );
  }

  Widget _productsList() {
    return new FutureBuilder(
      future: apiService.getProducts(productsIDs: this.widget.products),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> model) {
        if (model.hasData) {
          return _buildProductsList(model.data);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildProductsList(List<Product> items) {
    return Container(
      height: 200,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          var data = items[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                width: 130,
                height: 120,
                alignment: Alignment.center,
                // child: Image.network(
                //   data.images[0].src,
                //   height: 120,
                // ),
                child: data.images != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          data.images[0].src,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1200px-No_image_available.svg.png",
                      ), //SizedBox.shrink(),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 5),
                        blurRadius: 15),
                  ],
                ),
              ),
              Container(
                width: 130,
                alignment: Alignment.centerLeft,
                child: Text(
                  data.name,
                  style: TextStyle(
                    fontSize: 14,
                    color: ColorConstants.kSecondaryTextColor,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4, left: 4),
                width: 130,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(
                      '${data.regularPrice}৳',
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.lineThrough,
                        color: ColorConstants.kPrimaryLightColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      ' ${data.salePrice}৳',
                      style: TextStyle(
                        fontSize: 14,
                        color: ColorConstants.kSecondaryTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
} // last
