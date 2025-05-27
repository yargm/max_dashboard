import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/auth/forgot_password_controller.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/widgets/my_button.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/helpers/widgets/my_text_style.dart';
import 'package:maxdash/view/layouts/auth_layout.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> with UIMixin {
  ForgotPasswordController controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Form(
              key: controller.basicValidator.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText.titleLarge("Forgot Password", fontWeight: 600),
                  MySpacing.height(12),
                  MyText.bodyMedium(
                      "Enter the email address associated with your account and we'll send an email instructions on how to recover your password.",
                      fontWeight: 600,
                      xMuted: true),
                  MySpacing.height(12),
                  TextFormField(
                    validator: controller.basicValidator.getValidation('email'),
                    controller: controller.basicValidator.getController('email'),
                    keyboardType: TextInputType.emailAddress,
                    style: MyTextStyle.labelMedium(),
                    decoration: InputDecoration(
                      labelText: "Email Address",
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      filled: true,
                      fillColor: contentTheme.secondary.withAlpha(36),
                      prefixIcon: Icon(LucideIcons.mail, size: 16),
                      contentPadding: MySpacing.all(15),
                      isDense: true,
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                    ),
                  ),
                  MySpacing.height(20),
                  Center(
                    child: MyButton.rounded(
                      onPressed: controller.onLogin,
                      elevation: 0,
                      padding: MySpacing.xy(20, 16),
                      backgroundColor: contentTheme.primary,
                      child: MyText.labelMedium('Forgot Password', color: contentTheme.onPrimary),
                    ),
                  ),
                  Center(
                    child: MyButton.text(
                      onPressed: controller.gotoLogIn,
                      elevation: 0,
                      padding: MySpacing.x(16),
                      splashColor: contentTheme.secondary.withValues(alpha:0.1),
                      child: MyText.labelMedium('Back to log in', color: contentTheme.secondary),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
