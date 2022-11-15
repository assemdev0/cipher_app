part of 'auto_key_cubit.dart';

@immutable
abstract class AutoKeyState {}

class AutoKeyInitial extends AutoKeyState {}

class AutoKeyEncryptState extends AutoKeyState {}

class AutoKeyDecryptState extends AutoKeyState {}

class AutoKeyResetState extends AutoKeyState {}
