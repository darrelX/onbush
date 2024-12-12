import 'dart:convert';

import 'package:crypto/crypto.dart';

String encryptToHex(String input) {
  final date = DateTime.now().toString();
  // Générer un hash SHA256 du texte d'entrée

  final bytes = utf8.encode(input + date);
  final hash = sha256.convert(bytes).toString();

  // Retourner les 30 premiers caractères du hash hexadécimal
  return hash.substring(0, 50).trim();
}
