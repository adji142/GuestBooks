import 'package:flutter/material.dart';
import 'package:guestbook/model/kelompoktamu.dart';
import 'package:guestbook/model/tamu.dart';
import 'package:guestbook/shared/dialog.dart';
import 'package:guestbook/shared/inputdata.dart';
import 'package:guestbook/shared/lookup.dart';
import 'package:guestbook/shared/session.dart';

class TamuInputPage extends StatefulWidget {
  final Session? session;
  final String? KodeTamu;
  final String? KodeEvent;
  TamuInputPage(this.session, {this.KodeTamu, this.KodeEvent});

  @override
  _tamuInputState createState() => _tamuInputState();
}

class _tamuInputState extends State<TamuInputPage> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  String? _kodeTamu = "";
  String? _namaTamu = "";
  String? _kodeKelompokTamu = "";
  String? _namaKelompokTamu = "";
  int? _jumlahUndangan = 0;
  String? _alamatUndangan = "";

  List? _dataSet;

  bool valid = false;

  Future<Map> _getData(String KodeTamu) async {
    Map Parameter() {
      return {
        "KodeTamu": KodeTamu,
        "RecordOwnerID": this.widget.session!.RecordOwnerID.toString(),
        "Kriteria": "",
        "EventID" : widget.KodeEvent.toString()
      };
    }

    var temp = await TamuModels(this.widget.session).read(Parameter());
    return temp;
  }

  _fetchData(String KodeTamu) async {
    var temp = await _getData(KodeTamu);
    _dataSet = temp["data"].toList();

    _kodeTamu = _dataSet![0]["KodeTamu"];
    _namaTamu = _dataSet![0]["NamaTamu"];
    _kodeKelompokTamu = _dataSet![0]["KelompokTamu"];
    _namaKelompokTamu = _dataSet![0]["NamaKelompok"];
    _jumlahUndangan = _dataSet![0]["JumlahUndangan"];
    _alamatUndangan = _dataSet![0]["AlamatTamu"];

    setState(() => {});
  }

  @override
  void initState() {
    if (this.widget.KodeTamu == "") {
      _kodeTamu = "";
      _namaTamu = "";
      _kodeKelompokTamu = "";
      _namaKelompokTamu = "";
      _jumlahUndangan = 0;
      _alamatUndangan = "";

      _dataSet = null;
    } else {
      _fetchData(this.widget.KodeTamu.toString());
    }
    super.initState();
  }

  bool setEnablecommand() {
    valid = _kodeTamu.toString() != "" &&
        _namaTamu != "" &&
        _namaKelompokTamu != "" &&
        _jumlahUndangan != 0 &&
        _alamatUndangan != "";

    return valid;
  }

  void _simpanData() {
    // print("data click");
    showLoadingDialog(context, _keyLoader, info: "Processing");

    var oSave = new TamuModels(this.widget.session);
    Map oParam() {
      return {
        "formmode": _dataSet == null ? "add" : "edit",
        "KodeTamu": _kodeTamu,
        "NamaTamu": _namaTamu,
        "KelompokTamu": _kodeKelompokTamu,
        "JumlahUndangan": _jumlahUndangan.toString(),
        "AlamatTamu": _alamatUndangan,
        "EventID" : widget.KodeEvent.toString(),
        "RecordOwnerID": this.widget.session!.RecordOwnerID
      };
    }

    print(oParam());

    oSave.crud(oParam()).then((value) async {
      print(value);
      if (value["success"].toString() == "true") {
        Navigator.of(context, rootNavigator: false).pop();
        await messageBox(
            context: context,
            title: "Informasi",
            message: "Data Berhasil Tersimpan");
        Navigator.of(context).pop();
      } else {
        print(value);
        Navigator.of(context, rootNavigator: false).pop();
        await messageBox(
            context: context,
            title: "Error",
            message: "Error : " + value["nError"].toString() + " / " + value["sError"]);
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
            ? Text("Data Tamu | ** Add **")
            : Text("Data Tamu | ** Edit **"),
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
            _jumlahUndangan == "" ? "<Tidak Ada>" : "$_jumlahUndangan",
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
        _widgetKodeTamu(),
        _widgetNamaTamu(),
        _WidgetKelompokTamu(),
        _widgetJumlahTamu(),
        _widgetAlamat(),
        _WidgetsimpanData()
      ],
    );
  }

  Widget _widgetKodeTamu() {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("1")),
      title: Text(
        "Kode Tamu",
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      children: <Widget>[
        _inputDataString(
            title: "Kode Tamu",
            label: "Kode Tamu",
            dataField: this._kodeTamu == "" ? "-" : this._kodeTamu,
            description: "",
            maxlen: 1,
            isEdit: _dataSet == null ? false : true,
            onChange: (v) => setState(() => this._kodeTamu = v)),
      ],
    );
  }

  Widget _widgetNamaTamu() {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("2")),
      title: Text(
        "Nama Tamu",
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      children: <Widget>[
        _inputDataString(
            title: "Nama Tamu",
            label: "Nama Tamu",
            dataField: this._namaTamu == "" ? "-" : this._namaTamu,
            description: "",
            maxlen: 1,
            isEdit: false,
            onChange: (v) => setState(() => this._namaTamu = v)),
      ],
    );
  }

  Widget _WidgetKelompokTamu() {
    return ListTile(
      leading: CircleAvatar(child: Text("3")),
      title: Text(
        "Kelompok Tamu",
        style:
            TextStyle(fontSize: 12, color: Theme.of(context).primaryColorDark),
      ),
      subtitle: _namaKelompokTamu == ""
          ? Text("<PILIH KELOMPOK TAMU>", style: TextStyle(color: Colors.red))
          : Text(
              _namaKelompokTamu!,
              style: TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Theme.of(context).primaryColor,
      ),
      onTap: () async {
        Map parameter() {
          return {"RecordOwnerID": this.widget.session!.RecordOwnerID};
        }

        var result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Lookup(
                    title: "Daftar Kelompok Tamu",
                    datamodel: new KelompokTamuModels(widget.session),
                    parameter: parameter(),
                  )),
        );

        setState(() {
          if (result != null) {
            _kodeKelompokTamu = result["ID"];
            _namaKelompokTamu = result["Title"];
            //_fetchStandar(_kodeItemFG);
          }
        });
      },
    );
  }

  Widget _widgetJumlahTamu() {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("4")),
      title: Text(
        "Jumlah Tamu",
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      children: <Widget>[
        _inputDataNumeric(
            title: "Jumlah Tamu",
            label: "Jumlah Tamu",
            uom: "Orang",
            labelEx: "",
            dataField: this._jumlahUndangan,
            onChange: (v) => setState(() => this._jumlahUndangan = v)),
      ],
    );
  }

  Widget _widgetAlamat() {
    return ExpansionTile(
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("5")),
      title: Text(
        "Alamat Tamu",
        style: TextStyle(color: Theme.of(context).primaryColorDark),
      ),
      children: <Widget>[
        _inputDataString(
            title: "Alamat Tamu",
            label: "Alamat Tamu",
            dataField: this._alamatUndangan == "" ? "-" : this._alamatUndangan,
            description: "",
            maxlen: 3,
            isEdit: false,
            onChange: (v) => setState(() => this._alamatUndangan = v)),
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
