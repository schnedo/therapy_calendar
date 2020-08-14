import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'batch.g.dart';

abstract class Batch implements Built<Batch, BatchBuilder> {
  factory Batch([void Function(BatchBuilder) updates]) = _$Batch;

  Batch._();

  int get number;

  static Serializer<Batch> get serializer => _$batchSerializer;
}
