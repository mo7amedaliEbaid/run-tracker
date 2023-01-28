import 'package:equatable/equatable.dart';

interface class SendNewPasswordRequest extends Equatable {
  final String email;

  const SendNewPasswordRequest({required this.email});

  @override
  List<Object?> get props => [email];

  Map<String, dynamic> toMap() {
    return {'email': email};
  }

  @override
  bool get stringify => true;
}
