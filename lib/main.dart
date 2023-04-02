// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'list.dart';
import 'info.dart';
import 'models/station.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher_string.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Juana Help',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final mapController = MapController();

  void setMapCenter() {
    mapController.move(LatLng(8.955458, 125.59715), 18);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

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
  final List<Marker> markers = [];

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    for (var element in stations) {
      markers.add(
        Marker(
          point: LatLng(double.parse(element.lat), double.parse(element.long)),
          width: 48,
          height: 48,
          builder: (context) =>
              const Image(image: AssetImage('assets/police.png')),
        ),
      );
    }
    markers.add(
      Marker(
        point: LatLng(8.955458, 125.59715),
        width: 48,
        height: 48,
        builder: (context) =>
            const Image(image: AssetImage('assets/marker.png')),
      ),
    );

    return Scaffold(
      body: Center(
        child: FlutterMap(
          mapController: appState.mapController,
          options: MapOptions(
            center: LatLng(8.955458, 125.59715),
            zoom: 18.0,
            maxZoom: 19.0,
          ),
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(
              source: '',
              onSourceTapped: null,
            ),
          ],
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: markers,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            heroTag: "fab1",
            onPressed: () {
              appState.setMapCenter();
            },
            child: const Icon(Icons.gps_fixed_outlined),
          ),
          SizedBox(height: 10),
          FloatingActionButton.small(
            heroTag: "fab2",
            onPressed: () {
              var lat = 8.955458;
              var long = 125.59715;
              String googleUrl =
                  'https://www.google.com/maps/search/?api=1&query=$lat,$long';
              launchUrlString(googleUrl);
            },
            child: Padding(
                padding: EdgeInsets.all(5.0),
                child: const Image(image: AssetImage('assets/gmap.png'))),
          ),
          SizedBox(height: 10),
          FloatingActionButton.small(
            heroTag: "fab3",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ListPage(scheme: 'sms')));
            },
            child: const Icon(Icons.message_outlined),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: "fab4",
            backgroundColor: Colors.deepOrange,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ListPage(scheme: 'tel')));
            },
            child: const Icon(Icons.call_outlined),
          ),
        ],
      ),
    );
  }
}

class StationsPage extends StatelessWidget {
  final List<Station> stations = Station.getStations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: const Text('List of all Police Stations',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
          centerTitle: true,
        ),
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
                  subtitle: Text(station.address),
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
