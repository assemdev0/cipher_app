import 'package:caesar_cipher/presentation/caesar/caesar_screen.dart';
import 'package:caesar_cipher/presentation/home/cubit/home_cubit.dart';
import 'package:caesar_cipher/presentation/home/cubit/home_cubit.dart';
import 'package:caesar_cipher/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return DefaultTabController(
          length: cubit.tabPages.length,
          initialIndex: 0,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(StringsManager.appName),
              bottom: TabBar(
                tabs: cubit.tabPages,
              ),
            ),
            body: TabBarView(
              children: cubit.tabViews,
            ),
          ),
        );
      },
    );
  }
}
