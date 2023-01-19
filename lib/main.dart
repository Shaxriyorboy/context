import 'package:context/pages/context.dart';
import 'package:context/pages/home_task/home_task.dart';
import 'package:context/pages/inherit_pages/inherit_model_start.dart';
import 'package:context/pages/inherit_pages/inherit_notifier_start.dart';
import 'package:context/pages/inherit_pages/inherit_widget_vandad.dart';
import 'package:context/pages/inherit_pages/inherit_widjet_start.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeTask(),
    );
  }
}

