// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:english_words/english_words.dart';

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
  var current = WordPair.random();
  var history = <WordPair>[];

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
        page = HotlinesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
    // and subtle switching animation.
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
                      label: 'Map (Mapa)',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.numbers),
                      label: 'Hotlines (Numero)',
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
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var theme = Theme.of(context);
    var pair = appState.current;

    return Scaffold(
      body: Center(
        child: FlutterMap(
          mapController: appState.mapController,
          options: MapOptions(
            center: LatLng(8.955458, 125.59715),
            zoom: 18.0,
            maxZoom: 20.0,
          ),
          nonRotatedChildren: [
            AttributionWidget.defaultWidget(
              source: 'OpenStreetMap contributors',
              onSourceTapped: null,
            ),
          ],
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(8.955458, 125.59715),
                  width: 56,
                  height: 56,
                  builder: (context) => const Icon(Icons.person),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              appState.setMapCenter();
            },
            child: const Icon(Icons.center_focus_strong),
          ),
          SizedBox(height: 10),
          FloatingActionButton.small(
            onPressed: () {},
            child: const Icon(Icons.message),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: theme.colorScheme.onSecondary,
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Crime Type (Klase sa Krimen)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                content: const Text('AlertDialog description'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            child: const Icon(Icons.call),
          ),
        ],
      ),
    );
  }
}

class HotlinesPage extends StatefulWidget {
  @override
  State<HotlinesPage> createState() => _HotlinesPageState();
}

class _HotlinesPageState extends State<HotlinesPage> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) => Card(
            child: ListTile(
          leading: CircleAvatar(
              radius: 28,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1680266194753-0cf288bf7b93?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80')),
          title: Text('Name $index'),
          subtitle: Text('Email $index'),
          trailing: const Icon(Icons.arrow_forward),
        )),
      ),
    );
  }
}
