import 'package:easy_map/core/my_colors/my_colors.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? phoneNumper;
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
              children: [
                _buildIntroText(),
                SizedBox(height: 30),
                _buildPhoneFormFeild(),
                SizedBox(height: 50),
                _buildNextButton(),
              ],
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
          fontSize: 30,
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

Widget _buildPhoneFormFeild() {
  return Row(
    children: [
      Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.lightBlue),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Text(
            '${generatCountryFlag()}+20',
            style: TextStyle(fontSize: 16, letterSpacing: 2),
          ),
        ),
      ),
      SizedBox(width: 4),
      Expanded(
        flex: 3,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(color: MyColors.blue),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: TextFormField(
            onSaved: (value) {
              var phoneNumper = value;
            },
            autofocus: true,
            style: TextStyle(fontSize: 16, letterSpacing: 2),
            decoration: InputDecoration(border: InputBorder.none),
            cursorColor: Colors.black,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value!.isEmpty) {
                return 'please enter your phone number';
              } else if (value.length < 11) {
                return 'enter a valid number';
              }
              return null;
            },
          ),
        ),
      ),
    ],
  );
}

String generatCountryFlag() {
  String countryCode = 'eg';
  return countryCode.toUpperCase().replaceAllMapped(
    RegExp(r'[A-Z]'),
    (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
  );
}

Widget _buildNextButton() {
  return Align(
    alignment: Alignment.centerRight,
    child: ElevatedButton(
      onPressed: () {},
      child: Text('Next', style: TextStyle(color: Colors.white, fontSize: 15)),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(130, 50),
        backgroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        maximumSize: Size(150, 100),
      ),
    ),
  );
}
