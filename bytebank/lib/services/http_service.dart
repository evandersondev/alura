import 'package:http_interceptor/http_interceptor.dart';

import 'interceptors/http_interceptor.dart';

class HttpService {
  static final instance = InterceptedClient.build(interceptors: [
    HttpInterceptor(),
  ]);
}
