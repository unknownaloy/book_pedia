// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookItem _$BookItemFromJson(Map<String, dynamic> json) {
  return BookItem(
    id: json['id'] as String,
    bookVolumeInfo:
        BookVolumeInfo.fromJson(json['bookVolumeInfo'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookItemToJson(BookItem instance) => <String, dynamic>{
      'id': instance.id,
      'bookVolumeInfo': instance.bookVolumeInfo.toJson(),
    };
