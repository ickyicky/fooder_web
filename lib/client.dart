import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html';


class ApiClient {
  final String baseUrl;
  String? token = null;
  String? refreshToken = null;
  http.Client httpClient = http.Client();

  ApiClient({
    required this.baseUrl,
  }) {
    if (window.localStorage.containsKey('token')) {
      this.token = window.localStorage['token'];
    }
    if (window.localStorage.containsKey('refreshToken')) {
      this.refreshToken = window.localStorage['refreshToken'];
    }
  }

  Map<String, String> headers() {
    if (this.token == null) {
      throw Exception('Not logged in');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (this.token != null) {
      headers['Authorization'] = 'Bearer ${this.token}';
    }

    return headers;
  }

  Future<Map<String, dynamic>> get(String path) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl$path'),
      headers: this.headers(),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl$path'),
      body: jsonEncode(body),
      headers: this.headers(),
    );
    return jsonDecode(response.body);
  }


  Future<Map<String, dynamic>> delete(String path) async {
    final response = await httpClient.delete(
      Uri.parse('$baseUrl$path'),
      headers: this.headers(),
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> patch(String path, Map<String, dynamic> body) async {
    final response = await httpClient.patch(
      Uri.parse('$baseUrl$path'),
      body: jsonEncode(body),
      headers: this.headers(),
    );
    return jsonDecode(response.body);
  }

  void login(String username, String password) async {
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
}
