import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:medium/core/extractor.dart';
import 'package:uuid/uuid.dart';


Future<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => getPdfFromLink(context),
    _ => Future.value(
        Response(
          statusCode: HttpStatus.badRequest,
        ),
      ),
  };
}

Future<Response> getPdfFromLink(RequestContext context) async {
  final body = await context.request.json() as Map<String, dynamic>;
  final link = body['link'] as String?;
  if (link == null) {
    return Response(statusCode: HttpStatus.badRequest, body: 'Link cannot be empty');
  }
  try {
    final bytes = await context.read<Extractor>().getArticle(link: link);

    return Response.bytes(
      body: bytes,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/pdf',
        HttpHeaders.contentDisposition: 'attachment; filename="${Uuid().v4()}.pdf',
      },
    );
  } catch (e) {
    return Response(statusCode: HttpStatus.badRequest, body: 'Extractor error - ${e.toString()}');
  }
}
