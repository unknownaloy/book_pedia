import 'package:book_pedia/models/book_model/book_images.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_volume_info.g.dart';

@JsonSerializable(explicitToJson: true)
class BookVolumeInfo extends Equatable {
  final String title;

  final String? subtitle;

  final List<String>? authors;

  final String? description;

  @JsonKey(name: "pageCount")
  final int? pages;

  final List<String> categories;

  @JsonKey(name: "averageRating")
  final double? rating;

  final int? ratingsCount;

  @JsonKey(name: "imageLinks")
  final BookImages bookImages;

  const BookVolumeInfo({
    required this.title,
    this.subtitle,
    this.authors,
    this.description,
    this.pages,
    required this.categories,
    this.rating,
    this.ratingsCount,
    required this.bookImages,
  });

  @override
  List<Object?> get props => [
        title,
        subtitle,
        authors,
        rating,
        ratingsCount,
        description,
        pages,
        categories,
        bookImages,
      ];

  factory BookVolumeInfo.fromJson(Map<String, dynamic> json) =>
      _$BookVolumeInfoFromJson(json);
  Map<String, dynamic> toJson() => _$BookVolumeInfoToJson(this);
}
