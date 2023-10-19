import 'dart:io';
import 'package:anotei/models/user.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  Future<User> login(String email, String password) async {
    final deviceName = await _getDeviceName();
    final api = Modular.get<Dio>();

    var response = await api.post('/sanctum/token', data: {
      'email': email,
      'password': password,
      'device_name': deviceName,
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('api_token', response.data['token']);

    response = await api.get('/user');
    return User.fromJson(response.data);
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
