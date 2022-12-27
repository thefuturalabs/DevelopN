import 'package:flutter/material.dart';

class ServiceProviderDrawer extends StatelessWidget {
  const ServiceProviderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 60,),
                child: Text(
                  'UserName',
                  style: TextStyle(fontSize: 30),
                )),
            Divider(),
            Card(
              child: ListTile(
                title: Text('Messages'),
                trailing: Icon(Icons.message),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Feedbacks'),
                trailing: Icon(Icons.feedback),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
