import 'package:maxdash/helpers/utils/my_string_utils.dart';
import 'package:maxdash/helpers/widgets/my_field_validator.dart';

class MyEmailValidator extends MyFieldValidatorRule<String> {
  @override
  String? validate(String? value, bool required, Map<String, dynamic> data) {
    if (!required) {
      if (value == null) {
        return null;
      }
    } else if (value != null &&
        value.isNotEmpty &&
        !MyStringUtils.isEmail(value)) {
      return "Please enter valid email";
    }
    return null;
  }
}

class MyLengthValidator implements MyFieldValidatorRule<String> {
  final bool short, required;
  final int? min, max, exact;

  MyLengthValidator(
      {this.required = true,
      this.exact,
      this.min,
      this.max,
      this.short = false});

  @override
  String? validate(String? value, bool required, Map<String, dynamic> data) {
    if (value != null) {
      if (!required && value.isEmpty) {
        return null;
      }
      if (exact != null && value.length != exact!) {
        return short
            ? "Need $exact characters"
            : "Need exact $exact characters";
      }
      if (min != null && value.length < min!) {
        return short ? "Need $min characters" : "Longer than $min characters";
      }
      if (max != null && value.length > max!) {
        return short ? "Only $max characters" : "Lesser than $max characters";
      }
    }
    return null;
  }
}

class MyNameValidator implements MyFieldValidatorRule<String> {
  final bool required;
  final int? min, max;

  MyNameValidator({
    this.required = true,
    this.min,
    this.max,
  });

  @override
  String? validate(String? value, bool required, Map<String, dynamic> data) {
    if (value != null) {
      if (!required && value.isEmpty) {
        return null;
      }
      if (min != null && value.length < min!) {
        return "Name should be at least $min characters long";
      }
      if (max != null && value.length > max!) {
        return "Name should be at most $max characters long";
      }
    }
    return null;
  }
}
