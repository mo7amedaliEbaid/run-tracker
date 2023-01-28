import 'package:dio/dio.dart';

import '../../core/utils/sharedPrefs_utils.dart';
import '../model/request/edit_password_request.dart';
import '../model/request/login_request.dart';
import '../model/request/send_new_password_request.dart';
import '../model/response/login_response.dart';
import 'helpers/api_helper.dart';

interface class UserApi {

  static Future<int> createUser(LoginRequest request) async {
    Response? response = await ApiHelper.makeRequest(
        '${ApiHelper.BASEURL}user/register', 'POST',
        data: request.toMap());
    return response?.data;
  }


  static Future<LoginResponse> login(LoginRequest request) async {
    Response? response = await ApiHelper.makeRequest(
        '${ApiHelper.BASEURL}user/login', 'POST',
        data: request.toMap());

    return LoginResponse.fromMap(response?.data);
  }

  static Future<void> logout() async {
    await ApiHelper.makeRequest(
        '${ApiHelper.BASEURL}private/user/logout', 'POST');
  }

  static Future<void> delete() async {
    await ApiHelper.makeRequest('${ApiHelper.BASEURL}private/user', 'DELETE');
  }


  static Future<String?> refreshToken() async {
    String? refreshToken = await PrefsUtils.getRefreshToken();

    Response? response = await ApiHelper.makeRequest(
        '${ApiHelper.BASEURL}user/refreshToken', 'POST',
        data: {'token': refreshToken});

    String? jwt = response?.data['token'];
    await PrefsUtils.setJwt(response?.data['token']);

    return jwt;
  }


  static Future<String> sendNewPasswordByMail(
      SendNewPasswordRequest request) async {
    Response? response = await ApiHelper.makeRequest(
        '${ApiHelper.BASEURL}user/sendNewPasswordByMail', 'POST',
        queryParams: request.toMap());

    return response?.data;
  }


  static Future<void> editPassword(EditPasswordRequest request) async {
    await ApiHelper.makeRequest(
        '${ApiHelper.BASEURL}private/user/editPassword', 'PUT',
        data: request.toMap());
  }
}
