import 'package:flutter/foundation.dart';

class Liste with ChangeNotifier {
  final String id;
  String saisie;
  bool isChecked;

  Liste({
    @required this.id,
    @required this.saisie,
    this.isChecked = false,
  });
//******************************** */
//conversion des  données  en  Map pour inserer dans ma liste
  Liste.conversion(Map<String, dynamic> data, String id)
      : id = id,
        saisie = data["saisi"],
        isChecked = data["isChecked"];
}
