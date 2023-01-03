import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddFeedback extends StatelessWidget {
  AddFeedback({super.key});

  TextEditingController feedbackController = TextEditingController();

  sendFeedback(BuildContext context) async {
    String uid = await Services.getUserId() ?? '2';
    final data = await Services.postData({
      'user_id': uid,
      'feedback': feedbackController.text,
    }, 'add_feedback.php');
    if (data['result'] == 'done') {
      Fluttertoast.showToast(msg: 'SENT');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                maxLines: 7,
                controller: feedbackController,
                decoration: const InputDecoration(
                  label: Text('feedback'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    sendFeedback(context);
                  },
                  child: Text('SEND'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
