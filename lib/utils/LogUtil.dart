import 'package:logger/logger.dart';

class LogUtil {
  static Logger logger = Logger();
  static void error(Object object, Object error, StackTrace stackTrace) {
    logger.log(Level.error, object.toString(), error, stackTrace);
  }

  static void verbose(Object object, Object log) {
    logger.log(Level.verbose, object.toString(), log);
  }
}
