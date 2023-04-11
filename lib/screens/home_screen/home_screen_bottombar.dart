import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/common/navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:user/constant.dart';
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
        child: Image(
          height: MediaQuery.of(context).size.height / 22,
          color: white,
          image: const AssetImage('assets/images/scanner.png'),
        ),
        onPressed: () => showDialog(
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

                allowDuplicates: true,
                onDetect: (barcode, args) async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  String tempMobile = pref.getString('userMobileNumber')!;
                  print('====== >>>>>>>> $tempMobile');
                  debugPrint('===>====>===>===>===>.=>${barcode.rawValue}');
                },

                // startDelay: true,

                // onDetect: (capture) async {
                //   SharedPreferences pref =
                //       await SharedPreferences.getInstance();
                //   String tempMobile = pref.getString('userMobileNumber')!;
                //   print('====== >>>>>>>> $tempMobile');
                //   debugPrint('Barcode found! ${capture.raw}');

                // Navigator.pop(context);
                // final  barcode = capture.barcodes;
                // barcode
                // for (final barcode in barcodes) {
                //   debugPrint('Barcode found! ${barcode.rawValue}');
                // }
              ),
            ),
          ),
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
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    // _controller = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 1000),
    // );
    // animation = CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeIn,
    // );
    // _controller.forward();
    super.initState();
  }

  // startAnimation() {
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(milliseconds: 1000),
  //   );
  //   animation = CurvedAnimation(
  //     parent: _controller,
  //     curve: Curves.easeIn,
  //   );
  //   _controller.forward();
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return widget.currentPage;
  }
}
