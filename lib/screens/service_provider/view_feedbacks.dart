import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';

class ViewFeedBack extends StatelessWidget {
  const ViewFeedBack({super.key});

 Future<dynamic> getFeedbacks()async{
    final data= await Services.postData({}, 'view_feedback.php');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getFeedbacks(),
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
                  Text(snap.data![index]['feedback'],style: TextStyle(fontSize: 20)),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(snap.data![index]['user']),
                    ),
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
