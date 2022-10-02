import 'package:flutter/material.dart';
import 'package:shopapp/modules/shop_app/models/login_model.dart';

import '../modules/shop_app/login/login Screen.dart';
import '../network/remote/cache_helper.dart';
import 'components.dart';

signOut(context) async {
  try {
    var x= await CacheHelper.removeData(key: 'token');
    if (x==true) {
      navigateReplacementTo(context, LoginScreen());
    }else {null;}
  }catch(error){
    print(error);
  }
}

void printFullText(String text) {
  final pattern = RegExp('.{1800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String ?token = '';
