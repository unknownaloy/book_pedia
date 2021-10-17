import 'package:book_pedia/models/book_model/book_item.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'books.g.dart';

@JsonSerializable(explicitToJson: true)
class Books extends Equatable {
  @JsonKey(name: "items")
  final List<BookItem> bookItem;

  const Books({required this.bookItem});

  @override
  List<Object> get props => [bookItem];

  factory Books.fromJson(Map<String, dynamic> json) => _$BooksFromJson(json);
  Map<String, dynamic> toJson() => _$BooksToJson(this);
}
