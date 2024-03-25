import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:fooder/models/meal.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ApiClient {
  final String baseUrl;
  String? token;
  String? refreshToken;
  http.Client httpClient = http.Client();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  ApiClient({
    required this.baseUrl,
  }) {
    () async {
      await loadToken();
    }();
  }

  Future<void> loadToken() async {
    Map<String, String> allValues = await storage.readAll();

    if (allValues.containsKey('token')) {
      token = allValues['token'];
    }
    if (allValues.containsKey('refreshToken')) {
      refreshToken = allValues['refreshToken'];
    }
  }

  Map<String, String> headers({bool forGet = false, bool forLogin = false}) {
    if (token == null && !forLogin) {
      throw Exception('Not logged in');
    }

    final headers = {
      'Accept': 'application/json',
    };

    if (!forGet) {
      headers['Content-Type'] = 'application/json';
    }

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  Map<String, dynamic> _jsonDecode(http.Response response) {
    try {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } catch (e) {
      throw Exception('Response returned status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> get(String path) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl$path'),
      headers: headers(forGet: true),
    );

    if (response.statusCode == 401) {
      await refresh();
      return await get(path);
    }

    if (response.statusCode != 200) {
      throw Exception('Response returned status code: ${response.statusCode}');
    }

    return _jsonDecode(response);
  }

  Future<Map<String, dynamic>> post(String path, Map<String, dynamic> body,
      {bool forLogin = false}) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl$path'),
      body: jsonEncode(body),
      headers: headers(forLogin: forLogin),
    );

    if (response.statusCode == 401) {
      await refresh();
      return await post(path, body, forLogin: forLogin);
    }

    if (response.statusCode != 200) {
      throw Exception('Response returned status code: ${response.statusCode}');
    }

    return _jsonDecode(response);
  }

  Future<void> postNoResult(String path, Map<String, dynamic> body,
      {bool forLogin = false, bool empty = false}) async {
    final response = await httpClient.post(
      Uri.parse('$baseUrl$path'),
      body: jsonEncode(body),
      headers: headers(forLogin: forLogin),
    );

    if (response.statusCode == 401) {
      await refresh();
      return await postNoResult(path, body, forLogin: forLogin);
    }

    if (response.statusCode != 200) {
      throw Exception('Response returned status code: ${response.statusCode}');
    }
  }

  Future<void> delete(String path) async {
    final response = await httpClient.delete(
      Uri.parse('$baseUrl$path'),
      headers: headers(),
    );

    if (response.statusCode == 401) {
      await refresh();
      return await delete(path);
    }

    if (response.statusCode != 200) {
      throw Exception('Response returned status code: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> patch(
      String path, Map<String, dynamic> body) async {
    final response = await httpClient.patch(
      Uri.parse('$baseUrl$path'),
      body: jsonEncode(body),
      headers: headers(),
    );

    if (response.statusCode == 401) {
      await refresh();
      return await patch(path, body);
    }

    if (response.statusCode != 200) {
      throw Exception('Response returned status code: ${response.statusCode}');
    }

    return _jsonDecode(response);
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

    final token = _jsonDecode(response)['access_token'];
    this.token = token;
    await storage.write(key: 'token', value: token);

    final refreshToken = _jsonDecode(response)['refresh_token'];
    this.refreshToken = refreshToken;
    await storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<void> refresh() async {
    if (refreshToken == null) {
      throw Exception("No valid refresh token found");
    }

    final response = await post("/token/refresh", {
      "refresh_token": refreshToken,
    });

    token = response['access_token'] as String;
    await storage.write(key: 'token', value: token);

    refreshToken = response['refresh_token'] as String;
    await storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<Map<String, dynamic>> getDiary({required DateTime date}) async {
    var formatter = DateFormat('yyyy-MM-dd');
    var params = {
      "date": formatter.format(date),
    };
    var response = await get("/diary?${Uri(queryParameters: params).query}");
    return response;
  }

  Future<void> logout() async {
    token = null;
    refreshToken = null;

    await storage.deleteAll();
  }

  Future<Map<String, dynamic>> getProducts(String q) async {
    var response =
        await get("/product?${Uri(queryParameters: {"q": q}).query}");
    return response;
  }

  Future<Map<String, dynamic>> getPresets(String? q) async {
    var response = await get("/preset?${Uri(queryParameters: {"q": q}).query}");
    return response;
  }

  Future<void> addEntry({
    required double grams,
    required int productId,
    required int mealId,
  }) async {
    var entry = {
      "grams": grams,
      "product_id": productId,
      "meal_id": mealId,
    };
    await post("/entry", entry);
  }

  Future<void> deleteEntry(int id) async {
    await delete("/entry/$id");
  }

  Future<void> deleteMeal(int id) async {
    await delete("/meal/$id");
  }

  Future<void> deletePreset(int id) async {
    await delete("/preset/$id");
  }

  Future<void> updateEntry(
    int id, {
    required double grams,
    required int productId,
    required int mealId,
  }) async {
    var entry = {
      "grams": grams,
      "product_id": productId,
      "meal_id": mealId,
    };
    await patch("/entry/$id", entry);
  }

  Future<void> register(String username, String password) async {
    try {
      await post(
        "/user",
        {
          "username": username,
          "password": password,
        },
        forLogin: true,
      );
    } catch (e) {
      throw Exception("Failed to register");
    }
  }

  Future<void> addMeal(
      {required String name, required int diaryId}) async {
    await post("/meal", {
      "name": name,
      "diary_id": diaryId,
    });
  }

  Future<void> addMealFromPreset(
      {required String name, required int diaryId, required int presetId}) async {
    await post("/meal/from_preset", {
      "name": name,
      "diary_id": diaryId,
      "preset_id": presetId,
    });
  }

  Future<Map<String, dynamic>> addProduct({
    required String name,
    required double protein,
    required double carb,
    required double fat,
    required double fiber,
  }) async {
    var response = await post("/product", {
      "name": name,
      "protein": protein,
      "carb": carb,
      "fat": fat,
      "fiber": fiber,
    });
    return response;
  }

  Future<void> saveMeal(Meal meal, String name) async {
    await postNoResult("/meal/${meal.id}/save", {
      "name": name,
    });
  }
}
