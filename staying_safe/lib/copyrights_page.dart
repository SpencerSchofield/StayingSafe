import 'package:flutter/material.dart';

class CopyrightsPage extends StatelessWidget {
  final String copyrightsText;

  const CopyrightsPage({Key? key, required this.copyrightsText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TomTom Maps API - Copyrights"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Text(copyrightsText)),
            )),
          ],
        ),
      ),
    );
  }
}
