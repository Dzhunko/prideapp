import 'package:flutter/material.dart';

class NoDoItem extends StatelessWidget {
  String _itemName;
  String _dateChoosen;
  int _id;

  NoDoItem(this._itemName, this._dateChoosen);

  NoDoItem.map(dynamic obj) {
    this._itemName = obj["itemName"];
    this._dateChoosen = obj["dateChoosen"];
    this._id = obj ["id"];
  }

  String get itemName => _itemName;
  String get dateChoosen => _dateChoosen;
  int get id => _id;

  Map<String, dynamic> toMap () {
    var map = new Map<String, dynamic>();
    map ["itemName"] = _itemName;
    map ["dateChoosen"] = _dateChoosen;
    map ["id"] = _id;

    if (_id != null)  {
      map ["id"] = _id;
    }

    return map;

  }

  NoDoItem.fromMap(Map<String, dynamic> map) {
    this._itemName = map["itemName"];
    this._dateChoosen = map["dateChoosen"];
    this._id = map ["id"];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text  (_itemName, style: 
          TextStyle()),
          new Container(
            margin: EdgeInsets.only(top: 5.0),
            child: Text('Date: $_dateChoosen',
              style: TextStyle()),
          ),
        ],
      ),
    );
  }
}