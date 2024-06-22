import 'package:dio/dio.dart';

import '../model/request/activity_request.dart';
import '../model/response/activity_response.dart';
import 'helpers/api_helper.dart';

interface class ActivityApi {
  static String URL = '${ApiHelper.BASEURL}private/activity/';


  static Future<List<ActivityResponse>> getrecentActivities() async {
    Response? response =
        await ApiHelper.makeRequest('${ActivityApi.URL}all', 'GET');
    final data = List<Map<String, dynamic>>.from(response?.data);
    return data.map((e) => ActivityResponse.fromMap(e)).toList();
  }


  static Future<ActivityResponse> getrecentActivityById(String id) async {
    Response? response =
        await ApiHelper.makeRequest('${ActivityApi.URL}$id', 'GET');
    return ActivityResponse.fromMap(response?.data);
  }


  static Future<String?> removeActivity(String id) async {
    Response? response = await ApiHelper.makeRequest(ActivityApi.URL, 'DELETE',
        queryParams: {'id': int.parse(id)});
    return response?.data?.toString();
  }


  static Future<ActivityResponse?> addActivity(ActivityRequest request) async {
    Response? response = await ApiHelper.makeRequest(ActivityApi.URL, 'POST',
        data: request.toMap());
    return response != null ? ActivityResponse.fromMap(response.data) : null;
  }


  static Future<ActivityResponse> editActivity(ActivityRequest request) async {
    Response? response = await ApiHelper.makeRequest(ActivityApi.URL, 'PUT',
        data: request.toMap());
    return ActivityResponse.fromMap(response?.data);
  }
}
