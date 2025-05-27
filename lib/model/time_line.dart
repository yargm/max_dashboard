import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:maxdash/helpers/services/json_decoder.dart';
import 'package:maxdash/model/identifier_model.dart';

class TimeLineModel extends IdentifierModel {
  final String firstName, lastName, email;

  TimeLineModel(super.id, this.firstName, this.lastName, this.email);

  static TimeLineModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String firstName = decoder.getString('first_name');
    String lastName = decoder.getString('last_name');
    String email = decoder.getString('email');

    return TimeLineModel(decoder.getId, firstName, lastName, email);
  }

  static List<TimeLineModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => TimeLineModel.fromJSON(e)).toList();
  }

  static List<TimeLineModel>? _dummyList;

  static Future<List<TimeLineModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }
    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/time_line.json');
  }
}
