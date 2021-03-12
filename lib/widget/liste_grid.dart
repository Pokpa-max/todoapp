// import 'package:application/provider/listes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/listes.dart';
import './liste_item.dart';

class ListeGrid extends StatelessWidget {
  final bool isChecked;
  ListeGrid(this.isChecked);
  @override
  Widget build(BuildContext context) {
    // final firestoreInstance = FirebaseFirestore.instance.collection('liste');
    final listesData = Provider.of<Listes>(context, listen: true);
    final listes = isChecked ? listesData.listesComplete : listesData.items;
    //final listes = listesData.items;
    print(listes);

    return ListView.builder(
      itemCount: listes.length,
      itemBuilder: (ctx, i) =>
          ListeItem(listes[i].id, listes[i].saisie, listes[i].isChecked),
    );
  }
}
