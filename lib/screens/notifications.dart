import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewNotifications extends StatelessWidget {
  const ViewNotifications({super.key});

 Future<dynamic> getNotifications()async{
    final data= await Services.getData('view_notification.php');
    SharedPreferences spref=await SharedPreferences.getInstance();
    spref.setInt('noti',data.length);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getNotifications(),
        builder: (_, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snap.hasData) {
          return ListView.builder(
            itemCount: snap.data.length,
            itemBuilder: (_, index) {
            return Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 79, 79, 79),
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
              width: double.infinity,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(snap.data![index]['title'],style: TextStyle(fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(snap.data![index]['notification']),
                  ),
                ],
              ),
            );
          });
        } else {
          return Center(child: Text('Something went wrong'));
        }
      }),
    );
  }
}
