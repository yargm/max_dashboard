import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/helpers/widgets/my_text_utils.dart';
import 'package:flutter/material.dart';
import 'package:maxdash/model/drag_n_drop_model.dart';

class DragNDropController extends MyController {
  List<DragNDropModel> dragNDrop = [];
  final scrollController = ScrollController();
  final gridViewKey = GlobalKey();
  List<String> dummyTexts = List.generate(12, (index) => MyTextUtils.getDummyText(60));

  @override
  void onInit() {
    DragNDropModel.dummyList.then((value) {
      dragNDrop = value;
      update();
    });
    super.onInit();
  }

  void onReorder(int oldIndex, int newIndex) {
    final item = dragNDrop.removeAt(oldIndex);
    dragNDrop.insert(newIndex, item);
    update();
  }
}
