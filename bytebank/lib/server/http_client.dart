import 'package:http_interceptor/http_interceptor.dart';

class HttpClient {
  static final instance = InterceptedClient.build(interceptors: [
    LoggingInterceptor(),
  ]);
}

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('Url: ${data.baseUrl}');
    print('Method: ${data.method}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print('Url: ${data.url}');
    print('Status Code: ${data.statusCode}');
    print('Method: ${data.method}');
    return data;
  }
}
