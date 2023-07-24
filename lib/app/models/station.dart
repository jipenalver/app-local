import 'stations/butuan.dart';
import 'stations/adn.dart';
import 'stations/ads.dart';
import 'stations/sdn.dart';
import 'stations/sds.dart';
import 'stations/dinagat.dart';
import 'stations/mobile.dart';

class Station {
  final String name;
  final String address;
  final String avatar;
  final String number;
  final String lat;
  final String long;
  double distance;

  Station(
      {required this.name,
      required this.address,
      required this.avatar,
      required this.number,
      required this.lat,
      required this.long,
      required this.distance});

  static Station fromJson(json) => Station(
        name: json['name'],
        address: json['address'],
        avatar: json['avatar'],
        number: json['number'],
        lat: json['lat'],
        long: json['long'],
        distance: json['distance'],
      );

  static List<Station> getStations() {
    var data = [
      ...Butuan.data,
      ...Adn.data,
      ...Ads.data,
      ...Sdn.data,
      ...Sds.data,
      ...Dinagat.data,
      ...Mobile.data,
    ];
    return data.map<Station>(Station.fromJson).toList();
  }
}
