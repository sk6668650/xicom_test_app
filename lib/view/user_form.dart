import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:xicom_test/model/response/post_user_response.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();

  late Uint8List imageBytes;

  var fileMy;

  @override
  void initState() {
    super.initState();
    ///urlToFile();
    convertToBytes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Screen"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.image,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  debugPrint("$stackTrace");

                  return const SizedBox(
                    height: 0,
                    width: 0,
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "  First Name",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: TextField(
                      controller: firstName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'First Name',
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "  Last name",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: TextField(
                      controller: lastName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'last name',
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "  Email",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: TextField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'email',
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "  Phone",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 18,
                    width: MediaQuery.of(context).size.width / 1.8,
                    child: TextField(
                      controller: phone,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'phone',
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "        ",
                        style: TextStyle(fontSize: 20, color: Colors.grey),
                        textScaleFactor: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        ///apiCall();
                        ///urlToFile();
                        validate();
                      },
                      child: const Text("Submit"),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  validate() {
    firstName.text.isEmpty ||
            lastName.text.isEmpty ||
            email.text.isEmpty ||
            phone.text.isEmpty
        ? Fluttertoast.showToast(
            msg: "please enter all the fields",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0)
        : !email.text.contains("@") ||
                !email.text.contains(".") ||
                email.text.length < 6
            ? Fluttertoast.showToast(
                msg: "please enter a valid email address",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0)
            : phone.text.length != 10
                ? Fluttertoast.showToast(
                    msg: "please enter a valid phone number",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0)
                : apiCall();
  }

  convertToBytes() async {
    imageBytes = (await NetworkAssetBundle(Uri.parse(widget.image))
        .load(widget.image))
        .buffer
        .asUint8List();

    print(imageBytes);
  }

  
  
  apiCall() async {
    var request = http.MultipartRequest("POST",Uri.parse("http://dev3.xicom.us/xttest/savedata.php"));

    request.fields['first_name'] = firstName.text;
    request.fields['last_name'] = lastName.text;
    request.fields['email'] = email.text;
    request.fields['phone'] = phone.text;
    ///request.fields['user_image'] = "image.png";

    var file = http.MultipartFile.fromBytes('user_image', imageBytes,filename: "icon.png");

    print(file);
    request.files.add(file);

    var response = await request.send();

    final respStr = await response.stream.bytesToString();


   var one =  UserResponse.fromJson(jsonDecode(respStr));


   if(one.status == "success"){
     Fluttertoast.showToast(
         msg: one.message,
         toastLength: Toast.LENGTH_LONG,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.green,
         textColor: Colors.white,
         fontSize: 16.0);
   }

   else if (one.status == "failed"){
     Fluttertoast.showToast(
         msg: one.message,
         toastLength: Toast.LENGTH_LONG,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 16.0);
   }else{
     Fluttertoast.showToast(
         msg: "something went wrong",
         toastLength: Toast.LENGTH_LONG,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.red,
         textColor: Colors.white,
         fontSize: 16.0);
   }


    print(respStr);

    // var responseData = await response.stream.toBytes();
    // print(responseData);
    // var result = String.fromCharCode(responseData);
    // print(result);

  }

//   Future<File> urlToFile() async {
// // generate random number.
//     var rng = new Random();
// // get temporary directory of device.
//     Directory tempDir = await getTemporaryDirectory();
// // get temporary path from temporary directory.
//     String tempPath = tempDir.path;
// // create a new file in temporary path with random file name.
//     File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');
// // call http.get method and pass imageUrl into it to get response.
//     http.Response response = await http.get(Uri.parse(widget.image));
// // write bodyBytes received in response to file.
//     await file.writeAsBytes(response.bodyBytes);
//     print(file);
//
//     fileMy = file;
// // now return the file which is created with random name in
// // temporary directory and image bytes from response is written to // that file.
//     return file;
//   }


  callApi() async {


    // final uri = Uri.parse('https://myendpoint.com');
    // var request =  http.MultipartRequest('POST', uri);
    // final httpImage = http.MultipartFile.fromBytes('files.myimage', widget.image,
    //     contentType: MediaType.parse(mimeType), filename: 'myImage.png');
    // request.files.add(httpImage);
    // final response = await request.send();
    //



    http.MultipartRequest request =  http.MultipartRequest("POST", Uri.parse('http://dev3.xicom.us/xttest/savedata.php'));

    http.MultipartFile multipartFile = await http.MultipartFile.fromPath('file', "image.png");

    ///http.MultipartFile multipartFile = http.MultipartFile.fromBytes('file', imageBytes);
    request.files.add(multipartFile);

    http.StreamedResponse response = await request.send();

    final respStr = await response.stream.bytesToString();

    print(respStr);

  }
}
