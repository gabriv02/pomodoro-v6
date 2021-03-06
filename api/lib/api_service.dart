// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'info.dart';

class ApiService {
  final String url =
      'https://pomodoroapp20211114235511.azurewebsites.net/api/People';

  // GET FUNCTION
  Future<List<Info>> getInfo() async {
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print('EXITO: ' + jsonResponse['entries'][0]['API']);

      return (jsonResponse['entries'] as List)
          .map((e) => Info.fromJSON(e))
          .toList();
    }
    throw Exception('Error al llamar al API');
  }

  Future<Info> getInfoId(int id) async {
    var response = await http.get(Uri.parse(url + '/$id'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      //print('EXITO: ' + jsonResponse['entries'][0]['API']);

      return Info.fromJSON(jsonDecode(response.body));
    }
    throw Exception('Error al llamar al API');
  }
}
