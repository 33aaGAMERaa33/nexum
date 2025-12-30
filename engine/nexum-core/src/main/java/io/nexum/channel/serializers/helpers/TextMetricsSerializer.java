package io.nexum.channel.serializers.helpers;

import io.nexum.services.HelperSerializerService;
import io.nexum.material.TextMetrics;
import io.nexum.channel.FriendlyBuffer;
import io.nexum.channel.HelperSerializer;
import org.jetbrains.annotations.NotNull;

public class TextMetricsSerializer implements HelperSerializer<TextMetrics> {
    @Override
    public void serialize(@NotNull TextMetrics object, @NotNull FriendlyBuffer friendlyBuffer) {
        HelperSerializerService.getInstance().serialize(object.getSize(), friendlyBuffer);
    }

    @Override
    public @NotNull String getIdentifier() {
        return "text_metrics";
    }

    @Override
    public @NotNull Class<TextMetrics> getObjectClazz() {
        return TextMetrics.class;
    }
}
