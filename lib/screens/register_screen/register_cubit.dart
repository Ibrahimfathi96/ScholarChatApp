import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> userRegistration({required String email, required String password}) async {
    emit(RegisterLoading());
    try {
    UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password);
    emit(RegisterSuccess());
    }on FirebaseAuthException catch (exception) {
      if (exception.code == 'weak password') {
       emit(RegisterFailure(errorMessage: 'Invalid password'));
      } else if (exception.code == 'email-already-in-use') {
        emit(RegisterFailure(errorMessage: 'this email is already in use'));
      }
    }on Exception catch (err) {
      emit(RegisterFailure(errorMessage:'something went wrong, please try again'));
    }
  }
}
