part of 'vigenere_cubit.dart';

@immutable
abstract class VigenereState {}

class VigenereInitial extends VigenereState {}

class VigenereEncryptState extends VigenereState {}

class VigenereDecryptState extends VigenereState {}

class VigenereResetState extends VigenereState {}
