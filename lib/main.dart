import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xicom_test/view/home.dart';

void main()async{
  runApp(const GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),));
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}
