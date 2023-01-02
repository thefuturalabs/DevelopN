import 'package:develop_n/screens/login_page.dart';
import 'package:develop_n/screens/user_home_page.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';

class UserRegistration extends StatefulWidget {
  UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {
  final fkey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController qualificationController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: fkey,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 150),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Signup as user',
                  style: TextStyle(
                      color: Color.fromARGB(255, 169, 200, 226),
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'enter name';
                  }
                },
                decoration: InputDecoration(
                  label: Text('name'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'enter email';
                  }
                },
                decoration: InputDecoration(
                  label: Text('email'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: phoneController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'enter phone';
                  }
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  label: Text('phone'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: qualificationController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'enter qualification';
                  }
                },
                decoration: InputDecoration(
                  label: Text('qualification'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Radio(
                      value: 'male',
                      groupValue: gender,
                      onChanged: (v) {
                        setState(() {
                          gender = v;
                        });
                      }),
                  Text('male'),
                  SizedBox(
                    width: 30,
                  ),
                  Radio(
                      value: 'female',
                      groupValue: gender,
                      onChanged: (v) {
                        setState(() {
                          gender = v;
                        });
                      }),
                  Text('female'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: usernameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'enter username';
                  }
                },
                decoration: InputDecoration(
                  label: Text('username'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'enter password';
                  }
                },
                decoration: InputDecoration(
                  label: Text('password'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: InkWell(
                onTap: () {
                  if (fkey.currentState!.validate()) {
                    userSignUp();
                  }
                },
                onLongPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UserHomePage(),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 97, 123, 144),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Text('LOGIN'),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LoginPage(),
                          ),
                        );
              },
              child: Text(
                'Login instead',
                style: TextStyle(color: Colors.white),
              ),
            )
          ]),
        ),
      ),
    );
  }

  userSignUp() async {
    Services.postData({
      'name': nameController.text,
      'email': emailController.text,
      'phn_no': phoneController.text,
      'qualification': qualificationController.text,
      'gender': gender,
      'username': usernameController.text,
      'password': passwordController.text,
    }, 'user_reg.php');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => UserHomePage(),
      ),
    );
  }
}
