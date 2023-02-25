import 'package:flutter/material.dart';
import 'package:guestbook/shared/layoutdata.dart';
import 'package:guestbook/shared/session.dart';

class KelompokMasterPage extends StatefulWidget {
  final Session ? session;
  KelompokMasterPage(this.session);
  @override
  _KelompokMasterState createState() => _KelompokMasterState();
}

class _KelompokMasterState extends State<KelompokMasterPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kelompok Tamu"),
      ),
    );
  }
}