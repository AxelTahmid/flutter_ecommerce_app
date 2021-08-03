import 'package:flutter/material.dart';
import 'package:we_deliver_bd/api_service.dart';
import 'package:we_deliver_bd/models/customer.dart';
import 'package:we_deliver_bd/utils/ProgressHUD.dart';
import 'package:we_deliver_bd/utils/form_helper.dart';
import 'package:we_deliver_bd/utils/validator_service.dart';

import '../color_constants.dart';

class SignupPage extends StatefulWidget {
  // const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  APIService apiService;
  CustomerModel model;
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
        backgroundColor: ColorConstants.kPrimaryLightColor,
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
                  model.firstName,
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
                FormHelper.fieldLabel("Last Name"),
                FormHelper.textInput(
                  context,
                  model.lastName,
                  (value) => {
                    this.model.lastName = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return "Please enter Last Name";
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Email ID"),
                FormHelper.textInput(
                  context,
                  model.email,
                  (value) => {
                    this.model.email = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return "Please enter your Email ID";
                    }
                    if (value.isNotEmpty && !value.toString().isValidEmail()) {
                      return "Please enter valid Email ID";
                    }
                    return null;
                  },
                ),
                FormHelper.fieldLabel("Password"),
                FormHelper.textInput(
                  context,
                  model.password,
                  (value) => {
                    this.model.password = value,
                  },
                  onValidate: (value) {
                    if (value.toString().isEmpty) {
                      return "Please enter Password";
                    }
                    return null;
                  },
                  obscureText: hidePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    color: Theme.of(context).accentColor.withOpacity(0.4),
                    icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                new Center(
                  child: FormHelper.saveButton(
                    "Register",
                    () {
                      if (validateAndSave()) {
                        print(model.toJson());
                        setState(() {
                          isApiCallProcess = true;
                        });

                        apiService.createCustomer(model).then(
                          (ret) {
                            setState(() {
                              isApiCallProcess = false;
                            });

                            if (ret) {
                              FormHelper.showMessage(
                                context,
                                "WeDeliver App",
                                "Registration Sucessful",
                                "Ok",
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            } else {
                              FormHelper.showMessage(
                                context,
                                "WeDeliver App",
                                "Email Already Registered",
                                "Ok",
                                () {
                                  Navigator.of(context).pop();
                                },
                              );
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
