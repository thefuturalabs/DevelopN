import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProviderChatPage extends StatefulWidget {
  ProviderChatPage({super.key, required this.userId});
  String userId;

  @override
  State<ProviderChatPage> createState() => _UserChatPageState();
}

class _UserChatPageState extends State<ProviderChatPage> {
  TextEditingController messageController = TextEditingController();
  TextEditingController replyController = TextEditingController();

  bool isLoading = false;

  // sendMessage() async {
  //   if (messageController.text.trim() != '') {
  //     setState(() {
  //       isLoading = true;
  //     });
  //     Map data = await Services.postData(
  //       {
  //         'provider_id': widget.recieverId,
  //         'message': messageController.text,
  //         'user_id': widget.senderId
  //       },
  //       'user-provider.php',
  //     );
  //     messageController.clear();
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }
  // }

  sendReply(String chatId) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('send reply'),
              content: TextFormField(

                controller: replyController,
                decoration: const InputDecoration(
                  label: Text('reply'),
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      final data = await Services.postData(
                          {'chat_id': chatId, 'reply': replyController.text},
                          'add_reply.php');
                      if (data['result'] == 'updated') {
                        Navigator.pop(context);
                        setState(() {});
                      }
                    },
                    child: Text('send'))
              ],
            ));
  }

  Future<dynamic> getChats() async {
    String prId = await Services.getUserId() ?? '2';
    print('provider ${prId} user ${widget.userId}');
    final data = await Services.postData(
      {
        'provider_id': prId,
        'user_id': widget.userId,
      },
      'u-p chatlist.php',
    );
    print('???????$data');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snap.data![index]['message']),
                                  if (snap.data![index]['reply'] == '')
                                    IconButton(
                                        onPressed: () {
                                          sendReply(
                                            snap.data![index]['chat_id'],
                                          );
                                        },
                                        icon: Icon(Icons.reply))
                                ],
                              ),
                            ),
                            if (snap.data![index]['reply'] != '')
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 124, 124, 124),
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                width: double.infinity,
                                child: Text(snap.data![index]['reply']),
                              ),
                          ],
                        );
                      },
                    );
                  } else if (snap.hasError) {
                    return Center(child: Text('errrrrr'));
                  } else {
                    return Text('wrong');
                  }
                }),
          ),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Padding(
          //         padding:
          //             const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          //         child: TextFormField(
          //           controller: messageController,
          //           keyboardType: TextInputType.visiblePassword,
          //           decoration: const InputDecoration(
          //             label: Text('message'),
          //             border: OutlineInputBorder(),
          //           ),
          //         ),
          //       ),
          //     ),
          //     IconButton(
          //       onPressed: () {
          //         if (messageController.text.trim() != '') {
          //           sendMessage();
          //           setState(() {});
          //         }
          //       },
          //       icon: isLoading
          //           ? const Icon(Icons.pending)
          //           : const Icon(Icons.send),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
