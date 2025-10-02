import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 80, horizontal: 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_buildIntroText()],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildIntroText() {
  return Column(
    children: [
      const Text(
        'Whit is your phone number ?',
        style: TextStyle(
          fontSize: 30    ,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 40),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        child: const Text(
          'please enter your phone number to verfiey your account ',
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    ],
  );
}
