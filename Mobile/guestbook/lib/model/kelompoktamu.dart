import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:guestbook/shared/session.dart';

class KelompokTamuModels{
  Session ? sess;
  String ? url;

  KelompokTamuModels(this.sess) {
    url="https://${sess!.server}/mstr";
  }

  Future<Map> read(Map Parameter) async{
    try {
      // print(Parameter);
      // print(this.url);
      var url = Uri.parse('${this.url}/kelompoktamuread');
      final response = await http.post(url, body: Parameter);
      return json.decode(response.body);
    } catch (e) {
      var error = {};
      error[0] = e.toString();

      return error;
    }
  }

  Future<Map> crud(Map Parameter) async{
    try {
      var url = Uri.parse('${this.url}/kelompoktamucrud');
      final response = await http.post(url, body: Parameter);
      return json.decode(response.body);
    } catch (e) {
      var error = {};
      error[0] = e.toString();

      return error;
    }
  }

  Future<Map> getLookup(Map Parameter) async {
      var url = Uri.parse('${this.url}/kelompoktamulookup');
      final response = await http.post(url, body: Parameter);
      // List temp = response.body["data"].toList();
      return json.decode(response.body);
  }
}