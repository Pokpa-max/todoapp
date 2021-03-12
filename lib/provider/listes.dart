import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'liste.dart';

class Listes with ChangeNotifier {
  Listes() {
    print('pokpa');
    recuperation();
  }
  //final firestoreInstance = FirebaseFirestore.instance.collection('liste').doc();
  final firestoreInstance = FirebaseFirestore.instance.collection('liste');

  List<Liste> _items = [];
//historique des tache
  List<Liste> _historique = [];

  List<Liste> get historique {
    return [..._historique];
  }
//************** */
  List<Liste> get items {
    return [..._items];
  }

  Liste findById(String id) {
    return _items.firstWhere((liste) => liste.id == id);
  }

//tache non terminé
  List<Liste> get listes =>
      _items.where((liste) => liste.isChecked == false).toList();
//tache effectué
  List<Liste> get listesComplete =>
      _items.where((liste) => liste.isChecked == true).toList();

  List<Liste> get listesIcomplete =>
      _items.where((liste) => liste.isChecked == false).toList();

  Future addListe(Liste liste) async {
    firestoreInstance.add({
      'time': Timestamp.now(),
      'saisi': liste.saisie,
      'isChecked': false,
    })
      .catchError((err){print(err);})
      .whenComplete(() => {print('ajout avec success')})
    ;
    notifyListeners();
  }

  //creation de mon map ajout
  Future recuperation() async {
    firestoreInstance.snapshots().listen((event) {
      _items = event.docs.map((element) {
        print("element recu ${element.data()}");
        return Liste.conversion(element.data(), element.id);
      }).toList() 
      ;
      notifyListeners();
    });
  }

  Future updateListe(String id, String newListe) async {
    // final listeIndex = _items.indexWhere((liste) => liste.id == id);
    // _items[listeIndex].saisie = newListe;
    firestoreInstance.doc(id).update({'saisi': newListe});
    notifyListeners();
  }

  //update

  Future checked(String id) async {
    //gestion du check en local
    //*********************************** */
    // final listeIndex = _items.indexWhere((liste) => liste.id == id);
    // _items[listeIndex].isChecked = !_items[listeIndex].isChecked;
    // print(_items[listeIndex].isChecked);
    //*********************************** */
    //gestion du check cote backend
    DocumentSnapshot doc = await firestoreInstance.doc(id).get();
   await firestoreInstance.doc(id).update({'isChecked': !doc['isChecked']});
    notifyListeners();
  }

  Future deleteListe(String id) async {
    // _items.removeWhere((liste) => liste.id == id);
    firestoreInstance.doc(id).delete();
    notifyListeners();
 }
 //delete liste



}
