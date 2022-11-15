import 'package:caesar_cipher/presentation/home/cubit/home_cubit.dart';
import 'package:caesar_cipher/presentation/resources/routes_manager.dart';
import 'package:caesar_cipher/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/resources/theme_manager.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return MaterialApp(
            title: StringsManager.appName,
            debugShowCheckedModeBanner: false,
            theme: getApplicationTheme(),
            initialRoute: RoutesManager.home,
            routes: RoutesManager.routes,
            // home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
