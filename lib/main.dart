
import 'package:activity2/screen/register_screen.dart';
import 'package:activity2/widget/form/form_kontak.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Kontak',
      debugShowCheckedModeBanner: false,
      home: RegisterScreen(),
    );
  }
}
