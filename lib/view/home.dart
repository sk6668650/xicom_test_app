import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xicom_test/constants/urls.dart';
import 'package:xicom_test/model/request/get_images.dart';
import 'package:xicom_test/model/response/get_image_response.dart';
import 'package:xicom_test/network/api_call.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xicom_test/view/user_form.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Images> images = List<Images>.empty(growable: true);
  int imagePageCount = 0;
  bool visibility = false;

  @override
  void initState() {
    images.clear();
    callApi();
    super.initState();
  }

  callApi() async {
    var one = GetImages(
        userId: "108", offset: imagePageCount.toString(), type: "popular");
    var response = await ApiCall.callApi(ApiUrls.getImageUrl, one);
    var data = GetImagesResponse.fromJson(response);

    if (data.images.isNotEmpty) {
      for (int i = 0; i < data.images.length; i++) {
        images.add(data.images[i]);
        visibility = true;
      }
    } else {
      Fluttertoast.showToast(
          msg: "There is no image left.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Images"),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey.shade200,
          child: images.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 10.0),
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          if (index == images.length - 1) {
                            return Visibility(
                              visible: visibility,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      imagePageCount++;
                                      callApi();
                                    },
                                    child: const Text(
                                      "Load more images",
                                      style: TextStyle(fontSize: 25.0),
                                    )),
                              ),
                            );
                          } else {
                            return GestureDetector(
                              onTap: () {
                                Get.to(UserForm(
                                  image: images[index].xtImage,
                                ));
                              },
                              child: Image.network(
                                images[index].xtImage,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  debugPrint("\n$stackTrace");
                                  return const SizedBox(
                                    height: 0,
                                    width: 0,
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
