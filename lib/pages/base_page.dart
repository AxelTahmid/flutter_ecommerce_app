import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_deliver_bd/color_constants.dart';
import 'package:we_deliver_bd/provider/cart_provider.dart';
import 'package:we_deliver_bd/provider/loader_provider.dart';
import 'package:we_deliver_bd/utils/ProgressHUD.dart';

class BasePage extends StatefulWidget {
  BasePage({Key key}) : super(key: key);

  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  bool isApiCallProcess = false;
  String pageTitle = "WeDeliver App";

  @override
  void initState() {
    super.initState();
    //print('BasePage: initState()');

    // var mastersBloc = Provider.of<MastersProvider>(context, listen: false);
    // mastersBloc.resetStreams();
    // mastersBloc.fetchAllMasters();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(
      builder: (context, loaderModel, child) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: ProgressHUD(
            child: pageUI(),
            inAsyncCall: loaderModel.isApiCallProcess,
            opacity: 0.3,
          ),
        );
      },
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.green,
      automaticallyImplyLeading: true,
      title: Text(
        pageTitle,
        style: TextStyle(color: ColorConstants.kPrimaryTextColor),
      ),
      actions: <Widget>[
        Icon(Icons.notifications_none, color: ColorConstants.kPrimaryTextColor),
        SizedBox(
          width: 10,
        ),
        // Icon(Icons.shopping_cart, color: ColorConstants.kPrimaryTextColor),
        // SizedBox(
        //   width: 10,
        // ),
        new Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
            height: 150.0,
            width: 30.0,
            child: new GestureDetector(
              onTap: () {},
              child: new Stack(
                children: <Widget>[
                  new IconButton(
                    icon: new Icon(
                      Icons.shopping_cart,
                      color: ColorConstants.kPrimaryTextColor,
                    ),
                    onPressed: null,
                  ),
                  Provider.of<CartProvider>(context, listen: false)
                              .cartItems
                              .length ==
                          0
                      ? new Container()
                      : new Positioned(
                          child: new Stack(
                            children: <Widget>[
                              new Icon(
                                Icons.brightness_1,
                                size: 22.0,
                                color: ColorConstants
                                    .kSecondaryColor[800], //Colors.green[800],
                              ),
                              new Positioned(
                                top: 3.0,
                                right: 5.0,
                                child: new Center(
                                  child: new Text(
                                    Provider.of<CartProvider>(context,
                                            listen: false)
                                        .cartItems
                                        .length
                                        .toString(),
                                    style: new TextStyle(
                                      color: ColorConstants.kPrimaryTextColor,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget pageUI() {
    return null;
  }

  @override
  void dispose() {
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:we_deliver_bd/provider/loader_provider.dart';
// import 'package:we_deliver_bd/utils/ProgressHUD.dart';

// //notification for cart icon, needs work, code misssing

// class BasePage extends StatefulWidget {
//   BasePage({Key key}) : super(key: key);

//   @override
//   BasePageState createState() => BasePageState();
// }

// class BasePageState<T extends BasePage> extends State<T> {
//   bool isApiCallProcess = false;
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<LoaderProvider>(builder: (context, loaderModel, child) {
//       return Scaffold(
//         appBar: _buildAppBar(),
//         body: ProgressHUD(
//           child: pageUI(),
//           inAsyncCall: loaderModel.isApiCallProcess,
//           opacity: 0.3,
//         ),
//       );
//     });
//   }

//   Widget pageUI() {
//     return null;
//   }

//   Widget _buildAppBar() {
//     return AppBar(
//       centerTitle: true,
//       brightness: Brightness.dark,
//       elevation: 0,
//       backgroundColor: Colors.redAccent,
//       automaticallyImplyLeading: true,
//       title: Text(
//         "WeDeliver",
//         style: TextStyle(color: ColorConstants.kPrimaryTextColor),
//       ),
//       actions: [
//         Icon(
//           Icons.notifications_none,
//           color: ColorConstants.kPrimaryTextColor,
//         ),
//         SizedBox(
//           width: 10,
//         ),
//         Icon(
//           Icons.shopping_cart,
//           color: ColorConstants.kPrimaryTextColor,
//         ),
//         SizedBox(
//           width: 10,
//         ),
//       ],
//     );
//   }
// }
