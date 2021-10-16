// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_volume_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookVolumeInfo _$BookVolumeInfoFromJson(Map<String, dynamic> json) {
  return BookVolumeInfo(
    title: json['title'] as String,
    subTitle: json['subTitle'] as String,
    authors:
        (json['authors'] as List<dynamic>).map((e) => e as String).toList(),
    rating: (json['averageRating'] as num).toDouble(),
    ratingsCount: json['ratingsCount'] as int,
    description: json['description'] as String,
    pages: json['pageCount'] as int,
    categories:
        (json['categories'] as List<dynamic>).map((e) => e as String).toList(),
    bookImages: BookImages.fromJson(json['imageLinks'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BookVolumeInfoToJson(BookVolumeInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subTitle': instance.subTitle,
      'authors': instance.authors,
      'averageRating': instance.rating,
      'ratingsCount': instance.ratingsCount,
      'description': instance.description,
      'pageCount': instance.pages,
      'categories': instance.categories,
      'imageLinks': instance.bookImages.toJson(),
    };
