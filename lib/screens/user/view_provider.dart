import 'dart:developer';

import 'package:develop_n/Constants/constants.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';

class ViewProvider extends StatelessWidget {
  ViewProvider({super.key, required this.providerId});
  String providerId;
  Future<dynamic> getData() async {
    return await Services.postData(
        {'provider_id': providerId}, 'profile_view.php');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
            future: getData(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snap.hasData) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 300,
                      flexibleSpace: SizedBox(
                          height: 300,
                          child: Image.network(
                              Constants.baseImageUrl + snap.data!['image'],
                              fit: BoxFit.cover)),
                      title: Text(snap.data!['name']),
                    ),
                    SliverFillRemaining(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Contact us:',style: TextStyle(fontSize: 30),),
                            SizedBox(height: 20,),
                            Text(
                             'name: ${ snap.data!['email']}',
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                             'phone: ${ snap.data!['phn_no']}',
                              style: TextStyle(fontSize: 25),
                            ),
                            Text(
                              'qualification: ${snap.data!['qualification']}',
                              style: TextStyle(fontSize: 25),
                            ),
                          
                            Text(
                              'work status: ${snap.data!['work_status']}',
                              style: TextStyle(fontSize: 25),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Center(child: Text('No data'));
              }
            }),
      ),
    );
  }
}
