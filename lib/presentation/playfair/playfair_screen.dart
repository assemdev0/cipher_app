import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/strings_manager.dart';
import '../widgets/cipher_form_widget.dart';
import 'cubit/playfair_cubit.dart';

class PlayfairScreen extends StatelessWidget {
  const PlayfairScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlayfairCubit(),
      child: BlocConsumer<PlayfairCubit, PlayfairState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Scaffold(
            body: CipherFormWidget(
              formKey: PlayfairCubit.get(context).formKey,
              inputFormat: RegExp(r'[a-z A-Z]'),
              keyFormat: RegExp(r'[a-z A-Z]'),
              inputTextController:
                  PlayfairCubit.get(context).inputTextController,
              keyTextController: PlayfairCubit.get(context).keyTextController,
              keyType: TextInputType.text,
              onEncrypt: () {
                PlayfairCubit.get(context).playfairEncrypt();
              },
              onDecrypt: () {
                PlayfairCubit.get(context).playfairDecrypt(context: context);
              },
              onReset: () {
                PlayfairCubit.get(context).playfairReset();
              },
              result: PlayfairCubit.get(context).result,
              title: StringsManager.playfairCipher,
            ),
          );
        },
      ),
    );
  }
}
