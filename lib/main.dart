import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './provider/listes.dart';
import './screen/listes_overview_screen.dart';
import './screen/edit_liste_screen.dart';
import './widget/tache_encours.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Todos());
}

class Todos extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return SizedBox();
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return ChangeNotifierProvider(
              create: (context) => Listes(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Todos',
                theme: ThemeData(
                  brightness: Brightness.light,
                  primaryColor: Colors.amber[900],
                  accentColor: Colors.amber[900],
                ),
                home: ListesOverviewScreen(),
                //MyApp() ,
                routes: {
                  EditListe.routeName: (ctx) => EditListe(),
                  TacheEncours.routeName: (ctx) => TacheEncours()
                },
              ),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Scaffold(
            appBar: AppBar(
              title: Text('changement'),
            ),
            body: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.amber[900],
            ),
            ),
          );
          
        });
  }
}
