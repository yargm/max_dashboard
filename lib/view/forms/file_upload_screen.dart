import 'package:maxdash/controller/forms/file_upload_controller.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/utils/my_shadow.dart';
import 'package:maxdash/helpers/utils/utils.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
import 'package:maxdash/helpers/widgets/my_card.dart';
import 'package:maxdash/helpers/widgets/my_container.dart';
import 'package:maxdash/helpers/widgets/my_list_extension.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class FileUploadScreen extends StatefulWidget {
  const FileUploadScreen({super.key});

  @override
  State<FileUploadScreen> createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> with SingleTickerProviderStateMixin, UIMixin {
  late FileUploadController controller;

  @override
  void initState() {
    controller = FileUploadController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'file_upload_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("File Upload", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [MyBreadcrumbItem(name: 'Form'), MyBreadcrumbItem(name: 'File Upload', active: true)],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: MyCard.bordered(
                  borderRadiusAll: 4,
                  border: Border.all(color: Colors.grey.withValues(alpha:.2)),
                  shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  padding: MySpacing.only(left: 23, top: 20, bottom: 23, right: 23),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          MyText.labelLarge("Multiple File Select"),
                          MySpacing.width(12),
                          Switch(
                            onChanged: controller.onSelectMultipleFile,
                            value: controller.selectMultipleFile,
                            activeColor: theme.colorScheme.primary,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ],
                      ),
                      MySpacing.height(20),
                      uploadFile()
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget uploadFile() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyContainer.bordered(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          onTap: controller.pickFiles,
          paddingAll: 24,
          child: Center(
            heightFactor: 1.5,
            child: Padding(
              padding: MySpacing.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(LucideIcons.folder_up),
                  MySpacing.height(12),
                  MyContainer(
                    width: 340,
                    alignment: Alignment.center,
                    paddingAll: 0,
                    child: MyText.titleMedium(
                      "Drop files here or click to upload.",
                      fontWeight: 600,
                      muted: true,
                      fontSize: 18,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  MyContainer(
                    alignment: Alignment.center,
                    width: 610,
                    child: MyText.titleMedium(
                      "(This is just a demo dropzone. Selected files are not actually uploaded.)",
                      muted: true,
                      fontWeight: 500,
                      fontSize: 16,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (controller.files.isNotEmpty) ...[
          MySpacing.height(16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: controller.files.mapIndexed((index, file) {
              String fileExtension = file.extension?.toUpperCase() ?? 'Unknown';
              return MyContainer.bordered(
                paddingAll: 8,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MyContainer(
                      color: contentTheme.onBackground.withAlpha(28),
                      paddingAll: 8,
                      child: MyText.labelMedium(fileExtension),
                    ),
                    MySpacing.width(16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.bodyMedium(file.name, maxLines: 1, overflow: TextOverflow.ellipsis, fontWeight: 600),
                        MyText.bodySmall(Utils.getStorageStringFromByte(file.bytes?.length ?? 0)),
                      ],
                    ),
                    MySpacing.width(32),
                    MyContainer.roundBordered(
                      onTap: () => controller.removeFile(file),
                      paddingAll: 4,
                      child: Icon(LucideIcons.x, size: 16),
                    ),
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ],
    );
  }
}
