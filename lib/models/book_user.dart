import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'book_user.g.dart';

@JsonSerializable()
class BookUser extends Equatable {
  final String? id;


  final String? email;

  const BookUser({
    required this.id,
    required this.email,
  });

  @override
  List<Object?> get props => [id, email];

  factory BookUser.fromJson(Map<String, dynamic> json) =>
      _$BookUserFromJson(json);
  Map<String, dynamic> toJson() => _$BookUserToJson(this);
}
