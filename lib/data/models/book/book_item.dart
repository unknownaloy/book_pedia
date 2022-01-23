import 'package:book_pedia/data/models/book/book_volume_info.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_item.g.dart';

@JsonSerializable(explicitToJson: true)
class BookItem extends Equatable {
  final String id;

  @JsonKey(name: "volumeInfo")
  final BookVolumeInfo bookVolumeInfo;

  @JsonKey(defaultValue: false)
  final bool isFavorite;

  final int? timeStamp;

  const BookItem({
    required this.id,
    required this.bookVolumeInfo,
    required this.isFavorite,
    this.timeStamp,
  });

  @override
  List<Object> get props => [id, bookVolumeInfo];

  factory BookItem.fromJson(Map<String, dynamic> json) =>
      _$BookItemFromJson(json);
  Map<String, dynamic> toJson() => _$BookItemToJson(this);
}
