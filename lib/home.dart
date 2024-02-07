import 'package:flutter/material.dart';
import 'package:flutter_application_2/db/dbfunctions.dart';
import 'package:flutter_application_2/widgets/liststudentwidget.dart';
import 'package:flutter_application_2/widgets/addstudentwidget.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key, required studentData});

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return const Scaffold(
      // backgroundColor: Colors.grey,
      body: SafeArea(
          child: Column(
        children: [
          addStudentWidget(),
          Expanded(child: ListStudentWidget()),
        ],
      )),
    );
  }
}
