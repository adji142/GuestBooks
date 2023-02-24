
import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guestbook/auth/register_block/register_event.dart';
import 'package:guestbook/auth/register_block/register_state.dart';

String _CurentAddr = "";
Position? _currentPosition;
class SignUpBloc extends Bloc<SignUpEvent, SignUpState>{
  SignUpBloc() : super(SignUpInitialState()){
    on<SignUpTextChangedEvent>((event, emit) async{
      
      switch (event.field) {
        case "email":
          if(event.data == ""){
            emit(SignUpDefaultState(EmailerrorMessage: "Email Harus diisi"));
          }
          else if(!checkEmail(event.data)){
            emit(SignUpDefaultState(EmailerrorMessage: "Email Tidak Valid"));
          }
          else{
            emit(SignUpValidState());
          }
          break;
        case "password":
          var listofPassword = event.data.toString().split("|");

          if(listofPassword.length == 0){
            emit(SignUpDefaultState(PassworderrorMessage: "Password Harus diisi"));
          }
          else if(!isPasswordCompliant(listofPassword[0])){
            emit(SignUpDefaultState(PassworderrorMessage: "Password Tidak Valid", pwdVisibility: listofPassword[1]));
          }
          else{
            emit(SignUpValidState());
            emit(SignUpDefaultState(PassworderrorMessage: "", pwdVisibility: "0"));
          }
          break;
        case "repassword":
          var listofPassword = event.data.toString().split("|");

          if(listofPassword.length == 0){
            emit(SignUpDefaultState(rePassworderrorMessage: "Password Harus diisi"));
          }
          else if(!isPasswordCompliant(listofPassword[1])){
            emit(SignUpDefaultState(rePassworderrorMessage: "Password Tidak Valid", pwdVisibility: listofPassword[2]));
          }
          else if(listofPassword[0] != listofPassword[1]){
            emit(SignUpDefaultState(rePassworderrorMessage: "Password Tidak Sama", pwdVisibility: listofPassword[2]));
          }
          else{
            emit(SignUpValidState());
            emit(SignUpDefaultState(rePassworderrorMessage: "", pwdVisibility: "0"));
          }
          break;
        case "phone":
          if(event.data == ""){
            emit(SignUpDefaultState(PhoneerrorMessage: "No Hp Harus diisi"));
          }
          else{
            emit(SignUpValidState());
          }
          break;
        case "pwdvisibility":
          if(event.data == "1"){
            emit(SignUpDefaultState(pwdVisibility: "0"));
          }
          else if(event.data == "0"){
            emit(SignUpDefaultState(pwdVisibility: "1"));
          }
          break;
        // case "koordinat":
        //   final _requestAccess = await _handleLocationPermission();
        //   _getCurrentPosition();
        //   emit(SignUpDefaultState(Alamat: _CurentAddr));
        //   // _CurentAddr = await _getCurrentPosition();
        //   break;
      }
    });

    on<SignUpSubmitedEvent>((event, emit) {
      emit(SignUpLoadingState());
    });

    on<SignUpMapGetCurentLocationEvent>((event, emit) async{
      final _requestAccess = await _handleLocationPermission();
      _getCurrentPosition();
      // emit(SignUpDefaultState(Alamat: _CurentAddr));
      emit(SignUpMapLocationState(Koordinat: _CurentAddr));
    });

    on<demProfinsiEvent>((event, emit) async{
      
    });

  }
}

bool checkEmail(String email){
  bool valid = false;
  // if(RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(email)){
  if(RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(email)){

    valid = true;
  }
  else{
    valid = false;
  }

  return valid;
}

bool isPasswordCompliant(String password, [int minLength = 6]) {
  if (password == null || password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
  bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  return hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters & hasMinLength;
}
Future<String> _handleLocationPermission() async{
  // return true;
  bool serviceEnable;
  LocationPermission permission;

  serviceEnable = await Geolocator.isLocationServiceEnabled();

  if (!serviceEnable) {
    return "Location services are disabled. Please enable the services";
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return "Location permissions are denied";
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return "Location permissions are permanently denied, we cannot request permissions.";
  }
  return "OK";
}


Future<void> _getCurrentPosition() async {
  final hasPermission = await _handleLocationPermission();

  if (hasPermission != "OK") return;
  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
    _currentPosition = position;
    _getAddressFromLatLng(_currentPosition!);
  }).catchError((e) {
    // debugPrint(e);
    print(e);
  });
}

Future<void> _getAddressFromLatLng(Position position) async {
  await placemarkFromCoordinates(_currentPosition!.latitude, _currentPosition!.longitude).then((List<Placemark> placemarks) {
    Placemark place = placemarks[0];
    _CurentAddr ='${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
  }).catchError((e) {
    print(e);
  });
}