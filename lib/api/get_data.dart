import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intelligence_tank_management_system/models/Tank.dart';

Future<Tank> fetchTank(StreamController stream) async {
  final response = await http.get(
      Uri.parse('https://testing-api-laravel.herokuapp.com/api/getSingle'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Tank data = Tank.fromJson(jsonDecode(response.body));
    if (!stream.isClosed) {
      stream.sink.add(data);
    }
    return Tank.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
