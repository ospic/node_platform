import 'dart:io';
import 'package:chopper/chopper.dart';
import 'package:mobile/data/post_api_service.dart';
import 'package:mobile/model/bill_payload.dart';
import 'package:mobile/model/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/utils/utils.dart';
import 'package:mobile/widgets/index.dart';
import 'package:provider/provider.dart';
import 'package:built_collection/built_collection.dart';

class BillScreen extends StatelessWidget {
  final int billId;
  final String date;

  BillScreen(this.billId, this.date, );

  @override
  Widget build(BuildContext context) {
      return Scaffold(appBar: AppBar(
        elevation: 0.0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
            color: Constants.clr_blue
        ),
        title: Text(
          date == null ? "Bill No. $billId" : date,
          style: TextStyle(
              fontSize: 16.0,
              color:  Constants.clr_blue, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Constants.clr_light_blue,

      ),
          body: _buildBody(context, billId));
  }

  FutureBuilder<Response<BillPayload>> _buildBody(
      BuildContext context, int id) {
    return FutureBuilder<Response<BillPayload>>(
      future: Provider.of<PostApiService>(context).getBillById(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final BillPayload? posts = snapshot.data?.body;
          return _buildBillWidget(context, posts!);
        } else if(snapshot.hasError){
          return SomethingWrongHasHappened();
        }  else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView _buildBillWidget(BuildContext context, BillPayload bill) {
    final BuiltList<Transaction> transactions = bill.transactionResponse.transactions;
    return ListView(children: <Widget>[
      Padding(
        padding: EdgeInsets.all(2.0),
        child: Table(
          defaultColumnWidth: FlexColumnWidth(3),
          columnWidths: const <int, TableColumnWidth>{
            0: IntrinsicColumnWidth(),
            1: FlexColumnWidth()
          },
          border: TableBorder.all(
              color: gray1, style: BorderStyle.solid, width: 0.5),
          children: [
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('Created Date',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(bill.createdDate!)),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('Created by',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(bill.createdBy!)),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('Last updated',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(bill.lastUpdatedDate!)),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('Updated by',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(bill.lastUpdatedBy!)),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('For client',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(bill.patientName! +
                      '[ ' +
                      bill.patientId.toString() +
                      ' ]')),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('For consultation ',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(bill.consultationId.toString())),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('Total Amount',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(bill.totalAmount.toString())),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('Paid Amount',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(bill.paidAmount.toString())),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('Is active ?',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(
                    bill.isActive.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: bill.isActive! ? colorPrimary : Colors.red),
                  )),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('Is Paid ?',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(
                    bill.isPaid.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: bill.isPaid! ? colorPrimary : Colors.red),
                  )),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('Client addresses',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child:
                      Text('', style: TextStyle(fontWeight: FontWeight.bold))),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('Client address',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(bill.address!)),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('Client email',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(bill.emailAddress!)),
            ]),
            TableRow(children: [
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text('Client phone',
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(
                  padding: EdgeInsets.only(top: 5.0, bottom: 4.0, left: 5.0),
                  child: Text(bill.phoneNumber.toString())),
            ]),
          ],
        ),
      ),
      Container(
        color: Constants.clr_light_blue,
        margin: EdgeInsets.only(top: 10.0),
        child: Center(
          heightFactor: 3.0,
          child: Text(
            'Bill ${bill.id} Transactions',
            style: TextStyle(color: Constants.clr_blue, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      transactions.length > 0
          ? _buildBillTransactions(context, transactions.where((it) => !it.isReversed!).toBuiltList())
          : NothingFoundWarning()
    ]);
  }

  ListView _buildBillTransactions(
      BuildContext context, BuiltList<Transaction> transactions) {
    return ListView.builder(
      itemCount: transactions.length,
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.all(0.0),
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return TransactionWidget('bill_trxn_widget',
            transaction: transactions[index]);
      },
    );
  }

  _startAddNewTransaction(BuildContext context) {
    print('No object');
  }
}
