import 'dart:convert';

class CategoryModel {
  bool? status;
  CategoryDataModel? data;

  CategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryDataModel.fromJson(json['data']);
  }
}

class CategoryDataModel {
  int? currentPage;
  List<DataModel> data = [];

  CategoryDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
    currentPage = json['current_page'];
  }
}

class DataModel {
  int? id;

  String? name;
  String? img;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    img = json['image'];
  }
}
