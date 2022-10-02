import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/modules/shop_app/layout.dart';
import 'package:shopapp/modules/shop_app/login/login%20Screen.dart';
import 'package:shopapp/network/remote/cache_helper.dart';
import 'package:shopapp/network/remote/dio_helper.dart';
import 'package:shopapp/providers/loginprovider.dart';
import 'package:shopapp/styles/themes.dart';
import 'components/constants.dart';
import 'modules/shop_app/on_bording/on_boarding_screen.dart';
import 'providers/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  bool? OnBoarding = CacheHelper.getDate(key: "OnBoarding");
  Widget widget;
  token = CacheHelper.getDate(key: 'token');

  if (OnBoarding != null) {
    if (token != null) {
      widget = const Layout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  print(OnBoarding);
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => MyProvider()
        ..getHomeDate()
        ..getCategoriesDate()
        ..getFavoriteDate()
        ..getUserDate(),
    ),
    ChangeNotifierProvider(create: (_) => LoginProvider())
  ], child: MyApp(startWidget: widget)));
}

class MyApp extends StatelessWidget {
  final Widget? startWidget;

  const MyApp({
    this.startWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      home: startWidget,
    );
  }
}
