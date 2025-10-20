import 'package:flutter/material.dart';
import 'package:muslim/page/home/home_screen.dart';
import 'package:muslim/page/home/sura_details.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muslim',
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routNAme,
      routes: {
        HomeScreen.routNAme:(context)=> HomeScreen(),
        SuraDetails.routeName:(context)=> SuraDetails(),
      },
    );
  }
}
