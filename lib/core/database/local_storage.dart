import 'package:onbush/core/device_info/device_info.dart';
import 'package:onbush/core/hash/hash.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  late SharedPreferences? _prefs;

  // Constructeur principal pour initialiser les SharedPreferences
  LocalStorage({SharedPreferences? sharedPreferences}) {
    _prefs = sharedPreferences;
  }

  // Méthode pour récupérer ou initialiser les infos de l'appareil
  Future<void> _initializeDeviceInfo() async {
    final deviceInfo = await DeviceInfo.init().getInfoDevice("fingerprint");
    await setString('device', encryptToHex(deviceInfo));
  }

  // Méthode pour initialiser les préférences locales
  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    final device = getString('device');
    final avatar = getString('avatar');

    // Initialisation de l'information de l'appareil si nécessaire
    if (device == null || device.isEmpty || device == "null") {
      await _initializeDeviceInfo();
    }

    // Définir un avatar par défaut si nécessaire
    if (avatar == null || avatar.isEmpty || avatar == "null") {
      await setString('avatar', "assets/avatars/avatar 1.png");
    }
  }

  // Sauvegarder une chaîne de caractères
  Future<void> setString(String key, String value) async {
    await _prefs?.setString(key, value);
  }

  // Récupérer une chaîne de caractères
  String? getString(String key) {
    return _prefs?.getString(key);
  }

  // Sauvegarder un entier
  Future<bool> setInt(String key, int value) async {
    return await _prefs!.setInt(key, value);
  }

  // Récupérer un entier
  int? getInt(String key) {
    return _prefs?.getInt(key);
  }

  // Sauvegarder un booléen
  Future<bool> setBool(String key, bool value) async {
    return await _prefs!.setBool(key, value);
  }

  // Récupérer un booléen
  bool? getBool(String key) {
    return  _prefs?.getBool(key);
  }

  // Supprimer une donnée
  Future<bool?> remove(String key) async {
    return await _prefs?.remove(key);
  }

  // Sauvegarder une liste de chaînes de caractères
  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs!.setStringList(key, value);
  }

  // Récupérer une liste de chaînes de caractères
  List<String>? getStringList(String key) {
    return _prefs?.getStringList(key);
  }
}
