import 'package:flutter/material.dart';
import 'package:guestbook/shared/session.dart';
import 'dart:io' show Platform;

class layoutData{
  final BuildContext context;
  layoutData(this.context);

  double getWidth(){
    return MediaQuery.of(context).size.width / 100;
  }

  double getHeight(){
    return MediaQuery.of(context).size.height / 100;
  }

  Orientation getOrientation(){
    return MediaQuery.of(context).orientation;
  }

  String fontFamily({String? type}){
    switch(type) { 
      case "Header": { 
        return "Arial Black";
      } 
      break;
      case "Body": { 
        return "Arial";
      } 
      break;
      case "Deskripsi": { 
        return "Arial";
      } 
      break;
      default: { 
        return "Arial Black";
      }
      break; 
    } 
  }

  String getPlatform(){
    String setPlatform = "";
    if(Platform.isAndroid){
      setPlatform = "Android";
    }
    else if(Platform.isIOS){
      setPlatform = "IoS";
    }
    else if(Platform.isWindows && Platform.isLinux && Platform.isMacOS){
      setPlatform = "Dekstop";
    }
    else{
      setPlatform = "Undefinded";
    }
    return setPlatform;
  }
}