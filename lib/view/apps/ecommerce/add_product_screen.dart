import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/apps/ecommerce/add_product_controller.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/utils/my_shadow.dart';
import 'package:maxdash/helpers/utils/utils.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
import 'package:maxdash/helpers/widgets/my_button.dart';
import 'package:maxdash/helpers/widgets/my_card.dart';
import 'package:maxdash/helpers/widgets/my_container.dart';
import 'package:maxdash/helpers/widgets/my_dotted_line.dart';
import 'package:maxdash/helpers/widgets/my_flex.dart';
import 'package:maxdash/helpers/widgets/my_flex_item.dart';
import 'package:maxdash/helpers/widgets/my_list_extension.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/helpers/widgets/my_text_style.dart';
import 'package:maxdash/view/layouts/layout.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> with UIMixin {
  AddProductController controller = Get.put(AddProductController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'add_product_controller',
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
                      "Add Product",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Add Product'),
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
                    MyFlexItem(sizes: "lg-8 md-12", child: detail()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget detail() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha: .2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.server, size: 16),
              MySpacing.width(12),
              MyText.titleMedium("General", fontWeight: 600),
            ],
          ),
          MySpacing.height(24),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText.labelMedium("Product Name"),
              MySpacing.height(8),
              TextFormField(
                validator: controller.basicValidator.getValidation('product_name'),
                controller: controller.basicValidator.getController('product_name'),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "eg: Tomatoes",
                  hintStyle: MyTextStyle.bodySmall(xMuted: true),
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: focusedInputBorder,
                  contentPadding: MySpacing.all(16),
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
              MySpacing.height(24),
              MyText.labelMedium("Shop Name"),
              MySpacing.height(8),
              TextFormField(
                validator: controller.basicValidator.getValidation('shop_name'),
                controller: controller.basicValidator.getController('shop_name'),
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "eg: Fruits",
                  hintStyle: MyTextStyle.bodySmall(xMuted: true),
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: focusedInputBorder,
                  contentPadding: MySpacing.all(16),
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
              MySpacing.height(24),
              MyText.labelMedium("Description"),
              MySpacing.height(8),
              TextFormField(
                validator: controller.basicValidator.getValidation('description'),
                controller: controller.basicValidator.getController('description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "It's contains blah blah things",
                  hintStyle: MyTextStyle.bodySmall(xMuted: true),
                  border: outlineInputBorder,
                  enabledBorder: outlineInputBorder,
                  focusedBorder: focusedInputBorder,
                  contentPadding: MySpacing.all(16),
                  isCollapsed: true,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
              ),
              MySpacing.height(24),
              MyFlex(contentPadding: false, children: [
                MyFlexItem(
                    sizes: 'lg-6 md-12',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium(
                          "Category",
                        ),
                        MySpacing.height(8),
                        DropdownButtonFormField<Category>(
                          dropdownColor: contentTheme.background,
                          menuMaxHeight: 200,
                          isDense: true,
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem<Category>(
                                  value: category,
                                  child: MyText.labelMedium(
                                    category.name,
                                  ),
                                ),
                              )
                              .toList(),
                          icon: Icon(
                            Icons.expand_more,
                            size: 20,
                          ),
                          decoration: InputDecoration(
                            hintText: "Select category",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            contentPadding: MySpacing.all(14),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          onChanged: controller.basicValidator.onChanged<Object?>('Category'),
                        )
                      ],
                    )),
                MyFlexItem(
                    sizes: 'lg-6 md-12',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText.labelMedium("Price"),
                        MySpacing.height(8),
                        TextFormField(
                          validator: controller.basicValidator.getValidation('price'),
                          controller: controller.basicValidator.getController('price'),
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: "19.99",
                            hintStyle: MyTextStyle.bodySmall(xMuted: true),
                            border: outlineInputBorder,
                            enabledBorder: outlineInputBorder,
                            focusedBorder: focusedInputBorder,
                            prefixIcon: MyContainer.none(
                              margin: MySpacing.right(12),
                              alignment: Alignment.center,
                              color: contentTheme.primary.withAlpha(40),
                              child: MyText.labelLarge(
                                "\$",
                                color: contentTheme.primary,
                              ),
                            ),
                            prefixIconConstraints: BoxConstraints(maxHeight: 42, minWidth: 50, maxWidth: 50),
                            contentPadding: MySpacing.all(16),
                            isCollapsed: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                        ),
                      ],
                    )),
              ]),
              MySpacing.height(24),
              MyText.labelMedium("Status"),
              MySpacing.height(4),
              Wrap(
                  spacing: 16,
                  children: Status.values
                      .map(
                        (gender) => InkWell(
                          onTap: () => controller.onChangeGender(gender),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<Status>(
                                value: gender,
                                activeColor: theme.colorScheme.primary,
                                groupValue: controller.selectedGender,
                                onChanged: controller.onChangeGender,
                                visualDensity: getCompactDensity,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              MySpacing.width(8),
                              MyText.labelMedium(gender.name),
                            ],
                          ),
                        ),
                      )
                      .toList()),
              MySpacing.height(24),
              MyText.labelMedium("Tags"),
              MySpacing.height(8),
              Container(
                alignment: Alignment.topLeft,
                child: TextFormField(
                  maxLines: 3,
                  validator: controller.basicValidator.getValidation('tags'),
                  controller: controller.basicValidator.getController('tags'),
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    hintText: "fruits, vegetables, grocery, healthy, etc",
                    hintStyle: MyTextStyle.bodySmall(xMuted: true),
                    border: outlineInputBorder,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: focusedInputBorder,
                    contentPadding: MySpacing.all(16),
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
              ),
              MySpacing.height(24),
              productUpload(),
              MySpacing.height(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton.text(
                    onPressed: () {},
                    padding: MySpacing.xy(20, 16),
                    splashColor: contentTheme.secondary.withValues(alpha: 0.1),
                    child: MyText.bodySmall('Cancel'),
                  ),
                  MySpacing.width(12),
                  MyButton(
                    onPressed: () {},
                    elevation: 0,
                    padding: MySpacing.xy(20, 16),
                    backgroundColor: contentTheme.primary,
                    borderRadiusAll: AppStyle.buttonRadius.medium,
                    child: MyText.bodySmall(
                      'Save',
                      color: contentTheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget productUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: controller.pickFile,
          child: MyDottedLine(
            strokeWidth: 0.2,
            color: contentTheme.onBackground,
            corner: MyDottedLineCorner(leftBottomCorner: 2, leftTopCorner: 2, rightBottomCorner: 2, rightTopCorner: 2),
            child: Center(
              heightFactor: 1.5,
              child: Padding(
                padding: MySpacing.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined, size: 22),
                    MyContainer(
                      width: 340,
                      alignment: Alignment.center,
                      paddingAll: 0,
                      child: MyText.titleMedium(
                        "Drop Products here or click to upload.",
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
        ),
        if (controller.files.isNotEmpty) ...[
          MySpacing.height(16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: controller.files
                .mapIndexed((index, file) => MyContainer.bordered(
                      paddingAll: 8,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MyContainer(
                            color: contentTheme.onBackground.withAlpha(28),
                            paddingAll: 8,
                            child: Icon(Icons.insert_drive_file_outlined, size: 20),
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
                            child: Icon(Icons.close, size: 16),
                          ),
                        ],
                      ),
                    ))
                .toList(),
          )
        ],
      ],
    );
  }
}
