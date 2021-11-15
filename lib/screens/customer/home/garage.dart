import 'package:flutter/material.dart';
import 'package:oilwale/components/garagelist.dart';

class GarageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GarageListView(),
    );
  }
}
