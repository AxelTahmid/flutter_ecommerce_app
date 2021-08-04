import 'package:we_deliver_bd/models/variable_product.dart';

class Product {
  int id;
  String name;
  String description;
  String shortDescription;
  String sku;
  String price;
  String regularPrice;
  String salePrice;
  String stockStatus;
  List<Images> images;
  List<Categories> categories;
  List<Attributes> attributes;
  List<int> relatedIds;
  String type;
  VariableProduct variableProduct;

  Product({
    this.id,
    this.name,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.stockStatus,
    this.attributes,
    this.relatedIds,
    this.type,
    this.variableProduct,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    shortDescription = json['short_description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];

    salePrice =
        json['sale_price'] != "" ? json['sale_price'] : json['regular_price'];

    stockStatus = json['stock_status'];
    relatedIds = json['cross_sell_ids'].cast<int>();
    type = json['type'];

    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }

    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images.add(new Images.fromJson(v));
      });
    }
    if (json["attributes"] != null) {
      attributes = [];
      json["attributes"].forEach((v) {
        attributes.add(new Attributes.fromJson(v));
      });
    }
  }

  calculateDiscount() {
    double disPercent = 0;

    if (this.regularPrice != "") {
      double regularPrice = double.parse(this.regularPrice);
      double salePrice =
          this.salePrice != "" ? double.parse(this.salePrice) : regularPrice;
      double discount = regularPrice - salePrice;
      disPercent = (discount / regularPrice) * 100;
    }
    return disPercent.round();
  }
}

class Categories {
  int id;
  String name;

  Categories({this.id, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Images {
  String src;

  Images({
    this.src,
  });

  Images.fromJson(Map<String, dynamic> json) {
    src = json['src'];
  }
}

class Attributes {
  int id;
  String name;
  String option;

  Attributes({this.id, this.name, this.option});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    option = json["option"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['id'] = this.id;
    data['name'] = this.name;
    data['option'] = this.option;

    return data;
  }
}
