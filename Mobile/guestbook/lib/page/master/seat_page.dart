import 'package:flutter/material.dart';
import 'package:guestbook/model/seat.dart';
import 'package:guestbook/page/master/seat_input_page.dart';
import 'dart:async';
import 'package:guestbook/shared/layoutdata.dart';
import 'package:guestbook/shared/session.dart';

class SeatMasterPage extends StatefulWidget {
  final Session ? session;
  SeatMasterPage(this.session);
  @override
  _SeatMasterState createState() => _SeatMasterState();
}

class _SeatMasterState extends State<SeatMasterPage> {
  int _short = 0;
  bool _searchMode = true;
  Icon _appIcon = Icon(Icons.search, size: 32.0,);
  TextEditingController _searchText = TextEditingController();

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
            var x = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SeatInputPage(this.widget.session,kodeSeat: "",) )).then((value) {
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
      return Text("Daftar Tempat Duduk");
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
    print("object data");
    Map Parameter(){
      return {
        "KodeSeat"      : "",
        "RecordOwnerID" : this.widget.session!.RecordOwnerID.toString(),
        "Kriteria"      : _searchText.text
      };
    }
    return Expanded(
      child: FutureBuilder(
        future: SeatModels(this.widget.session).read(Parameter()),
        builder: (context, AsyncSnapshot<Map> snapshot){
          // print(snapshot.data);
          if(snapshot.hasData){
            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: snapshot.data == null ? 0 : snapshot.data!["data"].length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text((index + 1).toString()),
                      ),
                      title: Text(
                        snapshot.data!["data"][index]["NamaSeat"],
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                      subtitle: Text(snapshot.data!["data"][index]["KodeSeat"]),
                      trailing: Text(
                        snapshot.data!["data"][index]["Area"],
                        style: TextStyle(
                          color: Colors.red
                        ),
                      ),
                      onTap: ()async{
                        var x = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SeatInputPage(this.widget.session,kodeSeat: snapshot.data!["data"][index]["KodeSeat"],) )).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  );
                }
              ), 
            );
          }
          return Text("data");
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