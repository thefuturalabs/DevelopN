import 'package:badges/badges.dart' as badge;
import 'package:develop_n/screens/login_page.dart';
import 'package:develop_n/screens/notifications.dart';
import 'package:develop_n/screens/service_provider/provider_chat_list.dart';
import 'package:develop_n/screens/service_provider/provider_chat_page.dart';
import 'package:develop_n/screens/service_provider/provider_profile_screen.dart';
import 'package:develop_n/screens/service_provider/view_feedbacks.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 60,
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => ProviderProfilePage()));
                  },
                  child: Text(
                    'Manage Profile',
                    style: TextStyle(fontSize: 30),
                  ),
                )),
            Divider(),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ProviderChatList()));
                },
                title: Text('Messages'),
                trailing: Icon(Icons.message),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => ViewFeedBack()));
                },
                title: Text('Feedbacks'),
                trailing: Icon(Icons.feedback),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ViewNotifications()));
                },
                title: Text('Notification'),
                trailing: FutureBuilder(
                    future: Services.isNotificationRead(),
                    builder: (context, snap) {
                      if (snap.hasData) {
                        return badge.Badge(
                            child: Icon(Icons.notifications),
                            badgeColor: snap.data as bool
                                ? Colors.transparent
                                : Colors.red);
                      } else {
                        return Icon(Icons.notifications);
                      }
                    }),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  SharedPreferences spref =
                      await SharedPreferences.getInstance();
                  spref.clear();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginPage(),
                    ),
                  );
                },
                title: Text('Logout'),
                trailing: Icon(Icons.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
