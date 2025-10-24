import 'package:easy_map/business_logic/cubits/auth_cubit/auth_cubit.dart';
import 'package:easy_map/business_logic/cubits/auth_cubit/auth_state.dart';
import 'package:easy_map/core/my_colors/my_colors.dart';
import 'package:easy_map/core/routing/app_routs.dart';
import 'package:easy_map/presentation/screens/wigets/pin_code.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.phoneNumper});

  final String phoneNumper;
  static String otpCode = ""; // 👈 هنخزن الكود هنا

  Widget _buildNextButton({required void Function() navigator}) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: navigator,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(130, 50),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          maximumSize: const Size(150, 100),
        ),
        child: const Text(
          'verify',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AuthCubit, PhoneAuthState>(
        listener: (context, state) {
          if (state is PhoneOtbVerified) {
         Navigator.pushReplacementNamed(context, AppRouts.mapScreen);
          }
          if (state is ErroreOccurredd) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 45),
            child: Column(
              children: [
                _buildIntroText(phoneNumper),
                const SizedBox(height: 50),

                // PinCode
                PinCode(
                  onCompleted: (String code) {
                    otpCode = code; // 👈 خزّنا الكود
                  },
                ),

                const SizedBox(height: 20),

                // زرار Verify
                _buildNextButton(
                  navigator: () {
                    context.read<AuthCubit>().submitOTP(otpCode);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


Widget _buildIntroText(String phoneNum) {
  return Column(
    children: [
      const Text(
        'verify your phone number',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      const SizedBox(height: 40),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 3),
        child: RichText(
          text: TextSpan(
            text: 'Enter your 6 digits code numbers sent to ',
            style: TextStyle(color: Colors.black, fontSize: 18, height: 1.9),
            children: <TextSpan>[
              TextSpan(
                text: '$phoneNum',
                style: TextStyle(color: MyColors.blue),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
