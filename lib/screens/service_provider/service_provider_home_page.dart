import 'package:develop_n/screens/service_provider/add_idea_page.dart';
import 'package:develop_n/widgets/idea_list.dart';
import 'package:develop_n/widgets/request_list.dart';
import 'package:flutter/material.dart';

import '../../widgets/service_provider_drawer.dart';

class ServiceProviderHomePage extends StatelessWidget {
  const ServiceProviderHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.lightbulb),
            ),
            Tab(
              icon: Icon(Icons.person),
            ),
          ],
        ),
        appBar: AppBar(
          title: Text('DevelopN'),
        ),
        drawer: ServiceProviderDrawer(),
        body: TabBarView(children: [
          IdeaList(allIdeas: false),
          RequestList(
            
          ),
        ]),
        // ListView.builder(
        //     itemCount: 20,
        //     itemBuilder: (_, index) {
        //       return Card(
        //         child: ListTile(
        //           title: Text('Requester name'),
        //           subtitle: Text('Project name'),
        //           trailing:
        //               ElevatedButton(onPressed: () {}, child: Text('Accept')),
        //         ),
        //       );
        //     }),
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
      ),
    );
  }
}
