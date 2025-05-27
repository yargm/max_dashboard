import 'package:maxdash/controller/ui/drag_n_drop_controller.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/utils/my_shadow.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
import 'package:maxdash/helpers/widgets/my_card.dart';
import 'package:maxdash/helpers/widgets/my_container.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reorderable_grid/reorderable_grid.dart';

class DragNDropScreen extends StatefulWidget {
  const DragNDropScreen({super.key});

  @override
  State<DragNDropScreen> createState() => _DragNDropScreenState();
}

class _DragNDropScreenState extends State<DragNDropScreen> with SingleTickerProviderStateMixin, UIMixin {
  late DragNDropController controller;

  @override
  void initState() {
    controller = Get.put(DragNDropController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'drag_n_drop_controller',
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
                      "Drag & Drop",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'Widget'),
                        MyBreadcrumbItem(name: 'Drag & Drop', active: true),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              if (controller.dragNDrop.isNotEmpty)
                Padding(
                  padding: MySpacing.x(flexSpacing),
                  child: SizedBox(
                    height: 700,
                    child: ReorderableGridView.extent(
                      maxCrossAxisExtent: 250,
                      onReorder: controller.onReorder,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      childAspectRatio: 0.82,
                      children: controller.dragNDrop.map((data) {
                        return MyCard.bordered(
                          borderRadiusAll: 4,
                          border: Border.all(color: Colors.grey.withValues(alpha:.2)),
                          shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
                          paddingAll: 24,
                          key: ValueKey(data.id),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyContainer(
                                paddingAll: 0,
                                child: Image.asset(data.image, fit: BoxFit.cover),
                              ),
                              Text(data.name),
                              Text(data.userName),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
