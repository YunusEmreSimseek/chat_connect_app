import 'package:chat_connect_app/product/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/product/utility/extensions/validation_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum TextFieldTypeEnum {
  email(
    func: TextFieldTypeEnumFuncs.emailType,
    hintText: LocaleKeys.general_fieldType_email,
    prefixIcon: Icon(Icons.email_rounded),
    keyboardType: TextInputType.emailAddress,
  ),
  password(
    func: TextFieldTypeEnumFuncs.passwordType,
    hintText: LocaleKeys.general_fieldType_password,
    prefixIcon: Icon(Icons.password_rounded),
    isPassword: true,
    keyboardType: TextInputType.text,
  ),
  confirmPassword(
    func: TextFieldTypeEnumFuncs.passwordType,
    hintText: LocaleKeys.general_fieldType_confirmPassword,
    prefixIcon: Icon(Icons.password_rounded),
    isPassword: true,
    keyboardType: TextInputType.text,
  ),
  name(
    func: TextFieldTypeEnumFuncs.nameType,
    hintText: LocaleKeys.general_fieldType_name,
    prefixIcon: Icon(Icons.align_vertical_top),
    keyboardType: TextInputType.name,
  ),
  phone(
    func: TextFieldTypeEnumFuncs.phoneType,
    hintText: LocaleKeys.general_fieldType_phoneNumber,
    prefixIcon: Icon(Icons.phone),
    keyboardType: TextInputType.phone,
  ),
  text(
    func: null,
    hintText: '',
    prefixIcon: Icon(Icons.text_fields),
    keyboardType: TextInputType.text,
  );

  final String? Function(String?)? func;
  final String hintText;
  final Icon prefixIcon;
  final bool isPassword;
  final TextInputType keyboardType;
  const TextFieldTypeEnum(
      {required this.func,
      required this.hintText,
      required this.prefixIcon,
      this.isPassword = false,
      required this.keyboardType});
}

@immutable
final class TextFieldTypeEnumFuncs {
  static String? emailType(String? value) {
    if (!value!.isValidEmail) {
      return LocaleKeys.validation_email.tr();
    }
    return null;
  }

  static String? passwordType(String? value) {
    if (!value!.isPasswordValid) {
      return LocaleKeys.validation_password.tr();
    }
    return null;
  }

  static String? nameType(String? value) {
    if (value!.isEmpty) {
      return LocaleKeys.validation_phone.tr();
    }
    return null;
  }

  static String? phoneType(String? value) {
    if (!value!.isValidPhone) {
      return LocaleKeys.validation_name.tr();
    }
    return null;
  }
}
