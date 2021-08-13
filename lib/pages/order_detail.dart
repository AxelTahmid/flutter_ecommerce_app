import 'package:flutter/material.dart';
import 'package:we_deliver_bd/config.dart';
import 'package:we_deliver_bd/models/customer_detail_mode.dart';
import 'package:we_deliver_bd/models/order_detail.dart';
import 'package:we_deliver_bd/utils/widget_checkpoints.dart';

class OrderDetailsPage extends StatefulWidget {
  OrderDetailsPage({Key key}) : super(key: key);

  @override
  _OrderDetailsPageState createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  Widget build(BuildContext context) {
    OrderDetailModel orderDetailModel = OrderDetailModel();
    orderDetailModel.orderId = 1;
    orderDetailModel.orderDate = DateTime.parse("2020-12-09T20:39:49");
    orderDetailModel.paymentMethod = "Cash on Delivery";
    orderDetailModel.shipping = Shipping();
    orderDetailModel.shipping.address1 = "badda";
    orderDetailModel.shipping.address2 = "dhaka";
    orderDetailModel.shipping.state = "BD";
    orderDetailModel.shipping.city = "dhaka";

    orderDetailModel.lineItems = <LineItems>[];
    orderDetailModel.lineItems.add(
      LineItems(
        productId: 1,
        productName: "test",
        quantity: 10,
        totalAmount: 100,
      ),
    );

    return orderDetailUI(orderDetailModel);
  }

  Widget orderDetailUI(OrderDetailModel model) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("#${model.orderId.toString()}"),
          Text(model.orderDate.toString()),
          SizedBox(height: 20),
          Text("#Delivery Address"),
          Text(model.shipping.address1),
          Text(model.shipping.address2),
          Text("${model.shipping.city}, ${model.shipping.state}"),
          SizedBox(height: 20),
          Text("#Payment Method"),
          Text(model.paymentMethod),
          Divider(color: Colors.grey),
          SizedBox(height: 5),
          CheckPoints(
            checkedTill: 0,
            checkPoints: ["Processing", "Shipping", "Delivered"],
            checkPointFilledColor: Colors.redAccent,
          ),
          Divider(color: Colors.grey),
          _listOrderItems(model),
          Divider(color: Colors.grey),
        ],
      ),
    );
  }

  Widget _listOrderItems(OrderDetailModel model) {
    return ListView.builder(
      itemCount: model.lineItems.length,
      physics: ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _productItems(model.lineItems[index]);
      },
    );
  }

  Widget _productItems(LineItems product) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.all(2),
      onTap: () {},
      title: Text(product.productName),
      subtitle: Padding(
        padding: EdgeInsets.all(1),
        child: Text("Qty: ${product.quantity}"),
      ),
      trailing: Text("${product.totalAmount} ${Config.currency}"),
    );
  }

  Widget _itemTotal(String label, String value, {TextStyle textStyle}) {
    return;
  }
}
