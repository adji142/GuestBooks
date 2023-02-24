import 'package:geolocator/geolocator.dart';

abstract class MapState{}

class MapInitialState extends MapState{}

class MapHandlePermission extends MapState{
  final String koordinat;
  final String fullAddress;
  final String errorMessage;
  
  MapHandlePermission({this.koordinat="", this.fullAddress="",this.errorMessage=""});
}
class MapGetCurrentPosition extends MapState{
  
}
class MapGetAddress extends MapState{

}