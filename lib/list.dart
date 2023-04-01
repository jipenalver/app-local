import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  final String scheme;

  const ListPage({
    Key? key,
    required this.scheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Nearest Police Station',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "btn3",
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.map),
      ),
    );
  }
}
