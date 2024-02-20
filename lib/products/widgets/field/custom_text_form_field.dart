import 'package:chat_connect_app/features/register/cubit/register_cubit.dart';
import 'package:chat_connect_app/products/enums/font_size_enum.dart';
import 'package:chat_connect_app/products/enums/text_field_type_enum.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

final class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.controller, required this.type, this.isLogin = false});
  final TextEditingController controller;
  final TextFieldTypeEnum type;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final read = context.read<RegisterCubit>();
        return TextFormField(
          style: context.general.textTheme.titleMedium?.copyWith(fontSize: FontSizeEnum.lowMid.value),
          autovalidateMode: isLogin ? AutovalidateMode.disabled : AutovalidateMode.onUserInteraction,
          validator: (value) => type.func == null ? null : type.func!(value),
          controller: controller,
          obscureText: type.isPassword ? state.obscureText : false,
          keyboardType: type.keyboardType,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.all(context.border.normalRadius)),
            hintText: type.hintText.tr(),
            prefixIcon: type.prefixIcon,
            suffix: type.isPassword
                ? InkWell(
                    onTap: () => read.changeObscureText(),
                    child: Icon(state.obscureText ? Icons.remove_red_eye : Icons.remove_red_eye_outlined),
                  )
                : null,
          ),
        );
      },
    );
  }
}
