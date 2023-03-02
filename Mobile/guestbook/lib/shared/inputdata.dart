import 'dart:ffi';

import 'package:flutter/material.dart';

Future inputNumeric({required  context, String title="Input Data", String label="", String description = "",required int data,String uom=""}) async {

    TextEditingController _input = TextEditingController();

    _input.text= data == 0.0 ? "" : data.toString();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(5),
          contentPadding: EdgeInsets.fromLTRB(1, 15, 1, 15),
          title: Container(
              width: double.infinity,
              height: 30,
              color: Theme.of(context).primaryColorDark,
              child: Center(child: Text(title, style: TextStyle(color: Theme.of(context).primaryColorLight),))
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField( 
                      autofocus: true,
                      controller: _input,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          suffixText: uom,                          
                          suffixStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold, fontSize: 18),
                          labelText: "$label",
                          labelStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Text(description, style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColorDark),),
                  )

              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Proses'),
              onPressed: () {
                Navigator.of(context).pop(int.parse(_input.text));
              },
            ),
            ElevatedButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
          ],
        );
      },
    );
 }

 Future inputNumericEx({required BuildContext context, String title="Input Data", String label="", String labelEx="", String description = "",required int data, String uom=""}) async {

    TextEditingController _input = TextEditingController();
    TextEditingController _inputEx = TextEditingController();

    _input.text = data == 0.0 ? "" : data.toString();

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(5),
          contentPadding: EdgeInsets.fromLTRB(1, 15, 1, 15),
          title: Container(
              width: double.infinity,
              height: 30,
              color: Theme.of(context).primaryColorDark,
              child: Center(child: Text(title, style: TextStyle(color: Theme.of(context).primaryColorLight),))
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField( 
                      autofocus: true,
                      controller: _input,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          suffixText: uom,                          
                          suffixStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold, fontSize: 18),
                          labelText: "$label",
                          labelStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Text(description, style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColorDark),),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField( 
                      controller: _inputEx,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "$labelEx",
                          labelStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),

              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Proses'),
              onPressed: () {
                Navigator.of(context).pop(
                  {
                    "data": double.parse(_input.text),
                    "dataEx" : _inputEx.text
                  }
                );  
              },
            ),
            ElevatedButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
          ],
        );
      },
    );
 }

 Future inputString({required BuildContext context, String title="Input Data", String label="", String description = "",required String data, int maxlen = 1}) async {

    TextEditingController _input = TextEditingController();

    _input.text= data == "-" ? "" : data;

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(5),
          contentPadding: EdgeInsets.fromLTRB(1, 15, 1, 15),
          title: Container(
              width: double.infinity,
              height: 30,
              color: Theme.of(context).primaryColorDark,
              child: Center(child: Text(title, style: TextStyle(color: Colors.white),))
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextField( 
                      autofocus: true,
                      controller: _input,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.newline,
                      maxLines: maxlen,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          labelText: "$label",
                          labelStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Text(description, style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColorDark),),
                  )

              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Proses'),
              onPressed: () {
                Navigator.of(context).pop(_input.text);
              },
            ),
            ElevatedButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(null);
              },
            ),
          ],
        );
      },
    );
 }

 class InputDaftarTimbang extends StatefulWidget {
   final String title;
   final String uom;
   final List data;
   final double min;
   final double max;

   InputDaftarTimbang({this.title="-",required this.data,required  this.min,required this.max, this.uom=""});

   @override
   _InputDaftarTimbangState createState() => _InputDaftarTimbangState();
 }
 
 class _InputDaftarTimbangState extends State<InputDaftarTimbang> {

   List<TextEditingController> _data = <TextEditingController>[];
   List<bool> _status = <bool>[];

   int _selectCount = 0;

   @override
   void initState() {

    for(int row=0; row < widget.data.length;row++) {
      _data.add(TextEditingController());
      _data[row].text= widget.data[row]["value"] == 0 ? '' : widget.data[row]["value"].toString();
      _status.add(widget.data[row]["status"]);     
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

   @override
   Widget build(BuildContext context) {

     print("REBUILD");

     _selectCount = 0;
     for(int row=0; row < _status.length;row++) {
      if(_status[row]) {
        _selectCount ++;
      }
    }

     return Scaffold(
       appBar: AppBar(
         title: Text("${widget.title}"),
         actions: <Widget>[           
           ElevatedButton( 
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              onPrimary:  Colors.white
            ),
             child: Text("Proses", style: TextStyle(color: Colors.white)),
             onPressed: () {

               List _newdata = [];
               for(int row=0; row < _data.length ;  row++) {
                 
                 if(_data[row].text=="") {
                   _data[row].text="0";
                 }

                 String _temp = '{"value":${double.parse(_data[row].text)}, "min":${widget.min}, "max":${widget.max}, "status":${_status[row]}}';
                 _newdata.add(_temp);
               }
               Navigator.pop(context, _newdata);

             },
           )
         ],
       ),

      bottomNavigationBar: new SizedBox(
        height: 55,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Center(child: Text("$_selectCount Check List", style: TextStyle(fontSize: 20, color: Colors.white)))
        ),
      ),

      
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: ListView.builder(           
           itemCount: _data.length,
           itemBuilder: (context, index) {                  
                  return ListTile(
                      leading: CircleAvatar(
                        child: Text("${index+1}")
                      ),
                      trailing: Switch( 
                        activeColor: Colors.blue,
                        value: _status[index],
                        onChanged: (v) {
                          if(_data[index].text.trim()!="" || double.parse(_data[index].text) == 0) {  
                            setState(() {
                              _status[index]=v;  
                              print("Status Changed -> $v");
                            });
                          }
                        },
                      ),
                      title: TextField(                                                                         
                          controller: _data[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(      
                            border: InputBorder.none,    
                            filled: true,       
                            fillColor: _getColorStatus(widget.min, widget.max, _data[index].text.trim() == "" ? 0 : double.parse(_data[index].text)),
                            suffixText: "${widget.uom}",
                            suffixStyle: TextStyle(color: Theme.of(context).primaryColorDark , fontSize: 20, fontWeight: FontWeight.bold)
                          ),
                          style: TextStyle(fontSize: 18),
                          onChanged: (v) {
                            setState(() {});
                          },
                        ),
                  );
           },
         )
         
       ),
     );
   }

  Color? _getColorStatus(double min, double max, double value) {
      Color? retColor = value < min && value > 0
                       ? Colors.yellow[100] : value > max 
                       ? Colors.red[100] : value == 0
                       ? Colors.grey[300] : Colors.blue[100];
      return retColor;  
  }


 }
 class InputDaftarLebarBenang extends StatefulWidget {
   final String title;
   final String uom;
   final List dataTimbang;
   final List data;
   final double min;
   final double max;

   InputDaftarLebarBenang({this.title="-",required this.dataTimbang,required this.data,required  this.min,required this.max, this.uom=""});

   @override
   _InputDaftarLebarBenangState createState() => _InputDaftarLebarBenangState();
 }
 
 class _InputDaftarLebarBenangState extends State<InputDaftarLebarBenang> {

   List<TextEditingController> _data = <TextEditingController>[];

   int _selectCount = 0;

   @override
   void initState() {

    for(int row=0; row < widget.data.length;row++) {
      _data.add(TextEditingController());
      _data[row].text= widget.data[row]["value"] == 0 ? '' : widget.data[row]["value"].toString();
    }

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

   @override
   Widget build(BuildContext context) {

     print("REBUILD");

    _selectCount = 0;
     for(int row=0; row < _data.length;row++) {
      if(_data[row].text.trim() != "" && double.parse(_data[row].text) != 00 ) {
        _selectCount ++;
      }
    }
     return Scaffold(
       appBar: AppBar(
         title: Text("${widget.title}"),
         actions: <Widget>[           
           ElevatedButton( 
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              onPrimary:  Colors.white
            ),
            //  color: Theme.of(context).primaryColor,
             child: Text("Proses", style: TextStyle(color: Colors.white)),
             onPressed: () {

               List _newdata = [];
               for(int row=0; row < _data.length ;  row++) {
                 
                 if(_data[row].text=="") {
                   _data[row].text="0";
                 }

                 String _temp = '{"value":${double.parse(_data[row].text)}, "min":${widget.min}, "max":${widget.max}, "status":false}';
                 _newdata.add(_temp);
               }
               Navigator.pop(context, _newdata);

             },
           )
         ],
       ),

      bottomNavigationBar: new SizedBox(
        height: 55,
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Center(child: Text("$_selectCount Item", style: TextStyle(fontSize: 20, color: Colors.white)))
        ),
      ),

      
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: ListView.builder(           
           itemCount: _data.length,
           itemBuilder: (context, index) {                  
                  return ListTile(
                      leading: CircleAvatar(
                        child: Text("${index+1}"),
                      ),
                      title: Container(
                        child: Row(
                          children: <Widget>[
                            //Expanded( 
                            //  flex: 1,
                            //  child: Container(
                            //    height: 47,
                            //    color: _getColorStatus(widget.dataTimbang[index]["min"], widget.dataTimbang[index]["max"], widget.dataTimbang[index]["value"]),
                            //    child: Center(child: Text("${widget.dataTimbang[index]["value"]} gr", style: TextStyle(fontSize: 18, color: widget.dataTimbang[index]["value"] == 0 ? Colors.grey[300] : Colors.black),))
                            //)),
                            //SizedBox(width: 10,),
                            Expanded(
                                flex: 2,
                                child: TextField(                                                                         
                                  controller: _data[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(      
                                    border: InputBorder.none,    
                                    filled: true,  
                                    fillColor: _getColorStatus(widget.min, widget.max, _data[index].text.trim() == "" ? 0 : double.parse(_data[index].text)),
                                    //prefixText: "Lebar :  ",
                                    //prefixStyle: TextStyle(color: Theme.of(context).primaryColorDark, fontSize: 20, fontWeight: FontWeight.bold),
                                    suffixText: "${widget.uom}",
                                    suffixStyle: TextStyle(color: Theme.of(context).primaryColorDark , fontSize: 20, fontWeight: FontWeight.bold)
                                  ),
                                  style: TextStyle(fontSize: 18),
                                  onChanged: (v) {
                                    setState(() {
                                    });
                                  },
                                ),
                            ),
                          ],
                        ),
                      ),
                  );
           },
         )
         
       ),
     );
   }

  Color ? _getColorStatus(double min, double max, double value) {
      Color ? retColor = value < min && value > 0
                       ? Colors.yellow[100] : value > max 
                       ? Colors.red[100] : value == 0
                       ? Colors.grey[300] : Colors.blue[100];
      return retColor;  
  }

 }