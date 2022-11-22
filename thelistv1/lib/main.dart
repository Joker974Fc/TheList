//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thelistv1/Acc.dart';
import 'package:thelistv1/FrigPage.dart';
import 'package:thelistv1/PharmaPage.dart';

// couleur perso
const d_green = Color.fromARGB(255, 73, 137, 129);
int cindex = 0;

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
}
