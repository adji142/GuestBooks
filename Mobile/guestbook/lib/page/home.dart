import 'package:flutter/material.dart';
import 'package:guestbook/page/master/kelompoktamu.dart';
import 'package:guestbook/page/master/seat.dart';
import 'package:guestbook/page/master/tamu.dart';
import 'package:guestbook/shared/layoutdata.dart';
import 'package:guestbook/shared/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final Session ? session;
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
  Widget build(BuildContext context)  {
    var layout = new layoutData(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader( 
              accountName: Text(this.widget.session!.NamaUser, style: TextStyle(fontSize: 18),),
              accountEmail: Text(this.widget.session!.Email, style: TextStyle(fontSize: 18),),
              currentAccountPicture: CircleAvatar(child: Icon(Icons.person, size: 48, ), backgroundColor: Colors.white,),
              arrowColor: Theme.of(context).primaryColorLight,
              otherAccountsPictures: <Widget>[
                
              ],
            ),
            ListTile(
              title: Text("Master Tempat Duduk"),
              leading: Icon(Icons.chair),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>SeatMasterPage(this.widget.session,)));
              },
            ),
            ListTile(
              title: Text("Master Kelompok Tamu"),
              leading: Icon(Icons.people_alt),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>KelompokMasterPage(this.widget.session,)));
              },
            ),
            ListTile(
              title: Text("Master Tamu"),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TamuMasterPage(this.widget.session,)));
              },
            ),
            ListTile(
              title: Text("Shop (soon)"),
              leading: Icon(Icons.shopping_bag),
              trailing: Icon(Icons.arrow_forward_ios),
            )
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: layout.getHeight(),
        child: ListView(
          scrollDirection: Axis.vertical,
        ),
      ),
    );
  }
}