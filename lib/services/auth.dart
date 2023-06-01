import 'package:dehas/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? get currentUser => _auth.currentUser;

  Future signInGoogle() async {
    UserCredential userC await _auth.signInWithProvider(GoogleAuthProvider());
final user = userC.user;
    if (user != null) {
      await DataBaseServices().updateUser(user);
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    UserCredential userC = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userC.user;
    if (user != null) {
      await DataBaseServices().updateUser(user);
    }
  }

  // sign out
  Future signOut() async {
    await _auth.signOut();
  }
}
