import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:guestbook/model/event.dart';
import 'package:guestbook/shared/dialog.dart';
import 'package:guestbook/shared/inputdata.dart';
import 'package:guestbook/shared/lookup.dart';
import 'package:guestbook/shared/session.dart';

class EventDetailPage extends StatefulWidget {
  final Session? session;
  final String? kodeEvent;

  EventDetailPage(this.session, {this.kodeEvent});

  @override
  _eventDetailState createState() => _eventDetailState();
}

class _eventDetailState extends State<EventDetailPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  List? _dataSet;

  void initState() {
    super.initState();
  }

  @override 
  Widget build(BuildContext contex){
    var width = MediaQuery.of(context).size.width / 100;
    var height = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      appBar: AppBar(
        title: _dataSet== null ? Text("Data Kelompok Tamu | ** Add **") : Text("Data Kelompok Tamu | ** Edit **"),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Text(
            "This is Event Name With H1",
            style: Theme.of(context).textTheme.headline1,
          )
        ],
      )
    );
  }
}
