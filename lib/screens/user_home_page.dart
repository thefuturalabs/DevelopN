import 'package:develop_n/screens/view_idea.dart';
import 'package:flutter/material.dart';

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
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => ViewIdea(),
                //   ),
                // );
              },
            ),
          ),
        );
      }),
    );
  }
}
