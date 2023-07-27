// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'utils/colors.dart';
import 'app/views/list.dart';
import 'app/views/info.dart';
import 'app/models/station.dart';
import 'app/states/main_state.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: OverlaySupport.global(
        child: MaterialApp(
          title: 'LOCAL',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorsUtil.darkMode(),
          ),
          home: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    InternetConnectionChecker().onStatusChange.listen((status) {
      final hasInternet = status == InternetConnectionStatus.connected;

      setState(() {
        showSimpleNotification(
            Text(hasInternet ? "Internet Connected" : "No Internet Connection"),
            background: hasInternet ? Colors.green : Colors.red);
      });
    });

    // ignore: unused_local_variable
    StreamSubscription<ServiceStatus> serviceStatusStream =
        Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
      setState(() {
        if (status == ServiceStatus.disabled) {
          showSimpleNotification(Text("GPS/Location is turned off"),
              background: Colors.red);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MapsPage();
        break;
      case 1:
        page = StationsPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(child: mainArea),
              SafeArea(
                top: false,
                child: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.map),
                      label: 'Map',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.security),
                      label: 'Police Stations',
                    ),
                  ],
                  currentIndex: selectedIndex,
                  onTap: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

class MapsPage extends StatelessWidget {
  final List<Station> stations = Station.getStations();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    appState.markers.clear();
    for (var element in stations) {
      appState.markers.add(
        Marker(
          point: LatLng(double.parse(element.lat), double.parse(element.long)),
          width: 42,
          height: 42,
          builder: (context) => MapMarker(element),
        ),
      );
    }
    appState.markers.add(
      Marker(
        point: LatLng(appState.lat, appState.long),
        width: 48,
        height: 48,
        builder: (context) =>
            const Image(image: AssetImage('assets/icons/ic_marker3.png')),
      ),
    );

    return Scaffold(
      body: Center(
        child: FlutterMap(
          mapController: appState.mapController,
          options: MapOptions(
            center: LatLng(appState.lat, appState.long),
            zoom: 8.7,
            maxZoom: 19.0,
          ),
          nonRotatedChildren: [
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  '© OpenStreetMap',
                  onTap: null,
                ),
              ],
            ),
          ],
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.juana_help',
            ),
            MarkerLayer(
              markers: appState.markers,
            ),
            // CurrentLocationLayer(
            //   followOnLocationUpdate: FollowOnLocationUpdate.always,
            //   turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
            //   style: LocationMarkerStyle(
            //     marker: const Image(
            //         image: AssetImage('assets/icons/ic_marker3.png')),
            //     markerSize: const Size(40, 40),
            //     markerDirection: MarkerDirection.heading,
            //   ),
            // )
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: "fab1",
            onPressed: () {
              appState.setMarker();
              appState.checkLocation();
              appState.liveLocation();
            },
            child: const Icon(Icons.gps_fixed_outlined),
          ),
          SizedBox(height: 10),
          FloatingActionButton.small(
            heroTag: "fab2",
            onPressed: () {
              appState.setMarker();

              if (appState.checkLocation()) {
                var lat = appState.lat;
                var long = appState.long;
                String googleUrl =
                    'https://www.google.com/maps/search/?api=1&query=$lat,$long';
                launchUrlString(googleUrl);
              }
            },
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child:
                    const Image(image: AssetImage('assets/icons/ic_gmap.png'))),
          ),
          SizedBox(height: 10),
          FloatingActionButton.small(
            heroTag: "fab3",
            onPressed: () {
              appState.setMarker();

              if (appState.checkLocation()) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListPage(
                        scheme: 'sms',
                        lat: appState.lat,
                        long: appState.long)));
              }
            },
            child: const Icon(Icons.message_outlined),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "fab4",
            backgroundColor: Color(ColorsUtil.mainBtn),
            onPressed: () {
              appState.setMarker();

              if (appState.checkLocation()) {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ListPage(
                        scheme: 'tel',
                        lat: appState.lat,
                        long: appState.long)));
              }
            },
            child: const Icon(Icons.call_outlined),
          ),
        ],
      ),
    );
  }
}

class MapMarker extends StatefulWidget {
  final Station element;

  MapMarker(this.element);

  @override
  State<MapMarker> createState() => _MapMarkerState();
}

class _MapMarkerState extends State<MapMarker> {
  final key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final dynamic tooltip = key.currentState;
        tooltip.ensureTooltipVisible();
      },
      child: Tooltip(
        key: key,
        message: '${widget.element.name} \n ${widget.element.address}',
        textAlign: TextAlign.center,
        textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Color(ColorsUtil.surface)),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Image(image: AssetImage('assets/icons/ic_police.png')),
      ),
    );
  }
}

class StationsPage extends StatelessWidget {
  final List<Station> stations = Station.getStations();

  @override
  Widget build(BuildContext context) {
    stations.sort((a, b) => a.name.compareTo(b.name));

    return Scaffold(
      appBar: AppBar(
        leading: Image(image: AssetImage('assets/icons/ic_pnp-small.png')),
        title: const Text('CARAGA Police Stations',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(ColorsUtil.appBar))),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final station = stations[index];

          return Card(
              child: ListTile(
                  leading: CircleAvatar(
                      radius: 28, backgroundImage: AssetImage(station.avatar)),
                  title: Text(station.name),
                  subtitle: Text('${station.address} \n(${station.number})',
                      style: TextStyle(color: Color(ColorsUtil.subtitle))),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => InfoPage(station: station)));
                  }));
        },
      ),
    );
  }
}
