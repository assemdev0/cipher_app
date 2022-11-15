import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/strings_manager.dart';
import '../widgets/cipher_form_widget.dart';
import 'cubit/auto_key_cubit.dart';

class AutoKeyScreen extends StatelessWidget {
  const AutoKeyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AutoKeyCubit(),
        child: BlocConsumer<AutoKeyCubit, AutoKeyState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return CipherFormWidget(
              formKey: AutoKeyCubit.get(context).formKey,
              inputFormat: RegExp(r'[a-z A-Z]'),
              keyFormat: RegExp(r'[a-zA-Z]'),
              inputTextController:
                  AutoKeyCubit.get(context).inputTextController,
              keyTextController: AutoKeyCubit.get(context).keyTextController,
              keyType: TextInputType.text,
              onEncrypt: () {
                AutoKeyCubit.get(context).autoKeyEncrypt();
              },
              onDecrypt: () {
                AutoKeyCubit.get(context).autoKeyDecrypt();
              },
              onReset: () {
                AutoKeyCubit.get(context).autoKeyReset();
              },
              result: AutoKeyCubit.get(context).result,
              title: StringsManager.autoKeyCipher,
            );
          },
        ),
      ),
    );
  }
}
