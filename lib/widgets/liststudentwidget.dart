// ignore: file_names
// ignore_for_file: unused_import, avoid_print, use_build_context_synchronously, duplicate_ignore
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/db/dbfunctions.dart';
import 'package:flutter_application_2/db/model/datamodel.dart';
import 'package:flutter_application_2/editstudentwidget.dart';
import 'package:flutter_application_2/view.dart';

class ListStudentWidget extends StatelessWidget {
  const ListStudentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    getAllStudent();
    return ValueListenableBuilder(
      valueListenable: studentListNotifier,
      builder: (context, List<StudentModel> studentList, Widget? child) {
        return ListView.separated(
          itemBuilder: (context, index) {
            print("....>>>${studentList[index]}");
            final data = studentList[index];
            return ListTile(
              title: Text(data.name),
              leading: CircleAvatar(
                backgroundImage: FileImage(File(data.image)),
              ),
              subtitle: Text(data.phone),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      await getAllStudent();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditingPage(
                            student: data,
                          ),
                        ),
                      );
                    },
                    // onPressed: () {
                    //   Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => EditingPage(
                    //       student: data,
                    //     ),
                    //   ));
                    // },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.blue,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Are you sure ?'),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      final deleted =
                                          await deleteStudentById(data.id!);
                                      if (deleted) {
                                        // ignore: use_build_context_synchronously
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No')),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                      )),
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScreenUser(student: data),
                ));
              },
            );
          },
          itemCount: studentList.length,
          separatorBuilder: (context, index) => const Divider(),
        );
      },
    );
  }
}
