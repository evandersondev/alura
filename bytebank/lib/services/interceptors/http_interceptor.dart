import 'package:http_interceptor/http_interceptor.dart';

class HttpInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    print('Url: ${data.baseUrl}');
    print('Method: ${data.method}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    print(
        'Url: \x1B[33m${data.url}\x1B[0m - StatusCode: \x1B[33m${data.statusCode}\x1B[0m');
    print('Method: \x1B[33m${data.method}\x1B[0m');
    print('Headers: \x1B[33m${data.headers.toString()}\x1B[0m');
    return data;
  }
}
