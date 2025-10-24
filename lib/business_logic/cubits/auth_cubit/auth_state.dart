 abstract class PhoneAuthState{}
 class PhoneAuthInitial extends PhoneAuthState{}
 class Loading extends PhoneAuthState{}
 class ErroreOccurredd extends PhoneAuthState{
  final String error;

   ErroreOccurredd({required this.error});
 }
 class PhoneNumberSubmited extends PhoneAuthState{}
 class PhoneOtbVerified extends PhoneAuthState{}