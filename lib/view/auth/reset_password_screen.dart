import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/auth/reset_password_controller.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/widgets/my_button.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/helpers/widgets/my_text_style.dart';
import 'package:maxdash/view/layouts/auth_layout.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with UIMixin {
  ResetPasswordController controller = Get.put(ResetPasswordController());
  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        tag: 'reset_password_controller',
        builder: (controller) {
          return Form(
            key: controller.basicValidator.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText.titleLarge("Reset Password", fontWeight: 600),
                MySpacing.height(20),
                TextFormField(
                    validator: controller.basicValidator.getValidation('password'),
                    controller: controller.basicValidator.getController('password'),
                    keyboardType: TextInputType.visiblePassword,
                    style: MyTextStyle.labelMedium(),
                    decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: MyTextStyle.bodySmall(xMuted: true),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        suffixIcon: InkWell(
                          onTap: () => controller.onChangeShowPassword(),
                          child: Icon(controller.showPassword ? LucideIcons.eye_off : LucideIcons.eye, size: 16),
                        ),
                        prefixIcon: Icon(LucideIcons.lock, size: 16),
                        contentPadding: MySpacing.all(16),
                        isCollapsed: true,
                        isDense: true,
                        fillColor: contentTheme.secondary.withAlpha(36),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never),
                    obscureText: controller.showPassword),
                MySpacing.height(20),
                TextFormField(
                  validator: controller.basicValidator.getValidation('confirm_password'),
                  controller: controller.basicValidator.getController('confirm_password'),
                  keyboardType: TextInputType.visiblePassword,
                  style: MyTextStyle.labelMedium(),
                  decoration: InputDecoration(
                      labelText: "Confirm Password",
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      suffixIcon: InkWell(
                        onTap: () => controller.onConfirmPassword(),
                        child: Icon(controller.confirmPassword ? LucideIcons.eye_off : LucideIcons.eye, size: 16),
                      ),
                      prefixIcon: Icon(LucideIcons.lock, size: 16),
                      contentPadding: MySpacing.all(16),
                      isCollapsed: true,
                      isDense: true,
                      filled: true,
                      fillColor: contentTheme.secondary.withAlpha(36),
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                  obscureText: controller.confirmPassword,
                ),
                MySpacing.height(20),
                Center(
                  child: MyButton.rounded(
                    onPressed: controller.onResetPassword,
                    elevation: 0,
                    padding: MySpacing.xy(20, 16),
                    backgroundColor: contentTheme.primary,
                    child: MyText.labelMedium('Reset Password', color: contentTheme.onPrimary),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
