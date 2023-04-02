import 'models/crimes.dart';
import 'models/station.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListPage extends StatefulWidget {
  final String scheme;

  const ListPage({
    Key? key,
    required this.scheme,
  }) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final List<Station> stations = Station.getStations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Nearest Police Station',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
      ),
      body: ListView.builder(
        itemCount: stations.length,
        itemBuilder: (context, index) {
          final hotline = stations[index];

          return Card(
              child: ListTile(
            leading: CircleAvatar(
                radius: 28, backgroundImage: AssetImage(hotline.avatar)),
            title: Text(hotline.name),
            subtitle: Text(hotline.address),
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
                  width: 240,
                  child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(width: 3))),
                      value: Crime.selectedItem,
                      items: Crime.crimeTypes
                          .map((item) => DropdownMenuItem(
                              value: item,
                              child:
                                  Text(item, style: TextStyle(fontSize: 14))))
                          .toList(),
                      onChanged: (item) => setState(() {
                            Crime.selectedItem = item;
                          })),
                ),
                actions: <Widget>[
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pop();

                        final Uri callLaunchUri =
                            Uri(scheme: widget.scheme, path: hotline.number);
                        launchUrl(callLaunchUri);
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
