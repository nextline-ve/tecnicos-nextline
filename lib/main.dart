import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:tenicos_nextline/splash_screen.dart';

import 'Auth/bloc/bloc_auth.dart';
import 'Auth/ui/screens/login_screen.dart';
import 'Technician/Assignment/ui/screens/assignments_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/technician-home': (context) => AssignmentsScreen()
        },
      ),
      bloc: BlocAuth(),
    );
  }
}
