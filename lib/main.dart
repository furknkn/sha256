import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sha256/shaspn/sha256_spn_view.dart';

import 'chat/chat_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Crypto Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShaSpnView(),
    );
  }
}

