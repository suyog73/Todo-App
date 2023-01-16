import 'package:equatable/equatable.dart';
import 'package:todo_bloc/blocs/bloc_exports.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(themeValue: false)) {
    on<DarkThemeEvent>(_onDarkThemeEvent);
    on<LightThemeEvent>(_onLightThemeEvent);
  }

  void _onDarkThemeEvent(DarkThemeEvent event, Emitter<ThemeState> emit) {
    emit(const ThemeState(themeValue: true));
  }

  void _onLightThemeEvent(LightThemeEvent event, Emitter<ThemeState> emit) {
    emit(const ThemeState(themeValue: false));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    return state.toMap();
  }
}
