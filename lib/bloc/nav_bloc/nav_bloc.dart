import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'nav_event.dart';
part 'nav_state.dart';

class NavBloc extends Bloc<NavEvent, NavState> {
  NavBloc() : super(NavInitial(tabIndex: 0)) {
    on<NavEvent>((event, emit) {
      if (event is NavTabChange) {
        print(event.tabIndex);
        emit(NavInitial(tabIndex: event.tabIndex));
      }
    });
  }
}
