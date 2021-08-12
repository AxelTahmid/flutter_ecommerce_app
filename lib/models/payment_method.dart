class PaymentMethod {
  String id;
  String name;
  String description;
  String logo;
  String route;
  Function onTap;
  bool isRouteRedirect;

  PaymentMethod(this.id, this.name, this.description, this.logo, this.route,
      this.onTap, this.isRouteRedirect);
}

class PaymentMethodList {
  List<PaymentMethod> _paymentsList;
  List<PaymentMethod> _cashList;

  PaymentMethodList() {
    this._paymentsList = [
      PaymentMethod(
        "bKash",
        "bKash",
        "Click to pay with bKash",
        "assets/img/bKash1.png",
        "/bKash",
        () {},
        true,
      ),
      PaymentMethod(
        "nagad",
        "Nagad",
        "Click to pay with Nagad",
        "assets/img/nagad.png",
        "/nagad",
        () {},
        true,
      ),
    ];
    this._cashList = [
      new PaymentMethod(
        "cod",
        "Cash On Delivery",
        "Click to pay Cash On Delivery",
        "assets/img/cash.png",
        "/OrderSuccess",
        () {},
        false,
      ),
    ];
  }

  List<PaymentMethod> get paymentsList => _paymentsList;
  List<PaymentMethod> get cashList => _cashList;
}
