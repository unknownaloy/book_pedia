import 'package:book_pedia/data/models/book/book_item.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'books.g.dart';

@JsonSerializable(explicitToJson: true)
class Books extends Equatable {
  final int totalItems;

  @JsonKey(name: "items")
  final List<BookItem>? bookItem;

  const Books({required this.totalItems, this.bookItem});

  @override
  List<Object?> get props => [totalItems, bookItem];

  factory Books.fromJson(Map<String, dynamic> json) => _$BooksFromJson(json);
  Map<String, dynamic> toJson() => _$BooksToJson(this);
}