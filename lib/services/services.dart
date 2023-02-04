import 'dart:convert';
import 'dart:io';

import 'package:develop_n/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {

static Future<bool> isNotificationRead()async{
  SharedPreferences spref=await SharedPreferences.getInstance();
   int number= spref.getInt('noti')??0;
  final data= await Services.getData('view_notification.php');
return data.length==number;
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

static Future<String?> postWithIamge({required String endPoint,required Map params,required File image}) async {

  print('called multipart function');
    var request = new MultipartRequest("POST", Uri.parse(Constants.baseUrl+endPoint));
params.entries.forEach((element) { 
  request.fields[element.key]=element.value;
});
    // request.fields['user'] = 'someone@somewhere.com';
    request.files.add(await MultipartFile.fromPath(
      'image',
      image.path,
      // contentType: new MediaType('application', 'x-tar'),
    ));
    try {
  request.send().then((response) async{
    if (response.statusCode == 200) print("Uploaded!");
    final data=await Response.fromStream(response);
    print(data.body);
    return data.body;
  });
} on Exception catch (e) {
  Fluttertoast.showToast(msg:e.toString());
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

  static Future<String?> getUserId()async{
    SharedPreferences spref=await SharedPreferences.getInstance();
    String? uid=spref.getString('userId');
    print('user id: ${uid??"not found"}');
    return spref.getString('userId');
  }
  static Future<String?> getUserType()async{
    SharedPreferences spref=await SharedPreferences.getInstance();
    String? uid=spref.getString('type');
    print('user type: ${uid??"not found"}');
    return spref.getString('type');
  }
}
