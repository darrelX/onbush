import 'dart:convert';

import 'package:crypto/crypto.dart';

String encryptToHex(String input) {
  // Générer un hash SHA256 du texte d'entrée
  final bytes = utf8.encode(input);
  final hash = sha256.convert(bytes).toString();

  // Retourner les 30 premiers caractères du hash hexadécimal
  return hash.substring(0, 40);
}
