import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/db/model/datamodel.dart';

class ScreenUser extends StatelessWidget {
  final StudentModel student;

  const ScreenUser({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('User Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              width: 300,
              height: 200,
              child: Image.file(File(student.image)),
            ),
            const SizedBox(
              height: 20,
            ),
            // backgroundImage: FileImage(File(student.image)),
            ListTile(
              // title: Text('Name: ${student.name}'),
              // leading:
              //     CircleAvatar(child: Image.asset('assets/images/person.jpg')),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Name: ${student.name}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Age: ${student.age}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Subject: ${student.subject}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Phone: ${student.phone}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
