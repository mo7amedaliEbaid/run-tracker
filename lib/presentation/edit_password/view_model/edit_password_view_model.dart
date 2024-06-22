import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/request/edit_password_request.dart';
import '../../../data/repositories/user_repository_impl.dart';
import '../../../main.dart';
import 'edit_password_state.dart';

final editPasswordViewModelProvider =
    StateNotifierProvider.autoDispose<EditPasswordViewModel, EditPasswordState>(
  (ref) => EditPasswordViewModel(ref),
);

interface class EditPasswordViewModel extends StateNotifier<EditPasswordState> {
  Ref ref;

  EditPasswordViewModel(this.ref) : super(EditPasswordState.initial());

  void setCurrentPassword(String? currentPassword) {
    state = state.copyWith(currentPassword: currentPassword);
  }

  void setPassword(String? password) {
    state = state.copyWith(password: password);
  }

  void setCheckPassword(String? checkPassword) {
    state = state.copyWith(checkPassword: checkPassword);
  }

  Future<void> submitForm(
      BuildContext context, GlobalKey<FormState> formKey) async {
    state = state.copyWith(errorOnRequest: false);
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      state = state.copyWith(isEditing: true);

      final userRepository = ref.read(userRepositoryProvider);
      final editPasswordRequest = EditPasswordRequest(
        currentPassword: state.currentPassword,
        password: state.password,
      );

      try {
        await userRepository.editPassword(editPasswordRequest);
        navigatorKey.currentState?.pop();
      } catch (e) {
        state = state.copyWith(errorOnRequest: true);
      } finally {
        state = state.copyWith(isEditing: false);
      }
    }
  }
}
