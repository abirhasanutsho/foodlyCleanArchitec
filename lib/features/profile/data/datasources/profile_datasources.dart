import 'package:cleanarchitec/features/profile/data/model/profile_model.dart';
import 'package:dio/dio.dart';

class ProfileApiServices {
  static Future<ProfileModel?> profileServices() async {
    try {
      final Dio dio = Dio();
      final response =
          await dio.get("https://dev-admin.bitdeposit.org/api/v1/agent/details",
              options: Options(
                headers: {
                  "Authorization":
                      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNWE1NTA2M2ZiNTQxZjQ5MzA3YjM4YmIyZTEwMzZiYWRmYzEwN2I5YmZiYjI2NDUxM2MzYjhhNGI1OTAyZjFiYTQ0N2ViYmFjM2FlZGQwN2UiLCJpYXQiOjE3MTAwNTczMTYuMTE0MzM4LCJuYmYiOjE3MTAwNTczMTYuMTE0MzQyLCJleHAiOjE3MjU5NTQ5MTUuODc2MzY2LCJzdWIiOiIzNSIsInNjb3BlcyI6WyJjaGVjay1hZ2VudCJdfQ.ZEKua5vc5UAEMI1lznFSEQOn_ZyBe4U7BqsVLmNhEafBAyf_QElEZDBKRwmLRkxY0iPb-evhT9bWm8WZ9lsO_sR6tzmc8jirjmhBEdRO9YJTwChkSqFkdApuT4YdntQZiRUIKYlA_m64qS03Epwl6mQStmxEIhYXx44E4vT-LpXykLBMWEZZrjVsVDhSzOhX-_DHSqpIa0FPsDPCzBWIwwWD6LrJjfvv7BtTvY3N43wIZWINJU7SjUduBVf3d_M5PZh59NRqf4OrYD-DCPwNd67xXJRlGznn9oJCGrPHzFFDj-j-RowGqpuNBdkhw2SAsINPTAXl6nmOkfNlJm-2pM-3xicaQQS0_ynxQTNycS5E-bOXggrJEFqWLYmpoIZzckX5ocg6GlQGRfx1_8zKq0ocJ0Mh9Tf7OZXnDcPTi9A5Uex0fBWFA7EunhUh0todET40Zd9WfsRE0iSjzgaJTROKXePdaSwv5ojAm8Po4KqhfT5_4WI1OZsm5eddEh9-LYbO9iPDjJsSVpMCjSinCKWhNZzor91Tj416YDwtYcNiAhO-waXxfANyuECNwZyf9dT2_DZ2b_GcHu9aS8jfd-W0WltXViymE8wvRDjaI_z4qmHjEiEYS-z6rWN8btY62JCjN-_O0BBi1_v-q6whKO1s7JZx5rKapCovoPjz5mo"
                },
              ));
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
