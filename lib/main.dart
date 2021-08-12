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
        home: HomePage(),
        theme: ThemeData(
          fontFamily: 'ProductSans',
          primaryColor: Colors.white,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            elevation: 0,
            foregroundColor: Colors.white,
          ),
          brightness: Brightness.light,
          accentColor: Colors.redAccent,
          dividerColor: Colors.redAccent,
          focusColor: Colors.redAccent,
          hintColor: Colors.redAccent,
          textTheme: TextTheme(
            headline2: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: Colors.redAccent,
              height: 1.4,
            ),
            headline3: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.3,
            ),
            headline4: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              color: Colors.redAccent,
              height: 1.3,
            ),
            subtitle1: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 1.3,
            ),
            caption: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
              height: 1.2,
            ),
          ),
        ),
      ),
    );
  }
}
