import 'package:flutter/material.dart';
import 'package:guestbook/model/event.dart';
import 'package:guestbook/shared/dialog.dart';
import 'package:guestbook/shared/inputdata.dart';
import 'package:guestbook/shared/lookup.dart';
import 'package:guestbook/shared/session.dart';

class EventInputPage extends StatefulWidget {
  final Session? session;
  final String? kodeEvent;

  EventInputPage(this.session, {this.kodeEvent});

  @override
  _eventInputState createState() => _eventInputState();
}

class _eventInputState extends State<EventInputPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  List? _dataSet;
  bool valid = false;

  int? _KodeEvent = 0;
  String? _NamaEvent = "";
  String? _deskripsiEvent = "";
  int? _estimasiUndangan = 0;

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
    _estimasiUndangan = _dataSet![0]["EstimasiUndangan"];
    setState(() => {});
  }

  void initState() {
    if (this.widget.kodeEvent == "") {
      _KodeEvent = 0;
      _NamaEvent = "";
      _deskripsiEvent = "";
      _estimasiUndangan = 0;
      _dataSet = null;
    } else {
      _fetchData(this.widget.kodeEvent.toString());
    }
    super.initState();
  }

  bool setEnablecommand() {
    valid = _NamaEvent.toString() != "" &&
        _deskripsiEvent != "" &&
        _estimasiUndangan != 0;

    return valid;
  }

  void _simpanData() {
    // print("data click");
    showLoadingDialog(context, _keyLoader, info: "Processing");

    var oSave = new EventModels(this.widget.session);
    Map oParam() {
      return {
        "formmode": _dataSet == null ? "add" : "edit",
        "KodeEvent": _KodeEvent,
        "NamaEvent": _NamaEvent,
        "DeskripsiEvent": _deskripsiEvent,
        "EstimasiUndangan": _estimasiUndangan,
        "RecordOwnerID": this.widget.session!.RecordOwnerID
      };
    }

    print(oParam());

    oSave.crud(oParam()).then((value) async {
      if (value["success"].toString() == "true") {
        Navigator.of(context, rootNavigator: false).pop();
        await messageBox(
            context: context,
            title: "Informasi",
            message: "Data Berhasil Tersimpan");
        Navigator.of(context).pop();
      } else {
        Navigator.of(context, rootNavigator: false).pop();
        await messageBox(
            context: context,
            title: "Error",
            message: "Error : " + value["nError"] + " / " + value["sError"]);
      }
    });
  }

  @override
  Widget build(BuildContext contex) {
    var width = MediaQuery.of(context).size.width / 100;
    var height = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      appBar: AppBar(
        title: _dataSet == null
            ? Text("Data Kelompok Tamu | ** Add **")
            : Text("Data Kelompok Tamu | ** Edit **"),
      ),
      body: _formInput(),
    );
  }

  Widget _inputDataString({
    required String title,
    required String label,
    dynamic dataField,
    String description = "",
    int maxlen = 1,
    bool isEdit = false,
    required void Function(dynamic value) onChange,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 70, right: 20),
      title: Text("$dataField",
          style: TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      onTap: isEdit
          ? null
          : () async {
              var data = await inputString(
                  context: context,
                  title: "$title",
                  label: "$label",
                  data: dataField,
                  description: "$description",
                  maxlen: maxlen);
              if (data != null) {
                onChange(data);
                setEnablecommand();
              }
            },
    );
  }

  Widget _inputDataNumeric(
      {String? title,
      String? label,
      String? labelEx,
      String caption = "",
      dynamic dataField,
      String uom = "",
      String description = "",
      void Function(dynamic value)? onChange}) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 70, right: 20),
      title: Text("$label", style: TextStyle(color: Colors.red)),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            dataField == 0 ? "<Tidak Ada>" : "$dataField",
            style:
                TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      onTap: () async {
        var data = await inputNumeric(
            context: context,
            title: "$title",
            label: "$label",
            data: dataField,
            description: "$description",
            uom: "$uom");
        if (data != null) {
          onChange!(data);
        }
      },
    );
  }

  Widget _formInput() {
    return ListView(
      children: [
        _widgetNamaEvent(),
        _widgetDeskripsiEvent(),
        _widgetJumlahTamu(),
        _WidgetsimpanData()
      ],
    );
  }

  Widget _widgetNamaEvent() {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("1")),
      title: Text(
        "Nama Event",
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      children: <Widget>[
        _inputDataString(
            title: "Nama Event",
            label: "Nama Event",
            dataField: this._NamaEvent == "" ? "-" : this._NamaEvent,
            description: "",
            maxlen: 1,
            isEdit: false,
            onChange: (v) => setState(() => this._NamaEvent = v)),
      ],
    );
  }

  Widget _widgetDeskripsiEvent() {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("1")),
      title: Text(
        "Deskripsi Event",
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      children: <Widget>[
        _inputDataString(
            title: "Deskripsi Event",
            label: "Deskripsi Event",
            dataField: this._deskripsiEvent == "" ? "-" : this._deskripsiEvent,
            description: "",
            maxlen: 3,
            isEdit: false,
            onChange: (v) => setState(() => this._deskripsiEvent = v)),
      ],
    );
  }

  Widget _widgetJumlahTamu() {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("4")),
      title: Text(
        "Estimasi Jumlah Tamu",
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      children: <Widget>[
        _inputDataNumeric(
            title: "Estimasi Jumlah Tamu",
            label: "Estimasi Jumlah Tamu",
            uom: "Orang",
            labelEx: "",
            dataField: this._estimasiUndangan,
            onChange: (v) => setState(() => this._estimasiUndangan = v)),
      ],
    );
  }

  Widget _WidgetsimpanData() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColorDark,
            onPrimary: Colors.white),
        child: Text("Simpan Data",
            style: TextStyle(fontSize: 16, color: Colors.white)),
        onPressed: !valid
            ? null
            : () {
                _simpanData();
              },
      ),
    );
  }
}
