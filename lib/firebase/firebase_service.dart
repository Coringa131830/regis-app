import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_pantry/pages/api_response.dart';
import 'package:smart_pantry/pages/login/usuario.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<ApiResponse<User>> login(String email, String senha) async {
    try {
      // Usuario do Firebase
      final authResult =
          await _auth.signInWithEmailAndPassword(email: email, password: senha);
      final User fUser = authResult.user;
      print("signed in ${authResult.user.displayName}");

      // Cria um usuario do app
      final user = Usuario(
          nome: fUser.displayName, email: fUser.email, foto: fUser.photoURL);
      user.save();

      // Resposta genérica

      if (user != null) {
        return ApiResponse.ok(
            /*result: true, msg: "Login efetuado com sucesso"*/);
      } else {
        return ApiResponse.error(
            msg: "Não foi possível fazer o login, tente novamente!");
      }
    } on FirebaseAuthException catch (e) {
      print(" >>> CODE : ${e.code}\n>>> ERRO : $e");
      return ApiResponse.error(
          msg: "Não foi possível fazer o login, tente novamente!");
    }
  }

  Future<ApiResponse> reset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return ApiResponse.ok();
    } on FirebaseAuthException catch (e) {
      print(" >>> CODE : ${e.code}\n>>> ERRO : $e");
      return ApiResponse.error(
          msg:
              "Não foi possível enviar o e-mail para redefinir a senha, tente novamente!");
    }
  }

  Future<ApiResponse> create(String email, String senha) async {
    try {
      final response = await _auth.createUserWithEmailAndPassword(
          email: email, password: senha);
      print("Create acc >>> ${response.toString()}");
      return ApiResponse.ok();
    } on FirebaseAuthException catch (e) {
      print(" >>> CODE : ${e.code}\n>>> ERRO : $e");
      return ApiResponse.error(
          msg: "Não foi possível criar sua conta, tente novamente!");
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
