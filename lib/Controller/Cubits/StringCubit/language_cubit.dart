import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<String> {
  LanguageCubit() : super("Eng");

  chnageLanguage(value) {
    emit(value);
  }
}
