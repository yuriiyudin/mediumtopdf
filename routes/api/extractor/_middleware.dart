import 'package:dart_frog/dart_frog.dart';
import 'package:medium/core/extractor.dart';


Handler middleware(Handler handler) {
  // TODO: implement middleware
 return (context) {
   return handler.use(provider<Extractor>((_) => Extractor())).call(context);
 };
}
