// import 'package:develop_n/screens/user/payment_scree.dart';
import 'package:develop_n/screens/user/payment_screen.dart';
import 'package:develop_n/screens/user/user_chat_page.dart';
import 'package:develop_n/screens/user/view_provider.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewIdea extends StatelessWidget {
  ViewIdea(
      {super.key,
      required this.data,
      required this.byUser,
      required this.restrictedView});
  Map data;
  bool byUser;
  bool restrictedView;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // drawer: Drawer(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    data['title'],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ViewProvider(
                                  providerId: data['provider_id'])));
                    },
                    child: Text(
                      'view author',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    )),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  data['idea'],
                  overflow:restrictedView?TextOverflow.ellipsis:null, 
                  // softWrap: true,
                 maxLines: restrictedView?4:null,
                ),
              if(restrictedView)  TextButton(
                  onPressed: () {
                    Fluttertoast.showToast(msg: 'purchase to read more');
                      Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PaymentScreen(
                                price: data['price'],
                                ideaId: data['idea_id'],
                                providerId: data['provider_id'],
                              ),
                            ),
                          );
                  },
                  child: Text('read more'),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data['price'],
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (byUser)
                      ElevatedButton(
                        onPressed: () async {
                          String userId = await Services.getUserId() ?? '2';
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => UserChatPage(
                                  recieverId: data['provider_id'],
                                  senderId: userId),
                            ),
                          );
                        },
                        child: Text(
                          'CHAT',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    SizedBox(
                      width: 20,
                    ),
                    if (byUser)
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PaymentScreen(
                                price: data['price'],
                                ideaId: data['idea_id'],
                                providerId: data['provider_id'],
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'BUY',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ],
      )),
    );
  }
}
