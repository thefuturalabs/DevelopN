import 'package:develop_n/screens/login_page.dart';
import 'package:develop_n/screens/service_provider_home_page.dart';
import 'package:develop_n/screens/user_home_page.dart';
import 'package:develop_n/services/services.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DevelopN',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 48, 102, 145),
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
          future: Services.getUserType(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return LoginPage();
              
            } else if(snap.data=='provider'){
              return ServiceProviderHomePage();
            }else{
              return UserHomePage();
            }
          }),
    );
  }
}
