import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:user/common/appbar.dart';
import 'package:user/constant.dart';
import 'package:user/database/database_api.dart';
import 'package:user/navigation/app_navigation.dart';

class StaffListScreen extends StatefulWidget {
  const StaffListScreen({Key? key}) : super(key: key);
  static const route = 'staffListScreen';
  @override
  State<StaffListScreen> createState() => _StaffListScreenState();
}

class _StaffListScreenState extends State<StaffListScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  bool isLoading = false;

  Future<void> getData() async {
    isLoading = true;
    await StaffListApi.fetchData();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appbar(context, title: 'Staff List'),
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: primarycolor))
          : StaffListApi.staffDataList.isEmpty
              ? Center(
                  child: Lottie.asset(
                    'assets/icons/Circle.json',
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.builder(
                    itemCount: StaffListApi.staffDataList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        color: background,
                        child: ListTile(
                          onTap: () {
                            AppNavigation.shared
                                .movetoStaffProfilecreen({'index': index});
                            setState(() {});
                          },
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: primarycolor,
                            backgroundImage: NetworkImage(
                                StaffListApi.staffDataList[index].image),
                          ),
                          title: Text(
                            StaffListApi.staffDataList[index].name,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          subtitle: Text(
                            StaffListApi.staffDataList[index].degree,
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
