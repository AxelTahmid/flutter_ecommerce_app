class VariableProduct {
  int id;
  String sku;
  String price;
  String regularPrice;
  String salePrice;
  List<Attributes> attributes;

  VariableProduct({
    this.id,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.attributes,
  });

  VariableProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    //!= "" ? json['sale_price'] : json['regular_price']
    if (json["attributes"] != null) {
      attributes = [];
      json["attributes"].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['sku'] = this.sku;
    data['price'] = this.price;
    data['regular_price'] = this.regularPrice;
    data['sale_price'] = this.salePrice;
    if (this.attributes != null) {
      data['attributes'] = this.attributes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attributes {
  int id;
  String name;
  List<String> option;

  Attributes({this.id, this.name, this.option});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    option = json["option"].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['option'] = this.option;

    return data;
  }
}
