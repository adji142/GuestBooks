import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guestbook/model/auth.dart';
import 'package:guestbook/page/home.dart';
import 'package:guestbook/shared/dialog.dart';
import 'package:guestbook/shared/layoutdata.dart';
import 'package:guestbook/shared/session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  TextEditingController _kodeUser = TextEditingController();
  TextEditingController _password = TextEditingController();

  double? _ratio = 2;

  Session _session = new Session();

  savePrev(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('account', value);
    prefs.commit();
  }

  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (_session.KodeUser == "") {
      await initUserProfile();
    }
  }

  Future<void> initUserProfile() async {
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString("account") != null) {
      var account = prefs.getString("account")!.split("|");
      _session.Email = account[2];
      _session.NamaUser = account[1];
      _session.KodeUser = account[0];
      _session.RecordOwnerID = account[3];
      // isActive = true;
      // Updateing User Cart
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage(_session)));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    var layout = new layoutData(context);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Scaffold(
          key: _scaffoldKey,
          body: Container(
            width: double.infinity,
            height: layout.getHeight() * 100,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: layout.getHeight() * 5),
                      child: Container(
                        width: layout.getWidth() * 25,
                        height: layout.getWidth() * 25,
                        // child: Image.asset("assets/Logo.png"),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            top: layout.getHeight() * 2,
                            left: layout.getHeight() * 2,
                            right: layout.getHeight() * 2),
                        child: Container(
                          width: layout.getWidth() * 80,
                          height: layout.getHeight() * 5,
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: layout.getHeight() * 4,
                                fontFamily: layout.fontFamily(type: "Header"),
                                color: Theme.of(context).primaryColor),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            top: layout.getHeight() * 1,
                            left: layout.getHeight() * 1,
                            right: layout.getHeight() * 1),
                        child: Container(
                          width: layout.getWidth() * 80,
                          height: layout.getHeight() * 10,
                          // color: Colors.amber,
                          child: TextField(
                            controller: _kodeUser,
                            decoration: InputDecoration(
                                icon: Icon(Icons.person,
                                    size: 32,
                                    color: Theme.of(context).primaryColor),
                                labelText: "Email",
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                            onTap: () {
                              _ratio = 3.5;
                            },
                            onSubmitted: (_) {
                              _ratio = 2;
                            },
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(
                            left: layout.getHeight() * 1,
                            right: layout.getHeight() * 1),
                        child: Container(
                          width: layout.getWidth() * 80,
                          height: layout.getHeight() * 10,
                          // color: Colors.amber,
                          child: TextField(
                            obscureText: true,
                            controller: _password,
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock,
                                    size: 32,
                                    color: Theme.of(context).primaryColor),
                                labelText: "Password",
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor)),
                            onTap: () {
                              _ratio = 3.5;
                            },
                            onSubmitted: (_) {
                              _ratio = 2;
                            },
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: layout.getHeight() * 1,
                          right: layout.getHeight() * 1),
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          width: layout.getWidth() * 80,
                          height: layout.getHeight() * 6,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                        ),
                        onTap: () async {
                          showLoadingDialog(context, _keyLoader,
                              info: "Begin Login");
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> Register() ),);
                          var logindata = new AuthModels(_session);
                          Map Parameter() {
                            return {
                              "email": _kodeUser.text,
                              "password": _password.text
                            };
                          }

                          logindata.login(Parameter()).then((value) {
                            print(value);
                            if (value["success"].toString() == "true") {
                              print("Simpan Object, Masuk Halaman Selanjutnya");
                              // print(value);
                              savePrev(value["data"]["id"].toString() +
                                  "|" +
                                  value["data"]["name"].toString() +
                                  "|" +
                                  value["data"]["email"].toString() +
                                  "|" +
                                  value["data"]["RecordOwnerID"].toString());

                              setState(() {
                                _session.KodeUser =
                                    value["data"]["id"].toString();
                                _session.NamaUser =
                                    value["data"]["name"].toString();
                                _session.Email =
                                    value["data"]["email"].toString();
                                _session.RecordOwnerID =
                                    value["data"]["RecordOwnerID"].toString();
                              });
                              Navigator.of(context, rootNavigator: true).pop();

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomePage(_session)));
                            } else {
                              print("Error : " +
                                  value["nError"].toString() +
                                  " : " +
                                  value["sError"]);
                              Navigator.of(context, rootNavigator: true).pop();

                              messageBox(
                                  context: context,
                                  title: "Error",
                                  message: value["nError"].toString() +
                                      " : " +
                                      value["sError"]);
                            }
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: layout.getHeight() * 1,
                          left: layout.getHeight() * 1,
                          right: layout.getHeight() * 1),
                      child: Text("- OR -"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: layout.getHeight() * 1,
                          left: layout.getHeight() * 1,
                          right: layout.getHeight() * 1),
                      child: GestureDetector(
                        child: Container(
                          padding: EdgeInsets.all(12),
                          width: layout.getWidth() * 80,
                          height: layout.getHeight() * 6,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor,
                                width: 1.0),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=> Register() ),);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>BlocProvider(create: (context)=>SignUpBloc(), child: RegisterView(),)));
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
