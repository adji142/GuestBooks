import 'package:flutter/material.dart';
import 'package:guestbook/shared/layoutdata.dart';
import 'package:guestbook/shared/session.dart';

class SeatMasterPage extends StatefulWidget {
  final Session ? session;
  SeatMasterPage(this.session);
  @override
  _SeatMasterState createState() => _SeatMasterState();
}

class _SeatMasterState extends State<SeatMasterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seat"),
      ),
    );
  }
}