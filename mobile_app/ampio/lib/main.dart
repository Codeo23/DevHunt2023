import 'package:flutter/material.dart';

void main() {
  runApp(const AmpioApp());
}

class AmpioApp extends StatelessWidget {
  const AmpioApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Text('test'),
    );
  }
}