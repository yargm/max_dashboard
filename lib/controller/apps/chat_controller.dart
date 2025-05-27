import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/model/chat_model.dart';

class ChatController extends MyController {
  List<ChatModel> chat = [];
  List<ChatModel> searchChat = [];
  ChatModel? selectChat;
  TextEditingController messageController = TextEditingController();
  ScrollController? scrollController;

  @override
  void onInit() {
    ChatModel.dummyList.then((value) {
      chat = value;
      searchChat = value;
      selectChat = chat[0];
      update();
    });
    scrollController = ScrollController();
    super.onInit();
  }

  void onChangeChat(ChatModel selectSingleChat) {
    selectChat = selectSingleChat;
    update();
  }

  void onSearchChat(String query) {
    final input = query.toLowerCase();
    searchChat = chat.where((chat) => chat.firstName.toLowerCase().contains(input) || chat.messages.lastOrNull!.message.toLowerCase().contains(input)).toList();
    update();
  }

  void sendMessage() {
    if (messageController.value.text.isNotEmpty && selectChat != null) {
      selectChat!.messages.add(ChatMessageModel(-1, messageController.text, DateTime.now(), true, ""));
      messageController.clear();
      scrollToBottom(isDelayed: true);
      update();
    }
  }

  scrollToBottom({bool isDelayed = false}) {
    final int delay = isDelayed ? 400 : 0;
    Future.delayed(Duration(milliseconds: delay), () {
      scrollController!
          .animateTo(scrollController!.position.maxScrollExtent, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubicEmphasized);
    });
  }
}
