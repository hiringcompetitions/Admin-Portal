import 'package:firebase_auth/firebase_auth.dart';

class ErrorFormatter {

  String getFirebaseAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-credential':
        return "Invalid Credentials";
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'too-many-requests':
        return 'Too many attempts. Try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'An unknown error occurred: ${e.message}';
    }
  }

  String getFirestoreErrorMessage(FirebaseException error) {
    switch (error.code) {
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'unknown':
        return 'An unknown error occurred.';
      case 'invalid-argument':
        return 'Invalid data provided.';
      case 'deadline-exceeded':
        return 'The operation timed out.';
      case 'not-found':
        return 'The requested document was not found.';
      case 'already-exists':
        return 'A document with the same ID already exists.';
      case 'permission-denied':
        return 'You don\'t have permission to perform this action.';
      case 'resource-exhausted':
        return 'Quota exceeded. Please try again later.';
      case 'failed-precondition':
        return 'The operation could not be performed in the current state.';
      case 'aborted':
        return 'The operation was aborted.';
      case 'out-of-range':
        return 'The requested data is out of range.';
      case 'unimplemented':
        return 'This operation is not supported.';
      case 'internal':
        return 'An internal error occurred. Please try again.';
      case 'unavailable':
        return 'Firestore service is currently unavailable.';
      case 'data-loss':
        return 'Data loss occurred. Please contact support.';
      case 'unauthenticated':
        return 'You need to log in to perform this action.';
      default:
        return 'Something went wrong: ${error.message}';
    }
  }

}