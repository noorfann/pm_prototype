import 'package:bloc/bloc.dart';
import 'package:pm_prototype/routes/routes.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit() : super(MenuState(selectedRoute: rootScreen));

  void updateSelectedRoute(String route) {
    emit(MenuState(selectedRoute: route));
  }
}
