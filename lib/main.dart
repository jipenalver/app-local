// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';

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
        page = HotlinesPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    // The container for the current page, with its background color
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
    //var theme = Theme.of(context);

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
            backgroundColor: Colors.deepOrange,
            onPressed: () {},
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
  List<Hotlines> hotlines = [
    const Hotlines(
        name: 'Agusan del Norte Police Provincial Office',
        address: 'Camp Col Rafael C Rodriguez, Libertad Butuan City',
        avatar: 'assets/station8.png',
        number: '+639985987274'),
    const Hotlines(
        name: 'Butuan City Police Office-PIO',
        address: 'Malvar Circle, Brgy. Holy Redeemer, Butuan City',
        avatar: 'assets/station1.png',
        number: '+639985987292'),
    const Hotlines(
        name: 'Butuan City Mobile Force Company',
        address: 'J.C Aquino Ave Cor A.D Curato St, Butuan City',
        avatar: 'assets/station2.png',
        number: '+639302970041'),
    const Hotlines(
        name: 'Butuan City Police Station 1',
        address: 'JC Aquino Ave.AD Curato St. Butuan City',
        avatar: 'assets/station3.png',
        number: '+639985987293'),
    const Hotlines(
        name: 'Butuan City Police Station 2',
        address: 'J. Satorre St., Butuan City',
        avatar: 'assets/station4.png',
        number: '+639985987295'),
    const Hotlines(
        name: 'Butuan Cps III',
        address: 'Bayanihan, Butuan City',
        avatar: 'assets/station5.png',
        number: '+639985987297'),
    const Hotlines(
        name: 'Butuan City Police Office Station 4',
        address: 'P-3B, Ampayon, Butuan City',
        avatar: 'assets/station6.png',
        number: '+639985987299'),
    const Hotlines(
        name: 'Butuan City Police Station 5',
        address: 'San Mateo, Butuan City',
        avatar: 'assets/station7.png',
        number: '+639985987301'),
  ];

  List<String> crimeTypes = [
    'Carnapping (Karnap)',
    'Carnapping of Motorcycles',
    'Theft (Kawat)',
    'Robbery (Tulis)',
    'Physical Injury (Pagkulata)',
    'Rape (Paglugos)',
    'Murder (Pagpatay)',
    'Homicide'
  ];
  String? selectedItem = 'Carnapping (Karnap)';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: const Text('List of all Police Stations',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
      ),
      body: ListView.builder(
        itemCount: hotlines.length,
        itemBuilder: (context, index) {
          final hotline = hotlines[index];

          return Card(
              child: ListTile(
            leading: CircleAvatar(
                radius: 28, backgroundImage: AssetImage(hotline.avatar)),
            title: Text(hotline.name),
            subtitle: Text(hotline.address),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Crime Type (Klase sa Krimen)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                content: SizedBox(
                  width: 240,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(width: 3))),
                    value: selectedItem,
                    items: crimeTypes
                        .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item, style: TextStyle(fontSize: 14))))
                        .toList(),
                    onChanged: (item) => setState(() {
                      selectedItem = item;
                    }),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      // Send Crime Type to  Server
                      print(selectedItem);
                      // Call based on Number
                      final Uri callLaunchUri =
                          Uri(scheme: 'tel', path: hotline.number);
                      launchUrl(callLaunchUri);
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}

class Hotlines {
  final String name;
  final String address;
  final String avatar;
  final String number;

  const Hotlines(
      {required this.name,
      required this.address,
      required this.avatar,
      required this.number});
}
