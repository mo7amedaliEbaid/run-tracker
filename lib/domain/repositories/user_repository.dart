import '../../data/model/request/edit_password_request.dart';
import '../../data/model/request/login_request.dart';
import '../../data/model/request/send_new_password_request.dart';
import '../../data/model/response/login_response.dart';

abstract class UserRepository {
  Future<int> register(LoginRequest request);

  Future<LoginResponse> login(LoginRequest request);
  
  Future<void> logout();

  Future<void> deleteaccount();

  Future<void> sendNewPasswordByMail(SendNewPasswordRequest request);

  Future<void> editPassword(EditPasswordRequest request);
}
