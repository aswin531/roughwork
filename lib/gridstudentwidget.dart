// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/db/dbfunctions.dart';
import 'package:flutter_application_2/db/model/datamodel.dart';
import 'package:flutter_application_2/editstudentwidget.dart';
import 'package:flutter_application_2/home.dart';
import 'package:flutter_application_2/view.dart';

class GridStudentWidget extends StatefulWidget {
  const GridStudentWidget({Key? key}) : super(key: key);

  @override
  _GridStudentWidgetState createState() => _GridStudentWidgetState();
}

class _GridStudentWidgetState extends State<GridStudentWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: AppBar(
            toolbarHeight: 100,
            backgroundColor: Colors.white,
            title: TextFormField(
              controller: _searchController,
              onChanged: (value) {
                searchStudent(value);
              },
              decoration: InputDecoration(
                  hintText: 'Search',
                  suffixIcon: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.search)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ScreenHome(
                      studentData: null,
                    ),
                  ));
                },
                icon: const Icon(
                  Icons.list,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ValueListenableBuilder(
            valueListenable: studentListNotifier,
            builder: (context, List<StudentModel> studentList, Widget? child) {
              return Container(
                color: Colors.white,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 15.0,
                  ),
                  itemBuilder: (context, index) {
                    final data = studentList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ScreenUser(student: data),
                        ));
                      },
                      child: Card(
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                  height: 120,
                                  child: Image.file(
                                    File(data.image),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: ListTile(
                                  title: Text(data.name),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => EditingPage(
                                                student: data,
                                              ),
                                            ),
                                          );
                                        },
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
                                                title:
                                                    const Text('Are you sure?'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () async {
                                                      final deleted =
                                                          await deleteStudentById(
                                                              data.id!);
                                                      if (deleted) {
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: const Text('Yes'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text('No'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onDoubleTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ScreenUser(student: data),
                        ));
                      },
                    );
                  },
                  itemCount: studentList.length,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
