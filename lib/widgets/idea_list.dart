import 'package:develop_n/screens/view_idea.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdeaList extends StatefulWidget {
  IdeaList({super.key, required this.allIdeas});
  bool allIdeas;

  @override
  State<IdeaList> createState() => _IdeaListState();
}

class _IdeaListState extends State<IdeaList> {
  Future<dynamic> getIdea() async {
    var data;
    if (!widget.allIdeas) {
      String uid = await Services.getUserId() ?? '2';
      data = await Services.postData({'provider_id': uid}, 'view_idea.php');
    }
    print('data in widgets $data');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: FutureBuilder(
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
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ViewIdea(
                                data: snap.data![index],
                                byUser: widget.allIdeas,
                              ),
                            ),
                          );
                          // ViewIdea();
                        },
                        child: ListTile(
                          leading: Icon(Icons.lightbulb),
                          title: Text((snap.data as List)[index]['title']),
                        ),
                      ),
                    );
                  });
            } else {
              return Padding(
                padding: EdgeInsets.only(top: height / 2 - 100),
                child: Text('Something went wrong'),
              );
            }
          }),
    );
  }
}
