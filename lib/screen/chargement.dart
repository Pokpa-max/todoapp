import 'package:flutter/material.dart';

class Chargement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:CircularProgressIndicator(
        backgroundColor: Colors.amber[900],
        
          ),),
    );
  }
}
