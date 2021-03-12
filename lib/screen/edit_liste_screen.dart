import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/listes.dart';

class EditListe extends StatefulWidget {
  static const routeName = '/edit_liste';
  @override
  _EditListeState createState() => _EditListeState();
}

class _EditListeState extends State<EditListe> {
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final listeId = ModalRoute.of(context).settings.arguments as String;
    final liste = Provider.of<Listes>(context, listen: false).findById(listeId);
    String saisie;

    void _saveListe() {
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }

      _form.currentState.save();

      if (liste.id != null) {
        Provider.of<Listes>(context, listen: false)
            .updateListe(liste.id, saisie);
      }
    
    
      Navigator.of(context).pop();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit tache'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveListe,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                  initialValue: liste.saisie,
                  decoration: InputDecoration(
                    labelText: 'modifier',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return ' Veillez Saisir la Tache';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    saisie = value;
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
