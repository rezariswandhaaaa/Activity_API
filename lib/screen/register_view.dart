import 'package:activity2/widget/form/form_kontak.dart';
import 'package:activity2/widget/header/header_kontak.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              HeaderKontak(),
              FormKontak()
            ],
          ),
        ),
      ),
    );
  }
}