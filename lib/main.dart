import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_deliver_bd/pages/base_page.dart';
import 'package:we_deliver_bd/pages/cart_page.dart';
import 'package:we_deliver_bd/pages/home_page.dart';
import 'package:we_deliver_bd/pages/product_details.dart';
import 'package:we_deliver_bd/pages/product_page.dart';
import 'package:we_deliver_bd/provider/cart_provider.dart';
import 'package:we_deliver_bd/provider/loader_provider.dart';
import 'package:we_deliver_bd/provider/products_provider.dart';

import 'color_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: ProductPage(),
        ),
        ChangeNotifierProvider(
          create: (context) => LoaderProvider(),
          child: BasePage(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
          child: ProductDetails(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
          child: CartPage(),
        ),
      ],
      child: MaterialApp(
        title: 'WooCommerce App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Poppins',
          primaryColor: Colors.white,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0,
            foregroundColor: Colors.white,
          ),
          accentColor: ColorConstants.kPrimaryLightColor,
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 22.0, color: ColorConstants.kPrimaryLightColor),
              headline2: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                color: ColorConstants.kPrimaryLightColor,
              ),
              bodyText1: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: Colors.blueAccent,
              )),
        ),
        home: HomePage(),
      ),
    );
  }
}
