import 'package:onbush/shared/device_info/device_info.dart';
import 'package:onbush/shared/hash/hash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage? _instance;
  SharedPreferences? _prefs;

  LocalStorage._internal();

  factory LocalStorage() {
    _instance ??= LocalStorage._internal();
    return _instance!;
  }

  Future<void> _deviceInfo() async {
    setString('device',
        encryptToHex(await DeviceInfo.init().getInfoDevice("fingerprint")));
  }

  // Méthode pour initialiser SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await  _deviceInfo();
  }

  // Méthodes pour différents types de données

  // Sauvegarder une chaîne de caractères
  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Récupérer une chaîne de caractères
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Sauvegarder un entier
  Future<void> setInt(String key, int value) async {
    await _prefs?.setInt(key, value);
  }

  // Récupérer un entier
  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  // Sauvegarder un booléen
  Future<void> setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  // Récupérer un booléen
  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  Future<bool?> remove(String key) async {
    return await _prefs?.remove(key);
  }
}
