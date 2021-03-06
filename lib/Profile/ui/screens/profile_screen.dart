import 'package:flutter/material.dart';
import 'package:tenicos_nextline/Auth/ui/widgets/white_logo.dart';
import 'package:tenicos_nextline/Profile/bloc_profile.dart';
import 'package:tenicos_nextline/Profile/model/model_profile.dart';
import 'package:tenicos_nextline/Profile/ui/widgets/Background.dart';
import 'package:tenicos_nextline/utils/app_colors.dart';
import 'package:tenicos_nextline/utils/app_fonts.dart';
import 'package:tenicos_nextline/utils/exit_app.dart';
import 'package:tenicos_nextline/widgets/editable_input.dart';
import 'package:tenicos_nextline/widgets/jloading_screen.dart';
import 'package:tenicos_nextline/widgets/navigator_bar.dart';

class TechProfileScreen extends StatefulWidget {
  @override
  _TechProfileScreenState createState() => _TechProfileScreenState();
}

class _TechProfileScreenState extends State<TechProfileScreen> {
  BlocProfile blocProfile = BlocProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue_dark,
        centerTitle: true,
        title: Text(
          'PERFIL',
          style: TextStyle(fontFamily: AppFonts.input),
        ),
        automaticallyImplyLeading: false,
        actions: [ExitApp.exitFromAppButton(context)],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Background(),
          Container(
            child: FutureBuilder<TechProfile>(
                future: blocProfile.getTechProfile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return _formProfile(snapshot);
                  }
                  return JLoadingScreen();
                }),
          )
        ],
      ),
      bottomNavigationBar: NavigatorBar(index: 3),
    );
  }

  Widget _formProfile(snapshot) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        WhiteLogo(
          margin: EdgeInsets.only(bottom: 40, top: 20),
        ),
        EditableInput(
          placeholder: "Cédula",
          value: snapshot.data.ci,
          readOnly: true,
        ),
        EditableInput(
          placeholder: "Nombre",
          value: snapshot.data.nombre,
          readOnly: true,
        ),
        EditableInput(
          placeholder: "Apellido",
          value: snapshot.data.apellido,
          readOnly: true,
        ),
      ],
    );
  }
}
