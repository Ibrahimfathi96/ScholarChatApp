import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> userSignIn(
      {required String email, required String password}) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (exception) {
      if (exception.code == 'user-not-found') {
        emit(LoginFailure(errorMessage: 'this user is not found'));
      } else if (exception.code == 'wrong-password') {
        emit(LoginFailure(errorMessage: 'wrong password'));
      }
    } on Exception catch (e) {
      emit(LoginFailure(errorMessage: 'something went wrong'));
    }
  }
}
