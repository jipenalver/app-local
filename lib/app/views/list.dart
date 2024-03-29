import '../models/crimes.dart';
import '../models/station.dart';
import '../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class ListPage extends StatefulWidget {
  final String scheme;
  final double lat;
  final double long;

  const ListPage({
    Key? key,
    required this.scheme,
    required this.lat,
    required this.long,
  }) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final List<Station> stations = Station.getStations();

  @override
  Widget build(BuildContext context) {
    for (var station in stations) {
      station.distance = Geolocator.distanceBetween(widget.lat, widget.long,
          double.parse(station.lat), double.parse(station.long));
    }
    stations.sort((a, b) => a.distance.compareTo(b.distance));

    if (stations[0].fkId != 0) {
      int id = stations.indexWhere((element) => element.id == stations[0].fkId);
      stations.insert(1, stations[id]);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Nearest Police Station/s',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(ColorsUtil.appBar))),
      ),
      body: ListView.builder(
        itemCount: stations[0].fkId == 0 ? 1 : 2,
        itemBuilder: (context, index) {
          final hotline = stations[index];
          String newValue = '';
          if (hotline.distance < 1000) {
            newValue = '${hotline.distance.round()} m';
          } else {
            double integer = hotline.distance / 1000;
            newValue = '${integer.toStringAsFixed(1)} km';
          }

          return Card(
              child: ListTile(
            leading: CircleAvatar(
                radius: 28, backgroundImage: AssetImage(hotline.avatar)),
            title: Text(
                '${hotline.name} ${index == 1 ? '(Mother Station)\n(${hotline.number})' : '\n(${hotline.number})'}',
                style: index == 0
                    ? TextStyle(
                        color: Color(ColorsUtil.primary),
                        fontWeight: FontWeight.bold)
                    : null),
            subtitle: Text('${hotline.address} \n($newValue away)',
                style: TextStyle(color: Color(ColorsUtil.subtitle))),
            trailing: Icon(widget.scheme == 'tel'
                ? Icons.call_outlined
                : Icons.message_outlined),
            onTap: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Crime Type (Klase sa Krimen)',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                content: SizedBox(
                  width: 250,
                  child: DropdownButtonFormField<String>(
                      itemHeight: null,
                      isExpanded: true,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 1))),
                      value: Crime.selectedItem,
                      items: Crime.crimeTypes
                          .map((item) => DropdownMenuItem(
                              value: item,
                              child:
                                  Text(item, style: TextStyle(fontSize: 12.5))))
                          .toList(),
                      onChanged: (item) => setState(() {
                            Crime.selectedItem = item;
                          })),
                ),
                actions: <Widget>[
                  ElevatedButton.icon(
                      onPressed: () {
                        if (Crime.selectedItem != Crime.crimeTypes[0]) {
                          Navigator.of(context).pop();

                          final Uri callLaunchUri =
                              Uri(scheme: widget.scheme, path: hotline.number);
                          launchUrl(callLaunchUri);
                        }
                      },
                      icon: Icon(widget.scheme == 'tel'
                          ? Icons.call_outlined
                          : Icons.message_outlined),
                      label: Text(widget.scheme == 'tel' ? 'Call' : 'Text')),
                ],
              ),
            ),
          ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "fab1",
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.map),
      ),
    );
  }
}
