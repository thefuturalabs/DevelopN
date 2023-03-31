import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key, required this.ideaId, required this.providerId,required this.price});
  String ideaId;
  String providerId;
  String price;
  final fkey = GlobalKey<FormState>();
  TextEditingController upiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(40),
                child: Text(
                  '₹$price',
                  style: TextStyle(fontSize: 60),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text('Pay using,'),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('enter UPI id'),
                              content: Form(
                                key: fkey,
                                child: TextFormField(
                                  controller: upiController,
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Enter upi';
                                    } else if (!v.contains('@')) {
                                      return "upi id format not corrent";
                                    }
                                  },
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () async {
                                    await launchUrl(
                                      Uri.parse(
                                        'upi://pay?pa=${upiController.text}&pn=Dev&am=$price.00&cu=INR&aid=uGICAgICNgb2BfQ',
                                      ),
                                      mode: LaunchMode
                                          .externalNonBrowserApplication,
                                    );
                                    Future.delayed(Duration(seconds: 5))
                                        .then((value) {
                                      requestIdea(context);
                                    });
                                  },
                                  child: Text('Submit'),
                                ),
                              ],
                            );
                          });
                    },
                    child: Text('upi')),
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: null,
                    child: Text('Bank transfer'),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  requestIdea(BuildContext context) async {
    String uid = await Services.getUserId() ?? '2';
    final data = await Services.postData(
        {'provider_id': providerId, 'user_id': uid, 'idea_id': ideaId},
        'add_request.php');
        if(data['result']=='Added...'){
          showDialog(context: context, builder: (_)=>AlertDialog(
            title: Text('Request submitted'),
          ));
        }
  }
}
