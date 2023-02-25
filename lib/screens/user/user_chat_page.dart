import 'dart:developer';

import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';

class UserChatPage extends StatefulWidget {
  UserChatPage({super.key, required this.recieverId, required this.senderId});
  String recieverId;
  String senderId;

  @override
  State<UserChatPage> createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
  TextEditingController messageController = TextEditingController();
  TextEditingController replyController = TextEditingController();

  bool isLoading = false;

  sendMessage() async {
    if (messageController.text.trim() != '') {
      setState(() {
        isLoading = true;
      });
      Map data = await Services.postData(
        {
          'provider_id': widget.recieverId,
          'message': messageController.text,
          'user_id': widget.senderId
        },
        'user-provider.php',
      );
      messageController.clear();
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<dynamic> getChats() async {
    print('provider ${widget.recieverId} user ${widget.senderId}');
    final data = await Services.postData(
      {
        'provider_id': widget.recieverId,
        'user_id': widget.senderId,
      },
      'u-p chatlist.php',
    );
    print('???????$data');
    return data;
  }

  getUserBio() async {
    final data = await Services.postData(
      {'user_id': widget.recieverId},
      'user_profile_view.php',
    );
    print(data);
    setState(() {
      userData = data;
    });
  }

  Map? userData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserBio();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              showDialog(context: context, builder: (_)=>
              AlertDialog(
                title: Text(userData!['name']),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children:[
                    Text('name   : ${userData!['name']}'),
                    Text('email   : ${userData!['email']}'),
                    Text('mobile: ${userData!['mobile']}'),
                  ]
                  //  userData!.entries.map((e) => Text('${e.key}: ${e.value}'),).toList(),
                ),
              ));
            },
            child: CircleAvatar(
              
              backgroundImage:userData!=null? NetworkImage(userData!['dp']):null,
            ),
          ),
        ),
        title:userData!=null? Text(userData!['name']):null,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<dynamic>(
                future: getChats(),
                builder: (context, snap) {
                  print('daataaaaaaaaaa: ${snap.data}');
                  if (snap.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snap.hasData) {
                    // print(snap.data);
                    // print(snap.data.runtimeType);
                    if (snap.data[0]['message'] == 'Failed to View') {
                      return Center(child: Text('No message yet'));
                    } else {
                      return ListView.builder(
                        itemCount: snap.data.length,
                        itemBuilder: (_, index) {
                          return Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 79, 79, 79),
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.fromLTRB(10, 10, 20, 0),
                                width: double.infinity,
                                child: Text(snap.data![index]['message']),
                              ),
                              if (snap.data![index]['reply'] != '')
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 79, 79, 79),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                  width: double.infinity,
                                  child: Text(snap.data![index]['reply']),
                                ),
                            ],
                          );
                        },
                      );
                    }
                  } else if (snap.hasError) {
                    return Center(child: Text('errrrrr'));
                  } else {
                    return Text('wrong');
                  }
                }),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: TextFormField(
                    controller: messageController,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      label: Text('message'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (messageController.text.trim() != '') {
                    sendMessage();
                    setState(() {});
                  }
                },
                icon: isLoading
                    ? const Icon(Icons.pending)
                    : const Icon(Icons.send),
              ),
            ],
          )
        ],
      ),
    );
  }
}
