// auth_repository.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> register(String email, String password, String name) async {
    try {
      // Registrasi menggunakan email dan password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Setelah registrasi berhasil, update profil pengguna dengan nama
      User? user = userCredential.user;
      if (user != null) {
        // Update nama pengguna pada Firebase Authentication
        await user.updateDisplayName(name);

        // Simpan data pengguna ke Firestore
        await _firestore.collection('users').doc(user.uid).set({
          'name': name,
          'email': user.email,
          'uid': user.uid,
          'createdAt': Timestamp.now(),
        });
      }

      return user;
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
