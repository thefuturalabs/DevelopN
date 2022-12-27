import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (_, index) {
        return Card(
          child: ListTile(
            title: const Text('Project title'),
            subtitle: const Text('Project owner name'),
            trailing: ElevatedButton(
              child: const Text('View'),
              onPressed: () {},
            ),
          ),
        );
      }),
    );
  }
}
