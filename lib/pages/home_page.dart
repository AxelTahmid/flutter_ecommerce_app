import 'package:flutter/material.dart';
import 'package:we_deliver_bd/models/payment_method.dart';
import 'package:we_deliver_bd/pages/cart_page.dart';
import 'package:we_deliver_bd/pages/dashboard_page.dart';
import 'package:we_deliver_bd/pages/payment_screen.dart';
import 'package:we_deliver_bd/utils/cart_icons.dart';
import 'package:we_deliver_bd/widgets/widget_payment_method_list_item.dart';

import '../color_constants.dart';

class HomePage extends StatefulWidget {
  // HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _widgetList = [
    DashboardPage(),
    CartPage(),
    DashboardPage(),
    PaymentScreen(),
    // PaymentMethodListItem(
    //   paymentMethod: new PaymentMethod(
    //     "cod",
    //     "Cash On Delivery",
    //     "Click to pay Cash On Delivery",
    //     "assets/img/cash.png",
    //     "/OrderSuccess",
    //     () {},
    //     false,
    //   ),
    // )
  ];

  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CartIcons.home),
            label: ' Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(CartIcons.cart),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(CartIcons.favourites),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(CartIcons.account),
            label: 'My Account',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: _widgetList[_index],
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.green,
      automaticallyImplyLeading: false,
      title: Text(
        "WeDeliver App",
        style: TextStyle(color: ColorConstants.kPrimaryTextColor),
      ),
      actions: [
        Icon(
          Icons.notifications_none,
          color: ColorConstants.kPrimaryTextColor,
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          Icons.shopping_cart,
          color: ColorConstants.kPrimaryTextColor,
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
} //final bracket
