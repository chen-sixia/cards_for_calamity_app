import 'package:flutter/material.dart';

import 'card_stack_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cards For Calamity',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        primaryColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CardStackPage(title: 'Cards For Calamity'),
      debugShowCheckedModeBanner: false,
    );
  }
}
