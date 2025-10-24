import 'package:easy_map/business_logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:easy_map/business_logic/cubits/auth_cubit/auth_state.dart';
import 'package:easy_map/core/my_colors/my_colors.dart';
import 'package:easy_map/core/routing/app_routs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScreen extends StatelessWidget {
  AuthScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey();
  String? phoneNumber;

  Widget _buildPoneNumperSubmitedBloc() {
    return BlocListener<AuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndecator(context);
        }
        if (state is PhoneNumberSubmited) {
          Navigator.pop(context); // يقفل اللودنج
          Navigator.of(context)
              .pushNamed(AppRouts.otp, arguments: phoneNumber);
        }
        if (state is ErroreOccurredd) {
          Navigator.pop(context); // يقفل اللودنج
          String errorMsg = state.error;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(errorMsg)));
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) {
            return; // لو فيه خطأ متفتحش لودنج
          } else {
            _formKey.currentState!.save(); // يحفظ الرقم
            BlocProvider.of<AuthCubit>(context)
                .submitPhoneNumber(phoneNumber!); // يبدأ عملية التحقق
          }
        },
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(130, 50),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          maximumSize: const Size(150, 100),
        ),
        child: const Text(
          'Next',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIntroText(),
                  const SizedBox(height: 30),
                  _buildPhoneFormFeild(),
                  const SizedBox(height: 50),
                  _buildNextButton(context),
                  _buildPoneNumperSubmitedBloc(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIntroText() {
    return Column(
      children: [
        const Text(
          'What is your phone number ?',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 40),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          child: const Text(
            'Please enter your phone number to verify your account',
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
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.lightBlue),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: Text(
              '${generatCountryFlag()}+20',
              style: const TextStyle(fontSize: 16, letterSpacing: 2),
            ),
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          flex: 3,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.blue),
              borderRadius: const BorderRadius.all(Radius.circular(6)),
            ),
            child: TextFormField(
              onSaved: (value) {
                phoneNumber = value; // ✅ كده بيتخزن صح
              },
              autofocus: true,
              style: const TextStyle(fontSize: 16, letterSpacing: 2),
              decoration: const InputDecoration(border: InputBorder.none),
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
}

String generatCountryFlag() {
  String countryCode = 'eg';
  return countryCode.toUpperCase().replaceAllMapped(
    RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
  );
}

void showProgressIndecator(BuildContext context) {
  AlertDialog alertDialog = const AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
      ),
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => alertDialog,
  );
}
