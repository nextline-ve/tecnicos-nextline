import 'package:flutter/material.dart';
import 'package:tenicos_nextline/Technician/Assignment/ui/screens/assignment_details_screen.dart';
import 'package:tenicos_nextline/Tickets/bloc/bloc_tickets.dart';
import 'package:tenicos_nextline/Tickets/model/model_ticket.dart';
import 'package:tenicos_nextline/Tickets/ui/widgets/ticket_row.dart';
import 'package:tenicos_nextline/utils/app_colors.dart';
import 'package:tenicos_nextline/utils/app_fonts.dart';
import 'package:tenicos_nextline/utils/exit_app.dart';
import 'package:tenicos_nextline/widgets/jloading_screen.dart';
import 'package:tenicos_nextline/widgets/navigator_bar.dart';

class AssignmentsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AssignmentsScreen();
  }
}

class _AssignmentsScreen extends State<AssignmentsScreen> {
  BlocTickets blocTickets = BlocTickets();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.blue_dark,
        centerTitle: true,
        title: Text(
          'ASIGNACIONES TÉCNICAS',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: AppFonts.input, fontSize: 16),
        ),
        automaticallyImplyLeading: false,
        actions: [ExitApp.exitFromAppButton(context)],
      ),
      body: Stack(
        children: [
          FutureBuilder(
              future: blocTickets.getAssignedTickets(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData && snapshot.data.length > 0)
                    return ListView(
                      scrollDirection: Axis.vertical,
                      children: snapshot.data
                          .map<Widget>((Ticket ticket) => TicketRow(
                              ticket: ticket,
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AssignmentDetailsScreen(
                                            ticket: ticket,
                                            blocTickets: blocTickets,
                                          )))))
                          .toList(),
                    );
                  return Center(
                    child: Text(
                      "Usted no tiene tickets asignados",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: AppColors.blue_dark,
                          fontSize: 16,
                          fontFamily: AppFonts.poppins_bold),
                    ),
                  );
                }
                return JLoadingScreen();
              }),
        ],
      ),
      bottomNavigationBar: NavigatorBar(),
    );
  }
}
