import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/apps/file_manager_controller.dart';
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
import 'package:maxdash/helpers/widgets/my_list_extension.dart';
import 'package:maxdash/helpers/widgets/my_progress_bar.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/images.dart';
import 'package:maxdash/view/layouts/layout.dart';

class FileManagerScreen extends StatefulWidget {
  const FileManagerScreen({super.key});

  @override
  State<FileManagerScreen> createState() => _FileManagerScreenState();
}

class _FileManagerScreenState extends State<FileManagerScreen> with UIMixin {
  FileManagerController controller = Get.put(FileManagerController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'file_manager_controller',
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
                      "File Manager",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'File Manager'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(children: [
                  MyFlexItem(sizes: 'lg-3 md-6', child: index()),
                  MyFlexItem(sizes: 'lg-9 md-6', child: files()),
                ]),
              )
            ],
          );
        },
      ),
    );
  }

  Widget index() {
    Widget buildCreateNew(String fileName, IconData icon) {
      return InkWell(
        onTap: () {},
        child: Row(
          children: [
            Icon(icon, size: 20),
            MySpacing.width(16),
            MyText.labelMedium(fileName, fontWeight: 600),
          ],
        ),
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyButton.block(
            onPressed: () {},
            elevation: 0,
            backgroundColor: contentTheme.primary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.plus),
                MySpacing.width(12),
                Flexible(child: MyText.bodyMedium("Create New Folder", fontWeight: 600, color: contentTheme.onPrimary, maxLines: 1)),
              ],
            ),
          ),
          MySpacing.height(24),
          for (Map<String, dynamic> item in controller.indexFiles)
            Column(
              children: [buildCreateNew(item["name"], item["icon"]), MySpacing.height(24)],
            ),
          MyText.bodySmall("STORAGE", fontWeight: 700),
          MySpacing.height(14),
          MyProgressBar(width: 400, progress: 0.75, height: 5, radius: 4, inactiveColor: theme.dividerColor, activeColor: contentTheme.primary),
          MySpacing.height(14),
          MyText.labelMedium("11.25 GB (75%) of 15 GB used", fontWeight: 700, xMuted: true),
          MySpacing.height(26),
          Center(
            child: MyButton.large(
              onPressed: () {},
              elevation: 0,
              backgroundColor: contentTheme.primary,
              child: MyText.labelMedium("Upgrade Storage", fontWeight: 600, color: contentTheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Widget files() {
    buildFileData(Color color, icons, String fileName, dynamic bytes) {
      return MyContainer.bordered(
        paddingAll: 12,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyContainer(
              paddingAll: 12,
              color: color.withAlpha(28),
              child: Icon(icons, color: color, size: 20),
            ),
            MySpacing.width(12),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.bodyMedium(fileName),
                  MySpacing.height(4),
                  MyText.labelMedium(Utils.getStorageStringFromByte(bytes)),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText.bodyMedium("Folders", fontWeight: 600),
          MySpacing.height(24),
          Wrap(
            runSpacing: 24,
            spacing: 24,
            children: [
              buildFileData(contentTheme.warning, LucideIcons.file_audio, "Music.mp3", 18432000),
              buildFileData(contentTheme.info, LucideIcons.folder, "Documents", 7823456789),
              buildFileData(contentTheme.secondary, LucideIcons.file_video, "Movie.mp4", 1099511627776),
              buildFileData(contentTheme.pink, LucideIcons.file_image, "Vacation.jpg", 50270000),
              buildFileData(contentTheme.info, LucideIcons.folder, "Projects", 147258369012),
              buildFileData(contentTheme.success, LucideIcons.file_code, "SourceCode.java", 893568),
              buildFileData(contentTheme.red, LucideIcons.file_text, "Ebook.pdf", 23498201),
            ],
          ),
          MySpacing.height(24),
          MyText.bodyMedium("Quick Access", fontWeight: 600),
          MySpacing.height(24),
          Wrap(
            runSpacing: 24,
            spacing: 24,
            children: [
              buildFileData(contentTheme.info, LucideIcons.file_text, "Readme.txt", 102400),
              buildFileData(contentTheme.warning, LucideIcons.file, "Document.pdf", 15728640),
              buildFileData(contentTheme.secondary, LucideIcons.file_code, "Report.xlsx", 209715200),
              buildFileData(contentTheme.pink, LucideIcons.file_archive, "Backup.zip", 524288000),
            ],
          ),
          MySpacing.height(24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: MyContainer.none(
              borderRadiusAll: 4,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: DataTable(
                sortAscending: true,
                columnSpacing: 95,
                onSelectAll: (_) => {},
                headingRowColor: WidgetStatePropertyAll(contentTheme.primary.withAlpha(40)),
                dataRowMaxHeight: 60,
                showBottomBorder: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                border: TableBorder.all(borderRadius: BorderRadius.circular(4), style: BorderStyle.solid, width: .4, color: Colors.grey),
                columns: [
                  DataColumn(label: MyText.labelLarge("Name", color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge("Last Modified", color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge("Size", color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge("Owner", color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge("Members", color: contentTheme.primary)),
                  DataColumn(label: MyText.labelLarge("Action", color: contentTheme.primary)),
                ],
                rows: [
                  buildDataRows("UI/UX Design Files", DateTime.utc(2024, 4, 10), "Sarah", 167772160, "Ethan Williams", LucideIcons.images,
                      [Images.avatars[1], Images.avatars[2], Images.avatars[4]]),
                  buildDataRows("App Prototype.sketch", DateTime.utc(2022, 7, 19), "DesignHub", 734003200, "Visionary Studios", LucideIcons.file_minus,
                      [Images.avatars[3], Images.avatars[5]]),
                  buildDataRows("System Architecture.pdf", DateTime.utc(2021, 11, 5), "Lucas", 10485760, "Michael Scott", LucideIcons.file_text,
                      [Images.avatars[0], Images.avatars[3], Images.avatars[4]]),
                  buildDataRows("High-Fidelity Wireframes", DateTime.utc(2023, 8, 22), "Madeline", 7340032, "David Green", LucideIcons.folder,
                      [Images.avatars[2], Images.avatars[4]]),
                  buildDataRows("Tech Specs.docx", DateTime.utc(2021, 5, 15), "Oliver", 9437184, "Jessica Lee", LucideIcons.bookmark,
                      [Images.avatars[5], Images.avatars[1]]),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  buildDataRows(String name, DateTime modifyAt, String author, int bytes, String owner, IconData? icon, List<String> images) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              Icon(icon, size: 22),
              MySpacing.width(16),
              MyText.labelMedium(name, fontWeight: 600),
            ],
          ),
        ),
        DataCell(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText.labelMedium('${Utils.getDateStringFromDateTime(modifyAt, showMonthShort: true)}'),
              MyText.bodySmall("by $author", muted: true),
            ],
          ),
        ),
        DataCell(MyText.labelMedium(Utils.getStorageStringFromByte(bytes))),
        DataCell(MyText.labelMedium(owner)),
        DataCell(
          SizedBox(
            width: 130,
            child: Stack(
                alignment: Alignment.centerRight,
                children: images
                    .mapIndexed((index, image) => Positioned(
                          left: (18 + (20 * index)).toDouble(),
                          child: MyContainer.rounded(
                            bordered: true,
                            paddingAll: 0,
                            child: Image.asset(image, height: 28, width: 28, fit: BoxFit.cover),
                          ),
                        ))
                    .toList()),
          ),
        ),
        DataCell(MyContainer.none(
          paddingAll: 8,
          borderRadiusAll: 5,
          color: contentTheme.primary.withValues(alpha:0.05),
          child: PopupMenuButton(
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: Row(
                    children: [Icon(LucideIcons.share, size: 16), MySpacing.width(8), MyText.bodySmall("Share")],
                  )),
              PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: Row(
                    children: [Icon(LucideIcons.link, size: 16), MySpacing.width(8), MyText.bodySmall("Get Sharable Link")],
                  )),
              PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: Row(
                    children: [Icon(LucideIcons.pencil, size: 16), MySpacing.width(8), MyText.bodySmall("Rename")],
                  )),
              PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: Row(
                    children: [Icon(LucideIcons.download, size: 16), MySpacing.width(8), MyText.bodySmall("Download")],
                  )),
              PopupMenuItem(
                  padding: MySpacing.xy(16, 8),
                  height: 10,
                  child: Row(
                    children: [Icon(LucideIcons.trash, size: 16), MySpacing.width(8), MyText.bodySmall("Remove")],
                  ))
            ],
            child: Icon(LucideIcons.ellipsis, size: 18),
          ),
        )),
      ],
    );
  }
}
