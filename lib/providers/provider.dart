import 'package:flutter/material.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/modules/shop_app/Searsh/search_screen.dart';
import 'package:shopapp/modules/shop_app/categories/categories_screen.dart';
import 'package:shopapp/modules/shop_app/favorites/favorites_screen.dart';
import 'package:shopapp/modules/shop_app/models/caregory_model.dart';
import 'package:shopapp/modules/shop_app/models/change_favorite_model.dart';
import 'package:shopapp/modules/shop_app/models/favorite_model.dart';
import 'package:shopapp/modules/shop_app/models/home_model.dart';
import 'package:shopapp/modules/shop_app/models/search_model.dart';
import 'package:shopapp/modules/shop_app/products/products_screen.dart';
import 'package:shopapp/modules/shop_app/setting/setting_screen.dart';
import 'package:shopapp/network/end_points.dart';
import 'package:shopapp/network/remote/dio_helper.dart';

import '../components/constants.dart';
import '../modules/shop_app/models/login_model.dart';
import '../network/remote/cache_helper.dart';

class MyProvider extends ChangeNotifier {
  bool? isLoding = false;

  int currentindex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.production_quantity_limits_outlined),
        label: "Products"),
    const BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Categories"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border_outlined), label: "Favorite"),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Setting"),
  ];

  void changeBottomNavBar(index) {
    currentindex = index;
    notifyListeners();
  }

  List<Widget> bottomScreen = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoriteScreen(),
    SettingScreen(),
  ];
  HomeModel? homeModel;
  Map<int, bool> favorite = {};

  void getHomeDate() async {
    try {
      var response = await DioHelper.getDate(url: HOME, token: token);
      homeModel = HomeModel.fromJson(response.data);
      homeModel!.data!.products.forEach((element) {
        favorite.addAll({element.id!: element.favorites!});
      });

      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  CategoryModel? categoryModel;

  void getCategoriesDate() async {
    try {
      var response = await DioHelper.getDate(url: GET_CATEGORIES);
      categoryModel = CategoryModel.fromJson(response.data);
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  ChangeFavoriteModel? changeFavoriteModel;

  void changeFavorite(int productId) async {
    favorite[productId] = !favorite[productId]!;
    notifyListeners();
    try {
      var response = await DioHelper.postDate(
        url: FAVORITES,
        token: token,
        data: {
          'product_id': productId,
        },
      );
      changeFavoriteModel = ChangeFavoriteModel.fromJson(response.data);
      if (!changeFavoriteModel!.status!) {
        favorite[productId] = !favorite[productId]!;
        showToast(msg: changeFavoriteModel!.msg!, state: ToastStates.ERROR);
      } else {
        getFavoriteDate();
        notifyListeners();
        showToast(msg: changeFavoriteModel!.msg!, state: ToastStates.SUCCESS);
      }
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  FavoriteModel? favoriteModel;

  void getFavoriteDate() async {
    try {
      var response = await DioHelper.getDate(url: FAVORITES, token: token);
      favoriteModel = FavoriteModel.fromJson(response.data);
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  LoginModel? userModel;

  void getUserDate() async {
    try {
      var response = await DioHelper.getDate(url: PROFILE, token: token);
      userModel = LoginModel.fromJson(response.data);
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }
  }

  void updateUserDate({
    required String name,
    required String email,
    required String phone,
  }) async {
    isLoding = true;
    notifyListeners();
    try {
      var response = await DioHelper.putDate(
        token: token,
        url: UPDATE_PROFILE,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        },
      );
      userModel = LoginModel.fromJson(response.data);
      if (userModel!.status == false) {
        showToast(msg: userModel!.message!, state: ToastStates.ERROR);
        notifyListeners();
      }
    } catch (error) {
      print(error.toString());
    } finally {
      isLoding = false;
      notifyListeners();
    }
  }

  SearchModel? searchModel;

  void search(String text) async {
    isLoding = true;
    notifyListeners();
    try {
      var response = await DioHelper.postDate(
        url: SEARCH,
        token: token,
        data: {'text': text},
      );
      searchModel = SearchModel.fromJson(response.data);
      notifyListeners();
    } catch (error) {
      print(error.toString());
    }finally{
      isLoding =false;
      notifyListeners();
    }
  }
}
