import 'package:develop_n/screens/view_idea.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class YourPurchases extends StatelessWidget {
  const YourPurchases({super.key});

  Future<dynamic> getBoughtIdeas() async {
    String userId = await Services.getUserId() ?? '';
    return Services.postData({'user_id': userId}, 'bought_ideas.php');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your purchases'),
      ),
      body: FutureBuilder(
        future: getBoughtIdeas(),
        builder: (_, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snap.hasData) {
            return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (_, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewIdea(
                                  data: snap.data[index],
                                  byUser: true,
                                  restrictedView: false)));
                    },
                    title: Text(snap.data[index]['title']),
                    trailing: Text(
                      snap.data[index]['status'] == 0
                          ? 'purchase pending'
                          : 'purchased',
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text('No data'),
            );
          }
        },
      ),
    );
  }
}
