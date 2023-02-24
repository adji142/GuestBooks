import 'package:flutter/animation.dart';

abstract class SignUpState{}

class SignUpInitialState extends SignUpState{}

class SignUpInvalidState extends SignUpState{}

class SignUpValidState extends SignUpState{}

class SignUpDefaultState extends SignUpState{
  final String EmailerrorMessage;
  final String PhoneerrorMessage;
  final String PassworderrorMessage;
  final String rePassworderrorMessage;
  final String pwdVisibility;
  final String NikerroMessage;
  final String Koordinat;
  final String Alamat;
  final String ErrorMessage;
  SignUpDefaultState({this.EmailerrorMessage = "",this.PhoneerrorMessage = "", this.PassworderrorMessage="",this.rePassworderrorMessage = "", this.pwdVisibility = "0", this.NikerroMessage = "", this.Koordinat = "", this.Alamat = "", this.ErrorMessage=""});
}

class SignUpLoadingState extends SignUpState{}

class SignUpMapLocationState extends SignUpState{
  final String Koordinat;
  SignUpMapLocationState({this.Koordinat=""});
}

class SignUpDemografi extends SignUpState{
  final String id;
  final String title;

  SignUpDemografi({this.id="",this.title=""});
}