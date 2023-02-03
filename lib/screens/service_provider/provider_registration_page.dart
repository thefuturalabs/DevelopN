import 'dart:io';

import 'package:develop_n/screens/login_page.dart';
import 'package:develop_n/screens/user/user_home_page.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProviderRegistration extends StatefulWidget {
  ProviderRegistration({super.key});

  @override
  State<ProviderRegistration> createState() => _ProviderRegistrationState();
}

class _ProviderRegistrationState extends State<ProviderRegistration> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController qualificationController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController workStatusController = TextEditingController();

  String? gender;

  File? pickedImage;

  final fkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: fkey,
        child: SafeArea(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Text(
                    'Signup as Provider',
                    style: TextStyle(
                        color: Color.fromARGB(255, 169, 200, 226),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: InkWell(
                    onTap: () async {
                      File? temp = await Services.pickImage(context);
                      setState(() {
                        pickedImage = temp;
                      });
                      print(pickedImage!.path);
                    },
                    child: CircleAvatar(
                      backgroundImage: pickedImage == null
                          ? AssetImage('assets/avatar.webp')
                          : FileImage(pickedImage!) as ImageProvider,
                      radius: 70,
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter phone number';
                    }
                  },
                  decoration: InputDecoration(
                    label: Text('phone'),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextFormField(
                  controller: workStatusController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter enter status';
                    }
                  },
                  decoration: InputDecoration(
                    label: Text('work status'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: InkWell(
                  onTap: () {
                   
                    print('tapped');
                    if (fkey.currentState!.validate()) {
                      if(pickedImage==null){
                        print('image not selected');
                        Fluttertoast.showToast(msg: 'Pick image first');
                      }else{
                        print(pickedImage!.path);
                      
                    Services.postWithIamge(params: {
                      'username':usernameController.text,
                      'password':passwordController.text,
                      'name':nameController.text,
                      'email':emailController.text,
                      'qualification':qualificationController.text,
                      'phn_no':phoneController.text,
                      'gender':gender??'female',
                      
                      'work_status':workStatusController.text,
                    }, endPoint: 'pro_register.php',image: pickedImage!);}
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
                      child: Text('Signup'),
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
      ),
    );
  }
}
