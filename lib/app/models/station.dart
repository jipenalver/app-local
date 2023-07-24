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
    const data = [
      // Butuan City
      {
        "name": "Butuan City Police Office - PIO",
        "address": "Malvar Circle, Brgy. Holy Redeemer, Butuan City",
        "avatar": "assets/images/station1.png",
        "number": "+639985987292",
        "lat": "8.954789",
        "long": "125.531242",
        "distance": 0.0,
      },
      {
        "name": "Butuan City Police Station 1",
        "address": "JC Aquino Ave., AD Curato St. Butuan City",
        "avatar": "assets/images/station3.png",
        "number": "+639985987293",
        "lat": "8.9470874",
        "long": "125.5431909",
        "distance": 0.0,
      },
      {
        "name": "Butuan City Police Station 2",
        "address": "J. Satorre St., Butuan City",
        "avatar": "assets/images/station4.png",
        "number": "+639985987295",
        "lat": "8.958457",
        "long": "125.534016",
        "distance": 0.0,
      },
      {
        "name": "Butuan City Police Station 3",
        "address": "Bayanihan, Butuan City",
        "avatar": "assets/images/station5.png",
        "number": "+639985987297",
        "lat": "8.9404688",
        "long": "125.5245282",
        "distance": 0.0,
      },
      {
        "name": "Butuan City Police Station 4",
        "address": "P-3B, Ampayon, Butuan City",
        "avatar": "assets/images/station6.png",
        "number": "+639985987299",
        "lat": "8.957057",
        "long": "125.605488",
        "distance": 0.0,
      },
      {
        "name": "Butuan City Police Station 5",
        "address": "San Mateo, Butuan City",
        "avatar": "assets/images/station7.png",
        "number": "+639985987301",
        "lat": "8.784832",
        "long": "125.563433",
        "distance": 0.0,
      },

      // Agusan del Norte
      {
        "name": "Agusan del Norte Police Provincial Office",
        "address": "Camp Col Rafael C Rodriguez, Libertad, Butuan City",
        "avatar": "assets/images/station8.png",
        "number": "+639985987274",
        "lat": "8.9448895",
        "long": "125.50496",
        "distance": 0.0,
      },
      {
        "name": "Agusan del Norte 1st Provincial Mobile Force Company",
        "address": "D-4, Brgy. Camagong, Nasipit, Agusan del Norte",
        "avatar": "assets/images/station9.jpg",
        "number": "+639173058809",
        "lat": "8.968323",
        "long": "125.331467",
        "distance": 0.0,
      },
      {
        "name": "Agusan del Norte 2nd Provincial Mobile Force Company",
        "address": "P-3, Brgy. Doña Rosario, Tubay, Agusan del Norte",
        "avatar": "assets/images/station10.jpg",
        "number": "+639463445783",
        "lat": "9.1599066",
        "long": "125.5606697",
        "distance": 0.0,
      },
      {
        "name": "Cabadbaran City Police Station",
        "address": "P-3, Poblacion 9, Cabadbaran City, Agusan del Norte",
        "avatar": "assets/images/station11.jpg",
        "number": "+639985987278",
        "lat": "9.121962",
        "long": "125.545208",
        "distance": 0.0,
      },
      {
        "name": "Buenavista Municipal Police Station",
        "address": "P-4, Poblacion 3, Buenavista, Agusan del Norte",
        "avatar": "assets/images/station12.jpg",
        "number": "+639100904515",
        "lat": "8.97643266184839",
        "long": "125.404375752616",
        "distance": 0.0,
      },
      {
        "name": "Carmen Municipal Police Station",
        "address":
            "District Cabatuan, Brgy. Poblacion, Carmen, Agusan del Norte",
        "avatar": "assets/images/station13.jpg",
        "number": "+639985987279",
        "lat": "8.9902865",
        "long": "125.2960624",
        "distance": 0.0,
      },
      {
        "name": "Jabonga Municipal Police Station",
        "address": "P-1, Brgy. Poblacion, Jabonga, Agusan del Norte",
        "avatar": "assets/images/station14.jpg",
        "number": "+639985987230",
        "lat": "9.340793",
        "long": "125.51642",
        "distance": 0.0,
      },
      {
        "name": "Kitcharao Municipal Police Station",
        "address": "P-6, Brgy. Songkoy, Kitcharao, Agusan del Norte",
        "avatar": "assets/images/station15.jpg",
        "number": "+639999962071",
        "lat": "9.4527574",
        "long": "125.5714127",
        "distance": 0.0,
      },
      {
        "name": "Las Nieves Municipal Police Station",
        "address": "P-5, Poblacion, Las Nieves, Agusan del Norte",
        "avatar": "assets/images/station16.jpg",
        "number": "+639088108630",
        "lat": "8.7361",
        "long": "125.6007",
        "distance": 0.0,
      },
      {
        "name": "Magallanes Municipal Police Station",
        "address": "P-1, Brgy. Marcos, Magallanes, Agusan del Norte",
        "avatar": "assets/images/station17.jpg",
        "number": "+639985987283",
        "lat": "9.0268",
        "long": "125.5193",
        "distance": 0.0,
      },
      {
        "name": "Nasipit Municipal Police Station",
        "address": "Poblacion 4, Nasipit, Agusan del Norte",
        "avatar": "assets/images/station18.jpg",
        "number": "+639985590530",
        "lat": "8.987683",
        "long": "125.341242",
        "distance": 0.0,
      },
      {
        "name": "Remedios Trinidad Romualdez Municipal Police Station",
        "address": "P-6, Poblacion 1, RTR, Agusan del Norte",
        "avatar": "assets/images/station19.jpg",
        "number": "+639512398906",
        "lat": "9.0536",
        "long": "125.5853",
        "distance": 0.0,
      },
      {
        "name": "Santiago Municipal Police Station",
        "address":
            "Sweethome Village, P-10, Poblacion 1, Santiago, Agusan del Norte",
        "avatar": "assets/images/station20.jpg",
        "number": "+639985604669",
        "lat": "9.262462",
        "long": "125.553555",
        "distance": 0.0,
      },
      {
        "name": "Tubay Municipal Police Station",
        "address": "Lungsod Daan, Poblacion 2, Tubay, Agusan del Norte",
        "avatar": "assets/images/station21.jpg",
        "number": "+639385401158",
        "lat": "9.1694",
        "long": "125.5294",
        "distance": 0.0,
      },

      // Caraga RFMB
      {
        "name": "Butuan City Mobile Force Company",
        "address": "J.C Aquino Ave Cor., AD Curato St, Butuan City",
        "avatar": "assets/images/station2.png",
        "number": "+639302970041",
        "lat": "8.9472",
        "long": "125.5429",
        "distance": 0.0,
      },
      {
        "name": "1301st Maneuver Company, RMFB13",
        "address": "Sitio Cutlog, Brgy. Bahi, Barobo, Surigao del Sur",
        "avatar": "assets/images/station-rfmb-1.jpg",
        "number": "+639485160950",
        "lat": "8.502",
        "long": "126.0393",
        "distance": 0.0,
      },
      {
        "name": "1302nd Maneuver Company, RMFB13",
        "address": "P-4, Brgy. Adlay, Carrascal, Surigao del Sur",
        "avatar": "assets/images/station-rfmb-2.jpg",
        "number": "+639304684011",
        "lat": "9.415",
        "long": "125.8897",
        "distance": 0.0,
      },
      {
        "name": "1303rd Maneuver Company, RMFB13",
        "address": "Sitio Masapia, Brgy. Consuelo, Bunawan, Agusan del Sur",
        "avatar": "assets/images/station-rfmb-3.jpg",
        "number": "+639381192736",
        "lat": "8.234782",
        "long": "125.994364",
        "distance": 0.0,
      },

      // Surigao del Norte
      {
        "name": "Surigao del Norte Police Provincial Office",
        "address": "Borromeo St., Brgy. Taft, Surigao City, Surigao del Norte",
        "avatar": "assets/images/station-sdn-1.jpg",
        "number": "+639985398568",
        "lat": "9.787798",
        "long": "125.497474",
        "distance": 0.0,
      },
      {
        "name": "Alegria Municipal Police Station",
        "address": "Alegria, Surigao del Norte",
        "avatar": "assets/images/station-sdn-2.jpg",
        "number": "+639985987330",
        "lat": "9.46335",
        "long": "125.574972",
        "distance": 0.0,
      },
      {
        "name": "Bacuag Municipal Police Station",
        "address": "Brgy. Poblacion, Bacuag, Surigao del Norte",
        "avatar": "assets/images/station-sdn-3.jpg",
        "number": "+639985987331",
        "lat": "9.6085947",
        "long": "125.6403369",
        "distance": 0.0,
      },
      {
        "name": "Claver Municipal Police Station",
        "address": "Brgy. Tayaga, Claver, Surigao del Norte",
        "avatar": "assets/images/station-sdn-4.jpg",
        "number": "+639985987334",
        "lat": "9.5742",
        "long": "125.735",
        "distance": 0.0,
      },
      {
        "name": "Gigaquit Municipal Police Station",
        "address": "P-5, Brgy. Ipil, Gigaquit, Surigao del Norte",
        "avatar": "assets/images/station-sdn-5.jpg",
        "number": "+639985987339",
        "lat": "9.59",
        "long": "125.6968",
        "distance": 0.0,
      },
      {
        "name": "Mainit Municipal Police Station",
        "address": "Brgy. Magsaysay, Mainit, Surigao del Norte",
        "avatar": "assets/images/station-sdn-6.jpg",
        "number": "+639985987340",
        "lat": "9.5403",
        "long": "125.5239",
        "distance": 0.0,
      },
      {
        "name": "Malimono Municipal Police Station",
        "address": "Brgy. San Isidro, Malimono, Surigao del Norte",
        "avatar": "assets/images/station-sdn-7.jpg",
        "number": "+639985987341",
        "lat": "9.6187951",
        "long": "125.401992",
        "distance": 0.0,
      },
      {
        "name": "Placer Municipal Police Station",
        "address": "Brgy. Central, Placer, Surigao del Norte",
        "avatar": "assets/images/station-sdn-8.jpg",
        "number": "+639985987343",
        "lat": "9.6582027",
        "long": "125.6017523",
        "distance": 0.0,
      },
      {
        "name": "San Francisco Municipal Police Station",
        "address": "Brgy. Poblacion, San Francisco, Surigao del Norte",
        "avatar": "assets/images/station-sdn-9.jpg",
        "number": "+639985987345",
        "lat": "9.706882",
        "long": "125.3963595",
        "distance": 0.0,
      },
      {
        "name": "Sison Municipal Police Station",
        "address": "P-5, Brgy. San Pedro, Sison, Surigao del Norte",
        "avatar": "assets/images/station-sdn-10.jpg",
        "number": "+639985987347",
        "lat": "9.657656",
        "long": "125.528617",
        "distance": 0.0,
      },
      {
        "name": "Tagana-an Municipal Police Station",
        "address": "Tagana-an, Surigao del Norte",
        "avatar": "assets/images/station-sdn-11.jpg",
        "number": "+639985987350",
        "lat": "9.7006974",
        "long": "125.5846473",
        "distance": 0.0,
      },
      {
        "name": "Tubod Municipal Police Station",
        "address": "Tubod, Surigao del Norte",
        "avatar": "assets/images/station-sdn-12.jpg",
        "number": "+639688536155",
        "lat": "9.5533642",
        "long": "125.5692835",
        "distance": 0.0,
      },
      {
        "name": "Burgos Municipal Police Station",
        "address": "P-Kalamansi, Brgy. Poblacion 2, Burgos, Surigao del Norte",
        "avatar": "assets/images/station-sdn-13.jpg",
        "number": "+639951999238",
        "lat": "10.020801",
        "long": "126.067666",
        "distance": 0.0,
      },
      // Dinagat Island
      {
        "name": "Basilisa Municipal Police Station",
        "address": "P-4, Brgy. Ferdinand, Basilisa, Dinagat Islands",
        "avatar": "assets/images/station-di-1.jpg",
        "number": "+639951994164",
        "lat": "10.063304",
        "long": "125.598385",
        "distance": 0.0,
      },
      {
        "name": "Cagdianao Municipal Police Station",
        "address": "P-3, Brgy. Poblacion, Cagdianao, Dinagat Islands",
        "avatar": "assets/images/station-di-2.jpg",
        "number": "+639478923819",
        "lat": "9.951275",
        "long": "125.631035",
        "distance": 0.0,
      },
      {
        "name": "Dinagat Municipal Police Station",
        "address": "Brgy. New Mabuhay, Dinagat, Dinagat Islands",
        "avatar": "assets/images/station-di-3.jpg",
        "number": "+639989674864",
        "lat": "9.954622",
        "long": "125.598924",
        "distance": 0.0,
      },
      {
        "name": "Libjo Municipal Police Station",
        "address": "P-5, Brgy. Albor, Libjo, Dinagat Islands",
        "avatar": "assets/images/station-di-4.jpg",
        "number": "+639478923826",
        "lat": "10.193101",
        "long": "125.529726",
        "distance": 0.0,
      },
      {
        "name": "Loreto Municipal Police Station",
        "address": "P-4, Brgy. Carmen, Loreto, Dinagat Islands",
        "avatar": "assets/images/station-di-5.jpg",
        "number": "+639478923824",
        "lat": "10.356047",
        "long": "125.576634",
        "distance": 0.0,
      },
      {
        "name": "San Jose Municipal Police Station",
        "address": "P-2, Brgy. Don Ruben, San Jose, Dinagat Islands",
        "avatar": "assets/images/station-di-6.jpg",
        "number": "+639989674868",
        "lat": "10.015043",
        "long": "125.573243",
        "distance": 0.0,
      },
      {
        "name": "Tubajon Municipal Police Station",
        "address": "P-4, Brgy. San Vicente, Tubajon, Dinagat Islands",
        "avatar": "assets/images/station-di-7.jpg",
        "number": "+639630733611",
        "lat": "10.327116",
        "long": "125.560472",
        "distance": 0.0,
      },
      {
        "name": "Dinagat Islands PMFP Police Community Affairs Development",
        "address": "P-4, Brgy. Sta. Cruz, San Jose, Dinagat Islands",
        "avatar": "assets/images/station-di-8.jpg",
        "number": "+639985988251",
        "lat": "10.0228003",
        "long": "125.597183",
        "distance": 0.0,
      },
    ];
    return data.map<Station>(Station.fromJson).toList();
  }
}
