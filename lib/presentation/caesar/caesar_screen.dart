import 'package:caesar_cipher/presentation/caesar/cubit/caesar_cubit.dart';
import 'package:caesar_cipher/presentation/resources/colors_manager.dart';
import 'package:caesar_cipher/presentation/resources/font_manager.dart';
import 'package:caesar_cipher/presentation/resources/strings_manager.dart';
import 'package:caesar_cipher/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/cipher_form_widget.dart';

class CaesarScreen extends StatelessWidget {
  const CaesarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CaesarCubit(),
      child: BlocConsumer<CaesarCubit, CaesarState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            body: CipherFormWidget(
              formKey: CaesarCubit.get(context).formKey,
              inputFormat: RegExp(r'[a-z A-Z]'),
              keyFormat: RegExp(r'[0-9]'),
              inputTextController: CaesarCubit.get(context).inputTextController,
              keyTextController: CaesarCubit.get(context).keyTextController,
              keyType: TextInputType.number,
              onEncrypt: () {
                CaesarCubit.get(context).caesarEncrypt();
              },
              onDecrypt: () {
                CaesarCubit.get(context).caesarDecrypt();
              },
              onReset: () {
                CaesarCubit.get(context).caesarReset();
              },
              result: CaesarCubit.get(context).result,
              title: StringsManager.caesarCipher,
            ),
          );
        },
      ),
    );
  }
}
