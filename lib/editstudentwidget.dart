// ignore_for_file: unused_local_variable, unused_element, avoid_print, prefer_const_constructors_in_immutables, unused_import, use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/db/dbfunctions.dart';
import 'package:flutter_application_2/db/model/datamodel.dart';
import 'package:flutter_application_2/home.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditingPage extends StatefulWidget {
  final StudentModel student;

  EditingPage({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  State<EditingPage> createState() => EditingPageState();
}

class EditingPageState extends State<EditingPage> {
  String? _selectedImage;
  final studentnameController = TextEditingController();
  final ageController = TextEditingController();
  final subjectController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    studentnameController.text = widget.student.name;
    ageController.text = widget.student.age;
    subjectController.text = widget.student.subject;
    phoneController.text = widget.student.phone;
    _selectedImage = widget.student.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Edit Student'),
        toolbarHeight: 80,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 200,
                    child: _selectedImage != null
                        ? Image.file(
                            File(_selectedImage!),
                          ) // Display the selected image
                        : Image.asset('assets/images/icone.jpg'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            _pickGallery();
                          },
                          child: const Text('Gallery')),
                      const SizedBox(
                        width: 80,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _pickCamera();
                          },
                          child: const Text('Camera')),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: studentnameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid name';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      hintText: 'Name',
                    ),
                    keyboardType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: ageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid age';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      counterStyle: TextStyle(
                        height: double.minPositive,
                      ),
                      counterText: "",
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                      hintText: 'Age',
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 2,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: subjectController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid subject';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Subject',
                      border: OutlineInputBorder(),
                      hintText: 'Subject',
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a valid phone number';
                      } else {
                        return null;
                      }
                    },
                    decoration: const InputDecoration(
                      counterStyle: TextStyle(
                        height: double.minPositive,
                      ),
                      counterText: "",
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                      hintText: 'Phone',
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 10,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              checkStudent();
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) {
                              //       // Return the widget/screen you want to navigate to
                              //       return const ScreenHome(); // Replace NextScreen with the actual screen/widget you want to navigate to
                              //     },
                              //   ),
                              // );
                            }
                          },
                          child: const Text('Submit'),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void checkStudent() async {
    final name = studentnameController.text;
    final age = ageController.text;
    final subject = subjectController.text;
    final phone = phoneController.text;
    final image = _selectedImage;

    if (name.isNotEmpty &&
        age.isNotEmpty &&
        subject.isNotEmpty &&
        phone.isNotEmpty) {
      final updatedStudent = StudentModel(
        id: widget.student.id,
        name: name,
        age: age,
        subject: subject,
        phone: phone,
        image: image ?? '',
      );
      await updateStudent(updatedStudent); // await the update to complete
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx1) => ScreenHome(studentData: updatedStudent),
        ),
      );
    }
  }

  Future _pickGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = returnImage?.path;
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
}
