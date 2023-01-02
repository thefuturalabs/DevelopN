import 'package:develop_n/screens/payment_scree.dart';
import 'package:develop_n/screens/user_chat_page.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';

class ViewIdea extends StatelessWidget {
   ViewIdea({super.key,required this.data,required this.byUser});
Map data;
bool byUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // drawer: Drawer(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              data['title'],
              style: TextStyle(
                fontSize: 30,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
             data['idea']
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
                if(byUser) ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => PaymentScreen(),
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
                ElevatedButton(
              onPressed: () async{
                String userId= await Services.getUserId()??'2';
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => UserChatPage(recieverId: data['provider_id'],senderId:userId ),
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
