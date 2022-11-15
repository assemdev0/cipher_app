part of 'caesar_cubit.dart';

abstract class CaesarState {}

class CaesarInitial extends CaesarState {}

class CaesarEncryptState extends CaesarState {}

class CaesarDecryptState extends CaesarState {}

class CaesarResetState extends CaesarState {}
