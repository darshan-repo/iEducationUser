import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/common/navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:user/common/pref_util.dart';
import 'package:user/constant.dart';
import 'package:user/data/database_service.dart';
import 'package:user/database/database_api.dart';
import 'package:user/database/database_model.dart';
import 'package:user/home_screen.dart';
import 'package:user/screens/settings_screen.dart';

class HomeScreenBottomBar extends StatefulWidget {
  const HomeScreenBottomBar({super.key});
  static const route = 'homeScreenBottomBar';

  @override
  State<HomeScreenBottomBar> createState() => _HomeScreenBottomBarState();
}

class _HomeScreenBottomBarState extends State<HomeScreenBottomBar>
    with TickerProviderStateMixin {
  MobileScannerController cameraController = MobileScannerController();

  List<Map> tabData = [
    {
      'icon': Icons.home,
      'text': 'Home',
    },
    {
      'icon': Icons.settings,
      'text': 'Setting',
    },
  ];
  int activeIndex = 0;
  List<Widget> screensList = [const HomeScreen(), const SettingScreen()];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primarycolor,
        onPressed: SharedPref.getIsScanned == true
            ? null
            : () => showDialog(
                  barrierColor: Colors.black87,
                  context: context,
                  builder: (context) => Center(
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: MobileScanner(
                        fit: BoxFit.cover,

                        controller: cameraController,
                        // allowDuplicates: true,

                        onDetect: (barcode) async {
                          SharedPref.setIsScanned = true;
                          SharedPref.setScannedDate = DateTime.now().toString();
                          String tempMobile = SharedPref.getMobileNumber!;
                          print(
                              '------------->>>----->>------>>>------->$tempMobile');
                          double increment = 0.0;
                          increment = (100 / 183) + increment;
                          Attendence obj = Attendence(
                            name:
                                '${DataBaseHelper.viewStudentData!.fName} ${DataBaseHelper.viewStudentData!.mName} ${DataBaseHelper.viewStudentData!.lName}',
                            stream: DataBaseHelper.viewStudentData!.stream,
                            semester: DataBaseHelper.viewStudentData!.semester,
                            image: DataBaseHelper.viewStudentData!.image,
                            key: DataBaseHelper.viewStudentData!.key,
                            attendence: increment,
                          );
                          AttendenceApi.attendenceAddData(obj: obj);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ),
        child: SharedPref.getIsScanned == true
            ? const Icon(
                Icons.check,
                color: Colors.white,
              )
            : Image(
                height: MediaQuery.of(context).size.height / 22,
                color: white,
                image: const AssetImage('assets/images/scanner.png'),
              ),
      ),
      body: NotificationListener<ScrollNotification>(
        child: NavigationScreen(screensList[activeIndex]),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        backgroundColor: background,
        itemCount: tabData.length,
        tabBuilder: (index, isActive) {
          return Column(
            children: [
              Icon(tabData[index]['icon']),
              Text(tabData[index]['text'])
            ],
          );
        },
        activeIndex: activeIndex,

        // notchAndCornersAnimation: borderRadiusAnimation,
        //splashSpeedInMilliseconds: 300,
        // notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        // hideAnimationController: _hideBottomBarAnimationController,
        onTap: (index) => setState(() => activeIndex = index),
      ),
    );
  }
}

class NavigationScreen extends StatefulWidget {
  final Widget currentPage;

  const NavigationScreen(this.currentPage, {super.key});

  @override
  NavigationScreenState createState() => NavigationScreenState();
}

class NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return widget.currentPage;
  }
}
