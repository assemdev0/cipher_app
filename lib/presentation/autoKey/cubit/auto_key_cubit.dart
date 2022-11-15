import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auto_key_state.dart';

class AutoKeyCubit extends Cubit<AutoKeyState> {
  AutoKeyCubit() : super(AutoKeyInitial());

  static AutoKeyCubit get(context) => BlocProvider.of(context);

  final TextEditingController inputTextController = TextEditingController();
  final TextEditingController keyTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String result = '';

  // Encrypt
  void autoKeyEncrypt() {
    emit(AutoKeyInitial());
    // Get input text and key
    String plainText =
        inputTextController.text.toUpperCase().replaceAll(' ', '');
    String key = keyTextController.text.toUpperCase();
    key += plainText;
    String cypherText = '';
    const firstCharAscii = 65;

    // Encrypt
    for (int i = 0; i < plainText.length; i++) {
      // Get the ascii value of the character
      int plainTextChar = plainText.codeUnitAt(i) - firstCharAscii;

      // Get the ascii value of the key character
      int keyChar = key.codeUnitAt(i) - firstCharAscii;

      // Add the two values and get the remainder when divided by 26
      int cipherChar = (plainTextChar + keyChar) % 26;
      log('i- $i         Char: ${String.fromCharCode(plainTextChar + firstCharAscii)} - $plainTextChar,      Key: ${String.fromCharCode(keyChar + firstCharAscii)} - $keyChar           Cipher:  ${String.fromCharCode(cipherChar + firstCharAscii)} - $cipherChar');

      // Add the character to the cypher text
      cypherText += String.fromCharCode(cipherChar + firstCharAscii);
    }

    result = cypherText;
    emit(AutoKeyEncryptState());
  }

  // Decrypt
  void autoKeyDecrypt() {
    emit(AutoKeyInitial());

    // Get input text and key
    String cypherText =
        inputTextController.text.toUpperCase().replaceAll(' ', '');
    String key = keyTextController.text.toUpperCase();
    String plainText = '';
    const firstCharAscii = 65;

    // Decrypt
    for (int i = 0; i < cypherText.length; i++) {
      // Get the ASCII value of the character
      int cipherTextChar = cypherText.codeUnitAt(i) - firstCharAscii;

      // Get the ASCII value of the key character
      int keyChar = key.codeUnitAt(i) - firstCharAscii;

      // Subtract the key from the ASCII value
      int decryptedCharCode = (cipherTextChar - keyChar) % 26;

      // Complete key
      key += String.fromCharCode(decryptedCharCode + firstCharAscii);

      // Convert the ASCII value to a character
      plainText = plainText + String.fromCharCode(decryptedCharCode + 65);
    }
    result = plainText;
    emit(AutoKeyDecryptState());
  }

  // Reset
  void autoKeyReset() {
    emit(AutoKeyInitial());
    inputTextController.clear();
    keyTextController.clear();
    result = '';
    emit(AutoKeyResetState());
  }
}
