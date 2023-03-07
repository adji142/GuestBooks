import 'dart:async';

import 'package:flutter/material.dart';
import 'package:guestbook/model/event.dart';
import 'package:guestbook/page/master/event_detail_page.dart';
import 'package:guestbook/page/master/event_input_page.dart';
import 'package:guestbook/page/master/kelompoktamu_page.dart';
import 'package:guestbook/page/master/seat_page.dart';
import 'package:guestbook/page/master/tamu_page.dart';
import 'package:guestbook/shared/layoutdata.dart';
import 'package:guestbook/shared/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final Session? session;
  HomePage(this.session);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var layout = new layoutData(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Guest Books"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                this.widget.session!.NamaUser,
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text(
                this.widget.session!.Email,
                style: TextStyle(fontSize: 18),
              ),
              currentAccountPicture: CircleAvatar(
                child: Icon(
                  Icons.person,
                  size: 48,
                ),
                backgroundColor: Colors.white,
              ),
              arrowColor: Theme.of(context).primaryColorLight,
              otherAccountsPictures: <Widget>[],
            ),
            ListTile(
              title: Text("Master Tempat Duduk"),
              leading: Icon(Icons.chair),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SeatMasterPage(
                              this.widget.session,
                            )));
              },
            ),
            ListTile(
              title: Text("Master Kelompok Tamu"),
              leading: Icon(Icons.people_alt),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => KelompokMasterPage(
                              this.widget.session,
                            )));
              },
            ),
            // ListTile(
            //   title: Text("Master Tamu"),
            //   leading: Icon(Icons.person),
            //   trailing: Icon(Icons.arrow_forward_ios),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => TamuMasterPage(
            //                   this.widget.session,
            //                 )));
            //   },
            // ),
            ListTile(
              title: Text("Shop (soon)"),
              leading: Icon(Icons.shopping_bag),
              trailing: Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(child: Icon(Icons.add), onPressed: () async{
            var x = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventInputPage(this.widget.session,kodeEvent: "",) )).then((value) {
              setState(() {});
            });
            setState(() => Container(),);   
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).primaryColor,
        child: ListTile(
          dense: true,
          title: Text("This is title use wisely",
              style: TextStyle(color: Colors.white)),
        ),
      ),
      body: Column(
        children: [
          _loadData()
        ],
      )
    );
  }

  Widget _loadData() {
    Map Parameter() {
      return {
        'KodeEvent': '',
        'RecordOwnerID': this.widget.session!.RecordOwnerID,
        'Kriteria': ''
      };
    }

    return Expanded(
      child: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder(
          future: EventModels(this.widget.session).read(Parameter()),
          builder: (context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!["data"].length == 0 ? 0 : snapshot.data!["data"].length,
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text((index +1).toString()),
                      ),
                      title: Text(
                        snapshot.data!["data"][index]["NamaEvent"],
                        style: TextStyle(
                          color: Theme.of(context).primaryColorDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Rencana : ",
                            style: TextStyle(
                              color: Colors.green[900]
                            ),
                          ),
                          Text(
                            snapshot.data!["data"][index]["JumlahTamu"].toString()
                          ),
                          Text(
                            " -> Kehadiran : ",
                            style: TextStyle(
                              color: snapshot.data!["data"][index]["JumlahTamuDatang"] < snapshot.data!["data"][index]["JumlahTamu"] ? Colors.green[900] : Colors.red[900]
                            ),
                          ),
                          Text(
                            snapshot.data!["data"][index]["JumlahTamuDatang"].toString(),
                            style:  TextStyle(
                              color: snapshot.data!["data"][index]["JumlahTamuDatang"] < snapshot.data!["data"][index]["JumlahTamu"] ? Colors.green[900] : Colors.red[900]
                            ),
                          ),
                        ],
                      ),
                      trailing: snapshot.data!["data"][index]["JumlahTamuDatang"] < snapshot.data!["data"][index]["JumlahTamu"] ?
                                  Icon(Icons.arrow_drop_down, color: Colors.green[900],):
                                  Icon(Icons.arrow_drop_up, color: Colors.red[900],),
                      onTap: ()async{
                        var x = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventDetailPage(this.widget.session,kodeEvent: snapshot.data!["data"][index]["KodeEvent"],) )).then((value) {
                        setState(() {});
                      });
                      },
                    ),
                  );
                }
              );
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
      )
      
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
