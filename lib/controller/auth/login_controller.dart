import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/helpers/services/auth_service.dart';
import 'package:maxdash/helpers/widgets/my_form_validator.dart';
import 'package:maxdash/helpers/widgets/my_validators.dart';

class LoginController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();

  bool showPassword = false, isChecked = false;

  final String _dummyEmail = "demo@example.com";
  final String _dummyPassword = "1234567";

  @override
  void onInit() {
    basicValidator.addField('email', required: true, label: "Email", validators: [MyEmailValidator()], controller: TextEditingController(text: _dummyEmail));

    basicValidator.addField('password',
        required: true, label: "Password", validators: [MyLengthValidator(min: 6, max: 10)], controller: TextEditingController(text: _dummyPassword));

    super.onInit();
  }

  void onChangeCheckBox(bool? value) {
    isChecked = value ?? isChecked;
    update();
  }

  void onChangeShowPassword() {
    showPassword = !showPassword;
    update();
  }

  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      update();
      var errors = await AuthService.loginUser(basicValidator.getData());
      if (errors != null) {
        basicValidator.addErrors(errors);
        basicValidator.validateForm();
        basicValidator.clearErrors();
      } else {
        String nextUrl = Uri.parse(ModalRoute.of(Get.context!)?.settings.name ?? "").queryParameters['next'] ?? "/home";
        Get.toNamed(nextUrl);
      }
      update();
    }
  }

  void goToForgotPassword() {
    Get.toNamed('/auth/forgot_password');
  }

  void gotoRegister() {
    Get.offAndToNamed('/auth/register_account');
  }
}
