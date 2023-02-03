import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';

class RequestList extends StatefulWidget {
  const RequestList({super.key});

  @override
  State<RequestList> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  Future<dynamic> getRequests() async {
    String uid = await Services.getUserId() ?? '2';
    var data = await Services.postData({
      'provider_id': uid,
    }, 'view_request.php');
    // print('@@@@@ $data');
    return data;
  }

  acceptOrRejectRequest({
    required String reqId,
    required bool accept,
  }) async {
    Map data = await Services.postData(
      {'req_id': reqId},
      accept ? 'req_accept.php' : 'reject_req.php',
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: FutureBuilder(
          future: getRequests(),
          builder: (context, snap) {
            print(snap.data);
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snap.hasData) {
              if(snap.data.first['message']=='Failed to View'){
                return Center(child: Text('Nothing here to view'));
              }else{
              return ListView.builder(
                  itemCount: (snap.data as List).length,
                  itemBuilder: (_, index) {
                    return Card(
                      child: InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (_) => ViewIdea(data: snap.data![index]),
                          //   ),
                          // );
                          // ViewIdea();
                        },
                        child: ListTile(
                          leading: Icon(Icons.download),
                          title: Text((snap.data as List)[index]['name']),
                          subtitle: Text((snap.data as List)[index]['title']),
                          trailing: (snap.data as List)[index]['status'] == '0'
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    MaterialButton(
                                      color: Colors.green,
                                      onPressed: () {
                                        acceptOrRejectRequest(
                                            reqId: (snap.data as List)[index]
                                                ['req_id'],
                                            accept: true);
                                      },
                                      child: Text('accept'),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    MaterialButton(
                                      color: Colors.red,
                                      onPressed: () {
                                        acceptOrRejectRequest(
                                            reqId: (snap.data as List)[index]
                                                ['req_id'],
                                            accept: false);
                                      },
                                      child: Text('reject'),
                                    ),
                                  ],
                                )
                              : MaterialButton(
                                color:(snap.data as List)[index]['status'] == '1'?Colors.green:Colors.red ,
                                  onPressed: () {},
                                  child: Text(
                                      (snap.data as List)[index]['status'] == '1'
                                          ? 'Accepted'
                                          : 'Rejected'),
                                ),
                        ),
                      ),
                    );
                  });}
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
