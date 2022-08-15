
class CustomException implements Exception {

  final error;
  final _prefix;

  CustomException([this.error, this._prefix]);

  @override
  String toString() {
  return "$_prefix$error";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, "Bad Request ");
}

class UnauthorisedException extends CustomException {

  UnauthorisedException([message]) : super(message, "Couldn't find the account ");
}

class InvalidInputException extends CustomException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}
class PasswordMissMatchException extends CustomException {
  PasswordMissMatchException([String? message]) : super(message, "Password does not match: ");
}

class ServerErrorException extends CustomException {
  ServerErrorException([String? message]) : super(message, "Server Error: ");
}

class DuplicateEntryException extends CustomException {
  DuplicateEntryException([String? message])
      : super(message, "User Already Exist");
}

