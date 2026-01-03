class ErrorHandler {
  static String getErrorMessage(String error) {
    if (error.contains('Firebase is not initialized')) {
      return 'Firebase is not configured. Please check your Firebase setup.';
    } else if (error.contains('user-not-found')) {
      return 'No account found with this email. Please sign up first.';
    } else if (error.contains('wrong-password')) {
      return 'Incorrect password. Please try again.';
    } else if (error.contains('invalid-email')) {
      return 'Invalid email address. Please check and try again.';
    } else if (error.contains('email-already-in-use')) {
      return 'This email is already registered. Please sign in instead.';
    } else if (error.contains('weak-password')) {
      return 'Password is too weak. Please use a stronger password.';
    } else if (error.contains('operation-not-allowed')) {
      return 'Email/Password sign-up is not enabled. Please enable it in Firebase Console under Authentication > Sign-in method.';
    } else if (error.contains('canceled')) {
      return ''; // User canceled - return empty to suppress error
    } else if (error.contains('invalid_client') || error.contains('401')) {
      return 'Google Sign-In is not configured. Please check your Web Client ID in Firebase Console.';
    } else if (error.contains('popup_closed')) {
      return 'Sign-in was interrupted. Please try again.';
    }
    return error;
  }

  static bool shouldShowError(String error) {
    return !error.contains('canceled');
  }
}

