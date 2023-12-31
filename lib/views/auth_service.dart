import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  FirebaseAuth firebaseAuth=FirebaseAuth.instance;

  // ignore: body_might_complete_normally_nullable
  Future<User?> signUp(String email,String password) async {
  try{ final UserCredential userCredential = 
   await  firebaseAuth.createUserWithEmailAndPassword( //when work with intrnet use await
      email: email,
      password: password);
      return userCredential.user; 
      } catch (e) {
        // ignore: avoid_print
        print(e);
        }  }

  Future<User?> signIn(String email,String password) async {
  try{ final UserCredential userCredential = 
   await  firebaseAuth.signInWithEmailAndPassword( 
      email: email,
      password: password);
      return userCredential.user; 
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
  return null; }

  static signOut() {}

     

}