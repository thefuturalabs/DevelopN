import 'package:develop_n/screens/view_idea.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdeaList extends StatelessWidget {
  IdeaList({super.key, required this.allIdeas});
  bool allIdeas;
  Future<dynamic> getIdea() async {
    var data;
    if (!allIdeas) {
      String uid = await Services.getUserId() ?? '2';
      data = await Services.postData({'provider_id': uid}, 'view_idea.php');
    }
      print('data in widgets $data');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIdea(),
        builder: (context, snap) {
          print(snap.data);
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snap.hasData) {
            return ListView.builder(
              itemCount: (snap.data as List).length,
              itemBuilder: (_, index) {
              return Card(
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ViewIdea(data: snap.data![index]),),);
                    // ViewIdea();
                  },
                  child: ListTile(
                    leading: Icon(Icons.lightbulb),
                    title: Text((snap.data as List) [index]['title']),
                  ),
                ),
              );
            });
          } else {
            return Center(child: Text('Something went wrong'));
          }
        });
  }
}
