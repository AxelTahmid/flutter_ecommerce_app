import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_deliver_bd/models/order.dart';
import 'package:we_deliver_bd/provider/order_provider.dart';
import 'package:we_deliver_bd/widgets/widget_order_item.dart';

class OrderPage extends StatefulWidget {
  OrderPage({Key key}) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  List<OrderModel> orders;

  @override
  void initState() {
    super.initState();
    var orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.fetchOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
      builder: (context, ordersModel, child) {
        if (ordersModel.allOrders != null && ordersModel.allOrders.length > 0) {
          _listView(context, ordersModel.allOrders);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //_listView(context, orders);
  }

  Widget _listView(BuildContext context, List<OrderModel> order) {
    return ListView(
      children: [
        ListView.builder(
          itemCount: order.length,
          physics: ScrollPhysics(),
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: WidgetOrderItem(
                orderModel: order[index],
              ),
            );
          },
        ),
      ],
    );
  }
}
