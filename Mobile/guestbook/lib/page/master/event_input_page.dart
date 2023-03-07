import 'package:flutter/material.dart';
import 'package:guestbook/model/event.dart';
import 'package:guestbook/shared/dialog.dart';
import 'package:guestbook/shared/inputdata.dart';
import 'package:guestbook/shared/lookup.dart';
import 'package:guestbook/shared/session.dart';
import 'package:intl/intl.dart';

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
  DateTime _tglEvent = DateTime.now();
  TimeOfDay _JamEvnet = TimeOfDay.now();
  String? _lokasiEvent = "";

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
    _tglEvent = DateTime.parse(_dataSet![0]["TglEvent"]);
    // _JamEvnet = _dataSet![0]["JamEvent"];
    _JamEvnet = TimeOfDay(
        hour: int.parse(
            _dataSet![0]["JamEvent"].toString().split(":")[0].toString()),
        minute: int.parse(
            _dataSet![0]["JamEvent"].toString().split(":")[1].toString()));
    _lokasiEvent = _dataSet![0]["LokasiEvent"];
    TimeOfDay _selectedTime = TimeOfDay.now();

    setState(() => {});
  }

  void initState() {
    if (this.widget.kodeEvent == "") {
      _KodeEvent = 0;
      _NamaEvent = "";
      _deskripsiEvent = "";
      _estimasiUndangan = 0;
      _tglEvent = DateTime.now();
      _JamEvnet = TimeOfDay.now();
      _lokasiEvent = "";
      _dataSet = null;
    } else {
      _fetchData(this.widget.kodeEvent.toString());
    }
    super.initState();
  }

  bool setEnablecommand() {
    valid = _NamaEvent.toString() != "" &&
        _deskripsiEvent != "" &&
        _estimasiUndangan != 0 &&
        _lokasiEvent != "";

    return valid;
  }

  void _simpanData() {
    // print("data click");
    showLoadingDialog(context, _keyLoader, info: "Processing");

    var oSave = new EventModels(this.widget.session);
    Map oParam() {
      return {
        "formmode": _dataSet == null ? "add" : "edit",
        "KodeEvent": _KodeEvent.toString(),
        "NamaEvent": _NamaEvent,
        "DeskripsiEvent": _deskripsiEvent,
        "EstimasiUndangan": _estimasiUndangan.toString(),
        "RecordOwnerID": this.widget.session!.RecordOwnerID,
        "TglEvent": DateFormat("yyyy-MM-dd").format(_tglEvent).toString(),
        "JamEvent": DateFormat("HH:mm")
            .format(DateTime(_tglEvent.year, _tglEvent.month, _tglEvent.day,
                _JamEvnet.hour, _JamEvnet.minute))
            .toString(),
        "LokasiEvent" : _lokasiEvent
      };
    }

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
            message: "Error : " + value["nError"].toString() + " / " + value["sError"]);
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _tglEvent,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _tglEvent) {
      setState(() {
        _tglEvent = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _JamEvnet,
      builder: (context, child) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!);
      },
    );
    if (picked != null && picked != _JamEvnet) {
      setState(() {
        _JamEvnet = picked;
      });
    }
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
        _widgetTanggalEvent(),
        _widgetJamEvent(),
        _widgetNamaEvent(),
        _widgetDeskripsiEvent(),
        _widgetLokasiEvent(),
        _widgetJumlahTamu(),
        _WidgetsimpanData()
      ],
    );
  }

  Widget _widgetTanggalEvent() {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("1")),
      title: Text(
        "Tanggal Event",
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      children: <Widget>[
        GestureDetector(
          child: ListTile(
            //
            contentPadding: const EdgeInsets.only(left: 70, right: 20),
            title: Text(
              DateFormat('dd MMMM yyyy').format(_tglEvent).toString(),
              style: TextStyle(
                  color: Colors.green,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            _selectDate(context);
          },
        )
      ],
    );
  }

  Widget _widgetJamEvent() {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("2")),
      title: Text(
        "Jam Event",
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      children: <Widget>[
        GestureDetector(
          child: ListTile(
            contentPadding: const EdgeInsets.only(left: 70, right: 20),
            title: Text(
              DateFormat("HH:mm")
                  .format(DateTime(_tglEvent.year, _tglEvent.month,
                      _tglEvent.day, _JamEvnet.hour, _JamEvnet.minute))
                  .toString(),
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          onTap: (() => _selectTime(context)),
        )
      ],
    );
  }

  Widget _widgetNamaEvent() {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("3")),
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
      leading: CircleAvatar(child: Text("4")),
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

  Widget _widgetLokasiEvent() {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("5")),
      title: Text(
        "Lokasi Event",
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      children: <Widget>[
        _inputDataString(
            title: "Lokasi Event",
            label: "Lokasi Event",
            dataField: this._lokasiEvent == "" ? "-" : this._lokasiEvent,
            description: "",
            maxlen: 3,
            isEdit: false,
            onChange: (v) => setState(() => this._lokasiEvent = v)),
      ],
    );
  }

  Widget _widgetJumlahTamu() {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("6")),
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
