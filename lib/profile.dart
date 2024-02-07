// ignore_for_file: unused_field, unused_local_variable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/db/dbfunctions.dart';
import 'package:flutter_application_2/db/model/datamodel.dart';
import 'package:flutter_application_2/home.dart';
// import 'package:flutter_application_2/home.dart';
import 'package:image_picker/image_picker.dart';

class ScreenProfile extends StatefulWidget {
  final StudentModel? student;

  const ScreenProfile({Key? key, this.student}) : super(key: key);

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  String? _selectedImage;

  final formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.transparent,
              child: _selectedImage != null
                  ? Image.file(File(_selectedImage!))
                  : const Image(
                      image: AssetImage('assets/images/icone.jpg'),
                    ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _pickGallery();
                  },
                  child: const Text(" Gallery"),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _pickCamera();
                  },
                  child: const Text(" Camera"),
                ),
                const SizedBox(
                  height: 20,
                ),
                // _selectedImage != null ? Image.file(_selectedImage!) : Text('')
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  if (!RegExp(r"^[A-Z]").hasMatch(value)) {
                    return 'Name should start with a capital letter';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  focusColor: Colors.blue,
                  labelText: 'Name',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _ageController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  focusColor: Colors.blue,
                  labelText: 'Age',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: TextFormField(
                controller: _subjectController,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  focusColor: Colors.blue,
                  labelText: 'Subject',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _phoneController,
                validator: (value) {
                  if (_phoneController.text.length != 10) {
                    return 'Please enter valid mobile number';
                  }

                  return null;
                },
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  focusColor: Colors.blue,
                  labelText: 'Phone',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_nameController.text.isEmpty ||
                    _ageController.text.isEmpty ||
                    _subjectController.text.isEmpty ||
                    _phoneController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Fill all fields ! ',
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.blue,
                  ));
                } else {
                  addStudentCheck();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ScreenHome(
                      studentData: null,
                    ),
                  ));
                }
              },
              child: const Text('SAVE'),
            ),
          ],
        )),
      ),
    );
  }

  Future _pickGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = returnImage!.path;
    });
  }

  Future _pickCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage != null) {
      setState(() {
        _selectedImage = returnImage.path;
      });
    }
  }

  Future<void> addStudentCheck() async {
    final name = _nameController.text;
    final age = _ageController.text;
    final subject = _subjectController.text;
    final phone = _phoneController.text;
    // final image =selected
    //     _selectedImage?.path ?? ''; // Use the  image path if available
    final student = StudentModel(
      name: name,
      age: age,
      subject: subject,
      phone: phone,
      image: _selectedImage ?? 'assets/images/icone.jpg',
    );
    addStudent(student);
  }
}
