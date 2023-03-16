import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:guestbook/shared/session.dart';

class AuthModels{
  Session ? sess;
  String ? url;

  AuthModels(this.sess) {
    url="https://${sess!.server}/auth";
  }

  Future<Map> login(Map Parameter) async{
    try {
      print(Parameter);
      // print(this.url);
      var url = Uri.parse('${this.url}/login');
      final response = await http.post(url, body: Parameter);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (e) {
      var error = {};
      error[0] = e.toString();

      return error;
    }
  }

}