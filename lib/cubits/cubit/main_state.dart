part of 'main_cubit.dart';

@immutable
abstract class MainState {}

class MainInitial extends MainState {}

//! --------------------------------------------------
class LoadingLoginState extends MainState {}

class SuccessLoginState extends MainState {}

class ErrorLoginState extends MainState {}

//! --------------------------------------------------
class LoadingRegisterState extends MainState {}

class SuccessRegisterState extends MainState {}

class ErrorRegisterState extends MainState {}

//! --------------------------------------------------

class LoadingGetCategoriesState extends MainState {}

class SuccessGetCategoriesState extends MainState {}

class ErrorGetCategoriesState extends MainState {}

//! --------------------------------------------------