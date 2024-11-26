import 'dart:convert';
import 'package:http/http.dart' as http;

void registerUser() async {
  final url = Uri.parse(
      'https://api.accounts.onbush237.com/v1/connexion/samsung/b0qxxx/b0q:9/TP1A.220624.014/S908EXXS2BWA2:user/release-keys');
  final headers = {
    'accept': 'application/json',
    'Content-Type': 'application/json',
  };
  final body = jsonEncode({
    // "appareil": "samsung/b0qxxx/b0q:9/TP1A.220624.014/S908EXXS2BWA2:user/release-keys",
    // "matricule": "20G00140",
    // "nom": "d",
    // "sexe": "male",
    // "naissance": "03/11/2024",
    // "email": "darre@gmail.com",
    // "telephone": "657590803",
    // "niveau": 1,
    // "filiere_id": 1,
    // "etablissement_id": 1,
    // "code_parrain": 0,
    // "role": "etudiant"
  });

  try {
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('User registered successfully: ${response.body}');
    } else {
      print('Failed to register user: ${response.statusCode}');
      print('Response: ${response.body}');
    }
  } catch (e) {
    print('Error occurred: $e');
  }
}

void main() {
  registerUser();
}
