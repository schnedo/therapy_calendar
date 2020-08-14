import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'batch_number.g.dart';

abstract class BatchNumber implements Built<BatchNumber, BatchNumberBuilder> {
  factory BatchNumber([void Function(BatchNumberBuilder) updates]) =
      _$BatchNumber;
  BatchNumber._();

  int get number;

  @override
  String toString() => 'Ch.-B. $number';

  static Serializer<BatchNumber> get serializer => _$batchNumberSerializer;
}
