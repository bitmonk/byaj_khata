import 'package:byaz_track/core/dio_provider/api_error.dart';
import 'package:byaz_track/core/dio_provider/api_response.dart';
import 'package:byaz_track/core/dio_provider/dio_api_client.dart';
import 'package:dartz/dartz.dart';
import 'package:byaz_track/core/extension/extensions.dart';
import 'package:get/get.dart';
class {{name.pascalCase()}}RemoteSource {
  const {{name.pascalCase()}}RemoteSource(this._client);
  final DioApiClient _client;

  Future<Either<AppError,ApiResponse<dynamic>>> fetchData({required int pageKey, String? searchQuery }) async{
        try {
      // final param = <String, dynamic>{'page': pageKey};
      // final url = searchQuery == null
      //     ? AppEndpoints.countries
      //     : AppEndpoints.countries + searchQuery;

      // final response =
      //     await _client.httpGet<dynamic>(url, queryParameters: param);
      // return right(
      //   ApiResponse(
      //     data: null
      //   ,)
      // );
      throw UnimplementedError();
    } catch (e) {
      if (e is ApiErrorResponse) {
        return left(e);
      } else {
        return left(InternalAppError(message: e.toString()));
      }
    }

  }
}
