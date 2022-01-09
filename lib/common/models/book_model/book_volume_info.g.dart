// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_volume_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookVolumeInfo _$BookVolumeInfoFromJson(Map<String, dynamic> json) =>
    BookVolumeInfo(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      authors:
          (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
      pages: json['pageCount'] as int?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      rating: (json['averageRating'] as num?)?.toDouble(),
      ratingsCount: json['ratingsCount'] as int?,
      bookImages: json['imageLinks'] == null
          ? null
          : BookImages.fromJson(json['imageLinks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookVolumeInfoToJson(BookVolumeInfo instance) =>
    <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'authors': instance.authors,
      'description': instance.description,
      'pageCount': instance.pages,
      'categories': instance.categories,
      'averageRating': instance.rating,
      'ratingsCount': instance.ratingsCount,
      'imageLinks': instance.bookImages?.toJson(),
    };
