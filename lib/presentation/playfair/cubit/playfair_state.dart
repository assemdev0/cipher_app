part of 'playfair_cubit.dart';

@immutable
abstract class PlayfairState {}

class PlayfairInitial extends PlayfairState {}

class PlayfairEncryptState extends PlayfairState {}

class PlayfairDecryptState extends PlayfairState {}

class PlayfairResetState extends PlayfairState {}
