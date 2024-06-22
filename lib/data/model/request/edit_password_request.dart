import 'package:equatable/equatable.dart';

interface class EditPasswordRequest extends Equatable {
  final String currentPassword;
  final String password;

  const EditPasswordRequest({
    required this.currentPassword,
    required this.password,
  });

  @override
  List<Object?> get props => [currentPassword, password];

  Map<String, dynamic> toMap() {
    return {
      'currentPassword': currentPassword,
      'password': password,
    };
  }

  @override
  bool get stringify => true;
}
