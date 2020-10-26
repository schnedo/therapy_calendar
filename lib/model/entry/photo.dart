import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'photo.g.dart';

abstract class Photo implements Built<Photo, PhotoBuilder> {
  factory Photo([void Function(PhotoBuilder) updates]) = _$Photo;
  Photo._();

  String get path;
  String get description;

  static Serializer<Photo> get serializer => _$photoSerializer;
}
