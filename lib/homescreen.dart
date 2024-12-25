import 'package:eventplanningapp/home/home_page.dart';
import 'package:eventplanningapp/profilescreen/profilescreen.dart';
import 'package:eventplanningapp/utils/imageassets.dart';
import 'package:flutter/material.dart';
import 'package:eventplanningapp/utils/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// import 'package:eventplanningapp/tabs/hadethtab/hadethtab.dart';
// import 'package:eventplanningapp/tabs/qurantab/qurantab.dart';
// import 'package:eventplanningapp/tabs/radiotab/radiotab.dart';
// import 'package:eventplanningapp/tabs/tasbehtab/tasbehtab.dart';
// import 'package:eventplanningapp/tabs/timetab/timetab.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = "homescreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [
    HomePage(),
    Container(),
    Container(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.add,
            color: AppColor.whiteColor,
            size: 32,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

        bottomNavigationBar: BottomAppBar(
          padding: EdgeInsets.all(0),
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
          child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              type: BottomNavigationBarType.fixed,
              items: [
                customBottomNavBar(
                    index: 0,
                    imageName: ImageAssets.unSelectedHomeImage,
                    selectedImage: ImageAssets.selectedHomeImage,
                    label: AppLocalizations.of(context)!.home),
                customBottomNavBar(
                    index: 1,
                    imageName: ImageAssets.unSelectedMapImage,
                    selectedImage: ImageAssets.selectedMapImage,
                    label: AppLocalizations.of(context)!.map),
                customBottomNavBar(
                    index: 2,
                    imageName: ImageAssets.unSelectedLoveImage,
                    selectedImage: ImageAssets.selectedLoveImage,
                    label: AppLocalizations.of(context)!.love),
                customBottomNavBar(
                    index: 3,
                    imageName: ImageAssets.unSelectedProfileImage,
                    selectedImage: ImageAssets.selectedProfileImage,
                    label: AppLocalizations.of(context)!.profile),
              ]),
        ),
        body: tabs[selectedIndex]);
  }

  BottomNavigationBarItem customBottomNavBar(
      {required int index,
      required String imageName,
      required String selectedImage,
      required String label}) {
    return selectedIndex == index
        ? BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(selectedImage),
            ),
            label: label)
        : BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(imageName),
            ),
            label: label);
  }
}
