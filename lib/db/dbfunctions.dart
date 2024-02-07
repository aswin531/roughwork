// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_2/db/model/datamodel.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>> studentListNotifier = ValueNotifier([]);

late Database _db;

Future<void> initaliseDataBase() async { 
  try {
    _db = await openDatabase(
      'student.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE student (id INTEGER PRIMARY KEY,name TEXT,age TEXT,subject TEXT,phone TEXT,image TEXT)');
      },
    );
    print('database initialised');
  } catch (e) {
    print('error');
  }
}

Future<void> addStudent(StudentModel value) async {
  try {
    await _db.insert(
      'student',
      {
        'name': value.name,
        'age': value.age,
        'subject': value.subject,
        'phone': value.phone, 
        'image': value.image,
      },
    );
 
    print('success');
    getAllStudent();
  } catch (e) {
    print('error in adding');
  }
}

Future<void> getAllStudent() async {
  final values = await _db.query('student');
  print(values);
  studentListNotifier.value.clear();
  for (var map in values) {
    final student = StudentModel.fromMap(map);
    studentListNotifier.value.add(student);
  }
  studentListNotifier.notifyListeners();
}

Future<bool> deleteStudentById(int id) async {
  final count = await _db.delete('student', where: 'id = ?', whereArgs: [id]);
  if (count == 1) {
  await  getAllStudent();
  }
  return count == 1;
}

Future<void> updateStudent(StudentModel updatedStudent) async {
  await _db.update(
    'student',
    {
      'name': updatedStudent.name,
      'age': updatedStudent.age,
      'subject': updatedStudent.subject,
      'phone': updatedStudent.phone,
      'image': updatedStudent.image,
    },
    where: 'id = ?',
    whereArgs: [updatedStudent.id],
  );
  await getAllStudent();
  // print('Updated Student Data: ${updatedStudent.toString()}');
  studentListNotifier.notifyListeners();
}

Future<void> searchStudent(String name) async {
  final students = await _db.query(
    'student',
    where: 'LOWER(name) LIKE ?',
    whereArgs: ['%${name.toLowerCase()}%'],
  );

  studentListNotifier.value =
      students.map((element) => StudentModel.fromMap(element)).toList();
}
