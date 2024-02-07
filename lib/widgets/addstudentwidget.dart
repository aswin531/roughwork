// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application_2/db/dbfunctions.dart';
import 'package:flutter_application_2/gridStudentWidget.dart';
import 'package:flutter_application_2/login.dart';
import 'package:flutter_application_2/profile.dart';

class addStudentWidget extends StatefulWidget {
  const addStudentWidget({super.key});

  @override
  State<addStudentWidget> createState() => _addStudentWidgetState();
}

class _addStudentWidgetState extends State<addStudentWidget> {
  bool isListView = true;
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextFormField(
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
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ScreenProfile(),
                  ));
                },
                child: const Text('ADD'),
              ),
              const SizedBox(
                width: 100,
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Are you want to Logout?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute(
                                    builder: (context) => const ScreenLogin(),
                                  ));
                                },
                                child: const Text('Ok'))
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.logout)),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.list)),
              const SizedBox(
                width: 270,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const GridStudentWidget(),
                    ));
                  },
                  icon: const Icon(Icons.grid_view))
            ],
          ),
        ],
      ),
    );
  }
}
