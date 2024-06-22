import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/repositories/user_repository_impl.dart';
import '../../../main.dart';
import 'settings_state.dart';

final settingsViewModelProvider =
    StateNotifierProvider.autoDispose<SettingsViewModel, SettingsState>(
  (ref) => SettingsViewModel(ref),
);

class SettingsViewModel extends StateNotifier<SettingsState> {
  Ref ref;


  SettingsViewModel(this.ref) : super(SettingsState.initial());

  Future<void> logoutUser() async {
    try {
      state = state.copyWith(isLoading: true);
      await ref.read(userRepositoryProvider).logout();
      await clearStorage();
      navigatorKey.currentState?.pushReplacementNamed("/login");
    } catch (error) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> deleteUserAccount() async {
    try {
      state = state.copyWith(isLoading: true);
      await ref.read(userRepositoryProvider).deleteaccount();
      await clearStorage();
      navigatorKey.currentState?.pushReplacementNamed("/login");
    } catch (error) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> clearStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
