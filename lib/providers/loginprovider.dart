import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/components/constants.dart';
import 'package:shopapp/modules/shop_app/layout.dart';
import 'package:shopapp/network/remote/cache_helper.dart';
import '../components/components.dart';
import '../modules/shop_app/models/login_model.dart';
import '../network/end_points.dart';
import '../network/remote/dio_helper.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoding = false;
  bool isvisible = true;
  Icon suffix = const Icon(Icons.visibility_outlined);

  late LoginModel loginModel;

  void changeToVisible() {
    isvisible = !isvisible;
    suffix = isvisible
        ? const Icon(Icons.visibility_outlined)
        : const Icon(Icons.visibility_off_outlined);
    notifyListeners();
  }

  void userLogin(BuildContext ctx, {required email, required password}) async {
    isLoding = true;
    notifyListeners();
    try {
      var Response = await DioHelper.postDate(
        url: LOGIN,
        data: {
          "email": email,
          "password": password,
        },
      );
      print(Response.data);
      loginModel = LoginModel.fromJson(Response.data);
      if (loginModel.status == true) {
        showToast(state: ToastStates.SUCCESS, msg: loginModel.message!);

        bool saveToken = await CacheHelper.saveData(
            key: "token", value: loginModel.data!.token);
        if (saveToken == true) {
          navigateReplacementTo(ctx, const Layout());
         token = loginModel.data?.token;
        }
      } else {
        showToast(state: ToastStates.ERROR, msg: loginModel.message!);
        print(loginModel.message);
      }
    } catch (error) {
      print(error);
    } finally {
      isLoding = false;
      notifyListeners();
    }
  }

  void userRegister(
    BuildContext ctx, {
    required email,
    required password,
    required name,
    required phone,
  }) async {
    isLoding = true;
    notifyListeners();
    try {
      var Response = await DioHelper.postDate(
        url: REGISTER,
        data: {
          "email": email,
          "password": password,
          "name": name,
          "phone": phone,
        },
      );
      print(Response.data);
      loginModel = LoginModel.fromJson(Response.data);
      if (loginModel.status == true) {
        showToast(state: ToastStates.SUCCESS, msg: loginModel.message!);
        bool saveToken = await CacheHelper.saveData(
            key: "token", value: loginModel.data!.token);
        if (saveToken == true) {
          navigateReplacementTo(ctx, const Layout());
          token = loginModel.data!.token;
        }
      } else {
        showToast(state: ToastStates.ERROR, msg: loginModel.message!);
      }
    } catch (error) {
      print(error);
    } finally {
      isLoding = false;
      notifyListeners();
    }
  }
}
