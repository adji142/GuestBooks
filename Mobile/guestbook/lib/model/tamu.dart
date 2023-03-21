import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:guestbook/shared/session.dart';

class TamuModels {
  Session? sess;
  String? url;

  TamuModels(this.sess) {
    url = "${sess!.server}/mstr";
  }

  Future<Map> read(Map Parameter) async {
    try {
      // print(Parameter);
      // print(this.url);
      var url = Uri.parse('${this.url}/tamuread');
      final response = await http.post(url, body: Parameter);
      return json.decode(response.body);
    } catch (e) {
      var error = {};
      error[0] = e.toString();

      return error;
    }
  }

  Future<Map> crud(Map Parameter) async {
    try {
      var url = Uri.parse('${this.url}/tamucrud');
      final response = await http.post(url, body: Parameter);
      return json.decode(response.body);
    } catch (e) {
      var error = {};
      error[0] = e.toString();

      return error;
    }
  }

  Future<dynamic> generateQR(Map Parameter) async {
    try {
      var url = Uri.parse('${this.url}/generateqr');
      final response = await http.post(url, body: Parameter);
      return json.decode(response.body);
    } catch (e) {
      var error = {};
      error[0] = e.toString();

      return error;
    }
  }
}
