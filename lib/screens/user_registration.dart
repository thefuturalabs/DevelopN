import 'package:develop_n/screens/user_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserRegistration extends StatelessWidget {
   UserRegistration({super.key});
final fkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: fkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: TextFormField(
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
              ), Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: TextFormField(
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
              ), Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: TextFormField(
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
              ), Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: TextFormField(
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
              ), Padding(
                padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: TextFormField(
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
                padding: const EdgeInsets.only(top: 30),
                child: InkWell(
                  onTap: () {
                    if (fkey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => UserHomePage(),
                        ),
                      );
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
                
                },
                child: Text(
                  'SignUp instead',
                  style: TextStyle(color: Colors.white),
                ),
              )
        ]),
      ),
    );
  }
}