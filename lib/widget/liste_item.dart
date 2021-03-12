import 'package:application/provider/listes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screen/edit_liste_screen.dart';

class ListeItem extends StatelessWidget {
  final String id;
  final String saisie;
  final bool isChecked;

  ListeItem(this.id, this.saisie, this.isChecked);

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onDoubleTap: () {
        Navigator.of(context).pushNamed(EditListe.routeName, arguments: id);
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
            title: Text(
              saisie,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  decoration: isChecked
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
            leading: Checkbox(
              activeColor: Theme.of(context).primaryColor,
              value: isChecked,
              onChanged: (_) {
                Provider.of<Listes>(context, listen: false).checked(id);
              },
            ),
            trailing: Container(
              width: 100,
              child: Row(
                children: [
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      return showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Voulez-vous Supprimé ?',
                            style: TextStyle(color: Colors.red),
                          ),
                          content: Text(
                            'Sure de Vouloir Supprimé',
                            style: TextStyle(color: Colors.black),
                          ),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Text(
                                'Non',
                                style: TextStyle(
                                    color: Colors.amber[900], fontSize: 18),
                              ),
                            ),
                            FlatButton(
                              onPressed: () {
                                Provider.of<Listes>(context).deleteListe(id);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Oui',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
