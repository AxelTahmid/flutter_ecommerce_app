import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:we_deliver_bd/models/cart_response_model.dart';
import 'package:we_deliver_bd/provider/cart_provider.dart';
import 'package:we_deliver_bd/provider/loader_provider.dart';
import 'package:we_deliver_bd/utils/custom_stepper.dart';
import 'package:we_deliver_bd/utils/utils.dart';

import '../color_constants.dart';

class CartProduct extends StatelessWidget {
  CartProduct({Key key, this.data}) : super(key: key);
  CartItem data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: makeListTitle(context),
      ),
    );
  }

  ListTile makeListTitle(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        leading: Container(
          width: 50,
          height: 150,
          alignment: Alignment.center,
          child: Image.network(
            data.thumbnail,
            height: 150,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            data.variationId == 0
                ? data.productName
                : "${data.productName} (${data.attributeValue}${data.attribute})",
            style: TextStyle(
              color: ColorConstants.kSecondaryTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.all(5),
          child: Wrap(
            direction: Axis.vertical,
            children: [
              Text(
                "${data.productSalePrice.toString()}৳",
                style: TextStyle(
                  color: ColorConstants.kSecondaryTextColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  Utils.showMessage(
                    context,
                    "WeDeliver",
                    "Do you want to remove this item?",
                    "Yes",
                    () {
                      Provider.of<LoaderProvider>(context, listen: false)
                          .setLoadingStatus(true);
                      Provider.of<CartProvider>(context, listen: false)
                          .removeItem(data.productId);
                      Provider.of<LoaderProvider>(context, listen: false)
                          .setLoadingStatus(false);

                      Navigator.of(context).pop();
                    },
                    buttonText2: "No",
                    isConfirmationDialog: true,
                    onPressed2: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.delete,
                      color: ColorConstants.kPrimaryTextColor,
                      size: 20,
                    ),
                    Text(
                      "Remove",
                      style: TextStyle(
                        color: ColorConstants.kPrimaryTextColor,
                      ),
                    ),
                  ],
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(8),
                  backgroundColor: ColorConstants.kPrimaryLightColor,
                  shape: StadiumBorder(),
                ),
              ),
            ],
          ),
        ),
        trailing: Container(
          width: 120,
          child: CustomStepper(
            lowerLimit: 0,
            upperLimit: 20,
            stepValue: 1,
            iconSize: 22.0,
            value: data.qty,
            onChanged: (value) {
              Provider.of<CartProvider>(context, listen: false).updateQty(
                  data.productId, value,
                  variationId: data.variationId);
            },
          ),
        ),
      );
}
