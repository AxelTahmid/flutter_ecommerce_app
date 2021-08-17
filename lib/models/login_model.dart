class LoginResponseModel {
  bool success;
  int statusCode;
  String code;
  String message;
  Data data;

  LoginResponseModel({
    this.success,
    this.statusCode,
    this.code,
    this.message,
    this.data,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    code = json['code'];
    message = json['message'];
    data = json['data'].length > 0 ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['code'] = this.code;
    data['message'] = this.message;

    if (this.data != null) {
      data['data'] = this.data.toJson();
    }

    return data;
  }
}

class Data {
  String token;
  String email;
  String nicename;
  String displayName;

  Data({
    this.token,
    this.email,
    this.nicename,
    this.displayName,
  });

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    email = json['user_email'];
    nicename = json['user_nicename'];
    displayName = json['user_display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['user_email'] = this.email;
    data['user_nicename'] = this.nicename;
    data['user_display_name'] = this.displayName;

    return data;
  }
}

// class Data {
//   String token;
//   int id;
//   String email;
//   String nicename;
//   String firstName;
//   String lastName;
//   String displayName;

//   Data({
//     this.token,
//     this.email,
//     this.nicename,
//     this.firstName,
//     this.lastName,
//     this.displayName,
//   });
  //jwt auth
  // Data.fromJson(Map<String, dynamic> json) {
  //   token = json['token'];
  //   id = json['id'];
  //   email = json['email'];
  //   nicename = json['nicename'];
  //   firstName = json['firstName'];
  //   lastName = json['lastName'];
  //   displayName = json['displayName'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['token'] = this.token;
  //   data['email'] = this.email;
  //   data['nicename'] = this.nicename;
  //   data['firstName'] = this.firstName;
  //   data['lastName'] = this.lastName;
  //   data['displayName'] = this.displayName;

  //   return data;
  // }
//}
