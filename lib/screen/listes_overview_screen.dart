import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/liste_grid.dart';
import '../widget/app_drawer.dart';
import '../provider/listes.dart';
import '../provider/liste.dart';
import '../widget/tache_encours.dart';

enum FilterOptions {
  Effectuees,
  All,
}

class ListesOverviewScreen extends StatefulWidget {
  @override
  _ListesOverviewScreenState createState() => _ListesOverviewScreenState();
}

class _ListesOverviewScreenState extends State<ListesOverviewScreen> {
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    var _editedListe = Liste(
      id: null,
      saisie: '',
    );

    _save() {
      if (_editedListe.saisie.isNotEmpty) {
        Provider.of<Listes>(context, listen: false).addListe(_editedListe);

        // Provider.of<Listes>(context, listen: false)
        // .createListe(_editedListe) ;

        Navigator.of(context).pop();
      } else {
        return ' Pas de Taches';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('MES TACHES'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.low_priority,
                color: Colors.white,
              ),
              onPressed: () {
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
          PopupMenuButton(
            onSelected: (FilterOptions selectValue) {
              setState(() {
                if (selectValue == FilterOptions.Effectuees) {
                  _isChecked = true;
                } else if (selectValue == FilterOptions.All) {
                  _isChecked = false;
                } else {
                  _isChecked = false;
                }
              });
            },
            icon: Icon(Icons.done_all_outlined),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text(
                  'EFFECTUEES',
                  style: TextStyle(
                    color: Colors.green[900],
                  ),
                ),
                value: FilterOptions.Effectuees,
              ),
              PopupMenuItem(
                child: Text(
                  'TACHES',
                  style: TextStyle(color: Colors.amber[900]),
                ),
                value: FilterOptions.All,
              ),
            ],
          ),
        ],
      ),
      drawer: AppDrawer(),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text('AJOUTER UNE TACHE'),
                  content: TextField(
                    onChanged: (String value) {
                      _editedListe = Liste(
                        id: null,
                        saisie: value,
                      );
                    },
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        _save();
                        _editedListe.saisie = '';
                      },
                      child: Text(
                        'Enregistrer',
                        style: TextStyle(
                          color: Colors.amber[900],
                          fontSize: 18,
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: FlatButton(
                        child: Text(
                          'Annuler',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: ListeGrid(_isChecked),
    );
  }
}
