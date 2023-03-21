import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:guestbook/model/event.dart';
import 'package:guestbook/model/tamu.dart';
import 'package:guestbook/page/checkin.dart';
import 'package:guestbook/page/master/event_input_page.dart';
import 'package:guestbook/page/master/kelompoktamu_page.dart';
import 'package:guestbook/page/master/seat_page.dart';
import 'package:guestbook/page/master/tamu_page.dart';
import 'package:guestbook/shared/dialog.dart';
import 'package:guestbook/shared/session.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailPage extends StatefulWidget {
  final Session? session;
  final int? kodeEvent;

  EventDetailPage(this.session, {this.kodeEvent});

  @override
  _eventDetailState createState() => _eventDetailState();
}

class _eventDetailState extends State<EventDetailPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  int? _KodeEvent = 0;
  String? _NamaEvent = "";
  String? _deskripsiEvent = "";
  int? _estimasiUndangan = 0;
  DateTime _tglEvent = DateTime.now();
  TimeOfDay _JamEvnet = TimeOfDay.now();
  String? _lokasiEvent = "";
  int? _jumlahUndanganAktual = 0;
  int? _jumlahUndanganDatang = 0;

  DateTime _fullDate = DateTime.now();
  int _intDate = 0;

  List? _dataSet;

  bool _eventStarted = false;

  // Download
  String FileUrl = "";
  bool downloading = false;
  var progress = "";

  Future<Map> _getData(String KodeEvent) async {
    Map Parameter() {
      return {
        "KodeEvent": KodeEvent,
        "RecordOwnerID": this.widget.session!.RecordOwnerID.toString(),
        "Kriteria": ""
      };
    }

    var temp = await EventModels(this.widget.session).read(Parameter());
    return temp;
  }

  _fetchData(String KodeEvent) async {
    var temp = await _getData(KodeEvent);
    _dataSet = temp["data"].toList();

    _KodeEvent = _dataSet![0]["KodeEvent"];
    _NamaEvent = _dataSet![0]["NamaEvent"];
    _deskripsiEvent = _dataSet![0]["DeskripsiEvent"];
    // _estimasiUndangan = _dataSet![0]["EstimasiUndangan"];
    _estimasiUndangan = 0;
    _tglEvent = DateTime.parse(_dataSet![0]["TglEvent"]);
    _JamEvnet = TimeOfDay(
        hour: int.parse(
            _dataSet![0]["JamEvent"].toString().split(":")[0].toString()),
        minute: int.parse(
            _dataSet![0]["JamEvent"].toString().split(":")[1].toString()));
    _fullDate = DateTime(_tglEvent.year, _tglEvent.month, _tglEvent.day,
        _JamEvnet.hour, _JamEvnet.minute);
    _intDate = _fullDate.millisecondsSinceEpoch;
    _lokasiEvent = _dataSet![0]["LokasiEvent"];
    _jumlahUndanganAktual = _dataSet![0]["JumlahTamu"];
    _jumlahUndanganDatang = _dataSet![0]["JumlahTamuDatang"];

    DateTime nowDate = DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day);

    _eventStarted = _tglEvent.microsecondsSinceEpoch <= nowDate.microsecondsSinceEpoch;
    setState(() => {});
  }

  Future<String> get _localPath async {
    final directory = await getTemporaryDirectory();

    return directory.path;
  }

  Future downloadFile2(Dio dio, String url, String savePath) async {
    print(url);
    try {
      Response response = await dio.get(
        url,
        onReceiveProgress: showDownloadProgress,
        //Received data with List<int>
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      print(response.headers);
      File file = File(savePath);
      print(file);
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      downloading = false;
    } catch (e) {
      print(e);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      setState(() {
        downloading = true;
        progress = (received / total * 100).toStringAsFixed(0) + "%";
      });
      print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }

  void initState() {
    _fetchData(this.widget.kodeEvent.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext contex) {
    var width = MediaQuery.of(context).size.width / 100;
    var height = MediaQuery.of(context).size.height / 100;

    var d = 123;
    var h = 23;
    var m = 59;
    var s = 40;

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Event"),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async{
              bool _konfirmasiSimpam =  await messageDialog(
                  context: context,
                  title: "Konfirmasi",
                  message: "Delete Data ini ?"
              );

              if(_konfirmasiSimpam){
                showLoadingDialog(context, _keyLoader,info: "Processing");

                var oSave = new EventModels(this.widget.session);
                Map oParam(){
                  return {
                    "formmode"      : "delete",
                    "KodeEvent"      : widget.kodeEvent.toString(),
                    "RecordOwnerID" : this.widget.session!.RecordOwnerID
                  };
                }

                oSave.crud(oParam()).then((value) async{
                  if(value["success"].toString() == "true"){
                    Navigator.of(context,rootNavigator: false).pop();
                    await messageBox(context: context,title: "Informasi",message: "Data Berhasil Dihapus");
                    Navigator.of(context).pop();
                  }
                  else{
                    Navigator.of(context,rootNavigator: false).pop();
                    await messageBox(context: context,title: "Error",message: "Error : " + value["nError"].toString() + " / " + value["sError"]);
                  }
                  
                });
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            Text(
              _NamaEvent!,
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              _deskripsiEvent!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Wrap(
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.edit),
                  label: Text("Edit"),
                  onPressed: _eventStarted
                      ? null
                      : () async {
                          var x = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (context) => EventInputPage(
                                        this.widget.session,
                                        kodeEvent: _KodeEvent.toString(),
                                      )))
                              .then((value) {
                            setState(() {});
                          });
                        },
                ),
                Container(
                  width: width * 2,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.chair),
                  label: Text("Tempat Duduk"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green)
                  ),
                  onPressed: () async {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => SeatMasterPage(this.widget.session,this.widget.kodeEvent.toString())));
                  },
                ),
                Container(
                  width: width * 2,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.people_alt),
                  label: Text("Kelompok Tamu"),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.teal)
                  ),
                  onPressed: () async {
                    Navigator.push(context,MaterialPageRoute(builder: (context) => KelompokMasterPage(this.widget.session,this.widget.kodeEvent.toString())));
                  },
                ),
                Container(
                  width: width * 2,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.add_reaction_rounded),
                  label: Text("Tambah Tamu"),
                  onPressed: () async {
                    var x = await Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => TamuMasterPage(
                                  this.widget.session,
                                  KodeEvent: _KodeEvent.toString(),
                                )))
                        .then((value) {
                      _fetchData(this.widget.kodeEvent.toString());
                    });
                  },
                ),
                Container(
                  width: width * 2,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.download),
                  label: Text("Download QRCode"),
                  onPressed: () async {
                    showLoadingDialog(context, _keyLoader, info: "Processing");
                    Map Parameter(){
                      return {
                        "RecordOwnerID":this.widget.session!.RecordOwnerID.toString(),
                        "EventID" : this.widget.kodeEvent.toString()
                      };
                    }
                    var x = await TamuModels(this.widget.session).generateQR(Parameter()).then((value) async{
                      if(value["success"].toString() == "true"){
                        // "http://"+this.widget.session!.server+"/mstr/downloadqr/"+ this.widget.session!.RecordOwnerID +"-"+_KodeEvent.toString()+"/Event QR Download - "+_NamaEvent.toString()
                        Uri url = Uri.parse("https://"+this.widget.session!.server+"/mstr/downloadqr/"+ this.widget.session!.RecordOwnerID +"-"+_KodeEvent.toString()+"/Event QR Download - "+_NamaEvent.toString());
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw Exception('Could not launch $url');
                        }
                        Navigator.of(context, rootNavigator: false).pop();
                        // Dio dio = Dio();

                        // Directory? directory;

                        // directory = Directory('/storage/emulated/0/Download');

                        // var tempDir = await getExternalStorageDirectory();
                        // String fullPath = tempDir!.path+"/Event QR Download - " + _NamaEvent.toString() + ".zip" ;

                        // downloadFile2(dio, "http://"+this.widget.session!.server+"/mstr/downloadqr/"+ this.widget.session!.RecordOwnerID +"-"+_KodeEvent.toString()+"/Event QR Download - "+_NamaEvent.toString(), fullPath);

                        // if(!downloading){
                        //   Navigator.of(context, rootNavigator: false).pop();
                        //   await messageBox(
                        //     context: context,
                        //     title: "Informasi",
                        //     message: "Data Berhasil Tersimpan");
                        //   }
                      }
                    });
                  },
                ),
                Container(
                  width: width * 2,
                ),
                ElevatedButton.icon(
                  icon: Icon(Icons.attach_money_rounded),
                  label: Text("Keuangan"),
                  onPressed: () async {
                    // Navigator.push(context,MaterialPageRoute(builder: (context) => KelompokKeuangan(this.widget.session,this.widget.kodeEvent.toString())));
                  },
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: height * 2)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: width * 2, right: width * 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: width * 30,
                              height: width * 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Estimasi Tamu",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red[300]),
                                  )
                                ],
                              )),
                          SizedBox(
                              width: width * 30,
                              height: width * 30,
                              child: Container(
                                color: Colors.red[300],
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _jumlahUndanganAktual.toString(),
                                      style: TextStyle(
                                          fontSize: width * 10,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: width * 2, right: width * 2),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 30,
                            height: width * 10,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Tamu Hadir",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green[600]),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 30,
                            height: width * 30,
                            child: Container(
                              color: Colors.green[600],
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _jumlahUndanganDatang.toString(),
                                    style: TextStyle(
                                        fontSize: width * 10,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                ListTile(
                  title: Text("Tanggal Acara :"),
                  subtitle: Text(DateFormat("dd MMM yyyy").format(_tglEvent)),
                ),
                ListTile(
                  title: Text("Jam :"),
                  subtitle: Text(DateFormat("HH:mm")
                      .format(DateTime(_tglEvent.year, _tglEvent.month,
                          _tglEvent.day, _JamEvnet.hour, _JamEvnet.minute))
                      .toString()),
                ),
                ListTile(
                  title: Text("Lokasi Acara :"),
                  subtitle: Text(_lokasiEvent.toString()),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: height * 2),
                  child: Text(
                    "Acaramu Akan dimulai pada :",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            CountdownTimer(
              endTime: _intDate,
              widgetBuilder: (context, time) {
                List<Widget> list = [];
                if (time == null) {
                  return Container();
                } else {
                  if (time.days != null) {
                    list.add(Padding(
                        padding: EdgeInsets.only(left: width * 0),
                        child: Column(
                          children: [
                            SizedBox(
                                width: width * 20,
                                height: width * 20,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      time.days.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(top: width * 1)),
                                    SizedBox(
                                      width: width * 20,
                                      height: width * 5,
                                      child: Container(
                                        child: Text(
                                          "Hari",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )));
                  }

                  if (time.hours != null) {
                    list.add(
                      Padding(
                          padding: EdgeInsets.only(left: width * 2),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: width * 20,
                                  height: width * 20,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        time.hours.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: width * 1)),
                                      SizedBox(
                                        width: width * 20,
                                        height: width * 5,
                                        child: Container(
                                          child: Text(
                                            "Jam",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          )),
                    );
                  }

                  if (time.min != null) {
                    list.add(
                      Padding(
                          padding: EdgeInsets.only(left: width * 2),
                          child: Column(
                            children: [
                              SizedBox(
                                  width: width * 20,
                                  height: width * 20,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        time.min.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                          padding:
                                              EdgeInsets.only(top: width * 1)),
                                      SizedBox(
                                        width: width * 20,
                                        height: width * 5,
                                        child: Container(
                                          child: Text(
                                            "Menit",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          )),
                    );
                  }

                  if (time.sec != null) {
                    list.add(Padding(
                        padding: EdgeInsets.only(left: width * 2),
                        child: Column(
                          children: [
                            SizedBox(
                                width: width * 20,
                                height: width * 20,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      time.sec.toString(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                        padding:
                                            EdgeInsets.only(top: width * 1)),
                                    SizedBox(
                                      width: width * 20,
                                      height: width * 5,
                                      child: Container(
                                        child: Text(
                                          "Detik",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )));
                  }
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: list,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          width: double.infinity,
          height: height * 7,
          child: ElevatedButton.icon(
            icon: Icon(Icons.check_outlined),
            label: Text("Checkin"),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.green)),
            onPressed: !_eventStarted ? null : () async{
              var x = await Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => CheckinPage(
                            this.widget.session,
                            KodeEvent: _KodeEvent.toString(),
                          )))
                  .then((value) {
                _fetchData(this.widget.kodeEvent.toString());
              });
            },
          ),
        ),
      ),
    );
  }
}
