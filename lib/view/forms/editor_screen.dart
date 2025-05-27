import 'package:flutter_quill/flutter_quill.dart';
import 'package:maxdash/controller/forms/editor_controller.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
import 'package:maxdash/helpers/widgets/my_card.dart';
import 'package:maxdash/helpers/widgets/my_flex.dart';
import 'package:maxdash/helpers/widgets/my_flex_item.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key});

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> with SingleTickerProviderStateMixin, UIMixin {
  EditorController controller = EditorController();

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'editor_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Editor", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [MyBreadcrumbItem(name: 'Form'), MyBreadcrumbItem(name: 'Editor', active: true)],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              MyFlex(children: [
                MyFlexItem(
                  sizes: "lg-8",
                  child: MyCard(
                    paddingAll: 0,
                    child: Column(
                      children: [
                        QuillSimpleToolbar(
                          controller: controller.quillController,
                          configurations: QuillSimpleToolbarConfigurations(),
                        ),
                        Divider(),
                        Padding(
                          padding: MySpacing.all(24),
                          child: QuillEditor.basic(
                            controller: controller.quillController,
                            configurations: QuillEditorConfigurations(autoFocus: true),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ])
            ],
          );
        },
      ),
    );
  }
}
