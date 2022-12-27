import 'package:flutter/material.dart';

class AddIdeaPage extends StatelessWidget {
  AddIdeaPage({super.key});

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'add your idea details below',
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                label: Text('title'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              maxLines: 5,
              decoration: const InputDecoration(
                label: Text('details'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 150,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: titleController,
                decoration: const InputDecoration(
                  label: Text('price'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Expanded(child: SizedBox()),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Submit Idea'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
