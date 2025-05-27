import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:maxdash/helpers/services/json_decoder.dart';
import 'package:maxdash/model/identifier_model.dart';

class DragNDropModel extends IdentifierModel {
  final String name, image, userName, contactNumber;

  DragNDropModel(super.id, this.name, this.image, this.userName, this.contactNumber);

  static DragNDropModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String name = decoder.getString('name');
    String image = decoder.getString('image');
    String userName = decoder.getString('user_name');
    String contactNumber = decoder.getString('contact_number');

    return DragNDropModel(decoder.getId, name, image, userName, contactNumber);
  }

  static List<DragNDropModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => DragNDropModel.fromJSON(e)).toList();
  }

  static List<DragNDropModel>? _dummyList;

  static Future<List<DragNDropModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/drag_n_drop_data.json');
  }
}
