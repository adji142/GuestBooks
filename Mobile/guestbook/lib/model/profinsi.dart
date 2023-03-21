import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:guestbook/shared/session.dart';

class Profinsi{
  Session ? sess;
  String ? url;

  Profinsi(this.sess) {
    url="${sess!.server}/dem";
  }

  Future<List> getLookup({String search=""}) async {
    Map param(){
      return {
        'Kriteria' : search
      };
    }
    var url = Uri.parse('${this.url}/readprofinsi');
    final response = await http.post(url, body: param());
    return json.decode(response.body);
  }

}