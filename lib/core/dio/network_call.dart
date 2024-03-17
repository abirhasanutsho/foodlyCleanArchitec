import 'dart:developer';
import 'package:dio/dio.dart';
import '../utils/utils.dart';
import 'common_response.dart';
import 'dio_exception.dart';
import 'interceptor.dart';


Future<CommonResponse> networkCallPost(dynamic fromData, String apiPath) async {

  Response response;
  log("from__${fromData}");
  try {
    bool isFormDataEmpty = fromData == null;

    if (isFormDataEmpty) {
      response = await DioClient().dio.post(
        developmentBaseUrl + apiPath,
      );

    } else {
      var formData = FormData.fromMap(fromData);
      response = await DioClient().dio.post(
        developmentBaseUrl + apiPath,
        data: formData,
      );

    }


    return CommonResponse(false, null, response.data);
  } on DioError catch (e) {
    String errorMessage;
    if (e.response != null) {
      if (
          e.response!.statusCode == 403 ||
          e.response!.statusCode == 404 ||
          e.response!.statusCode == 422 ||
          e.response!.statusCode == 409 ||
          e.response!.statusCode == 400 ||
          e.response!.statusCode == 406 ||
          e.response!.statusCode == 506
      ) {
        final responseData = e.response!.data;
        errorMessage = responseData['message'];

      } else  {
        if(e.response!.statusCode == 401 || e.response!.statusCode == 503){
          //logout();

        }
        errorMessage = 'Unexpected error occurred (${e.response!.statusCode})';
      }
    } else {
      errorMessage = 'Connection error: ${e.message}';
    }

    return CommonResponse(true, errorMessage, null);
  } catch (error) {
    return CommonResponse(true, 'Unexpected error occurred', null);
  }
}

Future<CommonResponse> networkCallDelete(String apiPath) async {
  try {
    Response response = await DioClient().dio.delete(
      developmentBaseUrl + apiPath,
    );

    return CommonResponse(false, null, response.data);
  } on DioError catch (e) {
    String errorMessage;
    if (e.response != null) {
      if (e.response!.statusCode == 403 ||
          e.response!.statusCode == 404 ||
          e.response!.statusCode == 422 ||
          e.response!.statusCode == 400) {
        final responseData = e.response!.data;
        errorMessage = responseData['message'];
      } else {
        errorMessage = 'Unexpected error occurred (${e.response!.statusCode})';
      }
    } else {
      errorMessage = 'Connection error: ${e.message}';
    }
    return CommonResponse(true, errorMessage, null);
  } catch (error) {
    return CommonResponse(true, 'Unexpected error occurred', null);
  }
}

Future<CommonResponse> networkCallGet(
    String apiPath, Map<String, dynamic>? queryParameter,
    {String? url}) async {
  final hasUrl = url != null;
  try {
    Response response = await DioClient().dio.get(
        hasUrl ? url : developmentBaseUrl + apiPath,
        queryParameters: queryParameter);
    return CommonResponse(false, null, response.data);
    //  }
  } catch (e) {
    final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
    return CommonResponse(true, errorMessage, null);
  }
}
