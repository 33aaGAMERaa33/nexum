import 'dart:convert';

class FriendlyBuffer {
  final List<_Data> _content;
  static final RegExp _splitEquals = RegExp(r"(?<!\\)=");
  static final RegExp _escapeReserved = RegExp(r"([=;\\])");
  static final RegExp _splitSemicolon = RegExp(r"(?<!\\)(?:\\\\)*;");

  FriendlyBuffer() : _content = [];
  FriendlyBuffer._(this._content);

  void write(String identifier, Object object) {
    _content.add(_Data(identifier, object.toString()));
  }

  String read(String identifier) {
    final _Data data = _content.last;
    assert(data.identifier == identifier, "Content idendifier \"${data.identifier}\" not equals \"$identifier\"");

    _content.remove(_content.last);
    return data.value;
  }

  String buildData() {
    String data = "";

    for(final _Data contentPart in _content) {
      final String escapedValue = _escape(contentPart.value);
      data += "${contentPart.identifier}=$escapedValue;";
    }

    return data;
  }

  List<int> buildBuffer() => utf8.encode(buildData());

  void writeInt(int integer) => write("int", integer);
  void writeBool(bool value) => write("boolean", value);
  void writeFloat(double float) => write("float", float);
  void writeString(String string) => write("string", string);
  void writeDouble(double double) => write("double", double);

  String readString() => read("string");
  int readInt() => int.parse(read("int"));
  double readDouble() => double.parse(read("double"));
  bool readBoolean() => bool.parse(read("boolean"));

  String _escape(String value) {
    return value.replaceAllMapped(
      _escapeReserved, (match) => "\\${value.substring(match.start, match.end)}",
    );
  }

  static String _unescape(String value) {
    return value
        .replaceAll("\\=", "=")
        .replaceAll("\\;", ";")
        .replaceAll("\\\\", "\\");
  }

  static FriendlyBuffer fromData(String data) {
    final List<String> splitedDatas = data.split(_splitSemicolon);

    List<_Data> content = [];

    for(final String dataPart in splitedDatas) {
      final List<String> splitedData = dataPart.split(_splitEquals);
      if(splitedData.length < 2) continue;

      content.add(_Data(splitedData[0], _unescape(splitedData[1])));
    }

    return FriendlyBuffer._(content);
  }

  static FriendlyBuffer fromBytes(List<int> bytes) {
    final decoded = utf8.decode(bytes);
    return fromData(decoded);
  }

  @override
  String toString() => _content.toString();
}

class _Data {
  final String identifier;
  final String value;
  _Data(this.identifier, this.value);

  @override
  String toString() => "Data(identifier: $identifier, value: $value)";
}