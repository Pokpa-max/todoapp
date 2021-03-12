import 'package:flutter/material.dart';
import '../widget/tache_encours.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('STRUCTURE DES TACHES'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.spellcheck),
            title: Text('Taches'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(Icons.done_all_outlined),
            title: Text('Historique'),
            onTap: () {

            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.low_priority),
            title: Text('Taches en Cours'),
            onTap: () {
               showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: Text('TACHES EN COURS'),
                      ),
                      body: TacheEncours(),
                    );
                  },
                );
              
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Dificultés'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.folder_open),
            title: Text('Autres'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
