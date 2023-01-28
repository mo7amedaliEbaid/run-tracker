import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/utils/sharedPrefs_utils.dart';
import '../../domain/repositories/user_repository.dart';
import '../api/user_api.dart';
import '../model/request/edit_password_request.dart';
import '../model/request/login_request.dart';
import '../model/request/send_new_password_request.dart';
import '../model/response/login_response.dart';

final userRepositoryProvider =
    Provider<UserRepository>((ref) => UserRepoImpl());

interface class UserRepoImpl extends UserRepository {
  UserRepoImpl();

  @override
  Future<int> register(LoginRequest request) async {
    return UserApi.createUser(request);
  }

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    LoginResponse response = await UserApi.login(request);
    await PrefsUtils.setJwt(response.token);
    await PrefsUtils.setRefreshToken(response.refreshedToken);
    return response;
  }

  @override
  Future<void> logout() async {
    await UserApi.logout();
    await PrefsUtils.removeJwt();
    await PrefsUtils.removeRefreshToken();
    return;
  }

  @override
  Future<void> deleteaccount() async {
    return UserApi.delete();
  }

  @override
  Future<void> sendNewPasswordByMail(SendNewPasswordRequest request) async {
    await UserApi.sendNewPasswordByMail(request);
  }

  @override
  Future<void> editPassword(EditPasswordRequest request) async {
    await UserApi.editPassword(request);
  }
}
