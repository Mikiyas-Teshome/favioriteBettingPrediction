part of 'nav_bloc.dart';

@immutable
abstract class NavState {
  final int tabIndex;

  const NavState({required this.tabIndex});
}

class NavInitial extends NavState {
  const NavInitial({required super.tabIndex});
}
