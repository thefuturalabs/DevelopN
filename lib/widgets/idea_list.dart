import 'package:develop_n/screens/view_idea.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';

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
    } else {
      String uid = await Services.getUserId() ?? '2';
      data = await Services.getData('view_all_idea.php');
    }
    print('data in widgets $data');
    rawData = data;
    if (filteredList.length < 1) {
      filteredList = data;
    }
    return data;
  }

  List<dynamic> rawData = [];
  filterList(String keyword) {
    setState(() {
      filteredList = filteredList
          .where(
            (element) => element['category'].toUpperCase().contains(
                  keyword.toUpperCase(),
                ),
          )
          .toList();
    });
  }

  List<dynamic> filteredList = [];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  // }

  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: Column(
        children: [
          SizedBox(height: 60,
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'search...',
                  suffix: IconButton(
                      onPressed: () {
                        print('tapped');
                        setState(() {
                          filteredList = rawData;
                        });
                        searchController.clear();
                      },
                      icon: Icon(Icons.close))),
              onChanged: (value) {
                filterList(value);
              },
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: getIdea(),
                builder: (context, snap) {
                  print(snap.data);
                  if (snap.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snap.hasData) {
                    if (snap.data.first['message'] == 'Failed to View') {
                      return Center(child: Text('Nothing here to view'));
                    } else {
                      return ListView.builder(
                          itemCount: (filteredList as List).length,
                          itemBuilder: (_, index) {
                            return Card(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ViewIdea(
                                        data: filteredList[index],
                                        byUser: widget.allIdeas,
                                        restrictedView: widget.allIdeas,
                                      ),
                                    ),
                                  );
                                  // ViewIdea();
                                },
                                child: ListTile(
                                  leading: Icon(Icons.lightbulb),
                                  title: Text(
                                      (filteredList as List)[index]['title']),
                                ),
                              ),
                            );
                          });
                    }
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: height / 2 - 100),
                      child: Text('Something went wrong'),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
