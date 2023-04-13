import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/common/pref_util.dart';
import 'package:user/database/database_api.dart';
import 'package:user/database/database_model.dart';
import 'package:user/model/model.dart';

class DataBaseHelper {
  static final firebaseDatabase = FirebaseDatabase.instance.ref();

  static List<UserData> userDataList = [];
  static List<UserData> profileDataList = [];
  static Student? viewStudentData;
  static List<Result> viewResultData = [];
  static List<Materials> viewMaterialData = [];
  static List<Course> viewCourseData = [];
  static List<TimeTable> viewTimeTableData = [];
  static List<Assignment> viewAssignmentData = [];
  static Attendence? viewAttendenceData;

  static userData({required Map<String, dynamic> data}) {
    String key = firebaseDatabase.push().key!;
    data["key"] = key;
    firebaseDatabase.child("userData").child(key).set(data);
  }

  static Future<void> loginData() async {
    DataSnapshot response = await firebaseDatabase.child("userData").get();
    Map data = response.value as Map? ?? {};
    userDataList.clear();
    data.forEach(
      (key, value) {
        userDataList.add(
          UserData(
            key: value['key'],
            mobilNumber: value['mobilNumber'],
            password: value["password"],
          ),
        );
      },
    );
  }

  static Future<void> profileData() async {
    DataSnapshot response = await firebaseDatabase.child("userData").get();
    Map data = response.value as Map? ?? {};
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userMobileNumber = prefs.get(
      "userMobileNumber",
    );

    debugPrint("userMobileNumber =====> $userMobileNumber");
    profileDataList.clear();
    data.forEach((key, value) {
      if (value["mobilNumber"] == userMobileNumber) {
        profileDataList.add(UserData(
          key: value['key'],
          mobilNumber: value['mobilNumber'],
          password: value["password"],
        ));
      }
    });
  }

  static filterData() async {
    await StudentDataApi.fetchData();
    await ResultApi.fetchData();
    await MaterialApi.fetchData();
    await CourseApi.fetchData();
    await TimeTableApi.fetchData();
    await AssignmentApi.fetchData();

    Student? dummyStudent;
    List<Result> dummyResult = [];
    List<Materials> dummyMaterial = [];
    List<Course> dummyCourse = [];
    List<TimeTable> dummyTimeTable = [];
    List<Assignment> dummyAssignment = [];

// **** Student Profile ****

    for (var mobile in StudentDataApi.studentDataList) {
      if (SharedPref.getMobileNumber == mobile.phoneNo) {
        dummyStudent = mobile;
      }
    }
    viewStudentData = dummyStudent;

// **** Result ****

    for (var result in ResultApi.resultDataList) {
      if ((viewStudentData!.stream == result.stream) &&
          (viewStudentData!.semester == result.semester)) {
        dummyResult.add(result);
      }
    }
    viewResultData = dummyResult;

// **** Material ****

    for (var material in MaterialApi.materialsDataList) {
      if ((viewStudentData!.stream == material.stream) &&
          (viewStudentData!.semester == material.semester)) {
        dummyMaterial.add(material);
      }
    }
    viewMaterialData = dummyMaterial;

// **** Course ****

    for (var course in CourseApi.courseDataList) {
      if ((viewStudentData!.stream == course.stream) &&
          (viewStudentData!.semester == course.semester)) {
        dummyCourse.add(course);
      }
    }
    viewCourseData = dummyCourse;

    for (var assignment in AssignmentApi.assignmentDataList) {
      if ((viewStudentData!.stream == assignment.stream) &&
          (viewStudentData!.semester == assignment.semester)) {
        dummyAssignment.add(assignment);
      }
    }
    viewAssignmentData = dummyAssignment;

// **** Time Table ****
    for (var timeTable in TimeTableApi.timeTableDataList) {
      for (var timeTableData in timeTable.tb) {
        if ((viewStudentData!.stream == timeTableData.stream) &&
            (viewStudentData!.semester == timeTableData.semester)) {
          dummyTimeTable.add(timeTableData);
        }
      }
    }
    viewTimeTableData = dummyTimeTable;
  }

  static clearAllData() {
    viewStudentData;
    viewResultData.clear();
    viewMaterialData.clear();
    viewAssignmentData.clear();
    viewCourseData.clear();
    viewTimeTableData.clear();
    viewAttendenceData=null;
    StudentDataApi.studentDataList.clear();
    ResultApi.resultDataList.clear();
    MaterialApi.materialsDataList.clear();
    CourseApi.courseDataList.clear();
    AssignmentApi.assignmentDataList.clear();
    TimeTableApi.timeTableDataList.clear();
    AttendenceApi.attendenceDataList.clear();
  }
}
