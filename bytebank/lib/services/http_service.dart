import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/http_interceptor.dart';

class HttpService {
  final instance = InterceptedClient.build(
    interceptors: [HttpInterceptor()],
    requestTimeout: const Duration(seconds: 5),
  );
}
