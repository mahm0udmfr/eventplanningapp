import 'package:flutter/material.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:eventplanningapp/utils/fontsclass.dart';
import 'package:eventplanningapp/homescreen.dart';
import 'package:eventplanningapp/onboarding/onboardinglist.dart';
import 'package:eventplanningapp/services.dart';

class OnBoarding extends StatefulWidget {
  static const String routename = "onboarding";
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => OnBoardingState();
}

class OnBoardingState extends State<OnBoarding> {
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  itemCount: onBoardingList.length,
                  itemBuilder: (context, i) => Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Image.asset(
                          onBoardingList[i].topimage ?? '',
                      
                          width: MediaQuery.of(context).size.height *0.29,
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Expanded(
                        flex: 2,
                        child: Image.asset(
                          onBoardingList[i].bodyimage ?? '',
                          width: MediaQuery.of(context).size.width * 0.99,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
Text(  
                        onBoardingList[i].body ?? '',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: AppColor.primarylLight,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontsName.inter,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height *0.04,
                      ),
                      Text(
                        onBoardingList[i].footer ?? '',
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: AppColor.blackColor,
                          fontFamily: FontsName.inter,
                          fontSize: 16,
                        ),
                      ),
                        ],
                      ),
                      
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: reversePage,
                    child: const Text("Back",
                        style: TextStyle(color: AppColor.primarylLight)),
                  ),
                  ////////////////////
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(
                          onBoardingList.length,
                          (index) => AnimatedContainer(
                                margin: const EdgeInsets.only(right: 5),
                                duration: const Duration(milliseconds: 900),
                                width: currentPage == index ? 20 : 5,
                                height: 6,
                                decoration: BoxDecoration(
                                    color: AppColor.primarylLight,
                                    borderRadius: BorderRadius.circular(10)),
                              )),
                    ],
                  ),
          
                  ///
                  TextButton(
                    onPressed: nextPage,
                    child: const Text(
                      "Next",
                      style: TextStyle(color: AppColor.primarylLight),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void nextPage() {
    setState(() {
      if (currentPage < onBoardingList.length - 1) {
        currentPage++;
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeInOut,
        );
      } else {
        MyServices.setString('step', '1');
        Navigator.of(context).pushReplacementNamed(HomeScreen.routename);
      }
    });
  }

  void reversePage() {
    setState(() {
      if (currentPage > 0) {
        currentPage--;
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 900),
          curve: Curves.easeInOut,
        );
      }
    });
  }
}
