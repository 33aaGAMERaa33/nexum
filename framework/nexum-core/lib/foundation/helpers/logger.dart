import '../channel/packet_manager.dart';
import '../channel/packets/foundation.dart';

class Logger {
  const Logger._();

  static void _print(LoggerType type, String identifier, String message) {
    PacketManager.instance.sendPacket(LoggerPacket(
        identifier: identifier, log: message, type: type,
    ));
  }

  static void log(String identifier, String log) {
    _print(LoggerType.log, identifier, log);
  }

  static void debug(String identifier, String log) {
    _print(LoggerType.debug, identifier, log);
  }

  static void warn(String identifier, String log) {
    _print(LoggerType.warn, identifier, log);
  }

  static void error(String identifier, String log) {
    _print(LoggerType.error, identifier, log);
  }
}