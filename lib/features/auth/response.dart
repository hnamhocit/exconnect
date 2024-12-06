sealed class Response {}

class SuccessResponse<T> extends Response {
  final T data;
  final int code;

  SuccessResponse({required this.code, required this.data});
}

class FailureResponse extends Response {
  final String message;
  final int code;

  FailureResponse({required this.code, required this.message});
}
