import 'package:flutter/material.dart';
import 'package:shopapp/modules/shop_app/login/login%20Screen.dart';
import 'package:shopapp/network/remote/cache_helper.dart';
import 'package:shopapp/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../components/components.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;
  final boardingController = PageController();

  void submit() {
    CacheHelper.saveData(key: "OnBoarding", value: true).then((value) {
      if (value) {
        navigateReplacementTo(
          context,
          LoginScreen(),
        );
      }
    });
  }

  List<BoardingModel> boarding = [
    BoardingModel(
        image: "assets/1.jpg",
        title: "On Boarding Title 1",
        body: "On Boarding Body 1"),
    BoardingModel(
        image: "assets/2.jpg",
        title: "On Boarding Title 2",
        body: "On Boarding Body 2"),
    BoardingModel(
        image: "assets/3.jpg",
        title: "On Boarding Title 3",
        body: "On Boarding Body 3"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            defualtTextButton(
              function: submit,
              txt: "Skip",
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: boardingController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (ctx, index) =>
                      buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardingController,
                      count: 3,
                      effect: const ExpandingDotsEffect(
                          activeDotColor: defaultClr,
                          dotColor: Colors.grey,
                          dotHeight: 10,
                          expansionFactor: 4,
                          dotWidth: 10,
                          spacing: 5)),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardingController.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastLinearToSlowEaseIn);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_outlined),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage(
                model.image,
              ),
            ),
          ),
          Text(
            model.title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            model.body,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      );
}
