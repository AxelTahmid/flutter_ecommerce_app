import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_deliver_bd/models/customer_detail_mode.dart';
import 'package:we_deliver_bd/pages/checkout_base.dart';
import 'package:we_deliver_bd/pages/payment_screen.dart';
import 'package:we_deliver_bd/provider/cart_provider.dart';
import 'package:we_deliver_bd/utils/form_helper.dart';

class VerifyAddress extends CheckoutBasePage {
  VerifyAddress({Key key}) : super(key: key);

  @override
  _VerifyAddressState createState() => _VerifyAddressState();
}

class _VerifyAddressState extends CheckoutBasePageState<VerifyAddress> {
  @override
  void initState() {
    super.initState();
    currentPage = 0;
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.fetchShippingDetails();
  }

  @override
  Widget pageUI() {
    return Consumer<CartProvider>(builder: (context, customerModel, child) {
      if (customerModel.customerDetailsModel.id != null) {
        return _formUI(customerModel.customerDetailsModel);
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }

  Widget _formUI(CustomerDetailsModel model) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabel("First Name"),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabel("Last Name"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child:
                          FormHelper.fieldLabelValue(context, model.firstName),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FormHelper.fieldLabelValue(
                              context, model.lastName)),
                    ),
                  ],
                ),
                FormHelper.fieldLabel("Address"),
                FormHelper.fieldLabelValue(context, model.shipping.address1),
                FormHelper.fieldLabel("Aprtment, Suite, etc."),
                FormHelper.fieldLabelValue(context, model.shipping.address2),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabel("Country"),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabel("State"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabelValue(
                          context, model.shipping.country),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FormHelper.fieldLabelValue(
                              context, model.shipping.state)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabel("City"),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabel("Postcode"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: FormHelper.fieldLabelValue(
                          context, model.shipping.city),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: FormHelper.fieldLabelValue(
                            context, model.shipping.postcode),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                new Center(
                  child: FormHelper.saveButton(
                    "Next",
                    () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
