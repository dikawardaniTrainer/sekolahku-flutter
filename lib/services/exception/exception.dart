abstract class ServiceException implements Exception {
  final String message;
  ServiceException(this.message);

  @override
  String toString() => message;
}

class IllegalArgumentException extends ServiceException {
  IllegalArgumentException(super.message);
}

class NotFoundException extends ServiceException {
  NotFoundException(super.message);
}

class NoDataChangedException extends ServiceException {
  NoDataChangedException(super.message);
}

class DuplicateEmailException extends ServiceException {
  DuplicateEmailException(super.message);
}