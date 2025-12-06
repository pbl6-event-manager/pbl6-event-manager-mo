import 'package:dio/dio.dart';

class ResponseInterceptor extends Interceptor {
  const ResponseInterceptor();

  /// If response is in range 200-299 and has `data` field => return the data field
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! <= 299 &&
        response.data is Map<String, dynamic> &&
        (response.data as Map<String, dynamic>).containsKey('data')) {
      // Extract the nested data field and create a new response
      final responseData = response.data as Map<String, dynamic>;
      final extractedData = responseData['data'];

      // Create a new response with the extracted data
      final modifiedResponse = Response(
        data: extractedData,
        headers: response.headers,
        requestOptions: response.requestOptions,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response.extra,
      );

      super.onResponse(modifiedResponse, handler);
    } else {
      // For all other cases, pass through the original response
      super.onResponse(response, handler);
    }
  }
}
