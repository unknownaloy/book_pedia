import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_images.g.dart';

@JsonSerializable()
class BookImages extends Equatable {
  final String? smallThumbnail;

  @JsonKey(name: "thumbnail")
  final String? mainThumbnail;

  const BookImages({this.smallThumbnail, this.mainThumbnail});

  @override
  List<Object?> get props => [smallThumbnail, mainThumbnail];

  factory BookImages.fromJson(Map<String, dynamic> json) =>
      _$BookImagesFromJson(json);
  Map<String, dynamic> toJson() => _$BookImagesToJson(this);
}
