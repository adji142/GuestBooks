import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:guestbook/shared/session.dart';

class BukuTamuModels {
  Session? sess;
  String? url;

  BukuTamuModels(this.sess) {
    url = "https://${sess!.server}/trx";
  }

  Future<Map> crud(Map Parameter) async {
    try {
      var url = Uri.parse('${this.url}/bukutamu');
      final response = await http.post(url, body: Parameter);
      print(json.decode(response.body));
      return json.decode(response.body);
    } catch (e) {
      var error = {};
      error[0] = e.toString();

      return error;
    }
  }

  Future<Map> getNumber(Map Parameter) async {
    try {
      // print(Parameter);
      // print(this.url);
      var url = Uri.parse('${this.url}/getnumber');
      final response = await http.post(url, body: Parameter);

      return json.decode(response.body);
    } catch (e) {
      var error = {};
      error[0] = e.toString();

      return error;
    }
  }
}
