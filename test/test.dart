// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// // Singleton pour gérer différents types de données locales
// class LocalStorage {
//   static LocalStorage? _instance;
//   static SharedPreferences? _prefs;

//   LocalStorage._internal();

//   factory LocalStorage() {
//     _instance ??= LocalStorage._internal();
//     return _instance!;
//   }

//   // Méthode pour initialiser SharedPreferences
//    Future<void> init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }

//   // Méthodes pour différents types de données

//   // Sauvegarder une chaîne de caractères
//   static Future<void> setString(String key, String value) async {
//     await _prefs?.setString(key, value);
//   }

//   // Récupérer une chaîne de caractères
//   static String? getString(String key) {
//     return _prefs?.getString(key);
//   }

//   // Sauvegarder un entier
//   static Future<void> setInt(String key, int value) async {
//     await _prefs?.setInt(key, value);
//   }

//   // Récupérer un entier
//   static int? getInt(String key) {
//     return _prefs?.getInt(key);
//   }

//   // Sauvegarder un booléen
//   static Future<void> setBool(String key, bool value) async {
//     await _prefs?.setBool(key, value);
//   }

//   // Récupérer un booléen
//   static bool? getBool(String key) {
//     return _prefs?.getBool(key);
//   }
// }

// Future<void> main() async {
//   var a = LocalStorage();
  
//   await LocalStorage.init();
//   LocalStorage.setBool('1', true);
//   LocalStorage.getBool('1');
// }
