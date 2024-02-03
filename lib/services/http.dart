import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:uuid_type/uuid_type.dart';

const _defaultHeaders = {"Content-type": "application/json"};

// { "username": "cameron", "password": "mycoolpassword" }
// <username>cameron</username><password>mycoolpassword</password>

class HttpService {
  final _client = Client();

  Future<Uuid> login(String email, String password) async {
    final url = Uri.http("localhost:3001", "/login");
    final request = {"username": email, "password": password};
    final requestBody = json.encode(request);
    final response = await _client.post (
      url,
      body: requestBody,
      headers: _defaultHeaders,
    );

    final responseBody = json.decode(response.body);
    final uuid = responseBody["session_token"];
    return Uuid.parse(uuid);
  }

   Future<Uuid> createUser(String email, String password) async {
    final url = Uri.http("localhost:3001", "/create-user");
    final request = {"username": email, "password": password};
    final requestBody = json.encode(request);
    final response = await _client.post(
      url,
      body: requestBody,
      headers: _defaultHeaders,
    );

    final responseBody = json.decode(response.body);
    final uuid = responseBody["session_token"];
    return Uuid.parse(uuid);
  }
}

