import 'package:develop_n/screens/add_idea_page.dart';
import 'package:flutter/material.dart';

import '../widgets/service_provider_drawer.dart';

class ServiceProviderHomePage extends StatelessWidget {
  const ServiceProviderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DevelopN'),
      ),
      drawer: ServiceProviderDrawer(),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (_, index) {
            return Card(
              child: ListTile(
                title: Text('Requester name'),
                subtitle: Text('Project name'),
                trailing:
                    ElevatedButton(onPressed: () {}, child: Text('Accept')),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Idea',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddIdeaPage(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
