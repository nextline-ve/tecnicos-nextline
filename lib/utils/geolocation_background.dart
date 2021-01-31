import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class GeolocationBackground {

  final technicianId;


  GeolocationBackground({this.technicianId}) {
    this.realTimeLocation();
  }

  realTimeLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    Geolocator.getPositionStream().listen((Position position) {
      WebSocketChannel channel = IOWebSocketChannel.connect(
          'wss://panel.nextline.com.ve/ws/tecnico/${this.technicianId}/'
      );

      String jsonString = json.encode({
        "tecnicoId": this.technicianId,
        "latitud": position.latitude,
        "longitud": position.longitude
      });

      channel.sink.add(jsonString);
      channel.sink.close();

      /*print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
          ', ' +
          position.longitude.toString());*/
    });

  }
}
