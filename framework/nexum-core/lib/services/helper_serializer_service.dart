import 'package:nexum_core/exceptions/helper_serialization_exception.dart';

import '../foundation/channel/friendly_buffer.dart';
import '../foundation/channel/helper_serializer.dart';
import '../storages/helper_serializer_registry.dart';

class HelperSerializerService {
  static HelperSerializerService get instance => _instance;
  static const HelperSerializerService _instance = HelperSerializerService._();

  const HelperSerializerService._();

  void serializeObject<T>(T object, FriendlyBuffer friendlyBuffer) {
    final HelperSerializer ? helperSerializer = HelperSerialzerRegistry.instance.getSerializer(object.runtimeType);

    if(helperSerializer == null) {
      throw HelperSerializerException(
        "Não foi possivel encontrar o serializador para o objeto ${object.runtimeType}"
      );
    }

    helperSerializer.serialize(object, friendlyBuffer);
    friendlyBuffer.write("identifier", helperSerializer.identifier);
  }
}