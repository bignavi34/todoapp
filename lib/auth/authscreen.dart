import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to/auth/authform.dart';

class Authsreen extends StatefulWidget {
  const Authsreen({super.key});

  @override
  State<Authsreen> createState() => _AuthsreenState();
}

class _AuthsreenState extends State<Authsreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Authentication')),
      body: Authform(),
    );
  }
}
