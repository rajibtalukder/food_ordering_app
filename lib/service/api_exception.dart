
class ApiException implements Exception {
  final String message;
  final String errorName;
  final String url;

  ApiException(this.message, this.errorName, this.url);
}

class BadRequestException extends ApiException {
  BadRequestException(String message, String url)
      : super(message, 'Bad Request', url);
}

class ProcessDataException extends ApiException {
  ProcessDataException(String message, String url)
      : super(message, 'Unable to process', url);
}

class InternalServerException extends ApiException {
  InternalServerException(String message, String url)
      : super(message, 'Internal server error', url);
}

class ApiNotRespondingException extends ApiException {
  ApiNotRespondingException(String message, String url)
      : super(message, 'Api not found', url);
}

class UnAuthorizedException extends ApiException {
  UnAuthorizedException(String message, String url)
      : super(message, 'Unauthorized', url);
}





