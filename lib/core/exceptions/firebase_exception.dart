import 'base_exception.dart';

abstract base class CustomFirebaseException extends BaseException {
  const CustomFirebaseException({
    required String code,
    super.e,
  }) : super(
          code: 'firebase_$code',
        );

  factory CustomFirebaseException.from(dynamic e) {
    return switch (e.code) {
      'internal' => FirebaseNoInternetException(e: e),
      _ => FirebaseUnknownException(e: e),
    };
  }
}

final class FirebaseNoInternetException extends CustomFirebaseException {
  FirebaseNoInternetException({super.e}) : super(code: 'no_internet_connection');
}

final class FirebaseUnknownException extends CustomFirebaseException {
  FirebaseUnknownException({super.e}) : super(code: 'unknown');
}
