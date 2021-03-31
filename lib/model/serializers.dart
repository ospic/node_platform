import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:mobile/model/auth_post.dart';
import 'package:mobile/model/auth_response.dart';
import 'package:mobile/model/auth_role.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mobile/model/bill.dart';
import 'package:mobile/model/bill_payload.dart';
import 'package:mobile/model/contacts_information.dart';
import 'package:mobile/model/privilege.dart';
import 'package:mobile/model/role.dart';
import 'package:mobile/model/transaction.dart';
import 'package:mobile/model/user.dart';
import 'transaction_response.dart';
import 'consultation.dart';
import 'patient.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Patient, AuthPost, AuthResponse, AuthRole,
  Privilege, User, Transaction,TransactionResponse,
  Role, Consultation, ContactsInformation, Bill, BillPayload
])
final Serializers serializers = (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
