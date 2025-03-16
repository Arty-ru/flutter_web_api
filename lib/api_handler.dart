import 'dart:convert';
import 'package:flutter_web_api/model.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String _baseUrl = 'https://localhost:7118/api/users';

  Future<List<User>> getUserData() async {
    List<User> users = [];
    final url = Uri.parse(_baseUrl);
    try{
      final response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode >= 200 && response.statusCode < 300){
        final List<dynamic> jsonData = json.decode(response.body);
        users = jsonData.map((json) => User.fromJson(json)).toList();
      }
    }
    catch(e){
      print(e);
      return users;
    }
    return users;
  }

  Future<http.Response> updateUser(int userId, User user) async {
    final url = Uri.parse('$_baseUrl/$userId');
    late http.Response response;

    try{
      response = await http.put(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user),
      );
    }
    catch(e){
      print(e);
      return response;
    }

    return response;
  } 

  Future<http.Response> addData({required User user}) async {
    final url = Uri.parse(_baseUrl);
    late http.Response response;

    try{
      response = await http.post(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(user),
      );
    }
    catch(e){
      print(e);
      return response;
    }

    return response;
  }
}