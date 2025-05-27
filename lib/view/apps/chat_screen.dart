import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/apps/chat_controller.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/utils/my_shadow.dart';
import 'package:maxdash/helpers/utils/utils.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
import 'package:maxdash/helpers/widgets/my_button.dart';
import 'package:maxdash/helpers/widgets/my_card.dart';
import 'package:maxdash/helpers/widgets/my_container.dart';
import 'package:maxdash/helpers/widgets/my_flex.dart';
import 'package:maxdash/helpers/widgets/my_flex_item.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/helpers/widgets/my_text_style.dart';
import 'package:maxdash/images.dart';
import 'package:maxdash/model/chat_model.dart';
import 'package:maxdash/view/layouts/layout.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with UIMixin {
  ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'chat_controller',
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Chat",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Chat'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  children: [
                    MyFlexItem(sizes: 'lg-4', child: SizedBox(height: 800, child: chatIndex())),
                    MyFlexItem(sizes: 'lg-8', child: SizedBox(height: 800, child: messages())),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget chatIndex() {
    Widget searchField() {
      return TextFormField(
        onChanged: controller.onSearchChat,
        style: MyTextStyle.bodyMedium(),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          errorBorder: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(),
          focusedErrorBorder: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(),
          disabledBorder: OutlineInputBorder(),
          prefixIcon: Icon(LucideIcons.search),
          hintText: "Search",
          hintStyle: MyTextStyle.bodyMedium(),
          contentPadding: MySpacing.all(16),
          isCollapsed: true,
          isDense: true,
        ),
      );
    }

    Widget users() {
      return Expanded(
        child: ListView.separated(
          itemCount: controller.searchChat.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            ChatModel chat = controller.searchChat[index];
            return MyButton(
              onPressed: () => controller.onChangeChat(chat),
              padding: MySpacing.all(24),
              backgroundColor: theme.colorScheme.surface.withAlpha(5),
              splashColor: theme.colorScheme.onSurface.withAlpha(10),
              child: Row(
                children: [
                  MyContainer.rounded(
                    height: 44,
                    width: 44,
                    paddingAll: 0,
                    child: Image.asset(chat.avatar),
                  ),
                  MySpacing.width(24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.bodyMedium(chat.firstName, fontWeight: 600),
                        MySpacing.height(4),
                        MyText.labelSmall(chat.messages.lastOrNull!.message, fontWeight: 600, muted: true),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(height: 0);
          },
        ),
      );
    }

    return MyCard.bordered(
        borderRadiusAll: 4,
        border: Border.all(color: Colors.grey.withValues(alpha:.2)),
        shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
        paddingAll: 0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: MySpacing.all(24),
              child: searchField(),
            ),
            Padding(
              padding: MySpacing.nTop(24),
              child: MyText.bodyMedium("Conversations", fontWeight: 600),
            ),
            Divider(height: 0),
            users(),
          ],
        ));
  }

  Widget messages() {
    Widget sendMessage() {
      return Row(
        children: [
          Expanded(
            child: TextFormField(
              maxLines: 3,
              minLines: 1,
              controller: controller.messageController,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              style: MyTextStyle.bodyMedium(fontWeight: 600),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: MySpacing.xy(12, 16),
                hintText: "Send message...",
                hintStyle: MyTextStyle.bodyMedium(fontWeight: 600),
                border: OutlineInputBorder(),
                errorBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                focusedErrorBorder: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(),
                disabledBorder: OutlineInputBorder(),
              ),
            ),
          ),
          MySpacing.width(24),
          MyContainer(
            onTap: () => controller.sendMessage(),
            paddingAll: 0,
            height: 43,
            width: 43,
            borderRadiusAll: 8,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: contentTheme.primary,
            child: Icon(LucideIcons.send, size: 20, color: contentTheme.onPrimary),
          )
        ],
      );
    }

    return MyCard.bordered(
        borderRadiusAll: 4,
        border: Border.all(color: Colors.grey.withValues(alpha:.2)),
        shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
        paddingAll: 0,
        child: Column(
          children: [
            Padding(
              padding: MySpacing.all(24),
              child: Row(
                children: [
                  if (controller.selectChat != null)
                    MyContainer.rounded(
                      height: 44,
                      width: 44,
                      paddingAll: 0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Image.asset(controller.selectChat!.avatar, fit: BoxFit.cover),
                    ),
                  MySpacing.width(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.selectChat != null) MyText.bodyMedium(controller.selectChat!.firstName, fontWeight: 600),
                        MyText.bodySmall("Active Now", fontWeight: 600, muted: true)
                      ],
                    ),
                  ),
                  IconButton(onPressed: () {}, icon: Icon(LucideIcons.phone_call, size: 20)),
                  IconButton(onPressed: () {}, icon: Icon(LucideIcons.video, size: 20)),
                  PopupMenuButton(
                    position: PopupMenuPosition.under,
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(padding: MySpacing.xy(16, 8), height: 10, child: MyText.bodySmall("View Contact")),
                      PopupMenuItem(padding: MySpacing.xy(16, 8), height: 10, child: MyText.bodySmall("Create Shortcut")),
                      PopupMenuItem(padding: MySpacing.xy(16, 8), height: 10, child: MyText.bodySmall("Clear Chat")),
                      PopupMenuItem(padding: MySpacing.xy(16, 8), height: 10, child: MyText.bodySmall("Block")),
                    ],
                    child: Icon(LucideIcons.ellipsis_vertical, size: 18),
                  ),
                ],
              ),
            ),
            Divider(height: 0),
            Expanded(
              child: ListView.separated(
                  controller: controller.scrollController,
                  itemCount: (controller.selectChat?.messages ?? []).length,
                  padding: MySpacing.all(24),
                  itemBuilder: (context, index) {
                    final message = (controller.selectChat?.messages ?? [])[index];
                    final isSent = message.fromMe == true;
                    final theme = isSent ? contentTheme.primary : contentTheme.secondary;
                    return Row(
                      mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!isSent)
                          Column(
                            children: [
                              MyContainer.rounded(
                                height: 32,
                                width: 32,
                                paddingAll: 0,
                                child: Image.asset(controller.selectChat!.avatar, fit: BoxFit.cover),
                              ),
                              MySpacing.height(8),
                              MyText.bodySmall(
                                '${Utils.getTimeStringFromDateTime(message.sendAt, showSecond: false)}',
                                fontSize: 8,
                                muted: true,
                                fontWeight: 600,
                              ),
                            ],
                          ),
                        MySpacing.width(12),
                        Expanded(
                          child: Wrap(
                            alignment: isSent ? WrapAlignment.end : WrapAlignment.start,
                            children: [
                              MyContainer(
                                  padding: EdgeInsets.all(8),
                                  margin: EdgeInsets.only(
                                    left: isSent ? MediaQuery.of(context).size.width * 0.20 : 0,
                                    right: isSent ? 0 : MediaQuery.of(context).size.width * 0.20,
                                  ),
                                  color: theme.withAlpha(30),
                                  child: MyText.bodyMedium(
                                    message.message,
                                    fontWeight: 600,
                                    color: isSent ? contentTheme.primary : contentTheme.secondary,
                                    overflow: TextOverflow.clip,
                                  )),
                            ],
                          ),
                        ),
                        MySpacing.width(12),
                        if (controller.selectChat != null && isSent)
                          Column(
                            children: [
                              MyContainer.rounded(
                                height: 32,
                                width: 32,
                                paddingAll: 0,
                                child: Image.asset(
                                  Images.avatars[6],
                                  fit: BoxFit.cover,
                                ),
                              ),
                              MySpacing.height(8),
                              MyText.bodySmall(
                                '${Utils.getTimeStringFromDateTime(
                                  message.sendAt,
                                  showSecond: false,
                                )}',
                                fontSize: 8,
                                muted: true,
                                fontWeight: 600,
                              ),
                            ],
                          ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return MySpacing.height(12);
                  }),
            ),
            Divider(height: 0),
            Padding(
              padding: MySpacing.all(24),
              child: sendMessage(),
            ),
          ],
        ));
  }
}
