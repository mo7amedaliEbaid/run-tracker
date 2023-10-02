interface class SendNewPasswordState {
  final String email;

  final bool isSending;

  const SendNewPasswordState({
    required this.email,
    required this.isSending,
  });

  factory SendNewPasswordState.initial() {
    return const SendNewPasswordState(
      email: '',
      isSending: false,
    );
  }

  SendNewPasswordState copyWith({
    String? email,
    bool? isSending,
  }) {
    return SendNewPasswordState(
      email: email ?? this.email,
      isSending: isSending ?? this.isSending,
    );
  }
}
