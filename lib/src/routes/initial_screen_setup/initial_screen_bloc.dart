import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shuttle/src/firebase_backend/firebase_initialize.dart';

part 'initial_screen_event.dart';

part 'initial_screen_state.dart';

class InitialScreenBloc
    extends Bloc<CheckInitialScreenAuthStateEvent, InitialScreenAuthState> {
  InitialScreenBloc(this._firebaseInitSingleton) : super(LoadingState()) {
    on<CheckInitialScreenAuthStateEvent>(_checkInitialScreenAuthStateHandler);
  }

  final FirebaseInitSingleton _firebaseInitSingleton;

  void _checkInitialScreenAuthStateHandler(
      CheckInitialScreenAuthStateEvent event,
      Emitter<InitialScreenAuthState> emit) async {
    await emit.forEach(_firebaseInitSingleton.authState, onData: (user) {
      if (user == null) {
        return LoggedOutState();
      } else {
        return LoggedInState();
      }
    });
  }
}
