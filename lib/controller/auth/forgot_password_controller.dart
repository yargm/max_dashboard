import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:maxdash/controller/my_controller.dart';
import 'package:maxdash/helpers/services/auth_service.dart';
import 'package:maxdash/helpers/widgets/my_form_validator.dart';
import 'package:maxdash/helpers/widgets/my_validators.dart';

class ForgotPasswordController extends MyController {
  MyFormValidator basicValidator = MyFormValidator();
  bool showPassword = false;

  @override
  void onInit() {
    basicValidator.addField(
      'email',
      required: true,
      label: "Email",
      validators: [MyEmailValidator()],
      controller: TextEditingController(text: "demo@example.com"),
    );

    super.onInit();
  }

  Future<void> onLogin() async {
    if (basicValidator.validateForm()) {
      update();
      var errors = await AuthService.loginUser(basicValidator.getData());
      if (errors != null) {
        basicValidator.validateForm();
        basicValidator.clearErrors();
      }
      Get.toNamed('/auth/reset_password');
      update();
    }
  }

  void gotoLogIn() {
    Get.toNamed('/auth/login');
  }
}
