import 'package:bloc/bloc.dart';

import 'color_of_the_app_state.dart';

class Color_of_the_appCubit extends Cubit<Color_of_the_appState> {
  Color_of_the_appCubit() : super(Color_of_the_appState().init());
}
