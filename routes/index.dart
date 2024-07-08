import 'dart:io';

import 'package:dart_frog/dart_frog.dart';

Response onRequest(RequestContext context) {
  return Response(statusCode: HttpStatus.ok, headers: {
    HttpHeaders.accessControlAllowOriginHeader: '*',
    HttpHeaders.accessControlAllowHeadersHeader: 'Origin, X-Requested-With, Content-Type, Accept',
    HttpHeaders.accessControlAllowMethodsHeader: 'POST, OPTIONS, PATCH, DELETE',
  });
}
