import 'package:flutter/material.dart';
import 'package:we_deliver_bd/api_service.dart';
import 'package:we_deliver_bd/models/customer.dart';
import 'package:we_deliver_bd/utils/ProgressHUD.dart';
import 'package:we_deliver_bd/utils/form_helper.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  late APIService apiService;
  late CustomerModel model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  void initState() {
    apiService = new APIService();
    model = new CustomerModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: Text("Sign Up"),
      ),
      body: ProgressHUD(
        child: new Form(
          key: globalKey,
          child: _formUI(),
        ),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
      ),
    );
  }
}

Widget _formUI() {
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormHelper.fieldLabel("First Name"),
              FormHelper.textInput(
                context,
                model.firtName,
                (value) => {
                  this.model.firstName = value,
                },
                onValidate: (value) {
                  if (value.toString().isEmpty) {
                    return "Please enter First Name";
                  }
                  return null;
                },
              ),
              FormHelper()
            ],
          ),
        ),
      ),
    ),
  );
}
