import 'package:flutter/material.dart';
import 'package:we_deliver_bd/pages/cart_page.dart';
import 'package:we_deliver_bd/pages/dashboard_page.dart';
import 'package:we_deliver_bd/pages/login_page.dart';
import 'package:we_deliver_bd/pages/my_account.dart';
import 'package:we_deliver_bd/pages/verify_address.dart';
import 'package:we_deliver_bd/utils/cart_icons.dart';

import '../color_constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.selectedPage}) : super(key: key);
  int selectedPage;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _widgetList = [
    DashboardPage(),
    CartPage(),
    LoginPage(),
    MyAccount(),
  ];

  int _index = 0;

  @override
  void initState() {
    super.initState();

    if (this.widget.selectedPage != null) {
      _index = this.widget.selectedPage;
    }
  }

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
