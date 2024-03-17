class CommonResponse {

  bool isError;
  String? errorMessage;
  dynamic response;

  CommonResponse(this.isError, this.errorMessage, this.response);

  @override
  String toString() {
    return 'CommonResponse{isError: $isError, errorMessage: $errorMessage, response: $response}';
  }
}