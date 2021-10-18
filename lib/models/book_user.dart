import 'package:book_pedia/utilities/custom_methods.dart';
import 'package:equatable/equatable.dart';

class BookUser extends Equatable {
  final String? id;


  final String? email;

  const BookUser({
    required this.id,
    required this.email,
  });

  @override
  String toString() {
    return CustomMethods.removeAtSymbolFromEmail(email!);
  }

  @override
  List<Object?> get props => [id, email];
}
