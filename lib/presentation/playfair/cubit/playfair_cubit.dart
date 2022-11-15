import 'package:caesar_cipher/presentation/resources/colors_manager.dart';
import 'package:caesar_cipher/presentation/resources/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';

part 'playfair_state.dart';

class PlayfairCubit extends Cubit<PlayfairState> {
  PlayfairCubit() : super(PlayfairInitial());

  static PlayfairCubit get(context) => BlocProvider.of(context);

  final TextEditingController inputTextController = TextEditingController();
  final TextEditingController keyTextController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String result = '';

  // Encrypt
  void playfairEncrypt() {
    emit(PlayfairInitial());
    // TODO: implement playfairEncrypt

    // Initializing text for encryption
    String plainText = inputTextController.text
        .toUpperCase()
        .replaceAll(' ', '')
        .replaceAll('J', 'I');

    String cypherText = '';

    // Splitting the text in 2 characters
    var plainList = plainText.split('');
    for (int i = 0; i < plainList.length - 1; i++) {
      if (plainList[i] == plainList[++i]) {
        plainList.insert(i, 'X');
      }
    }
    if (plainList.length % 2 != 0) {
      plainList.add('X');
    }

    // Get matrix
    var matrix = _generateMatrix();

    // Encrypting
    for (int i = 0; i < plainList.length - 1; i += 2) {
      // Get the position of the first character
      int firstCharIndex =
          matrix.indexWhere((element) => element.contains(plainList[i]));
      int firstCharColumnIndex = matrix[firstCharIndex].indexOf(plainList[i]);

      // Get the position of the second character
      int secondCharIndex =
          matrix.indexWhere((element) => element.contains(plainList[i + 1]));
      int secondCharColumnIndex =
          matrix[secondCharIndex].indexOf(plainList[i + 1]);

      if (firstCharIndex == secondCharIndex) {
        // Same row
        cypherText += matrix[firstCharIndex][(firstCharColumnIndex + 1) % 5];
        cypherText += matrix[secondCharIndex][(secondCharColumnIndex + 1) % 5];
      } else if (firstCharColumnIndex == secondCharColumnIndex) {
        // Same column
        cypherText += matrix[(firstCharIndex + 1) % 5][firstCharColumnIndex];
        cypherText += matrix[(secondCharIndex + 1) % 5][secondCharColumnIndex];
      } else {
        // Rectangle
        cypherText += matrix[firstCharIndex][secondCharColumnIndex];
        cypherText += matrix[secondCharIndex][firstCharColumnIndex];
      }
    }

    result = cypherText;

    emit(PlayfairEncryptState());
  }

  // Decrypt
  void playfairDecrypt({required BuildContext context}) {
    emit(PlayfairInitial());
    // TODO: implement playfairDecrypt

    // Initializing text for decryption
    String cypherText = inputTextController.text
        .toUpperCase()
        .replaceAll(' ', '')
        .replaceAll('J', 'I');
    String plainText = '';

    // Splitting the text in 2 characters
    var cypherList = cypherText.split('');
    var matrix = _generateMatrix();
    bool isRepeated = false;
    bool isOdd = false;

    for (int i = 0; i < cypherList.length - 1; i++) {
      if (cypherList[i] == cypherList[++i]) {
        isRepeated = true;
        break;
      }
    }
    if (cypherList.length % 2 != 0) {
      isOdd = true;
    }
    if (isOdd) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            StringsManager.pleaseEnterEvenNumberOfCharacter,
            style: TextStyle(
              color: ColorManager.white,
              fontFamily: FontConstants.fontFamily,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s20),
              topRight: Radius.circular(AppSize.s20),
            ),
          ),
          backgroundColor: ColorManager.error,
        ),
      );
    }
    if (isRepeated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            StringsManager.pleaseDontRepeatCharacter,
            style: TextStyle(
              color: ColorManager.white,
              fontFamily: FontConstants.fontFamily,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSize.s20),
              topRight: Radius.circular(AppSize.s20),
            ),
          ),
          backgroundColor: ColorManager.error,
        ),
      );
    }

    // Decrypting
    if (!isRepeated && !isOdd) {
      for (int i = 0; i < cypherList.length - 1; i += 2) {
        // Get the position of the first character
        int firstCharIndex =
            matrix.indexWhere((element) => element.contains(cypherList[i]));
        int firstCharColumnIndex =
            matrix[firstCharIndex].indexOf(cypherList[i]);

        // Get the position of the second character
        int secondCharIndex =
            matrix.indexWhere((element) => element.contains(cypherList[i + 1]));
        int secondCharColumnIndex =
            matrix[secondCharIndex].indexOf(cypherList[i + 1]);

        if (firstCharIndex == secondCharIndex) {
          // Same row
          plainText += matrix[firstCharIndex][(firstCharColumnIndex - 1) % 5];
          plainText += matrix[secondCharIndex][(secondCharColumnIndex - 1) % 5];
        } else if (firstCharColumnIndex == secondCharColumnIndex) {
          // Same column
          plainText += matrix[(firstCharIndex - 1) % 5][firstCharColumnIndex];
          plainText += matrix[(secondCharIndex - 1) % 5][secondCharColumnIndex];
        } else {
          // Rectangle
          plainText += matrix[firstCharIndex][secondCharColumnIndex];
          plainText += matrix[secondCharIndex][firstCharColumnIndex];
        }
      }
      result = plainText;
    }
    emit(PlayfairDecryptState());
  }

  // Reset
  void playfairReset() {
    emit(PlayfairInitial());
    inputTextController.clear();
    keyTextController.clear();
    result = '';
    emit(PlayfairResetState());
  }

  // Generate matrix
  List<List<String>> _generateMatrix() {
    // Generate matrix 5 * 5
    List<List<String>> matrix =
        List.generate(5, ((index) => ['', '', '', '', '']));

    String key = keyTextController.text
        .toUpperCase()
        .replaceAll(' ', '')
        .replaceAll('J', 'I');

    // Remove duplicate characters
    var keyList = key.split('').toSet();

    // Generate Alphabet List
    List<String> alphabetList = [];
    for (int index = 'A'.codeUnitAt(0); index <= 'Z'.codeUnitAt(0); index++) {
      if (String.fromCharCode(index) != 'J') {
        alphabetList.add(String.fromCharCode(index));
      }
    }
    alphabetList.removeWhere((element) => keyList.contains(element));

    // Add Key to Matrix
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        if (keyList.isNotEmpty) {
          matrix[i][j] = keyList.first;
          keyList.remove(keyList.first);
        } else {
          break;
        }
      }
    }

    // Add Alphabet to Matrix
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        if (matrix[i][j] != '') {
          continue;
        } else {
          matrix[i][j] = alphabetList.first;
          alphabetList.removeAt(0);
        }
      }
    }

    return matrix;
  }
}
