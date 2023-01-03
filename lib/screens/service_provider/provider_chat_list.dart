import 'package:develop_n/screens/service_provider/provider_chat_page.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProviderChatList extends StatelessWidget {
  const ProviderChatList({super.key});

Future<dynamic> getChatList()async{
  String uid=await Services.getUserId()??'2';
final data=await Services.postData({'provider_id':uid}, 'chat_list.php');
return data;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('chats'),),
      body: FutureBuilder(
        future: getChatList(),
        builder: (_, snap) {
          if(snap.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if(snap.hasData){
        return ListView.builder(
          itemCount: snap.data!.length,
          itemBuilder: (_, index) {
          return Card(
            child: ListTile(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (_)=>ProviderChatPage(userId: snap.data![index]['user_id'],)));
              },
              title: Text(snap.data![index]['user']),
            ),
          );
        });}else{
          return Center(child: Text('something wrong'));
        }
      }),
    );
  }
}
