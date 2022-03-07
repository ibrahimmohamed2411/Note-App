import 'package:bloc/bloc.dart';

class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false);
  void toggleTheme(bool value) {
    emit(value);
  }
}
