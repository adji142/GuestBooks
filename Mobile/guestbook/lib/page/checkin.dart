import 'dart:async';
import 'package:flutter/material.dart';
import 'package:guestbook/model/bukutamu.dart';
import 'package:guestbook/model/tamu.dart';
import 'package:guestbook/shared/dialog.dart';
import 'package:guestbook/shared/session.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class CheckinPage extends StatefulWidget {
  final Session? session;
  final String? KodeEvent;
  CheckinPage(this.session, {this.KodeEvent});
  @override
  _CheckinPageState createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  int _short = 0;
  bool _searchMode = true;
  Icon _appIcon = Icon(
    Icons.search,
    size: 32.0,
  );
  TextEditingController _searchText = TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  String _scannedBarcode = "";

  Future<String> scanQR() async {
    String result;

    try {
      result = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
    } catch (e) {
      result = "Fail Scan";
    }

    _scannedBarcode = result == "Fail Scan" ? "" : result;

    if (!mounted) return result;

    return result;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 100;
    var height = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      appBar: AppBar(title: _searchWidget(), actions: <Widget>[
        IconButton(
          icon: _appIcon,
          onPressed: () {
            _searchMode = _searchMode ? false : true;
            _searchText.text = "";
            setState(() => _appIcon =
                _searchMode ? Icon(Icons.search) : Icon(Icons.close));
          },
        ),
      ]),
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: width * 10,
            bottom: height * 2,
            child: FloatingActionButton(
              heroTag: "hero1",
              child: Icon(Icons.qr_code),
              onPressed: () async {
                String? result = await scanQR();
                String? _kodeTamu = "";

                _kodeTamu = result.characters.toString();

                Map Parameter() {
                  return {
                    "KodeTamu": _kodeTamu,
                    "RecordOwnerID": this.widget.session!.RecordOwnerID.toString(),
                    "Kriteria": "",
                    "EventID": widget.KodeEvent.toString()
                  };
                }

                showLoadingDialog(context, _keyLoader, info: "Processing");

                var tempTamu = new TamuModels(this.widget.session)
                    .read(Parameter())
                    .then((value) => {
                          if (value["data"].length > 0)
                            {
                              _checkinProcedure(
                                  context: context,
                                  kodeTamu: _kodeTamu.toString(),
                                  jumlahTamu: int.parse(value["data"][0]
                                          ["JumlahUndangan"]
                                      .toString()),
                                  alamat: value["data"][0]["AlamatTamu"].toString(),
                                  rowID: value["data"][0]["RowID"],
                                  tamuHadir: int.parse(
                                      value["data"][0]["TamuHadir"].toString()),
                                      namaTamu: value["data"][0]["NamaTamu"])
                            }
                          else
                            {
                              Navigator.of(context, rootNavigator: false).pop(),
                              messageBox(
                                  context: context,
                                  title: "Error",
                                  message: "Data Tidak ditmukan")
                            }
                        });

                // await Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventInputPage(this.widget.session,kodeEvent: "",) ))
              })
          ),
          Positioned(
            right: width * 10,
            bottom: height * 2,
            child: FloatingActionButton(
              heroTag: "hero2",
              backgroundColor: Colors.red,
              child: Icon(Icons.add),
              onPressed:(){} ,
            )
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   color: Theme.of(context).primaryColor,
      //   child: ListTile(
      //     dense: true,
      //     title: Text("This is title use wisely",
      //         style: TextStyle(color: Colors.white)),
      //   ),
      // ),
      body: Column(
        children: [_loadData()],
      ),
    );
  }

  Widget _searchWidget() {
    if (_searchMode) {
      return Text("Checkin");
    } else {
      return (Container(
          color: Theme.of(context).primaryColorLight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
                controller: _searchText,
                autofocus: true,
                decoration: InputDecoration.collapsed(hintText: "Cari Data"),
                textInputAction: TextInputAction.search,
                onChanged: (value) => setState(() {})),
          )));
    }
  }

  Widget _loadData() {
    Map Parameter() {
      return {
        'KodeTamu': '',
        'RecordOwnerID': this.widget.session!.RecordOwnerID,
        'EventID': this.widget.KodeEvent.toString(),
        'Kriteria': ''
      };
    }

    return Expanded(
        child: RefreshIndicator(
      onRefresh: _refreshData,
      child: FutureBuilder(
          future: TamuModels(this.widget.session).read(Parameter()),
          builder: (context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!["data"].length == 0
                      ? 0
                      : snapshot.data!["data"].length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          leading: CircleAvatar(
                            child: snapshot.data!["data"][index]["RowID"] == 0
                                ? Text((index + 1).toString())
                                : Icon(Icons.check),
                            backgroundColor:
                                snapshot.data!["data"][index]["RowID"] == 0
                                    ? Theme.of(context).primaryColor
                                    : Colors.green,
                            foregroundColor: Colors.white,
                          ),
                          title: Text(
                            snapshot.data!["data"][index]["NamaTamu"],
                            style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          subtitle: Column(
                            children: [
                              Padding(padding: EdgeInsets.only(top: 5)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kelompok : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(snapshot.data!["data"][index]
                                      ["NamaKelompok"])
                                ],
                              ),
                              Padding(padding: EdgeInsets.only(top: 5)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Alamat : ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              Text(
                                snapshot.data!["data"][index]["AlamatTamu"],
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              _popupMenuItem("Check In",
                                  snapshot.data!["data"][index]["KodeTamu"]),
                              _popupMenuItem("Masukan Angpao",
                                  snapshot.data!["data"][index]["KodeTamu"])
                            ],
                            onSelected: (value) {
                              _checkinProcedure(
                                  context: context,
                                  kodeTamu: value,
                                  alamat: snapshot.data!["data"][index]
                                      ["AlamatTamu"],
                                  jumlahTamu: snapshot.data!["data"][index]
                                      ["JumlahUndangan"],
                                  rowID: snapshot.data!["data"][index]["RowID"],
                                  tamuHadir: int.parse(snapshot.data!["data"]
                                          [index]["TamuHadir"]
                                      .toString()),
                                  namaTamu: snapshot.data!["data"][index]["NamaTamu"]);
                            },
                            icon: Icon(Icons.more_vert),
                          )),
                    );
                  });
            } else {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(),
                        )
                      ],
                    )
                  ],
                ),
              );
            }
          }),
    ));
  }

  PopupMenuItem _popupMenuItem(String title, String value) {
    return PopupMenuItem(
      value: value,
      child: Text(title),
    );
  }

  Future _checkinProcedure(
      {required BuildContext context,
      String kodeTamu = "",
      int jumlahTamu = 0,
      String alamat = "",
      int rowID = 0,
      int tamuHadir = 0,
      String namaTamu = "",
      bool isManual = false}) async {
    // print("masuk checkuin");
    if (_scannedBarcode != "") {
      _scannedBarcode = "";
      Navigator.of(context, rootNavigator: false).pop();
    }
    // Navigator.of(context, rootNavigator: false).pop();

    TextEditingController _JumlahTamu = TextEditingController();
    TextEditingController _alamat = TextEditingController();
    TextEditingController _namaTamu = TextEditingController();

    _JumlahTamu.text = tamuHadir == 0 ? jumlahTamu.toString() : "0";
    _alamat.text = alamat;
    _namaTamu.text = namaTamu;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(5),
          contentPadding: EdgeInsets.fromLTRB(1, 15, 1, 15),
          title: Container(
              width: double.infinity,
              height: 30,
              color: Theme.of(context).primaryColorDark,
              child: Center(
                  child: Text(
                "Proses Checkin ",
                style: TextStyle(color: Colors.white),
              ))),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    readOnly: !isManual,
                    controller: _namaTamu,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Nama Tamu",
                      labelStyle: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    autofocus: true,
                    controller: _JumlahTamu,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Jumlah Tamu",
                      labelStyle: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextField(
                    autofocus: true,
                    controller: _alamat,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.go,
                    keyboardType: TextInputType.text,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: "Alamat",
                      labelStyle: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Proses'),
              onPressed: () async {
                showLoadingDialog(context, _keyLoader, info: "Processing");

                var oSave = new BukuTamuModels(this.widget.session);
                Map oParam() {
                  return {
                    "formmode": rowID == 0 ? "add" : "edit",
                    "RowID": rowID.toString(),
                    "KodeTamu": kodeTamu.toString(),
                    "JumlahUndangan": rowID == 0
                        ? _JumlahTamu.text.toString()
                        : (int.parse(_JumlahTamu.text) + tamuHadir).toString(),
                    "AlamatTamu": _alamat.text.toString(),
                    "EventID": widget.KodeEvent.toString(),
                    "RecordOwnerID": this.widget.session!.RecordOwnerID
                  };
                }

                oSave.crud(oParam()).then((value) async {
                  // print(oParam());
                  if (value["success"].toString() == "true") {
                    Navigator.of(context, rootNavigator: false).pop();
                    Navigator.of(context).pop();
                  } else {
                    // print(value);
                    Navigator.of(context, rootNavigator: false).pop();
                    await messageBox(
                        context: context,
                        title: "Error",
                        message: "Error : " +
                            value["nError"].toString() +
                            " / " +
                            value["sError"]);
                  }
                });
                // Navigator.of(context).pop(true);
              },
            ),
            ElevatedButton(
              child: Text('Batal'),
              onPressed: () {
                // Navigator.of(context).pop();
                Navigator.of(context).pop(false);
                // Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future _refreshData() async {
    setState(() {});

    Completer<Null> completer = Completer<Null>();
    Future.delayed(Duration(seconds: 1)).then((_) {
      completer.complete();
    });
    return completer.future;
  }
}
