import 'dart:convert';
import 'dart:io';

import 'package:develop_n/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  static Future<bool> isNotificationRead() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    int number = spref.getInt('noti') ?? 0;
    final data = await Services.getData('view_notification.php');
    return data.length == number;
  }

  static Future<dynamic> postData(Map params, String endPoint) async {
    Response res = await post(
      Uri.parse(Constants.baseUrl + endPoint),
      body: params,
    );
    print('response>>>${res.body}');
    return jsonDecode(res.body);
  }

  static getData(String endPoint) async {
    Response res = await get(
      Uri.parse(Constants.baseUrl + endPoint),
    );
    return jsonDecode(res.body);
  }

  static Future<String?> postWithIamge(
      {required String endPoint,
      required Map params,
      required File image}) async {
    print('called multipart function');
    var request =
        new MultipartRequest("POST", Uri.parse(Constants.baseUrl + endPoint));
    params.entries.forEach((element) {
      request.fields[element.key] = element.value;
    });
    // request.fields['user'] = 'someone@somewhere.com';
    request.files.add(await MultipartFile.fromPath(
      'image',
      image.path,
      // contentType: new MediaType('application', 'x-tar'),
    ));
    try {
      StreamedResponse response = await request.send();
//  .then((response) async{
      print('waiting for response');
      if (response.statusCode == 200) print("Uploaded!");
      final data = await Response.fromStream(response);
      print(data.body);
      return data.body;
      // });
    } on Exception catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  static Future<File?> pickImage(BuildContext context) async {
    XFile? pickedFile;
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Select source'),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: Text('camera'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Text('gallery'),
                ),
              ],
            ));

    print('>>>>>>>>>${pickedFile!.name}');

    if (pickedFile != null) {
      return File(pickedFile!.path);
    }
  }

  static Future<String?> getUserId() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    String? uid = spref.getString('userId');
    print('user id: ${uid ?? "not found"}');
    return spref.getString('userId');
  }

  static Future<String?> getUserType() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    String? uid = spref.getString('type');
    print('user type: ${uid ?? "not found"}');
    return spref.getString('type');
  }

  static checkConnection() {
    Socket.connect(Constants.baseUrl.split('/')[2].trim(), 80,
            timeout: Duration(seconds: 5))
        .then((socket) {
      print("Connection Success");
      socket.destroy();
    }).catchError((error) {
      Socket.connect(Constants.baseUrl.split('/')[2].trim(), 8080,
              timeout: Duration(seconds: 5))
          .then((socket) {
        print("Connection Success");
        socket.destroy();
      }).catchError((error) {
        Fluttertoast.showToast(
            msg:
                'Connection error at ${Constants.baseUrl.split('/')[2].trim()}');
      });
    });
  }

 static Future<void> fetchAndSetIdeaCategories() async {
    List ideas = await Services.getData('view_all_idea.php');
print('ideas: $ideas');
    Constants.ideaCategories =
        ideas.map((element) => element['category']as String).toList() ;
  }

  // updateIdeaCategories(String newCategory) async {
  //   SharedPreferences spref = await SharedPreferences.getInstance();
  //   List<String> tempList = spref.getStringList('idea_categories') ?? [];
  //   tempList.add(newCategory);
  //   spref.setStringList('idea_categories', tempList);
  //   fetchAndSetIdeaCategories();
  // }
}
