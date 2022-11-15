import 'package:caesar_cipher/presentation/autoKey/auto_key_screen.dart';
import 'package:caesar_cipher/presentation/caesar/caesar_screen.dart';
import 'package:caesar_cipher/presentation/playfair/playfair_screen.dart';
import 'package:caesar_cipher/presentation/resources/strings_manager.dart';
import 'package:caesar_cipher/presentation/vigenere/vigenere_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  final tabPages = const <Widget>[
    Tab(text: StringsManager.ceasar),
    Tab(text: StringsManager.playfair),
    Tab(text: StringsManager.autoKey),
    Tab(text: StringsManager.vigenere),
  ];
  final tabViews = const <Widget>[
    CaesarScreen(),
    PlayfairScreen(),
    AutoKeyScreen(),
    VigenereScreen(),
  ];
}
