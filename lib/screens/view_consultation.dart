import 'package:chopper/chopper.dart';
import 'package:mobile/data/post_api_service.dart';
import 'package:mobile/model/index.dart';
import 'package:mobile/screens/index.dart';
import 'package:mobile/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

var selectedValue = 2;
var isLargeScreen = false;

class ScreenVieConsultation extends StatelessWidget {
  final int consultationId;
  ScreenVieConsultation(this.consultationId);

  Widget build(BuildContext context) {
    return OrientationBuilder(
        builder: (context, orientation) {
          if (MediaQuery
              .of(context)
              .size
              .width > 600) {
            isLargeScreen = true;
          } else {
            isLargeScreen = false;
          }
          return Container(
            padding: EdgeInsets.all(0.0),
            child:  Scaffold(
                resizeToAvoidBottomInset: false,
                appBar:  AppBar(
                  elevation: 0.0,
                  automaticallyImplyLeading: !isLargeScreen,
                  backgroundColor: isLargeScreen ? Colors.white : colorPrimary ,
                  title: Text('Consultation No. '+consultationId.toString(), style: TextStyle(fontFamily: 'Batmfa', color: Colors.black)),
                ),
                body: _buildBody(context, consultationId)
            ),
          );
        });

  }
}

FutureBuilder<Response<ConsultationPayload>> _buildBody(BuildContext context, int id) {
  return FutureBuilder<Response<ConsultationPayload>>(
    future: Provider.of<PostApiService>(context).getUserConsultationById(id),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final ConsultationPayload consultation = snapshot.data.body;
        return _buildConsultationWidget(context, consultation);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

SingleChildScrollView _buildConsultationWidget(BuildContext context, ConsultationPayload consultation){
  final Staff staff = consultation.staff;
  final String staffName = staff==null? 'Un-assigned': (staff.fullName == null ? staff.username : staff.fullName);
  return SingleChildScrollView(

    child: ConstrainedBox(
      constraints: BoxConstraints(),
      child: Column(
          children:[
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Table(
                defaultColumnWidth: FlexColumnWidth(3),

                border: TableBorder.all(
                    color: gray1, style: BorderStyle.solid, width:0.5 ),
                children: [

                  TableRow(children: [
                    Padding(
                        padding:
                        EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                        child: Text('From Date', style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding:
                        EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                        child: Text(consultation.fromdate)),
                  ]),
                  TableRow(children: [
                    Padding(
                        padding:
                        EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                        child: Text('To Date', style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding:
                        EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                        child: Text(consultation.todate)),
                  ]),
                  TableRow(children: [
                    Padding(
                        padding:
                        EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                        child: Text('Is active ?', style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding:
                        EdgeInsets.only(top: 5.0, bottom: 4.0,left: 5.0),
                        child:Text(consultation.isActive.toString(), style: TextStyle(fontWeight: FontWeight.bold, color: consultation.isActive? colorPrimary: Colors.red),)),
                  ]),
                  TableRow(children: [
                    Padding(
                        padding:
                        EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                        child: Text('Is Admitted ?', style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding:
                        EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                        child: Text(consultation.isAdmitted.toString(),style: TextStyle(fontWeight: FontWeight.bold, color: consultation.isAdmitted? colorPrimary: Colors.red),)),
                  ]),
                  TableRow(children: [
                    Padding(
                        padding:
                        EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                        child: Text('Consultant ', style: TextStyle(fontWeight: FontWeight.bold))),
                    Padding(
                        padding:
                        EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                        child: Text(staffName)),
                  ]),

                ],
              ),
            ),

            _tabSection(context, consultation.id)]),
    ),
  );
}

Widget _tabSection(BuildContext context, int consultationId) {
  double width = MediaQuery.of(context).size.width;
  double tabWidth = width  / 4;

  return DefaultTabController(
    length: 4,
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Container(
         child: Material(
           color: green1.withOpacity(0.9),
           child: TabBar(
               indicatorColor: textSecondaryDarkColor,
               isScrollable: true,
               tabs: [
                Container(width: tabWidth, child:  Tab(text: "Diagnoses"),),
                 Container(width: tabWidth, child:Tab(text: "Services & Costs"),),
                 Container(width: tabWidth, child:Tab(text: "Reports"),),
                 Container(width: tabWidth, child:Tab(text: "Admissions"))
               ]),
         ),
        ),
        Container(
          //Add this to give height
          height: MediaQuery
              .of(context)
              .size
              .height,
          child: TabBarView(children: [
            Container(
              child: DiagnosesTab(consultationId),
            ),
            Container(
              child: ServiceAndCostsTab(consultationId),
            ),
            Container(
              child: ReportsTab(consultationId),
            ),
            Container(
              child: AdmissionsTab(consultationId),
            ),

          ]),
        ),
      ],
    ),
  );
}