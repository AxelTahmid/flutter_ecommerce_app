import 'package:flutter/material.dart';
import 'package:we_deliver_bd/models/product.dart';
import 'package:we_deliver_bd/pages/product_details.dart';

import '../color_constants.dart';

class ProductCard extends StatelessWidget {
  ProductCard({Key key, this.data}) : super(key: key);

  Product data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(
              product: data,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0XFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
          ],
        ),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Visibility(
                    visible: data.calculateDiscount() > 0,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: ColorConstants.kSecondaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${data.calculateDiscount()}% OFF',
                          style: TextStyle(
                            color: ColorConstants.kPrimaryTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xffE65829).withAlpha(40),
                        ),
                        Image.network(
                          //data.images.length > 0 //culprit
                          data.images != null
                              ? data.images[0].src
                              : "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1200px-No_image_available.svg.png",
                          height: 160,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    data.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.kSecondaryTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: data.regularPrice != data.salePrice,
                        child: Text(
                          '${data.regularPrice}???',
                          style: TextStyle(
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough,
                            color: ColorConstants.kPrimaryLightColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        ' ${data.salePrice}???',
                        style: TextStyle(
                          fontSize: 14,
                          color: ColorConstants.kSecondaryTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
