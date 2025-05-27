import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/images.dart';

class KanBanBoardController extends MyController {
  final AppFlowyBoardController boardData = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );
  late AppFlowyBoardScrollController boardController;

  @override
  void onInit() {
    super.onInit();
    final group1 = AppFlowyGroupData(
      id: "Pending",
      items: [
        TextItem("10 Oct 2024", "Update Home Page UI", "Alice", Images.avatars[0]),
        TextItem("12 Oct 2024", "Create Product Feature List", "Bob", Images.avatars[1]),
        TextItem("15 Oct 2024", "Design Login Flow", "Clara", Images.avatars[2]),
      ],
      name: 'Pending',
    );

    final group2 = AppFlowyGroupData(
      id: "Ongoing",
      items: [
        TextItem("5 Nov 2024", "Refactor API Endpoints", "Daniel", Images.avatars[3]),
        TextItem("10 Nov 2024", "Implement Push Notifications", "Eva", Images.avatars[4]),
      ],
      name: 'Ongoing',
    );

    final group3 = AppFlowyGroupData(
      id: "Completed",
      items: [
        TextItem("3 Oct 2024", "Develop Admin Dashboard", "Felix", Images.avatars[5]),
        TextItem("8 Oct 2024", "Setup Continuous Integration", "Grace", Images.avatars[6]),
        TextItem("14 Oct 2024", "Design Mobile App Icons", "Harry", Images.avatars[7]),
        TextItem("18 Oct 2024", "Create User Guide", "Ivy", Images.avatars[8]),
      ],
      name: 'Completed',
    );

    final group4 = AppFlowyGroupData(
      id: "On Hold",
      items: [
        TextItem("1 Nov 2024", "Design Marketing Website", "Jack", Images.avatars[9]),
      ],
      name: 'On Hold',
    );
  
    boardData.addGroup(group1);
    boardData.addGroup(group2);
    boardData.addGroup(group3);
    boardData.addGroup(group4);
  }
}

class TextItem extends AppFlowyGroupItem {
  final String date, title, name, image;

  TextItem(this.date, this.title, this.name, this.image);

  @override
  String get id => title;
}
