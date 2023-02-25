import 'package:flutter/material.dart';
import 'package:guestbook/model/seat.dart';
import 'package:guestbook/shared/inputdata.dart';
import 'package:guestbook/shared/session.dart';

class SeatInputPage extends StatefulWidget{
  final Session ? session;
  final String ? kodeSeat;
  SeatInputPage(this.session,{this.kodeSeat});

  @override
  _seatInputState createState() => _seatInputState();
}

class _seatInputState extends State<SeatInputPage>{
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  String ? _kodeSeat;
  String ? _namaSeat;
  String ? _area;

  List ? _dataSeat;
  Future<Map> _getData(String KodeSeat) async{
    Map Parameter(){
      return {
        "KodeSeat"      : KodeSeat,
        "RecordOwnerID" : this.widget.session!.RecordOwnerID.toString(),
        "Kriteria"      : ""
      };
    }
    var temp = await SeatModels(this.widget.session).read(Parameter());
    return temp;
  }

  _fetchData(String KodeSeat) async{
    var temp = await _getData(KodeSeat);
    _dataSeat = temp["data"].toList();
    _kodeSeat = _dataSeat![0]["KodeSeat"];
    _namaSeat = _dataSeat![0]["NamaSeat"];
    _area = _dataSeat![0]["Area"];
    setState(() => {});
  }

  @override

  void initState(){
    if(this.widget.kodeSeat == ""){
      _kodeSeat = "";
      _namaSeat = "";
      _area = "";
      _dataSeat = null;
    }
    else{
      _fetchData(this.widget.kodeSeat.toString());
    }
    super.initState();
  }

  bool setEnablecommand(){
    bool valid = false;

    valid = _kodeSeat.toString() != "" &&
            _namaSeat !="" &&
            _area != "";

    return valid;
  }

  void _simpanData(){

  }
  @override 
  Widget build(BuildContext contex){
    var width = MediaQuery.of(context).size.width / 100;
    var height = MediaQuery.of(context).size.height / 100;

    return Scaffold(
      appBar: AppBar(
        title: _dataSeat== null ? Text("Add | Data Kursi") : Text("Edit | Data Kursi"),
        actions: [
          TextButton(
            child: Text("Simpan"),
            onPressed: !setEnablecommand() ? null :() {
              _simpanData();
            } ,
          )
        ],
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
                    required void Function(dynamic value) onChange}) {

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
            }
        },
    );
  }

  Widget _formInput(){
    return ListView(
      children: [
        _widgetKodeSeat(),
        _widgetNamaSeat(),
        _widgetArea(),
        _WidgetsimpanData()
      ],
    );
  }

  Widget _widgetKodeSeat() {
    return ExpansionTile( 
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("1")),
      title: Text("Kode Seat", style: TextStyle(color: Theme.of(context).primaryColorDark),),
      children: <Widget>[
        _inputDataString(
            title:"Kode Seat", 
            label:"Kode Seat", 
            dataField:this._kodeSeat == "" ? "-" : this._kodeSeat, 
            description:"", 
            maxlen:1,
            isEdit: _dataSeat==null ? false : true,
            onChange: (v) => setState( () => this._kodeSeat = v)
        ),
      ],
    );
  }

  Widget _widgetNamaSeat() {
    return ExpansionTile( 
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("2")),
      title: Text("Nama Seat", style: TextStyle(color: Theme.of(context).primaryColorDark),),
      children: <Widget>[
        _inputDataString(
            title:"Nama Seat", 
            label:"Nama Seat", 
            dataField:this._namaSeat == "" ? "-" : this._namaSeat, 
            description:"", 
            maxlen:1,
            isEdit: false,
            onChange: (v) => setState( () => this._namaSeat = v)
        ),
      ],
    );
  }

  Widget _widgetArea() {
    return ExpansionTile( 
      initiallyExpanded: true,
      leading: CircleAvatar(child: Text("3")),
      title: Text("Area", style: TextStyle(color: Theme.of(context).primaryColorDark),),
      children: <Widget>[
        _inputDataString(
            title:"Area", 
            label:"Area", 
            dataField:this._area == "" ? "-" : this._area, 
            description:"", 
            maxlen:1,
            onChange: (v) => setState( () => this._area = v)
        ),
      ],
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
        onPressed: !setEnablecommand() ? null :() {
          _simpanData();
        },
      ),
    );
  }
}