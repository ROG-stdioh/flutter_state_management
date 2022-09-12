// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_state_management/pages/home_page.dart';
import 'package:flutter_state_management/pages/new_contact_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

/// +--------------------------------------------------------------------------------------------------------------------------------+
/// | After creating the new_contact_view state, we have to define a "ROUTE" which is a map of strings and widget function. It is a  |
/// | function that takes a build context and returns a widget. So it's kind of like a MAO with keys as strings which is the name of |
/// | the route and its values are like a function.                                                                                  |
/// | => So here, we say ROUTE is a new map and we have a new route called new contact and in here, it has to return a WIDGET so,    |
/// |    we'll just mention our widget. Now, we'll go to the FloatingActionButton and add the routing there.                         |
/// +--------------------------------------------------------------------------------------------------------------------------------+

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/new-contact': (context) => const NewContactView(),
      },
    );
  }
}
