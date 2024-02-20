import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/products/enums/font_size_enum.dart';
import 'package:chat_connect_app/products/enums/localization_enum.dart';
import 'package:chat_connect_app/products/enums/text_field_type_enum.dart';
import 'package:chat_connect_app/products/init/language/locale_keys.g.dart';
import 'package:chat_connect_app/products/init/product_localization.dart';
import 'package:chat_connect_app/products/widgets/field/custom_text_form_field.dart';
import 'package:chat_connect_app/products/widgets/text/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
final class GeneralShowDialog {
  const GeneralShowDialog._();

  static Future<dynamic> dialog({required BuildContext context, required String title, required String subtitle}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: CustomText(title),
              content: CustomText(
                subtitle,
                size: FontSizeEnum.lowMid,
              ),
              actions: const [],
            ));
  }

  static Future<dynamic> dropdownLangugeDialog({required BuildContext context}) {
    return showDialog(
        context: context,
        builder: (context) {
          final currentLocale = context.locale;
          LocalizationEnum currentLocalizationEnum = LocalizationEnum.en;
          LocalizationEnum? decideCurrentLocaleEnum() {
            for (var element in LocalizationEnum.values) {
              if (element.toLocale == currentLocale) {
                return element;
              }
            }
            return null;
          }

          final response = decideCurrentLocaleEnum();
          if (response != null) {
            currentLocalizationEnum = response;
          }

          return AlertDialog(
            title: CustomText(
              LocaleKeys.dialog_languge_title_languges.tr(),
              isBold: true,
            ),
            content: DropdownButtonFormField<LocalizationEnum>(
              items: LocalizationEnum.values
                  .map((e) => DropdownMenuItem<LocalizationEnum>(
                        value: e,
                        child: Text(e.languge.tr()),
                      ))
                  .toList(),
              value: currentLocalizationEnum,
              onChanged: (value) async {
                if (value != null) {
                  final locale = context.locale;
                  if (value.toLocale != locale) {
                    ProductLocalization.updateLanguge(context: context, value: value);
                    context.read<BaseCubit>().updateLocalUpdated();
                  }
                }
              },
            ),
            actions: const [],
          );
        });
  }

  static Future<dynamic> addChatDialog(
      {required BuildContext context,
      required TextEditingController controller,
      required Future<void> Function()? onPressed}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: CustomText(
                LocaleKeys.dialog_chat_adding_body_title.tr(),
              ),
              content: CustomTextFormField(controller: controller, type: TextFieldTypeEnum.phone),
              actions: [
                TextButton(onPressed: onPressed, child: CustomText(LocaleKeys.dialog_chat_adding_body_button.tr()))
              ],
            ));
  }

  static Future<dynamic> addPostDialog(
      {required BuildContext context,
      required TextEditingController controller,
      required Future<void> Function()? onPressed}) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: CustomText(
                LocaleKeys.dialog_home_addPost_body_title.tr(),
              ),
              content: CustomTextFormField(controller: controller, type: TextFieldTypeEnum.text),
              actions: [
                TextButton(onPressed: onPressed, child: CustomText(LocaleKeys.dialog_home_addPost_body_button.tr()))
              ],
            ));
  }
}
