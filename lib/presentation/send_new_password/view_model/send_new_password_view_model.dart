import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model/request/send_new_password_request.dart';
import '../../../data/repositories/user_repository_impl.dart';
import '../../../main.dart';
import 'send_new_password_state.dart';

final sendNewPasswordViewModelProvider = StateNotifierProvider.autoDispose<
    SendNewPasswordViewModel, SendNewPasswordState>(
  (ref) => SendNewPasswordViewModel(ref),
);

interface class SendNewPasswordViewModel extends StateNotifier<SendNewPasswordState> {
  final Ref ref;

  SendNewPasswordViewModel(this.ref) : super(SendNewPasswordState.initial());

  void setEmail(String? email) {
    state = state.copyWith(email: email ?? '');
  }

  Future<void> submitForm(
      BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      state = state.copyWith(isSending: true);

      final userRepository = ref.read(userRepositoryProvider);
      final sendNewPasswordRequest = SendNewPasswordRequest(email: state.email);

      try {
        await userRepository.sendNewPasswordByMail(sendNewPasswordRequest);

        state = state.copyWith(isSending: false);

        navigatorKey.currentState?.pop();
      } catch (error) {
        state = state.copyWith(isSending: false);
        navigatorKey.currentState?.pop();
      }
    }
  }
}
