import 'package:easy_map/core/routing/app_routs.dart';
import 'package:easy_map/presentation/screens/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/cubits/auth_cubit/auth_cubit.dart';

import '../../presentation/screens/auth_screen.dart';
import '../../presentation/screens/map_screen.dart';

class AppRouter {
  static final AuthCubit authCubit = AuthCubit();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouts.auth:
        return MaterialPageRoute(
          builder: (_) =>
              BlocProvider.value(value: authCubit, child: AuthScreen()),
        );
      case AppRouts.otp:
        final phoneNumper = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: authCubit,
            child: OtpScreen(phoneNumper: phoneNumper),
          ),
        );
      case AppRouts.mapScreen:
        return MaterialPageRoute(builder: (_) => MapScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('404 Not Found'))),
        );
    }
  }
}
