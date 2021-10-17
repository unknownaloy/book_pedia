import 'package:book_pedia/models/book_model/book_volume_info.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_item.g.dart';

@JsonSerializable(explicitToJson: true)
class BookItem extends Equatable {
  final String id;

  @JsonKey(name: "volumeInfo")
  final BookVolumeInfo bookVolumeInfo;

  const BookItem({
    required this.id,
    required this.bookVolumeInfo,
  });

  @override
  List<Object> get props => [id, bookVolumeInfo];

  factory BookItem.fromJson(Map<String, dynamic> json) =>
      _$BookItemFromJson(json);
  Map<String, dynamic> toJson() => _$BookItemToJson(this);
}
