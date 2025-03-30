import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteConfigMethod {
  static final FirebaseRemoteConfigMethod _instance =
      FirebaseRemoteConfigMethod._internal();

  factory FirebaseRemoteConfigMethod() {
    return _instance;
  }

  FirebaseRemoteConfigMethod._internal();

  final remoteConfig = FirebaseRemoteConfig.instance;

  Future<String> fetchRemoteConfig() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 1),
      ),
    );
    await remoteConfig.fetchAndActivate();
    final ui = remoteConfig.getString('ServerDrivenUserInterface');
    return ui;
  }

  Future<Map<String, dynamic>> fetchScreenJson({
    required String screenId,
  }) async {
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(seconds: 1),
        ),
      );
      await remoteConfig.fetchAndActivate();
      String jsonString = remoteConfig.getString(screenId);
      if (jsonString.isEmpty) {
        throw Exception('No data found for the given screen ID: $screenId');
      }
      return json.decode(jsonString);
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to fetch remote config: $e');
    }
  }
}
