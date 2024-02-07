// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_application_2/home.dart';

class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class _ScreenLoginState extends State<ScreenLogin> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // final Save_key_name = 'userloggedin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
            width: 50,
            height: 50,
            child: CircleAvatar(
              child: Icon(Icons.person),
            )
            // Image.asset(
            //   'assets/images/notes.jpg',
            // ),
            ),
        const SizedBox(
          height: 25,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: TextFormField(
            controller: _userController,
            decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue))),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: TextFormField(
            obscureText: true,
            controller: _passController,
            decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue))),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        ElevatedButton(
            onPressed: () async {
              if (_userController.text.isEmpty ||
                  _passController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Username & Password are required '),
                  backgroundColor: Colors.red,
                ));
              } else {
                const predefinedUsername = 'aswin';
                const predefinedPassword = '1234';

                if (_userController.text == predefinedUsername &&
                    _passController.text == predefinedPassword) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const ScreenHome(
                      studentData: 1,
                    ),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Invalid username or password.'),
                    backgroundColor: Colors.red,
                  ));
                }
              }
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //       builder: (context) => const ScreenHome(studentData: 1,),
              //     ));
            },
            child: const Text('Login'))
      ])),
    );
  }
}
