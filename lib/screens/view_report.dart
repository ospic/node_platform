import 'package:chopper/chopper.dart';
import 'package:mobile/data/post_api_service.dart';
import 'package:mobile/model/index.dart';
import 'package:mobile/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewReportScreen extends StatelessWidget {
  final int reportId;
  ViewReportScreen(this.reportId);

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: green1.withOpacity(0.9),
          title: Text('Report ' + reportId.toString()),
        ),
        body: _buildBody(context, reportId));
  }
}

FutureBuilder<Response<Report>> _buildBody(BuildContext context, int id) {
  return FutureBuilder<Response<Report>>(
    future: Provider.of<PostApiService>(context).getConsultationReportById(id),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final Report consultation = snapshot.data.body;
        return _buildReportWidget(context, consultation);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

SingleChildScrollView _buildReportWidget(BuildContext context, Report report) {
  return SingleChildScrollView(
      child: ConstrainedBox(
    constraints: BoxConstraints(),
    child: Column(children: [
      Padding(
        padding: EdgeInsets.all(2.0),
        child: Center(heightFactor: 2.0, child: Text(report.name)),
      ),
report.type.startsWith('image/') ? Image.network(report.url): Center(child: Text("Not image"),)
    ]),
  ));
}
