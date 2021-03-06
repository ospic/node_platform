import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'visit.g.dart';
abstract class Visit implements Built<Visit, VisitBuilder>{
  int get id;
  String ? get symptoms;
  @BuiltValueField(wireName: 'dateTime')
  String ? get date;

  Visit._();
  factory Visit([updates(VisitBuilder b)]) = _$Visit;
  static Serializer<Visit> get serializer => _$visitSerializer;
}