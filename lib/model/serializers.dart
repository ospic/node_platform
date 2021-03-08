import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:mobile/model/auth_post.dart';
import 'package:mobile/model/auth_response.dart';
import 'package:mobile/model/auth_role.dart';
import 'package:built_collection/built_collection.dart';
import 'package:mobile/model/privilege.dart';
import 'package:mobile/model/role.dart';
import 'package:mobile/model/user.dart';
import 'consultation.dart';
import 'built_post.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  BuiltPost,
  AuthPost,
  AuthResponse,
  AuthRole,
  Privilege,
  User,
  Role,
  Consultation,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
