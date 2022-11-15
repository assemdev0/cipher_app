import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'caesar_state.dart';

class CaesarCubit extends Cubit<CaesarState> {
  CaesarCubit() : super(CaesarInitial());

  static CaesarCubit get(BuildContext context) => BlocProvider.of(context);
  final TextEditingController inputTextController = TextEditingController();
  final TextEditingController keyTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String result = '';

  // Encrypt
  void caesarEncrypt() {
    emit(CaesarInitial());
    // Get input text and key
    String plainText =
        inputTextController.text.toUpperCase().replaceAll(' ', '');
    int key = int.parse(keyTextController.text);
    String cypherText = '';

    // Encrypt
    for (int i = 0; i < plainText.length; i++) {
      // Get the ASCII value of the character
      int charCode = plainText.codeUnitAt(i) - 65;

      // Add the key to the ASCII value
      int encryptedCharCode = (charCode + key) % 26;

      // Convert the ASCII value to a character
      cypherText = cypherText + String.fromCharCode(encryptedCharCode + 65);
    }

    result = cypherText;
    emit(CaesarEncryptState());
  }

  // Decrypt
  void caesarDecrypt() {
    emit(CaesarInitial());

    // Get input text and key
    String cypherText =
        inputTextController.text.toUpperCase().replaceAll(' ', '');
    int key = int.parse(keyTextController.text);
    String plainText = '';

    // Decrypt
    for (int i = 0; i < cypherText.length; i++) {
      // Get the ASCII value of the character
      int charCode = cypherText.codeUnitAt(i) - 65;

      // Subtract the key from the ASCII value
      int decryptedCharCode = (charCode - key) % 26;

      // Convert the ASCII value to a character
      plainText = plainText + String.fromCharCode(decryptedCharCode + 65);
    }
    result = plainText;
    emit(CaesarDecryptState());
  }

  // Reset
  void caesarReset() {
    emit(CaesarInitial());
    inputTextController.clear();
    keyTextController.clear();
    result = '';
    emit(CaesarResetState());
  }
}
