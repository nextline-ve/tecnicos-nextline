import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:web_socket_channel/io.dart';
import 'package:workmanager/workmanager.dart';

class GeolocationBackground {
  final Geolocator geo = Geolocator();

  final technicianId;
  IOWebSocketChannel channel;
  Future<Position> getCurrentLocation() async {
    return await geo.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }


  GeolocationBackground({this.technicianId}) {
    channel = IOWebSocketChannel.connect(
        'wss://nextline.jaspesoft.com/ws/tecnico/${this.technicianId}/'
    );
    Workmanager.initialize(
        realTimeLocation(), // The top level function, aka callbackDispatcher
        isInDebugMode: true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
    );
  }

  realTimeLocation() {
    // ignore: cancel_subscriptions
    Geolocator()
        .getPositionStream(
            LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1))
        .listen((Position position) {
      // AQUI VAMOS AGREGAR LA INSTANCIA DEL SOCKET CLIENTE QUE SE CONECTA CON EL ADMIN
      // EN LA APP DE TECNICOS

      this.channel.sink.add({
        "tecnicoId": this.technicianId,
        "latitud": position.latitude,
        "logitud": position.longitude
      });

      print(position == null
          ? 'Unknown'
          : position.latitude.toString() +
              ', ' +
              position.longitude.toString());
    });
  }
}
