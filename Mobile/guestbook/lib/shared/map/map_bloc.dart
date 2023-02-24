import 'package:bloc/bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guestbook/shared/map/map_event.dart';
import 'package:guestbook/shared/map/map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState>{
  MapBloc() : super(MapInitialState()){
    on<MapClickEvent>((event, emit) {
      // print(event.test);
      emit(MapHandlePermission(koordinat: "123", fullAddress: "asdasd",errorMessage: "OK"));
    });
  }
}
// Future<String> _handleLocationPermission() async{
//   // return true;
//   bool serviceEnable;
//   LocationPermission permission;

//   serviceEnable = await Geolocator.isLocationServiceEnabled();

//   if (!serviceEnable) {
//     return "Location services are disabled. Please enable the services";
//   }

//   permission = await Geolocator.checkPermission();
//   if (permission == LocationPermission.denied) {
//     permission = await Geolocator.requestPermission();
//     if (permission == LocationPermission.denied) {
//       return "Location permissions are denied";
//     }
//   }
//   if (permission == LocationPermission.deniedForever) {
//     return "Location permissions are permanently denied, we cannot request permissions.";
//   }
//   return "OK";
// }