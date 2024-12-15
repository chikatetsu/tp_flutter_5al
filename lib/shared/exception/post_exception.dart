class PostException implements Exception {
  final String message;

  const PostException([this.message = '']);

  static PostException from(dynamic exception) {
    if (exception is PostException) {
      return exception;
    }
    return const UnknownException();
  }
}

class UnknownException extends PostException {
  const UnknownException([super.message = 'Une erreur inconnue est survenue']);
}

class CreatePostException extends PostException {
  const CreatePostException([super.message = 'Erreur lors de la création du post']);
}

class UpdatePostException extends PostException {
  const UpdatePostException([super.message = 'Erreur lors de la modification du post']);
}
