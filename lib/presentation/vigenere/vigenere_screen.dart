import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/strings_manager.dart';
import '../widgets/cipher_form_widget.dart';
import 'cubit/vigenere_cubit.dart';

class VigenereScreen extends StatelessWidget {
  const VigenereScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => VigenereCubit(),
        child: BlocConsumer<VigenereCubit, VigenereState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return CipherFormWidget(
              formKey: VigenereCubit.get(context).formKey,
              inputFormat: RegExp(r'[a-z A-Z]'),
              keyFormat: RegExp(r'[a-zA-Z]'),
              inputTextController:
                  VigenereCubit.get(context).inputTextController,
              keyTextController: VigenereCubit.get(context).keyTextController,
              keyType: TextInputType.text,
              onEncrypt: () {
                VigenereCubit.get(context).vigenereEncrypt();
              },
              onDecrypt: () {
                VigenereCubit.get(context).vigenereDecrypt();
              },
              onReset: () {
                VigenereCubit.get(context).vigenereReset();
              },
              result: VigenereCubit.get(context).result,
              title: StringsManager.vigenereCipher,
            );
          },
        ),
      ),
    );
  }
}
