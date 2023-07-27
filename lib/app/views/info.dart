import '../models/crimes.dart';
import '../models/station.dart';
import '../../utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  final Station station;

  const InfoPage({
    Key? key,
    required this.station,
  }) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final List<Station> stations = Station.getStations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Station Information',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(ColorsUtil.appBar))),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Image.asset(
              widget.station.avatar,
              height: 400,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(widget.station.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26, fontWeight: FontWeight.w700)),
                    SizedBox(height: 15),
                    Text(widget.station.address,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w300)),
                    SizedBox(height: 15),
                    Text(widget.station.number,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500)),
                  ],
                )),
          ],
        )),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              heroTag: "fab1",
              onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      crimeDialog('sms', widget.station.number)),
              child: const Icon(Icons.message_outlined),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              heroTag: "fab2",
              backgroundColor: Color(ColorsUtil.mainBtn),
              onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) =>
                      crimeDialog('tel', widget.station.number)),
              child: const Icon(Icons.call_outlined),
            ),
          ],
        ));
  }

  crimeDialog(scheme, number) {
    return AlertDialog(
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
                    child: Text(item, style: TextStyle(fontSize: 12.5))))
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

                final Uri callLaunchUri = Uri(scheme: scheme, path: number);
                launchUrl(callLaunchUri);
              }
            },
            icon: Icon(
                scheme == 'tel' ? Icons.call_outlined : Icons.message_outlined),
            label: Text(scheme == 'tel' ? 'Call' : 'Text')),
      ],
    );
  }
}
