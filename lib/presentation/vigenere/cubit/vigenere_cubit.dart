import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'vigenere_state.dart';

class VigenereCubit extends Cubit<VigenereState> {
  VigenereCubit() : super(VigenereInitial());

  static VigenereCubit get(context) => BlocProvider.of(context);

  final TextEditingController inputTextController = TextEditingController();
  final TextEditingController keyTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String result = '';

  // Encrypt
  void vigenereEncrypt() {
    emit(VigenereInitial());
    // Get input text and key
    String plainText =
        inputTextController.text.toUpperCase().replaceAll(' ', '');
    String key = keyTextController.text.toUpperCase();
    String fullKey = '';

    // Generate full key
    while (fullKey.length < plainText.length) {
      fullKey += key;
    }
    String cypherText = '';
    const firstCharAscii = 65;

    // Encrypt
    for (int i = 0; i < plainText.length; i++) {
      // Get the ascii value of the character
      int plainTextChar = plainText.codeUnitAt(i) - firstCharAscii;

      // Get the ascii value of the key character
      int keyChar = fullKey.codeUnitAt(i) - firstCharAscii;

      // Add the two values and get the remainder when divided by 26
      int cipherChar = (plainTextChar + keyChar) % 26;
      log('i- $i         Char: ${String.fromCharCode(plainTextChar + firstCharAscii)} - $plainTextChar,      Key: ${String.fromCharCode(keyChar + firstCharAscii)} - $keyChar           Cipher:  ${String.fromCharCode(cipherChar + firstCharAscii)} - $cipherChar');

      // Add the character to the cypher text
      cypherText += String.fromCharCode(cipherChar + firstCharAscii);
    }

    result = cypherText;
    emit(VigenereEncryptState());
  }

  // Decrypt
  void vigenereDecrypt() {
    emit(VigenereInitial());

    // Get input text and key
    String cypherText =
        inputTextController.text.toUpperCase().replaceAll(' ', '');
    String key = keyTextController.text.toUpperCase();
    String fullKey = '';
    String plainText = '';
    const firstCharAscii = 65;

    // Generate full key
    while (fullKey.length < cypherText.length) {
      fullKey += key;
    }

    // Decrypt
    for (int i = 0; i < cypherText.length; i++) {
      // Get the ASCII value of the character
      int cipherTextChar = cypherText.codeUnitAt(i) - firstCharAscii;

      // Get the ASCII value of the key character
      int keyChar = fullKey.codeUnitAt(i) - firstCharAscii;

      // Subtract the key from the ASCII value
      int decryptedCharCode = (cipherTextChar - keyChar) % 26;

      // Convert the ASCII value to a character
      plainText = plainText + String.fromCharCode(decryptedCharCode + 65);
    }
    result = plainText;
    emit(VigenereDecryptState());
  }

  // Reset
  void vigenereReset() {
    emit(VigenereInitial());
    inputTextController.clear();
    keyTextController.clear();
    result = '';
    emit(VigenereResetState());
  }
}
