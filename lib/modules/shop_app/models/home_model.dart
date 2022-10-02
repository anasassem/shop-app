import 'dart:convert';

class HomeModel {
  bool? status;
  HomeDateModel? data;

  HomeModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
    data = HomeDateModel.formJson(json['data']);
  }
}

class HomeDateModel {
  List<BannerModel> banners = [] ;
  List<ProductModel> products = [];

  HomeDateModel.formJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add((BannerModel.formJson(element)));
    });

    json['products'].forEach((element) {
      products.add((ProductModel.formJson(element)));
    });
  }
}

  class BannerModel {
  int? id;
  String? img;

  BannerModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    img = json['image'];
  }
}

class ProductModel {
  int? id;

  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? img;
  String? name;
  bool? favorites;
  bool? cart;

  ProductModel.formJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    img = json['image'];
    name = json['name'];
    favorites = json['in_favorites'];
    cart = json['in_cart'];
  }
}
