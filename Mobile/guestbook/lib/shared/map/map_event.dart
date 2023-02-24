import 'package:geolocator/geolocator.dart';

abstract class MapEvent{}
class MapClickEvent extends MapEvent{
  final String test;
  MapClickEvent(this.test);
}