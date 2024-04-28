
import 'package:activity2/screen/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Data Kontak',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
