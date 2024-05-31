import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String nim,
    required String phoneNumber,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'nama': name,
          'nim': nim,
          'noWhatsapp': phoneNumber,
          'email': email,
        });
        print('User data saved to Firestore');
      }

      return user;
    } catch (e) {
      print('Error in signUpWithEmailAndPassword: $e');
      return null;
    }
  }

  Future<User?> loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error in loginWithEmailAndPassword: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserData(User user) async {
    DocumentSnapshot docSnapshot = await _firestore.collection('users').doc(user.uid).get();
    return docSnapshot.data() as Map<String, dynamic>?;
  }
}
