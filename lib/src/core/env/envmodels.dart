import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (kReleaseMode) {
      return '.env.production';
    } else {
      return '.env.development';
    }
  }

  static String get apiUrl {
    return dotenv.env['API_URL'] ?? "URL not found";
  }
   static String get imageUrl {
    return dotenv.env['Image_Route'] ?? "URL not found";
  }

}
