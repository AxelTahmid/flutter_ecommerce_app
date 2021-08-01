import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:we_deliver_bd/models/cart_response_model.dart';
import 'package:we_deliver_bd/provider/cart_provider.dart';
import 'package:we_deliver_bd/utils/custom_stepper.dart';

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
            data.productName,
            style: TextStyle(
              color: Colors.black,
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
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 20,
                    ),
                    Text(
                      "Remove",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(8),
                  backgroundColor: Colors.redAccent,
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
              Provider.of<CartProvider>(context, listen: false)
                  .updateQty(data.productId, value);
            },
          ),
        ),
      );
}
