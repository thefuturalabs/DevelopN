import 'package:develop_n/screens/service_provider/add_idea_page.dart';
import 'package:develop_n/widgets/idea_list.dart';
import 'package:develop_n/widgets/request_list.dart';
import 'package:flutter/material.dart';

import '../../widgets/service_provider_drawer.dart';

class ServiceProviderHomePage extends StatefulWidget {
  const ServiceProviderHomePage({super.key});

  @override
  State<ServiceProviderHomePage> createState() =>
      _ServiceProviderHomePageState();
}

class _ServiceProviderHomePageState extends State<ServiceProviderHomePage>
    with TickerProviderStateMixin {
  late TabController tabController;

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(handleTabSelection);
  }

  handleTabSelection() {
  
      setState(() {
       
      });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TabBar(
        // enableFeedback: true,

        onTap: (_) {
          setState(() {});
        },
        controller: tabController,
        tabs: const [
          Tab(
            icon: Icon(Icons.lightbulb),
          ),
          Tab(
            icon: Icon(Icons.person),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('DevelopN'),
      ),
      drawer: ServiceProviderDrawer(),
      body: TabBarView(controller: tabController, children: [
        IdeaList(allIdeas: false),
        const RequestList(),
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
      floatingActionButton: tabController.index == 0
          ? FloatingActionButton(
              tooltip: 'Add New Idea',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddIdeaPage(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
