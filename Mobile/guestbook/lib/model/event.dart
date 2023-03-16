import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:guestbook/shared/session.dart';

class EventModels {
  Session? sess;
  String? url;

  EventModels(this.sess){
    url="https://${sess!.server}/mstr";
  }

  Future<Map> read(Map Parameter) async{
    try {
      print(Parameter);
      // print(this.url);
      var url = Uri.parse('${this.url}/eventread');
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
      var url = Uri.parse('${this.url}/eventcrud');
      final response = await http.post(url, body: Parameter);
      return json.decode(response.body);
    } catch (e) {
      var error = {};
      error[0] = e.toString();

      return error;
    }
  }
}
