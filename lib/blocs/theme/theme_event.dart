part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();
}

class DarkThemeEvent extends ThemeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LightThemeEvent extends ThemeEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
