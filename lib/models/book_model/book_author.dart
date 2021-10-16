import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_author.g.dart';

@JsonSerializable()
class BookAuthor extends Equatable {
  final String authorName;


  const BookAuthor({required this.authorName});


  @override
  List<Object> get props => [authorName];


  factory BookAuthor.fromJson(Map<String, dynamic> json) =>
      _$BookAuthorFromJson(json);
  Map<String, dynamic> toJson() => _$BookAuthorToJson(this);
}