import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/apps/ecommerce/product_detail_controller.dart';
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

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> with UIMixin {
  ProductDetailController controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'product_detail_controller',
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
                      "Product Detail",
                      fontSize: 18,
                      fontWeight: 600,
                    ),
                    MyBreadcrumb(
                      children: [
                        MyBreadcrumbItem(name: 'App'),
                        MyBreadcrumbItem(name: 'Product Detail'),
                      ],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(children: [
                  MyFlexItem(sizes: 'lg-5', child: productImages()),
                  MyFlexItem(sizes: 'lg-7', child: productDetails()),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget productImages() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      child: MyFlex(
        contentPadding: false,
        children: [
          MyFlexItem(
            sizes: 'xxl-2 xl-2 lg-2 md-2 sm-2 xs-2',
            child: SizedBox(
              height: 600,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: controller.product['images'].length,
                itemBuilder: (context, index) {
                  return MyContainer.bordered(
                    onTap: () => controller.onChangeImage(controller.product['images'][index]),
                    paddingAll: 0,
                    height: 100,
                    width: 100,
                    child: Image.asset(controller.product['images'][index], fit: BoxFit.fill),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 24);
                },
              ),
            ),
          ),
          MyFlexItem(
            sizes: 'xxl-10 xl-10 lg-10 md-10 sm-10 xs-10',
            child: MyContainer.bordered(
              height: 600,
              child: Image.asset(controller.selectedImage, fit: BoxFit.cover),
            ),
          ),
        ],
      ),
    );
  }

  Widget productDetails() {
    return MyCard.bordered(
      borderRadiusAll: 4,
      border: Border.all(color: Colors.grey.withValues(alpha:.2)),
      shadow: MyShadow(elevation: 1, position: MyShadowPosition.bottom),
      paddingAll: 24,
      height: 770,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: <Widget>[
              Expanded(child: MyText.titleLarge(controller.product['name'])),
              MyText.titleLarge('\$${controller.product['price'].toString()} ${controller.product['currency']}', fontWeight: 600, color: contentTheme.primary),
            ],
          ),
          MyText.bodyMedium('Brand: ${controller.product['brand']}'),
          Row(
            children: [
              Icon(LucideIcons.star, color: Colors.amber, size: 16),
              MySpacing.width(12),
              MyText.bodySmall(controller.product['rating'].toString()),
              MySpacing.width(12),
              MyText.bodySmall("(155 Customer Reviews)"),
            ],
          ),
          MyText.bodyMedium('Category: ${controller.product['category']}'),
          MyText.bodyMedium('Available Sizes: ${controller.product['size'].join(", ")}'),
          MyText.bodyMedium('Colors: ${controller.product['color'].join(", ")}'),
          MyText.bodyMedium('Description:'),
          MyText.labelMedium(controller.product['description']),
          MyText.bodyMedium('Material: ${controller.product['material']}'),
          MyText.bodyMedium('Stock Information:'),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: controller.product['size'].map<Widget>((size) {
              return MyContainer.bordered(
                paddingAll: 8,
                child: MyText.labelMedium('$size: ${controller.product['available_stock'][size]} units'),
              );
            }).toList(),
          ),
          Table(
            columnWidths: {0: FixedColumnWidth(150), 1: FlexColumnWidth()},
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                children: [
                  MyText.bodyMedium('Shipping Details:'),
                  Container(),
                ],
              ),
              TableRow(
                children: [
                  Container(height: 24),
                  Container(),
                ],
              ),
              TableRow(
                children: [
                  MyText.labelMedium('Weight:'),
                  MyText.bodySmall('${controller.product['shipping_details']['weight']}'),
                ],
              ),
              TableRow(
                children: [
                  MyText.labelMedium('Dimensions:'),
                  MyText.bodySmall('${controller.product['shipping_details']['dimensions']}'),
                ],
              ),
              TableRow(
                children: [
                  MyText.labelMedium('Shipping Cost:'),
                  MyText.bodySmall('\$${controller.product['shipping_details']['shipping_cost']}'),
                ],
              ),
              TableRow(
                children: [
                  MyText.labelMedium('Delivery Time:'),
                  MyText.bodySmall('${controller.product['shipping_details']['delivery_time']}'),
                ],
              ),
              TableRow(
                children: [
                  Container(height: 12),
                  Container(),
                ],
              ),
              if (controller.product['discounts'] != null) ...[
                TableRow(
                  children: [
                    MyText.labelMedium('Discount:'),
                    MyText.bodySmall('${controller.product['discounts']['current_discount']}% Off'),
                  ],
                ),
                TableRow(
                  children: [
                    MyText.labelMedium('Discount Type:'),
                    MyText.bodySmall('${controller.product['discounts']['discount_type']}'),
                  ],
                ),
                TableRow(
                  children: [
                    MyText.labelMedium('Valid From:'),
                    MyText.bodySmall('${controller.product['discounts']['start_date']}'),
                  ],
                ),
                TableRow(
                  children: [
                    MyText.labelMedium('Valid Until:'),
                    MyText.bodySmall('${controller.product['discounts']['end_date']}'),
                  ],
                ),
                TableRow(
                  children: [
                    Container(height: 12),
                    Container(),
                  ],
                ),
              ],
              TableRow(
                children: [
                  MyText.labelMedium('Tags:'),
                  MyText.bodySmall('${controller.product['tags'].join(", ")}'),
                ],
              ),
            ],
          ),
          Row(
            children: [
              MyButton.outlined(
                onPressed: () {},
                borderColor: contentTheme.primary,
                child: MyText.labelMedium('Add to Cart', fontWeight: 600),
              ),
              MySpacing.width(24),
              MyButton.medium(
                onPressed: () {},
                backgroundColor: contentTheme.primary,
                elevation: 0,
                child: MyText.labelMedium('Buy now', color: contentTheme.onPrimary, fontWeight: 600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
