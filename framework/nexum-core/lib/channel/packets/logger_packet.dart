import 'package:nexum_core/channel/packet.dart';

enum LoggerType {
  log("log"),
  warn("warn"),
  error("error"),
  debug("debug");

  final String identifier;
  const LoggerType(this.identifier);
}

class LoggerPacket extends Packet {
  final String log;
  final LoggerType type;
  final String identifier;

  LoggerPacket({required this.log, required this.type, required this.identifier});
}