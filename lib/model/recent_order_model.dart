import 'dart:convert';

import 'package:maxdash/helpers/services/json_decoder.dart';
import 'package:maxdash/model/identifier_model.dart';
import 'package:flutter/services.dart';

class RecentOrderModel extends IdentifierModel {
  final String productName, customer, status;
  final int quantity, price;
  final DateTime orderDate;

  RecentOrderModel(
    super.id,
    this.productName,
    this.customer,
    this.status,
    this.quantity,
    this.price,
    this.orderDate,
  );

  static RecentOrderModel fromJSON(Map<String, dynamic> json) {
    JSONDecoder decoder = JSONDecoder(json);

    String productName = decoder.getString('product_name');
    String customer = decoder.getString('customer');
    String status = decoder.getString('status');
    int quantity = decoder.getInt('quantity');
    int price = decoder.getInt('price');
    DateTime orderDate = decoder.getDateTime('order_date');

    return RecentOrderModel(decoder.getId, productName, customer, status, quantity, price, orderDate);
  }

  static List<RecentOrderModel> listFromJSON(List<dynamic> list) {
    return list.map((e) => RecentOrderModel.fromJSON(e)).toList();
  }

  static List<RecentOrderModel>? _dummyList;

  static Future<List<RecentOrderModel>> get dummyList async {
    if (_dummyList == null) {
      dynamic data = json.decode(await getData());
      _dummyList = listFromJSON(data);
    }

    return _dummyList!;
  }

  static Future<String> getData() async {
    return await rootBundle.loadString('assets/data/recent_order.json');
  }
}
