import 'package:chat_connect_app/features/base/cubit/base_cubit.dart';
import 'package:chat_connect_app/features/chat/cubit/chat_cubit.dart';
import 'package:chat_connect_app/features/chat_detail/cubit/chat_detail_cubit.dart';
import 'package:chat_connect_app/features/home/cubit/home_cubit.dart';
import 'package:chat_connect_app/features/login/cubit/login_cubit.dart';
import 'package:chat_connect_app/features/register/cubit/register_cubit.dart';
import 'package:chat_connect_app/features/settings/cubit/settings_cubit.dart';
import 'package:chat_connect_app/products/states/loading/loading_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
final class BlocInit extends MultiBlocProvider {
  BlocInit({super.key, required super.child})
      : super(providers: [
          BlocProvider<BaseCubit>(create: (context) => BaseCubit()),
          BlocProvider<LoadingCubit>(create: (context) => LoadingCubit()),
          BlocProvider<LoginCubit>(create: (context) => LoginCubit()),
          BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
          BlocProvider<ChatCubit>(create: (context) => ChatCubit()),
          BlocProvider<ChatDetailCubit>(create: (context) => ChatDetailCubit()),
          BlocProvider<RegisterCubit>(create: (context) => RegisterCubit()),
          BlocProvider<SettingsCubit>(create: (context) => SettingsCubit()),
        ]);
}
