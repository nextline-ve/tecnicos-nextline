import 'package:flutter/material.dart';
import 'package:tenicos_nextline/Auth/bloc/bloc_auth.dart';
import 'package:tenicos_nextline/Auth/ui/widgets/form_login.dart';
import 'package:tenicos_nextline/Auth/ui/widgets/white_logo.dart';
import 'package:tenicos_nextline/utils/app_colors.dart';
import 'package:tenicos_nextline/widgets/background.dart';
import 'package:tenicos_nextline/widgets/jbutton.dart';
import 'package:tenicos_nextline/widgets/line.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  BlocAuth blocAuth;

  @override
  Widget build(BuildContext context) {
    return loginUI();
  }

  Widget loginUI() {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Background(
            pathImage: "assets/images/fondo_login.png",
          ),
          ListView(
            children: [
              WhiteLogo(),
              FormLogin(),
              Line(
                width: 100,
              ),
            ],
          )
        ],
      ),
    );
  }

}
