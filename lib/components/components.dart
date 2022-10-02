import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/styles/colors.dart';

import '../modules/shop_app/models/login_model.dart';

Widget myDivider() => const Padding(
      padding: EdgeInsets.all(8.0),
      child: Divider(
        thickness: 1,
        color: Colors.grey,
      ),
    );

/*
Widget articlebuilder(list, {isSearch = false}) => list.isEmpty
    ? isSearch
        ? Container()
        : const Center(child: CircularProgressIndicator())
    : ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: 10,
      );
*/

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (_) => widget));

void navigateReplacementTo(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => widget,
      ),
      (Route<dynamic> route) => false,
    );

Widget defualtButton({required Function() function, required String txt}) =>
    Container(
      decoration: BoxDecoration(
        color: defaultClr,
        borderRadius: BorderRadius.circular(50),
      ),
      height: 50,
      width: double.infinity,
      child: InkWell(
        onTap: function,
        child: Center(
          child: Text(
            txt,
            textAlign: TextAlign.center,
            style:const TextStyle(color: Colors.white,fontSize: 20),
          ),
        ),
      ),
    );

Widget defualtTextButton({required Function() function, required String txt}) =>
    TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(defaultClr)
      ),
      onPressed: function,
      child: Text(txt),
    );

void showToast({required String msg, required ToastStates state}) =>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
