import 'dart:convert';
import 'dart:io';

import 'package:develop_n/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
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

static  postWithIamge({required String endPoint,required Map params,required File image}) async {
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
    request.send().then((response) {
      if (response.statusCode == 200) print("Uploaded!");
    });
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
}
