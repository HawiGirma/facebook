import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  // GoogleSignIn will use the clientId from web/index.html meta tag for web
  // Make sure you've added the Web Client ID to web/index.html
  // For Android/iOS, it uses the configuration from google-services.json
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Lazy getter for FirebaseAuth - only accessed when needed
  FirebaseAuth get _auth {
    try {
      return FirebaseAuth.instance;
    } catch (e) {
      throw 'Firebase is not initialized. Please configure Firebase first.';
    }
  }

  // Check if Firebase is initialized
  bool get isFirebaseInitialized {
    try {
      Firebase.app();
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get current user
  User? get currentUser {
    if (!isFirebaseInitialized) return null;
    return _auth.currentUser;
  }

  // Stream of auth state changes
  Stream<User?> get authStateChanges {
    if (!isFirebaseInitialized) {
      return Stream.value(null);
    }
    return _auth.authStateChanges();
  }

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    if (!isFirebaseInitialized) {
      throw 'Firebase is not initialized. Please configure Firebase first.';
    }
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  // Sign up with email and password
  Future<UserCredential?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    if (!isFirebaseInitialized) {
      throw 'Firebase is not initialized. Please configure Firebase first.';
    }
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update display name
      if (name.isNotEmpty) {
        await credential.user?.updateDisplayName(name);
        await credential.user?.reload();
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      // Log detailed error for debugging
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      throw _handleAuthException(e);
    } catch (e) {
      print('Unexpected error during sign up: $e');
      throw 'An unexpected error occurred: ${e.toString()}';
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    if (!isFirebaseInitialized) {
      throw 'Firebase is not initialized. Please configure Firebase first.';
    }
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User canceled the sign-in
        print('Google Sign-In was canceled by user');
        throw 'Sign-in was canceled. Please try again.';
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Check if we have the required tokens
      if (googleAuth.idToken == null) {
        print('Google Sign-In failed: No ID token received');
        throw 'Google Sign-In failed: No authentication token received. Please check your Firebase configuration.';
      }

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error during Google Sign-In: ${e.code} - ${e.message}');
      throw 'Google Sign-In failed: ${_handleAuthException(e)}';
    } catch (e) {
      print('Error during Google Sign-In: $e');
      final errorString = e.toString();
      
      // Provide helpful error messages
      if (errorString.contains('invalid_client') || errorString.contains('401')) {
        throw 'Google Sign-In configuration error. Please check your Web Client ID in web/index.html (for web) or google-services.json (for Android).';
      } else if (errorString.contains('popup_closed')) {
        throw 'Sign-in popup was closed. Please try again and complete the sign-in process.';
      } else if (errorString.contains('network')) {
        throw 'Network error. Please check your internet connection and try again.';
      }
      
      throw 'Failed to sign in with Google: ${e.toString()}';
    }
  }

  // Sign out
  Future<void> signOut() async {
    final futures = <Future<void>>[];

    if (isFirebaseInitialized) {
      futures.add(_auth.signOut());
    }
    futures.add(_googleSignIn.signOut());

    await Future.wait(futures);
  }

  // Handle Firebase Auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'This operation is not allowed.';
      default:
        return 'An error occurred: ${e.message}';
    }
  }
}
