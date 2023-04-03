class Station {
  final String name;
  final String address;
  final String avatar;
  final String number;
  final String lat;
  final String long;

  const Station({
    required this.name,
    required this.address,
    required this.avatar,
    required this.number,
    required this.lat,
    required this.long,
  });

  static Station fromJson(json) => Station(
        name: json['name'],
        address: json['address'],
        avatar: json['avatar'],
        number: json['number'],
        lat: json['lat'],
        long: json['long'],
      );

  static List<Station> getStations() {
    const data = [
      {
        "name": "Agusan del Norte Police Provincial Office",
        "address": "Camp Col Rafael C Rodriguez, Libertad, Butuan City",
        "avatar": "assets/station8.png",
        "number": "+639985987274",
        "lat": "8.9448895",
        "long": "125.50496",
      },
      {
        "name": "Butuan City Police Office - PIO",
        "address": "Malvar Circle, Brgy. Holy Redeemer, Butuan City",
        "avatar": "assets/station1.png",
        "number": "+639985987292",
        "lat": "8.954789",
        "long": "125.531242",
      },
      {
        "name": "Butuan City Mobile Force Company",
        "address": "J.C Aquino Ave Cor., AD Curato St, Butuan City",
        "avatar": "assets/station2.png",
        "number": "+639302970041",
        "lat": "8.9472",
        "long": "125.5429",
      },
      {
        "name": "Butuan City Police Station 1",
        "address": "JC Aquino Ave., AD Curato St. Butuan City",
        "avatar": "assets/station3.png",
        "number": "+639985987293",
        "lat": "8.9470874",
        "long": "125.5431909",
      },
      {
        "name": "Butuan City Police Station 2",
        "address": "J. Satorre St., Butuan City",
        "avatar": "assets/station4.png",
        "number": "+639985987295",
        "lat": "8.958457",
        "long": "125.534016",
      },
      {
        "name": "Butuan City Police Station 3",
        "address": "Bayanihan, Butuan City",
        "avatar": "assets/station5.png",
        "number": "+639985987297",
        "lat": "8.9404688",
        "long": "125.5245282",
      },
      {
        "name": "Butuan City Police Office Station 4",
        "address": "P-3B, Ampayon, Butuan City",
        "avatar": "assets/station6.png",
        "number": "+639985987299",
        "lat": "8.957057",
        "long": "125.605488",
      },
      {
        "name": "Butuan City Police Station 5",
        "address": "San Mateo, Butuan City",
        "avatar": "assets/station7.png",
        "number": "+639985987301",
        "lat": "8.784832",
        "long": "125.563433",
      },
    ];
    return data.map<Station>(Station.fromJson).toList();
  }
}
