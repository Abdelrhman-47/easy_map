import 'package:easy_map/core/routing/app_routs.dart';
import 'package:flutter/material.dart';

import '../../presentation/screens/auth_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouts.auth:
        return MaterialPageRoute(builder: (_) => AuthScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text('404 Not Found'))),
        );
    }
  }
}
