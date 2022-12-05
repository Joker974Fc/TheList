//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:thelistv1/Vue/Acc.dart';

void main() {
  runApp(MyApp());
}

//Principal
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The List',
      home: Acc(),
    );
  }

  //gestion des notifications?

}
