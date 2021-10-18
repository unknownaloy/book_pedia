// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Books _$BooksFromJson(Map<String, dynamic> json) {
  return Books(
    totalItems: json['totalItems'] as int,
    bookItem: (json['items'] as List<dynamic>?)
        ?.map((e) => BookItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$BooksToJson(Books instance) => <String, dynamic>{
      'totalItems': instance.totalItems,
      'items': instance.bookItem?.map((e) => e.toJson()).toList(),
    };
