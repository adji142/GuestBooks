import 'package:flutter/material.dart';
import 'package:guestbook/shared/layoutdata.dart';
import 'package:guestbook/shared/session.dart';

class TamuMasterPage extends StatefulWidget {
  final Session ? session;
  TamuMasterPage(this.session);
  @override
  _TamuMasterState createState() => _TamuMasterState();
}

class _TamuMasterState extends State<TamuMasterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tamu"),
      ),
    );
  }
}