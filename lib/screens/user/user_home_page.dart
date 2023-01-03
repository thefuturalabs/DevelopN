
import 'package:develop_n/widgets/idea_list.dart';
import 'package:develop_n/widgets/user_drawer.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: UserDrawer(),
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
                    'Ideas',
                    style: TextStyle(
                        color: Color.fromARGB(255, 169, 200, 226),
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
          ),
                Divider(),
          Expanded(child: IdeaList(allIdeas: true)),
        ],
      )
    );
  }
}
