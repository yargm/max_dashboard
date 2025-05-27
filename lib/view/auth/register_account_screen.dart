import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/auth/register_account_controller.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/widgets/my_button.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/helpers/widgets/my_text_style.dart';
import 'package:maxdash/view/layouts/auth_layout.dart';

class RegisterAccountScreen extends StatefulWidget {
  const RegisterAccountScreen({super.key});

  @override
  State<RegisterAccountScreen> createState() => _RegisterAccountScreenState();
}

class _RegisterAccountScreenState extends State<RegisterAccountScreen> with UIMixin {
  RegisterAccountController controller = Get.put(RegisterAccountController());

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        builder: (controller) {
          return Form(
            key: controller.basicValidator.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText.titleLarge("Register", fontWeight: 600),
                MySpacing.height(12),
                MyText.bodyMedium("we're excited to have you on board,please activate your account by filling the details below",
                    fontWeight: 600, xMuted: true),
                MySpacing.height(12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        validator: controller.basicValidator.getValidation('first_name'),
                        controller: controller.basicValidator.getController('first_name'),
                        keyboardType: TextInputType.name,
                        style: MyTextStyle.labelMedium(),
                        decoration: InputDecoration(
                          labelText: "First Name",
                          labelStyle: MyTextStyle.bodySmall(xMuted: true),
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          prefixIcon: const Icon(LucideIcons.user, size: 16),
                          fillColor: contentTheme.secondary.withAlpha(36),
                          filled: true,
                          contentPadding: MySpacing.all(16),
                          isCollapsed: true,
                          isDense: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                    MySpacing.width(20),
                    Expanded(
                      child: TextFormField(
                        validator: controller.basicValidator.getValidation('last_name'),
                        controller: controller.basicValidator.getController('last_name'),
                        keyboardType: TextInputType.name,
                        style: MyTextStyle.labelMedium(),
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          labelStyle: MyTextStyle.bodySmall(xMuted: true),
                          border: OutlineInputBorder(borderSide: BorderSide.none),
                          prefixIcon: const Icon(
                            LucideIcons.user,
                            size: 16
                          ),
                          filled: true,
                          fillColor: contentTheme.secondary.withAlpha(36),
                          contentPadding: MySpacing.all(16),
                          isCollapsed: true,
                          isDense: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                  ],
                ),
                MySpacing.height(20),
                TextFormField(
                  validator: controller.basicValidator.getValidation('email'),
                  controller: controller.basicValidator.getController('email'),
                  keyboardType: TextInputType.emailAddress,
                  style: MyTextStyle.labelMedium(),
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    labelStyle: MyTextStyle.bodySmall(xMuted: true),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    prefixIcon: const Icon(
                      LucideIcons.mail,
                      size: 16
                    ),
                    filled: true,
                    fillColor: contentTheme.secondary.withAlpha(36),
                    contentPadding: MySpacing.all(16),
                    isCollapsed: true,
                    isDense: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),
                MySpacing.height(20),
                TextFormField(
                  validator: controller.basicValidator.getValidation('password'),
                  controller: controller.basicValidator.getController('password'),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !controller.showPassword,
                  style: MyTextStyle.labelMedium(),
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: MyTextStyle.bodySmall(xMuted: true),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: const Icon(
                        LucideIcons.lock,
                        size: 16,
                      ),
                      filled: true,
                      fillColor: contentTheme.secondary.withAlpha(36),
                      isDense: true,
                      suffixIcon: InkWell(
                        onTap: controller.onChangeShowPassword,
                        child: Icon(
                          controller.showPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          size: 16,
                        ),
                      ),
                      contentPadding: MySpacing.all(14),
                      isCollapsed: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never),
                ),
                MySpacing.height(30),
                Center(
                  child: MyButton.rounded(
                    onPressed: controller.onLogin,
                    elevation: 0,
                    padding: MySpacing.xy(20, 16),
                    backgroundColor: contentTheme.primary,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyText.bodySmall('Register', color: contentTheme.onPrimary),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: MyButton.text(
                    onPressed: controller.gotoLogin,
                    elevation: 0,
                    padding: MySpacing.x(16),
                    splashColor: contentTheme.secondary.withValues(alpha:0.1),
                    child: MyText.labelMedium(
                      'Already have account ?',
                      color: contentTheme.secondary,
                    ),
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
