import 'package:develop_n/screens/provider_registration_page.dart';
import 'package:develop_n/screens/service_provider_home_page.dart';
import 'package:develop_n/screens/user_home_page.dart';
import 'package:develop_n/screens/user_registration.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final fkey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 48, 102, 145),
      body: Form(
        key: fkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: SizedBox()),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  'Develop\'N',
                  style: TextStyle(
                      color: Color.fromARGB(255, 169, 200, 226),
                      fontSize: 50,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Lottie.asset('assets/bulb.json'),
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
                controller: passwordaController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'enter password';
                  }
                },
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  label: Text('password'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: InkWell(
                onTap: () {
                  login(context);
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
                showRegistrationDialog(context);
              },
              child: Text(
                'SignUp instead',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  login(BuildContext context) async {
    if (fkey.currentState!.validate()) {
      Map data = await Services.postData({
        'username': usernameController.text,
        'password': passwordaController.text
      }, 'login.php');
      print(data);
      if (data['message'] != 'Failed to LogIn') {
        SharedPreferences spref = await SharedPreferences.getInstance();
        spref.setString('userId', data['patient_id']);
        spref.setString('type', data['type']);
        if(data['type']=='provider'){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ServiceProviderHomePage(),
          ),
        );  
        }else{
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => UserHomePage(),
          ),
        );}
      } else {
        Fluttertoast.showToast(
            msg: 'Something went wrong',
            backgroundColor: ThemeData().backgroundColor);
      }
    }
  }

  showRegistrationDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Register as"),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProviderRegistration(),
                  ),
                );
              },
              child: Text('Idea Provider'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => UserRegistration(),
                  ),
                );
              },
              child: Text('User'),
            ),
          ],
        ),
      ),
    );
  }
}
