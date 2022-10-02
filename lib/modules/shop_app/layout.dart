import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/modules/shop_app/Searsh/search_screen.dart';
import 'package:shopapp/modules/shop_app/login/login%20Screen.dart';
import 'package:shopapp/network/remote/cache_helper.dart';
import 'package:shopapp/providers/provider.dart';
import 'package:shopapp/styles/colors.dart';

import '../../components/components.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MyProvider>(
        builder: (context, value, child) => Scaffold(
          appBar: AppBar(
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context,SearchScreen());
                  },
                  icon: const Icon(Icons.search))
            ],
            title: Container(
                width: 200,
                decoration: BoxDecoration(
                    color: defaultClr, borderRadius: BorderRadius.circular(20)),
                child:  const Text(
                    "Market",
                    textAlign: TextAlign.center,
                    style:  TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                )),
          body: value.bottomScreen[value.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            items: value.bottomItems,
            currentIndex: value.currentindex,
            onTap: (index) {
              value.changeBottomNavBar(index);
            },
          ),
        ),
    );
  }
}
