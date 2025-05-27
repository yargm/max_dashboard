import 'package:maxdash/controller/ui/notification_controller.dart';
import 'package:maxdash/helpers/theme/admin_theme.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/utils/my_shadow.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
import 'package:maxdash/helpers/widgets/my_button.dart';
import 'package:maxdash/helpers/widgets/my_card.dart';
import 'package:maxdash/helpers/widgets/my_flex.dart';
import 'package:maxdash/helpers/widgets/my_flex_item.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/helpers/widgets/my_text_style.dart';
import 'package:maxdash/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin, UIMixin {
  late NotificationController controller;
  @override
  late OutlineInputBorder outlineInputBorder;

  @override
  void initState() {
    controller = NotificationController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'notification_controller',
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
                      "Notifications",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Widget'),
                        MyBreadcrumbItem(name: 'Notifications', active: true),
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
                    MyFlexItem(
                      sizes: 'lg-6',
                      child: MyCard.bordered(
                        borderRadiusAll: 4,
                        border: Border.all(color: Colors.grey.withValues(alpha:.2)),
                        shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
                        paddingAll: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: MySpacing.only(left: 23, top: 20, bottom: 8, right: 23),
                              child: MyText.titleMedium("${controller.showBanner ? "${"Banner"}" : "${"Toast"}"} Customizer", fontWeight: 600),
                            ),
                            Divider(height: 24),
                            Padding(
                              padding: MySpacing.only(left: 23, top: 8, bottom: 23, right: 23),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Wrap(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    spacing: 16,
                                    runSpacing: 16,
                                    children: [
                                      buildMessageType(),
                                      buildColorVariation(),
                                      if (!controller.showBanner) buildFloatingType(),
                                    ],
                                  ),
                                  MySpacing.height(12),
                                  MyText.bodyMedium("Title Text", fontWeight: 600),
                                  MySpacing.height(8),
                                  TextFormField(
                                    controller: controller.toastTitleController,
                                    decoration: InputDecoration(
                                        labelText: "Toast Text",
                                        filled: true,
                                        contentPadding: MySpacing.all(16),
                                        isCollapsed: true,
                                        floatingLabelBehavior: FloatingLabelBehavior.never),
                                  ),
                                  MySpacing.height(12),
                                  buildAction(),
                                  MySpacing.height(12),
                                  buildTimeOut(),
                                  Center(
                                    child: MyButton(
                                      onPressed: controller.show,
                                      elevation: 0,
                                      padding: MySpacing.xy(20, 16),
                                      backgroundColor: contentTheme.primary,
                                      child: MyText.bodySmall(
                                        'Show',
                                        color: contentTheme.onPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildTimeOut() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodyMedium("Timeout", fontWeight: 600),
        SwitchListTile(
            value: controller.sticky,
            onChanged: controller.onChangeSticky,
            controlAffinity: ListTileControlAffinity.leading,
            visualDensity: getCompactDensity,
            contentPadding: MySpacing.zero,
            dense: true,
            title: MyText.bodyMedium("${"Infinite"} (∞)", fontWeight: 600)),
      ],
    );
  }

  Widget buildAction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyText.bodyMedium("Actions", fontWeight: 600),
        MySpacing.height(8),
        Theme(
          data: ThemeData(unselectedWidgetColor: contentTheme.light),
          child: CheckboxListTile(
              value: controller.showCloseIcon,
              onChanged: controller.onChangeShowCloseIcon,
              controlAffinity: ListTileControlAffinity.leading,
              visualDensity: getCompactDensity,
              contentPadding: MySpacing.zero,
              activeColor: contentTheme.primary,
              dense: true,
              title: MyText.bodyMedium("Show Close Icon", fontWeight: 600)),
        ),
        Theme(
          data: ThemeData(unselectedWidgetColor: contentTheme.light),
          child: CheckboxListTile(
              value: controller.showBanner ? controller.showLeadingIcon : controller.showOkAction,
              onChanged: controller.onAction,
              activeColor: contentTheme.primary,
              controlAffinity: ListTileControlAffinity.leading,
              visualDensity: getCompactDensity,
              contentPadding: MySpacing.zero,
              dense: true,
              title: MyText.bodyMedium(
                controller.showBanner ? "Show Leading Icon" : "Show ok Action",
                fontWeight: 600,
              )),
        ),
      ],
    );
  }

  Widget buildFloatingType() {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Floating Type", fontWeight: 600),
          MySpacing.height(12),
          DropdownButtonFormField<SnackBarBehavior>(
            value: controller.selectedBehavior,
            decoration: InputDecoration(
              hintText: "Select Type",
              hintStyle: MyTextStyle.bodyMedium(),
              contentPadding: MySpacing.all(12),
              isCollapsed: true,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            dropdownColor: contentTheme.background,
            onChanged: (SnackBarBehavior? newValue) {
              if (newValue != null) {
                controller.onChangeBehavior(newValue);
              }
            },
            items: SnackBarBehavior.values.map<DropdownMenuItem<SnackBarBehavior>>(
              (SnackBarBehavior behavior) {
                return DropdownMenuItem<SnackBarBehavior>(
                  value: behavior,
                  child: InkWell(
                    onTap: () => controller.onChangeBehavior(behavior),
                    child: MyText.labelMedium(behavior.name.capitalize!),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildColorVariation() {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Color variation", fontWeight: 600),
          MySpacing.height(12),
          DropdownButtonFormField<ContentThemeColor>(
            dropdownColor: contentTheme.background,
            value: controller.selectedColor,
            onChanged: controller.onChangeColor,
            decoration: InputDecoration(
              hintText: "Select Type",
              hintStyle: MyTextStyle.bodyMedium(),
              contentPadding: MySpacing.all(12),
              isCollapsed: true,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            items: ContentThemeColor.values.map((color) {
              return DropdownMenuItem<ContentThemeColor>(
                value: color,
                child: InkWell(
                  onTap: () => controller.onChangeColor(color),
                  child: MyText.labelMedium(
                    color.name.capitalize!,
                    fontWeight: 600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildMessageType() {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Message Type", fontWeight: 600),
          MySpacing.height(12),
          DropdownButtonFormField<bool>(
            value: controller.showBanner,
            decoration: InputDecoration(
              hintText: "Select Type",
              hintStyle: MyTextStyle.bodyMedium(),
              contentPadding: MySpacing.all(12),
              isCollapsed: true,
              filled: true,
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            dropdownColor: contentTheme.background,
            onChanged: (bool? newValue) {
              controller.setBannerType(newValue!);
            },
            items: [
              DropdownMenuItem<bool>(
                value: false,
                child: InkWell(
                  onTap: () => controller.setBannerType(false),
                  child: MyText.labelMedium("Toast"),
                ),
              ),
              DropdownMenuItem<bool>(
                value: true,
                child: InkWell(onTap: () => controller.setBannerType(true), child: MyText.labelMedium("Banner")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
