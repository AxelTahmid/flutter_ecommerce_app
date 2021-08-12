import 'package:flutter/material.dart';
import 'package:we_deliver_bd/pages/checkout_base.dart';

class VerifyAddress extends CheckoutBasePage {
  VerifyAddress({Key key}) : super(key: key);

  @override
  _VerifyAddressState createState() => _VerifyAddressState();
}

class _VerifyAddressState extends CheckoutBasePageState<VerifyAddress> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("verify"),
    );
  }
}
