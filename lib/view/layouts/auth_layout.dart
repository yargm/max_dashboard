import 'package:maxdash/controller/layout/auth_layout_controller.dart';
import 'package:maxdash/helpers/widgets/my_container.dart';
import 'package:maxdash/helpers/widgets/my_flex.dart';
import 'package:maxdash/helpers/widgets/my_flex_item.dart';
import 'package:maxdash/helpers/widgets/my_responsive.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxdash/images.dart';

class AuthLayout extends StatelessWidget {
  final Widget? child;

  final AuthLayoutController controller = AuthLayoutController();

  AuthLayout({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return MyResponsive(builder: (BuildContext context, _, screenMT) {
      return GetBuilder(
          init: controller,
          builder: (controller) {
            return screenMT.isMobile ? mobileScreen(context) : largeScreen(context);
          });
    });
  }

  Widget mobileScreen(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          padding: MySpacing.x(24),
          key: controller.scrollKey,
          child: child,
        ),
      ),
    );
  }

  Widget largeScreen(BuildContext context) {
    return Scaffold(
        key: controller.scaffoldKey,
        body: MyFlex(
          spacing: 0,
          runSpacing: 0,
          runAlignment: WrapAlignment.center,
          wrapCrossAlignment: WrapCrossAlignment.center,
          wrapAlignment: WrapAlignment.center,
          children: [
            MyFlexItem(
                sizes: 'xxl-9 xl-8 lg-8 md-6 sm-0',
                child: Image.asset(
                  Images.authBackground,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                )),
            MyFlexItem(
              sizes: "xxl-3 xl-4 lg-4 md-6 sm-12",
              child: MyContainer(
                height: MediaQuery.of(context).size.height,
                paddingAll: 24,
                borderRadiusAll: 0,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: child ?? Container(),
              ),
            ),
          ],
        ));
  }
}
