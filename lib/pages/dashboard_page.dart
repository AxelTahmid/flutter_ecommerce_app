import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:we_deliver_bd/config.dart';
import 'package:we_deliver_bd/widgets/widget_home_categories.dart';
import 'package:we_deliver_bd/widgets/widget_home_products.dart';

class DashboardPage extends StatefulWidget {
  // DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            imageCarousel(context),
            WidgetCategories(),
            WidgetHomeProducts(
              labelName: "Top Savers Today!",
              tagId: Config.offersTagID,
            ),
            WidgetHomeProducts(
              labelName: "Trending Products!",
              tagId: Config.trendingTagID,
            )
          ],
        ),
      ),
    );
  }

  Widget imageCarousel(BuildContext context) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: 200.0,
      child: new Carousel(
        overlayShadow: false,
        borderRadius: true,
        boxFit: BoxFit.none,
        autoplay: true,
        dotSize: 4.0,
        images: [
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://images.unsplash.com/photo-1542838132-92c53300491e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1267&q=80"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1350&q=80"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://images.unsplash.com/photo-1583258292688-d0213dc5a3a8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1267&q=80"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child: Image.network(
                "https://wedeliver-bd.com/wp-content/uploads/2020/11/greenlogo.png"),
          )
        ],
      ),
    );
  }
} //last
