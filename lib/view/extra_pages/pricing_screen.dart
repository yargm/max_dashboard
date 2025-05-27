import 'package:maxdash/controller/extra_pages/pricing_controller.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb.dart';
import 'package:maxdash/helpers/widgets/my_breadcrumb_item.dart';
import 'package:maxdash/helpers/widgets/my_button.dart';
import 'package:maxdash/helpers/widgets/my_container.dart';
import 'package:maxdash/helpers/widgets/my_flex.dart';
import 'package:maxdash/helpers/widgets/my_flex_item.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/helpers/widgets/my_text_style.dart';
import 'package:maxdash/view/layouts/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({super.key});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> with SingleTickerProviderStateMixin, UIMixin {
  late PricingController controller;

  @override
  void initState() {
    controller = PricingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: GetBuilder(
        init: controller,
        tag: 'pricing_controller',
        builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: MySpacing.x(flexSpacing),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText.titleMedium("Pricing", fontSize: 18, fontWeight: 600),
                    MyBreadcrumb(
                      children: [MyBreadcrumbItem(name: 'Extra'), MyBreadcrumbItem(name: 'Pricing', active: true)],
                    ),
                  ],
                ),
              ),
              MySpacing.height(flexSpacing),
              Padding(
                padding: MySpacing.x(flexSpacing / 2),
                child: MyFlex(
                  runAlignment: WrapAlignment.center,
                  wrapCrossAlignment: WrapCrossAlignment.center,
                  wrapAlignment: WrapAlignment.center,
                  children: [
                    MyFlexItem(
                        child: Column(
                      children: [
                        MyText.bodyLarge("Find your perfect plan: Transparent Pricing Tailored to your needs", fontWeight: 600),
                        MySpacing.height(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            MyText.bodyMedium(
                              "Monthly",
                              fontWeight: 600,
                              color: !controller.isMonth ? contentTheme.primary : null,
                            ),
                            Switch(
                              value: controller.isMonth,
                              activeColor: contentTheme.primary,
                              onChanged: (bool value) => controller.onSelectMonth(),
                            ),
                            MyText.bodyMedium(
                              "Annual",
                              fontWeight: 600,
                              color: controller.isMonth ? contentTheme.primary : null,
                            ),
                          ],
                        )
                      ],
                    )),
                    MyFlexItem(
                      sizes: 'xxl-2.5 xl-3.5 lg-12 sm-12',
                      child: buildData(
                        LucideIcons.zap,
                        "Starter Plan",
                        controller.isMonth ? "2.00" : "6.50",
                        'Start with essential tools and storage for small teams and personal use.',
                        '100 GB',
                        'Basic Cloud Storage',
                        'File Sharing & Access Controls',
                        'Collaborative Workspaces',
                        'Email and Chat Support',
                      ),
                    ),
                    MyFlexItem(
                      sizes: 'xxl-2.5 xl-3.5 lg-12 sm-12',
                      child: buildData(
                        LucideIcons.gem,
                        "Advanced Plan",
                        controller.isMonth ? "4.99" : "9.99",
                        'Unlock powerful tools, larger storage, and enhanced security for growing teams.',
                        '500 GB',
                        'Advanced Security Features',
                        'Team Collaboration & Project Management',
                        'Custom Integrations',
                        'Priority Email & Phone Support',
                      ),
                    ),
                    MyFlexItem(
                      sizes: 'xxl-2.5 xl-3.5 lg-12 sm-12',
                      child: buildData(
                        LucideIcons.graduation_cap,
                        "Enterprise Plan",
                        controller.isMonth ? "8.99" : "15.99",
                        'Designed for large enterprises with unlimited storage and dedicated support.',
                        'Unlimited Storage',
                        'Enterprise-Grade Security & Compliance',
                        'Custom API Access & Automation',
                        'Dedicated Account Manager',
                        '24/7 Premium Support & Dedicated Resources',
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

  Widget buildData(IconData icon, String pricingType, price, description, title1, title2, title3, title4, title5) {
    Widget pricingDetail(String title) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.check, size: 16),
          MySpacing.width(8),
          Expanded(
            child: MyText.bodySmall(
              title,
              fontWeight: 600,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      );
    }

    return MyContainer(
      paddingAll: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyContainer.roundBordered(
            borderColor: contentTheme.primary,
            paddingAll: 0,
            height: 44,
            width: 44,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Icon(icon, size: 20),
          ),
          MySpacing.height(16),
          MyText.bodyMedium(pricingType, fontWeight: 600),
          MySpacing.height(16),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: "\$$price/", style: MyTextStyle.displaySmall(fontWeight: 900)),
                TextSpan(text: "Month", style: MyTextStyle.titleLarge(fontWeight: 700))
              ],
            ),
          ),
          MySpacing.height(16),
          MyText.bodyMedium(description, fontWeight: 600, maxLines: 2),
          MySpacing.height(16),
          MyButton.block(
              elevation: 0,
              backgroundColor: contentTheme.primary,
              onPressed: () {},
              borderRadiusAll: 8,
              padding: MySpacing.y(20),
              child: MyText.bodyMedium("Get Started", fontWeight: 600, color: contentTheme.onPrimary)),
          MySpacing.height(16),
          MyText.bodyMedium("Everything in the ${pricingType.toLowerCase()} plan plus...", fontWeight: 600),
          MySpacing.height(16),
          pricingDetail(title1),
          MySpacing.height(16),
          pricingDetail(title2),
          MySpacing.height(16),
          pricingDetail(title3),
          MySpacing.height(16),
          pricingDetail(title4),
          MySpacing.height(16),
          pricingDetail(title5),
        ],
      ),
    );
  }
}
