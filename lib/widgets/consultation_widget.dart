import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile/model/consultation.dart';
import 'package:mobile/screens/view_consultation.dart';
import 'package:flutter/material.dart';

class ConsultationWidget extends StatefulWidget {
  final Consultation cs;

  const ConsultationWidget(
    String s, {
    Key key,
    @required this.cs,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConsultationWidgetWidgetState();
}

class _ConsultationWidgetWidgetState extends State<ConsultationWidget> {
  String _value = '';

  void _setValue(String value) => setState(() => _value = value);

  @override
  Widget build(BuildContext context) {
    final String consultant = widget.cs.staffName==null? '': 'Consultant name '+widget.cs.staffName;
    return  GestureDetector(
     child: Card(
      shadowColor: Colors.brown,
       elevation: 1.0,
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(5.0),
       ),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child:  Container(
              height: 72,
              color: Color(0xffffffff),
              child: Row(
                  children: [
                Container(
                    color: Color(0x0),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: widget.cs.isAdmitted ?  Colors.red[700]: Colors.green[100],
                      child: widget.cs.isAdmitted ? Icon(MdiIcons.bed, color: Colors.white,): Text(
                        widget.cs.id.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold, color: widget.cs.isActive ? Colors.white : Colors.green),
                      ),
                    )),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.cs.fromDate,
                          style: TextStyle(fontSize: 16, color: Color(0xff000000))),
                      Text(widget.cs.patientName,
                          style: TextStyle(fontSize: 14, color: Color(0xff000000)))
                    ]),

              ])),
        ),

    ),
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ScreenVieConsultation(widget.cs.id))),);
  }
}
