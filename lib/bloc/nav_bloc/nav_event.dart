part of 'nav_bloc.dart';

@immutable
abstract class NavEvent {}

class NavTabChange extends NavEvent {
  final int tabIndex;

  NavTabChange({required this.tabIndex});
}
