import 'package:dio/dio.dart';
import 'error_response.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        message = _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String message = '';

  String _handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        ErrorResponse errorResponse = ErrorResponse.fromJson(error);
        return errorResponse.message!;
      case 404:
        ErrorResponse errorResponse = ErrorResponse.fromJson(error);
        return errorResponse.message!;
      case 500:
        ErrorResponse errorResponse = ErrorResponse.fromJson(error);
        return errorResponse.message!;
      case 401:
        // if(!isLogin!){
        //   logout();
        // }
        ErrorResponse errorResponse = ErrorResponse.fromJson(error);
        return errorResponse.message!;
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
