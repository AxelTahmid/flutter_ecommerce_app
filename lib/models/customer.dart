class CustomerModel {
  // added ? mark to get rid of null safety
  String email;
  String firstName;
  String lastName;
  String password;

  CustomerModel({
    this.email,
    this.firstName,
    this.lastName,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    map.addAll({
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'password': password,
      'username': email
    });

    return map;
  }
}

// class CustomerModel {
//   // older model system below. json auto decoded now.
//   final String email;
//   final String firstName;
//   final String lastName;
//   final String password;

//   CustomerModel(
//     this.email,
//     this.firstName,
//     this.lastName,
//     this.password,
//   );

//   CustomerModel.fromJson(Map<String, dynamic> json)
//       : email = json['email'],
//         firstName = json['first_name'],
//         lastName = json['last_name'],
//         password = json['password'];

//   Map<String, dynamic> toJson() => {
//         'email': email,
//         'first_name': firstName,
//         'last_name': lastName,
//         'password': password,
//         'username': email
//       };
// }
