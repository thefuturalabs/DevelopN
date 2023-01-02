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

  bool isLoading = false;

  sendMessage() async {
    if (messageController.text.trim() != '') {
      setState(() {
        isLoading = true;
      });
      messageController.clear();
      Map data = await Services.postData(
        {
          'provider_id': widget.recieverId,
          'message': messageController.text,
          'user_id': widget.senderId
        },
        'user-provider.php',
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (_, index) {
                return Container();
              },
            ),
          ),
          Row(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextFormField(
                  controller: messageController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'enter password';
                    }
                  },
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    label: Text('password'),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              IconButton(
                onPressed: sendMessage,
                icon: isLoading? const Icon(Icons.send):const Icon(Icons.pending),
              ),
            ],
          )
        ],
      ),
    );
  }
}
