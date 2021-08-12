import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_deliver_bd/provider/loader_provider.dart';
import 'package:we_deliver_bd/utils/ProgressHUD.dart';

class CheckoutBasePage extends StatefulWidget {
  CheckoutBasePage({Key key}) : super(key: key);

  @override
  CheckoutBasePageState createState() => CheckoutBasePageState();
}

class CheckoutBasePageState<T extends CheckoutBasePage>
    extends State<CheckoutBasePage> {
  int currentPage = 0;
  bool showBackbutton = true;

  @override
  void initState() {
    super.initState();
    print('CheckoutBasePage: initState()');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(builder: (context, loaderModel, child) {
      return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.white,
        body: ProgressHUD(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(
                  color: Colors.grey,
                ),
                pageUI()
              ],
            ),
          ),
          inAsyncCall: loaderModel.isApiCallProcess,
          opacity: 0.3,
        ),
      );
    });
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.redAccent,
      automaticallyImplyLeading: showBackbutton,
      title: Text(
        "Checkout",
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[],
    );
  }

  Widget pageUI() {
    return null;
  }

  @override
  Void dispose() {
    super.dispose();
  }
}
