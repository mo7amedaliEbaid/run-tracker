interface class EditPasswordState {
  final String currentPassword;
  final String password;
  final String checkPassword;
  final bool isEditing;
  final bool errorOnRequest;

  const EditPasswordState(
      {required this.currentPassword,
      required this.password,
      required this.checkPassword,
      required this.isEditing,
      required this.errorOnRequest});

  factory EditPasswordState.initial() {
    return const EditPasswordState(
        currentPassword: '',
        password: '',
        checkPassword: '',
        isEditing: false,
        errorOnRequest: false);
  }

  EditPasswordState copyWith(
      {String? currentPassword,
      String? password,
      String? checkPassword,
      bool? isEditing,
      bool? errorOnRequest}) {
    return EditPasswordState(
        currentPassword: currentPassword ?? this.currentPassword,
        password: password ?? this.password,
        checkPassword: checkPassword ?? this.checkPassword,
        isEditing: isEditing ?? this.isEditing,
        errorOnRequest: errorOnRequest ?? this.errorOnRequest);
  }
}
