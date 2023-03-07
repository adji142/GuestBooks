import 'package:flutter/material.dart';
import 'package:guestbook/model/kelompoktamu.dart';
import 'package:guestbook/model/seat.dart';
import 'package:guestbook/page/master/kelompoktamu_page.dart';
import 'package:guestbook/shared/dialog.dart';
import 'package:guestbook/shared/inputdata.dart';
import 'package:guestbook/shared/lookup.dart';
import 'package:guestbook/shared/session.dart';

class KelompokInputPage extends StatefulWidget{
  final Session ? session;
  final String ? kodeKelompok;
  KelompokInputPage(this.session,{this.kodeKelompok});

  @override
  _kelompokInputState createState() => _kelompokInputState();
}
class _kelompokInputState extends State<KelompokInputPage>{
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  List ? _dataSet;
  bool valid = false;

  String ? _kodeKelompok = "";
  String ? _namaKelompok = "";
  String ? _kodeSeat = "";
  String ? _namaSeat = "";
  
  Future<Map> _getData(String KodeKelompok) async{
    Map Parameter(){
      return {
        "KodeKelompok"  : KodeKelompok,
        "RecordOwnerID" : this.widget.session!.RecordOwnerID.toString(),
        "Kriteria"      : ""
      };
    }
    var temp = await KelompokTamuModels(this.widget.session).read(Parameter());
    return temp;
  }

  _fetchData(String KodeKelompok) async{
    var temp = await _getData(KodeKelompok);
    _dataSet = temp["data"].toList();
    _kodeKelompok = _dataSet![0]["KodeKelompok"];
    _namaKelompok = _dataSet![0]["NamaKelompok"];
    _kodeSeat = _dataSet![0]["KodeSeat"];
    _namaSeat = _dataSet![0]["NamaSeat"];
    setState(() => {});
  }

  void initState(){
    if(this.widget.kodeKelompok == ""){
      _kodeKelompok = "";
      _namaKelompok = "";
      _kodeSeat = "";
      _namaSeat = "";
      _dataSet = null;
    }
    else{
      _fetchData(this.widget.kodeKelompok.toString());
    }
    super.initState();
  }

  bool setEnablecommand(){
    valid = _kodeSeat.toString() != "" &&
            _namaSeat !="" &&
            _kodeKelompok != ""&&
            _namaKelompok != "";

    return valid;
  }

  void _simpanData(){
    // print("data click");
    showLoadingDialog(context, _keyLoader,info: "Processing");

    var oSave = new KelompokTamuModels(this.widget.session);
    Map oParam(){
      return {
        "formmode"      : _dataSet == null ? "add" : "edit",
        "KodeKelompok"      : _kodeKelompok,
        "NamaKelompok"      : _namaKelompok,
        "KodeSeat"          : _kodeSeat,
        "RecordOwnerID" : this.widget.session!.RecordOwnerID
      };
    }

    oSave.crud(oParam()).then((value) async{
      if(value["success"].toString() == "true"){
        Navigator.of(context,rootNavigator: false).pop();
        await messageBox(context: context,title: "Informasi",message: "Data Berhasil Tersimpan");
        Navigator.of(context).pop();
      }
      else{
        Navigator.of(context,rootNavigator: false).pop();
        await messageBox(context: context,title: "Error",message: "Error : " + value["nError"].toString() + " / " + value["sError"]);
      }
      
    });
  }

  @override 
  Widget build(BuildContext contex){
    var width = MediaQuery.of(context).size.width / 100;
    var height = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      appBar: AppBar(
        title: _dataSet== null ? Text("Data Kelompok Tamu | ** Add **") : Text("Data Kelompok Tamu | ** Edit **"),
      ),
      body: _formInput(),
    );
  }
  Widget _inputDataString({required String title, 
                    required String label,                    
                    dynamic dataField, 
                    String description="",
                    int maxlen = 1,
                    bool isEdit = false,
                    required void Function(dynamic value) onChange,}) {

    return ListTile( 
        contentPadding: const EdgeInsets.only(left: 70, right: 20),
        title: Text("$dataField", style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),        
        onTap: isEdit ? null : () async{
            var data = await inputString(
              context: context, 
              title: "$title",
              label: "$label", 
              data:dataField,
              description: "$description",
              maxlen: maxlen
            );
            if(data != null) {
              onChange(data);
              setEnablecommand();
            }
        },
    );
  }

  Widget _formInput(){
    return ListView(
      children: [
        _widgetKodeKelompok(),
        _widgetNamaKelompok(),
        _WidgetSeat(),
        _WidgetsimpanData()
      ],
    );
  }

  Widget _widgetKodeKelompok() {
    return ExpansionTile( 
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("1")),
      title: Text("Kode Kelompok Tamu", style: TextStyle(color: Theme.of(context).primaryColorDark),),
      children: <Widget>[
        _inputDataString(
            title:"Kode Kelompok Tamu", 
            label:"Kode Kelompok Tamu", 
            dataField:this._kodeKelompok == "" ? "-" : this._kodeKelompok, 
            description:"", 
            maxlen:1,
            isEdit: _dataSet==null ? false : true,
            onChange: (v) => setState( () => this._kodeKelompok = v)
        ),
      ],
    );
  }

  Widget _widgetNamaKelompok() {
    return ExpansionTile( 
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("2")),
      title: Text("Nama Kelompok Tamu", style: TextStyle(color: Theme.of(context).primaryColorDark),),
      children: <Widget>[
        _inputDataString(
            title:"Nama Kelompok Tamu", 
            label:"Nama Kelompok Tamu", 
            dataField:this._namaKelompok == "" ? "-" : this._namaKelompok, 
            description:"", 
            maxlen:1,
            isEdit: false,
            onChange: (v) => setState( () => this._namaKelompok = v)
        ),
      ],
    );
  }

  Widget _WidgetSeat(){
    return ListTile(
      leading: CircleAvatar(child: Text("3")),
      title: Text("Grup", style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColorDark),),
      subtitle: _namaSeat == ""
                ? Text("<PILIH TEMPAT DUDUK>", style: TextStyle(color: Colors.red))
                : Text(_namaSeat!, style: TextStyle(fontSize: 32, color: Colors.black, fontWeight: FontWeight.bold),),
      trailing: Icon(Icons.keyboard_arrow_right, color: Theme.of(context).primaryColor,),
      onTap: () async{
        Map parameter(){
          return {
            "RecordOwnerID" : this.widget.session!.RecordOwnerID
          };
        }
        var result = await Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => Lookup(
                              title: "Daftar Tempat Duduk", 
                              datamodel: new SeatModels(widget.session),
                              parameter: parameter(), )
                          ),              
                      );
        
        setState(() {
            if(result != null) {
              _kodeSeat = result["ID"];
              _namaSeat = result["Title"];
                //_fetchStandar(_kodeItemFG);
            }
            
        });

      },                
    );
  }

  Widget _WidgetsimpanData(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 20, 50, 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).primaryColorDark,
          onPrimary: Colors.white
        ),
        child: Text("Simpan Data", style: TextStyle(fontSize: 16, color: Colors.white)),
        onPressed: !valid ? null :() {
          _simpanData();
        },
      ),
    );
  }
}