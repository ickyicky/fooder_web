import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html';


class ApiClient {
  final String baseUrl;
  String? token;
  String? refreshToken;
  http.Client httpClient = http.Client();

  ApiClient({
    required this.baseUrl,
  }) {
    if (window.localStorage.containsKey('token')) {
      token = window.localStorage['token'];
    }
    if (window.localStorage.containsKey('refreshToken')) {
      refreshToken = window.localStorage['refreshToken'];
    }
  }

  Map<String, String> headers() {
    if (token == null) {
      throw Exception('Not logged in');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Future<Map<String, dynamic>> get(String path) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl$path'),
      headers: headers(),
    );

    if (response.statusCode != 200) {
      throw Exception('Response returned status code: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl$path'),
      body: jsonEncode(body),
      headers: headers(),
    );

    if (response.statusCode != 200) {
      throw Exception('Response returned status code: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }


  Future<Map<String, dynamic>> delete(String path) async {
    final response = await httpClient.delete(
      Uri.parse('$baseUrl$path'),
      headers: headers(),
    );

    if (response.statusCode != 200) {
      throw Exception('Response returned status code: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> patch(String path, Map<String, dynamic> body) async {
    final response = await httpClient.patch(
      Uri.parse('$baseUrl$path'),
      body: jsonEncode(body),
      headers: headers(),
    );

    if (response.statusCode != 200) {
      throw Exception('Response returned status code: ${response.statusCode}');
    }

    return jsonDecode(response.body);
  }

  Future<void> login(String username, String password) async {
    final headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    };

    final response = await httpClient.post(
      Uri.parse('$baseUrl/token'),
      body: {
        'username': username,
        'password': password,
      },
      encoding: Encoding.getByName('utf-8'),
      headers: headers,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to login');
    }
    
    final token = jsonDecode(response.body)['access_token'];
    this.token = token;
    window.localStorage['token'] = token;

    final refreshToken = jsonDecode(response.body)['refresh_token'];
    this.refreshToken = refreshToken;
    window.localStorage['refreshToken'] = refreshToken;
  }

  Future<void> refresh() async {
    if (refreshToken == null) {
      throw Exception("No valid refresh token found");
    }

    final response = await post(
      "/token/refresh",
      {
        "refresh_token": refreshToken,
      }
    );

    token = response['access_token'] as String;
    window.localStorage['token'] = token!;
    refreshToken = response['refresh_token'] as String;
    window.localStorage['refreshToken'] = refreshToken!;
  }
}
