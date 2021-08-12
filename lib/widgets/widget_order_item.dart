import 'package:flutter/material.dart';
import 'package:we_deliver_bd/models/order.dart';

class WidgetOrderItem extends StatelessWidget {
  WidgetOrderItem({Key key, this.orderModel}) : super(key: key);

  OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          _orderStatus(this.orderModel.status),
          Divider(color: Colors.grey),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              iconText(
                Icon(
                  Icons.edit,
                  color: Colors.green,
                ),
                Text(
                  "Order ID",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                this.orderModel.orderNumber.toString(),
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              iconText(
                Icon(
                  Icons.today,
                  color: Colors.green,
                ),
                Text(
                  "Order Date",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Text(
                this.orderModel.orderDate.toString(),
                style: TextStyle(
                  fontSize: 14,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              textButton(
                Row(
                  children: [
                    Text(" Order Details "),
                    Icon(Icons.chevron_right),
                  ],
                ),
                Colors.green,
                () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget iconText(Icon iconWidget, Text textWidget) {
    return Row(
      children: [
        //blue color because here
        iconWidget,
        SizedBox(width: 5),
        textWidget,
      ],
    );
  }

  Widget textButton(Widget iconText, Color color, Function onPressed) {
    return TextButton(
      onPressed: onPressed,
      child: iconText,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(5),
        backgroundColor: color,
        shape: StadiumBorder(),
      ),
    );
  }

  Widget _orderStatus(String status) {
    Icon icon;
    Color color;

    if (status == "pending" || status == "processing" || status == "on-hold") {
      icon = Icon(Icons.timer, color: Colors.orange);
      color = Colors.orange;
    } else if (status == "completed") {
      icon = Icon(Icons.check, color: Colors.green);
      color = Colors.green;
    } else if (status == "cancelled" ||
        status == "refunded" ||
        status == "failed") {
      icon = Icon(Icons.clear, color: Colors.redAccent);
      color = Colors.redAccent;
    } else {
      icon = Icon(Icons.clear, color: Colors.redAccent);
      color = Colors.redAccent;
    }

    return iconText(
      icon,
      Text(
        "Order $status",
        style: TextStyle(
          fontSize: 15,
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
