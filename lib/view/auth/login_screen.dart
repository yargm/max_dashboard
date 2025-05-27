import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/auth/login_controller.dart';
import 'package:maxdash/helpers/theme/app_theme.dart';
import 'package:maxdash/helpers/utils/mixins/ui_mixin.dart';
import 'package:maxdash/helpers/widgets/my_button.dart';
import 'package:maxdash/helpers/widgets/my_spacing.dart';
import 'package:maxdash/helpers/widgets/my_text.dart';
import 'package:maxdash/helpers/widgets/my_text_style.dart';
import 'package:maxdash/view/layouts/auth_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with UIMixin{
  late LoginController controller;

  @override
  void initState() {
    controller = Get.put(LoginController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      child: GetBuilder(
        init: controller,
        tag: 'login_controller',
        builder: (controller) {
        return Form(
          key: controller.basicValidator.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              MyText.titleLarge("Sign in with email", fontWeight: 600),
              MySpacing.height(12),
              MyText.bodyMedium("Make a new doc to bring your words, data and terms together. For free", fontWeight: 600, xMuted: true),
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
                    prefixIcon: const Icon(LucideIcons.mail, size: 16),
                    contentPadding: MySpacing.all(14),
                    isDense: true,
                    isCollapsed: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never),
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
                    filled: true,
                    fillColor: contentTheme.secondary.withAlpha(36),
                    prefixIcon: const Icon(LucideIcons.mail, size: 16),
                    contentPadding: MySpacing.all(16),
                    isCollapsed: true,
                    isDense: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    suffixIcon: InkWell(
                      onTap: controller.onChangeShowPassword,
                      child: Icon(controller.showPassword ? LucideIcons.eye : LucideIcons.eye_off, size: 16),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => controller.onChangeCheckBox(!controller.isChecked),
                    child: Row(
                      children: [
                        Checkbox(
                          onChanged: controller.onChangeCheckBox,
                          value: controller.isChecked,
                          fillColor: WidgetStatePropertyAll(Colors.white),
                          activeColor: theme.colorScheme.primary,
                          checkColor: contentTheme.primary,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: getCompactDensity,
                        ),
                        MySpacing.width(8),
                        MyText.bodySmall("Remember Me"),
                      ],
                    ),
                  ),
                  MyButton.text(
                    onPressed: controller.goToForgotPassword,
                    elevation: 0,
                    padding: MySpacing.xy(8, 0),
                    splashColor: contentTheme.secondary.withAlpha(36),
                    child: MyText.bodySmall('Forgot password?', color: contentTheme.secondary),
                  ),
                ],
              ),
              MySpacing.height(28),
              Center(
                child: MyButton.rounded(
                  onPressed: controller.onLogin,
                  elevation: 0,
                  padding: MySpacing.xy(20, 16),
                  backgroundColor: contentTheme.primary,
                  child: MyText.labelMedium('Login', color: contentTheme.onPrimary),
                ),
              ),
              Center(
                child: MyButton.text(
                  onPressed: controller.gotoRegister,
                  elevation: 0,
                  padding: MySpacing.x(16),
                  splashColor: contentTheme.secondary.withValues(alpha:0.1),
                  child: MyText.bodySmall('I haven\'t account'),
                ),
              ),
            ],
          ),
        );
      },),
    );
  }
}
