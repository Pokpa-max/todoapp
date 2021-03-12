import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/listes.dart';
import '../screen/edit_liste_screen.dart';

class TacheEncours extends StatelessWidget {
  static const routeName = '/tache_en_cours';

  @override
  Widget build(BuildContext context) {
    final listesData = Provider.of<Listes>(context);
    final listes = listesData.listesIcomplete;
    return ListView.builder(
       itemCount: listes.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
       value: listes[i],
       child:Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        title: Text(listes[i].saisie,style: TextStyle(color: Colors.grey),),
        
        leading: IconButton(
          icon: 
          Icon(
            Icons.done,
            color: Colors.green,),
           onPressed: () {}),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
               Spacer(),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.amber[900],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditListe.routeName,
                      arguments: listes[i].id);
                },
              ),
            ],
          ),
        ),
      ),
       )
      )
    );
  }
}
