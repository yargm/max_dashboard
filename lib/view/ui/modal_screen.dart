import 'package:maxdash/controller/ui/modal_controller.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/utils/my_shadow.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
import 'package:maxdash/helpers/widgets/my_button.dart';
import 'package:maxdash/helpers/widgets/my_card.dart';
import 'package:maxdash/helpers/widgets/my_container.dart';
import 'package:maxdash/helpers/widgets/my_flex.dart';
import 'package:maxdash/helpers/widgets/my_flex_item.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class ModalScreen extends StatefulWidget {
  const ModalScreen({super.key});

  @override
  State<ModalScreen> createState() => _ModalScreenState();
}

class _ModalScreenState extends State<ModalScreen> with SingleTickerProviderStateMixin, UIMixin {
  late ModalController controller;

  @override
  void initState() {
    controller = ModalController(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'modal_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium(
                      "Modal",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Widget'),
                        MyBreadcrumbItem(name: 'Modal', active: true),
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
                        sizes: 'lg-4',
                        child: MyCard.bordered(
                          borderRadiusAll: 4,
                          border: Border.all(color: Colors.grey.withValues(alpha:.2)),
                          shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
                          paddingAll: 24,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              MyText.titleMedium("Show Modal", fontWeight: 600),
                              MySpacing.height(12),
                              MyText.bodySmall("Simple default Alert Example", fontWeight: 600),
                              MySpacing.height(12),
                              Center(
                                child: MyButton(
                                  elevation: 0,
                                  onPressed: () => _showDialog(),
                                  child: MyText.bodyMedium("Show Modal", color: contentTheme.onPrimary),
                                ),
                              ),
                            ],
                          ),
                        )),
                    MyFlexItem(
                        sizes: 'lg-4',
                        child: MyCard.bordered(
                          borderRadiusAll: 4,
                          border: Border.all(color: Colors.grey.withValues(alpha:.2)),
                          shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
                          paddingAll: 24,
                          child: Column(
                            children: [
                              MyText.titleMedium("Modal with button", fontWeight: 600),
                              MySpacing.height(12),
                              MyText.bodySmall("Small default styled Modal", fontWeight: 600),
                              MySpacing.height(12),
                              MyButton(
                                elevation: 0,
                                onPressed: () => _dialogButton(),
                                child: MyText.bodyMedium("Modal With Button", color: contentTheme.onPrimary),
                              ),
                            ],
                          ),
                        )),
                    MyFlexItem(
                        sizes: 'lg-4',
                        child: MyCard.bordered(
                          borderRadiusAll: 4,
                          border: Border.all(color: Colors.grey.withValues(alpha:.2)),
                          shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
                          paddingAll: 24,
                          child: Column(
                            children: [
                              MyText.titleMedium("Large Modal", fontWeight: 600),
                              MySpacing.height(12),
                              MyText.bodySmall("Large default styled modal with buttons", fontWeight: 600),
                              MySpacing.height(12),
                              MyButton(
                                elevation: 0,
                                onPressed: () => _largeModal(),
                                child: MyText.bodyMedium("Large Modal", color: contentTheme.onPrimary),
                              ),
                            ],
                          ),
                        )),
                    MyFlexItem(
                        sizes: 'lg-4',
                        child: MyCard.bordered(
                          borderRadiusAll: 4,
                          border: Border.all(color: Colors.grey.withValues(alpha:.2)),
                          shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
                          child: Column(
                            children: [
                              MyText.titleMedium("Animation Modal", fontWeight: 600),
                              MySpacing.height(12),
                              MyText.bodySmall("Animated Modal with starting and ending animation", fontWeight: 600),
                              MySpacing.height(12),
                              MyButton(
                                  elevation: 0,
                                  onPressed: () => _openCustomDialog(),
                                  child: MyText.bodyMedium("Animation Modal", color: contentTheme.onPrimary)),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _openCustomDialog() {
    showGeneralDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  title: MyText.bodyMedium('Hello!!', fontWeight: 600),
                  content: SizedBox(width: 300, child: MyText.labelMedium(controller.dummyTexts[9]))),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) => MyContainer());
  }

  void _largeModal() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: .5,
          insetPadding: MySpacing.xy(100, 40),
          insetAnimationCurve: Curves.easeInBack,
          insetAnimationDuration: Durations.short1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: MySpacing.nBottom(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Large Modal", fontWeight: 600),
                    InkWell(onTap: () => Get.back(), child: Icon(LucideIcons.x, size: 16)),
                  ],
                ),
              ),
              Divider(height: 40),
              Padding(
                padding: MySpacing.nTop(28),
                child: Column(
                  children: [
                    MyText.labelMedium(controller.dummyTexts[2], fontWeight: 600, overflow: TextOverflow.ellipsis, maxLines: 6),
                    MySpacing.height(8),
                    MyText.labelMedium(controller.dummyTexts[3], fontWeight: 600, overflow: TextOverflow.ellipsis, maxLines: 6),
                    MySpacing.height(8),
                    MyText.labelMedium(controller.dummyTexts[4], fontWeight: 600, overflow: TextOverflow.ellipsis, maxLines: 6),
                    MySpacing.height(8),
                    MyText.labelMedium(controller.dummyTexts[5], fontWeight: 600, overflow: TextOverflow.ellipsis, maxLines: 6),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _dialogButton() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: .5,
          insetAnimationCurve: Curves.easeInBack,
          insetAnimationDuration: Durations.short1,
          child: SizedBox(
            width: 400,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: MySpacing.nBottom(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText.titleMedium("Modal With Button", fontWeight: 600),
                      InkWell(onTap: () => Get.back(), child: Icon(LucideIcons.x, size: 16))
                    ],
                  ),
                ),
                Divider(height: 40),
                Padding(
                  padding: MySpacing.x(20),
                  child: MyText.labelMedium(controller.dummyTexts[2], overflow: TextOverflow.ellipsis, maxLines: 6, letterSpacing: 1),
                ),
                Divider(height: 40),
                Padding(
                  padding: MySpacing.nTop(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyButton.block(
                            elevation: 0,
                            borderRadiusAll: 0,
                            padding: MySpacing.all(20),
                            onPressed: () => Get.back(),
                            backgroundColor: contentTheme.secondary,
                            child: MyText.bodyMedium(
                              "Close",
                              color: contentTheme.onDisabled,
                              fontWeight: 600,
                            )),
                      ),
                      MySpacing.width(12),
                      Expanded(
                        child: MyButton.block(
                            elevation: 0,
                            borderRadiusAll: 0,
                            padding: MySpacing.all(20),
                            backgroundColor: contentTheme.primary,
                            onPressed: () => Get.back(),
                            child: MyText.bodyMedium(
                              "Save",
                              color: contentTheme.onPrimary,
                              fontWeight: 600,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: .5,
          insetAnimationCurve: Curves.easeInBack,
          insetAnimationDuration: Durations.short1,
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: MySpacing.nBottom(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText.titleMedium("Simple Modal", fontWeight: 600),
                      InkWell(onTap: () => Get.back(), child: Icon(LucideIcons.x, size: 16)),
                    ],
                  ),
                ),
                Divider(height: 30),
                Padding(
                  padding: MySpacing.nTop(20),
                  child: MyText.labelMedium(controller.dummyTexts[2]),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
