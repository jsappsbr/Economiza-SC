import 'dart:io';
import 'package:economiza_sc/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:economiza_sc/exceptions/http_exception.dart';

class AuthService {
  Future<User> login(String email, String password) async {
    try {
      final deviceName = await _getDeviceName();
      final api = Modular.get<Dio>();

      final response = await api.post('/sanctum/token', data: {
        'email': email,
        'password': password,
        'device_name': deviceName,
      });

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('api_token', response.data['token']);

      return fetchCurrentUser();
    } on DioException catch (e) {
      throw HttpException.fromDioException(e);
    }
  }

  Future<User> fetchCurrentUser() async {
    final api = Modular.get<Dio>();
    final response = await api.get('/user');
    return User.fromJson(response.data);
  }

  Future<void> logout() async {
    final api = Modular.get<Dio>();
    await api.delete('/sanctum/token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('api_token');
  }

  Future<String?> getApiToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('api_token');
  }

  Future<String> _getDeviceName() async {
    final deviceInfo = DeviceInfoPlugin();
    String deviceId = 'unknown';

    if (kIsWeb) {
      deviceId = 'web';
    } else if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor!;
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.id;
    }

    return deviceId;
  }
}
