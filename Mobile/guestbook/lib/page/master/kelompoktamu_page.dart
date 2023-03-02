import 'dart:async';

import 'package:flutter/material.dart';
import 'package:guestbook/model/kelompoktamu.dart';
import 'package:guestbook/page/master/kelompoktamu_input_page.dart';
import 'package:guestbook/shared/dialog.dart';
import 'package:guestbook/shared/layoutdata.dart';
import 'package:guestbook/shared/session.dart';

class KelompokMasterPage extends StatefulWidget {
  final Session ? session;
  KelompokMasterPage(this.session);
  @override
  _KelompokMasterState createState() => _KelompokMasterState();
}

class _KelompokMasterState extends State<KelompokMasterPage> {
  int _short = 0;
  bool _searchMode = true;
  Icon _appIcon = Icon(Icons.search, size: 32.0,);
  TextEditingController _searchText = TextEditingController();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        title: _searchWidget(),
        actions: <Widget>[
          IconButton(
            icon: _appIcon,
            onPressed: () {
              _searchMode = _searchMode ? false: true;
              _searchText.text = "";
              setState(() => _appIcon = _searchMode ? Icon(Icons.search) : Icon(Icons.close));                  
            },
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async{                  
            var x = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => KelompokInputPage(this.widget.session,kodeKelompok: "",) )).then((value) {
              setState(() {});
            });
            _searchMode = true;
            _searchText.text = "";
            setState(() => _appIcon = _searchMode ? Icon(Icons.search) : Icon(Icons.close));   
        } 
      ),
      body: Column(
        children: [
          _loadData()
        ],
      ),
    );
  }
  Widget _searchWidget() {
    if(_searchMode) {
      return Text("Daftar Kelompok Tamu");
    }else {
      return (
        Container(
          color: Theme.of(context).primaryColorLight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchText,
              autofocus: true,
              decoration: InputDecoration.collapsed(hintText: "Cari Data"),
              textInputAction: TextInputAction.search,
              onChanged: (value) => setState((){})
            ),
          )
        )
      );
    }
  }

  Widget _loadData(){
    Map Parameter(){
      return {
        "KodeKelompok"  : "",
        "RecordOwnerID" : this.widget.session!.RecordOwnerID.toString(),
        "Kriteria"      : _searchText.text
      };
    }
    return Expanded(
      child: FutureBuilder(
        future: KelompokTamuModels(this.widget.session).read(Parameter()),
        builder: (context, AsyncSnapshot<Map> snapshot){
          // print(snapshot.data);
          if(snapshot.hasData){
            // Navigator.of(context,rootNavigator: true).pop();
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: snapshot.data!.length == 0 ? 0 : snapshot.data!["data"].length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text((index + 1).toString()),
                      ),
                      title: Text(
                        snapshot.data!["data"][index]["NamaKelompok"],
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                      subtitle: Text(snapshot.data!["data"][index]["KodeKelompok"]),
                      trailing: GestureDetector(
                        child: Icon(Icons.delete),
                        onTap: ()async{
                          bool _konfirmasiSimpam =  await messageDialog(
                              context: context,
                              title: "Konfirmasi",
                              message: "Delete Data ini ?"
                          );

                          if(_konfirmasiSimpam){
                            showLoadingDialog(context, _keyLoader,info: "Processing");

                            var oSave = new KelompokTamuModels(this.widget.session);
                            Map oParam(){
                              return {
                                "formmode"      : "delete",
                                "KodeKelompok"  : snapshot.data!["data"][index]["KodeKelompok"],
                                "RecordOwnerID" : this.widget.session!.RecordOwnerID
                              };
                            }

                            oSave.crud(oParam()).then((value) async{
                              if(value["success"].toString() == "true"){
                                Navigator.of(context,rootNavigator: false).pop();
                                await messageBox(context: context,title: "Informasi",message: "Data Berhasil Dihapus");
                                setState(() {
                                  
                                });
                              }
                              else{
                                Navigator.of(context,rootNavigator: false).pop();
                                await messageBox(context: context,title: "Error",message: "Error : " + value["nError"].toString() + " / " + value["sError"]);
                              }
                              
                            });
                          }
                          
                        },
                      ),
                      onTap: ()async{
                        var x = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => KelompokInputPage(this.widget.session,kodeKelompok: snapshot.data!["data"][index]["KodeKelompok"],) )).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  );
                }
              ), 
            );
          }
          else{
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
          // return Text("data");
        }
      )
    );
  }

  Future _refreshData() async{
      setState((){});

      Completer<Null> completer = Completer<Null>();
      Future.delayed(Duration(seconds: 1)).then( (_) {
        completer.complete();
      });
      return completer.future;
  }
}