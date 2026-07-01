import 'dart:convert';

import 'package:book_library_mangement/models/book_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  final String baseUrl = "https://library-management-api-i6if.onrender.com";

  Future<BookModel> fetchingBooks() async {
    final response = await http.get(Uri.parse("$baseUrl/api/books"));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return BookModel.fromJson(result);
    } else {
      throw Exception("Fechting Failed");
    }
  }

  Future<void> addBook({
    required String title,
    required String author,
    required String category,
    required int publishedYear,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/api/books"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          Books(
            title: title,
            author: author,
            category: category,
            publishedYear: publishedYear,
          ).toJson(),
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        throw Exception("Failed to add Book:${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error adding book:$e");
    }
  }

  Future<void> userRegester({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/api/users/register"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );
      final result = jsonDecode(response.body);
      print("Status Code: ${response.statusCode}"); // ← Add kiya
      print("Response Body: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        return result;
      } else
        throw Exception("Error: ${response.statusCode}");
    } catch (e) {
      throw Exception("Error Generate:$e");
    }
  }

  Future<void> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/api/users/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      final result = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return result;
      } else {
        throw Exception(result["message"] ?? "Login Failed");
      }
    } catch (e) {
      throw Exception("Error:$e");
    }
  }
}
