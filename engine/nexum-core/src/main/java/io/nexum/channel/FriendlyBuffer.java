package io.nexum.channel;

import org.jetbrains.annotations.NotNull;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class FriendlyBuffer {
    private final List<Data> content;
    private static final Pattern SPLIT_EQUALS = Pattern.compile("(?<!\\\\)=");
    private static final Pattern ESCAPE_RESERVED = Pattern.compile("([=;\\\\])");
    private static final Pattern SPLIT_SEMICOLON = Pattern.compile("(?<!\\\\)(?:\\\\\\\\)*;");

    public FriendlyBuffer() {
        this.content = new ArrayList<>();
    }

    private FriendlyBuffer(List<Data> buf) {
        this.content = buf;
    }

    public void write(String identifier, Object object) {
        content.add(new Data(identifier, object.toString()));
    }

    public String read(String identifier) {
        if(content.isEmpty()) {
            throw new IllegalStateException("Buffer is empty");
        }

        Data last = content.remove(content.size() - 1);


        if(!last.identifier.equals(identifier)) {
            throw new IllegalStateException(String.format(
                    "Content identifier \"%s\" not equals \"%s\"",
                    last.identifier, identifier
            ));
        }

        return unescape(last.value);
    }

    public String buildData() {
        StringBuilder data = new StringBuilder();

        for(Data part : content) {
            String escapedValue = escape(part.value);

            data.append(part.identifier)
                    .append("=")
                    .append(escapedValue);

            data.append(";");
        }

        return data.toString();
    }

    private static String escape(String value) {
        return ESCAPE_RESERVED.matcher(value).replaceAll("\\\\$1");
    }

    private static String unescape(String value) {
        return value
                .replace("\\=", "=")
                .replace("\\;", ";")
                .replace("\\\\", "\\");
    }

    public static FriendlyBuffer fromData(String data) {
        String[] parts = SPLIT_SEMICOLON.split(data);
        List<Data> content = new ArrayList<>();

        for(String part : parts) {
            if (part.isEmpty()) continue;

            String[] kv = SPLIT_EQUALS.split(part, 2);
            content.add(new Data(kv[0], kv[1]));
        }

        return new FriendlyBuffer(content);
    }

    public void writeString(String value) { write("string", value); }
    public void writeInt(int value) { write("int", value); }
    public void writeDouble(double value) { write("double", value); }
    public void writeBoolean(boolean value) { write("boolean", value); }

    public String readString() { return read("string"); }
    public int readInt() { return Integer.parseInt(read("int")); }
    public float readFloat() { return Float.parseFloat(read("float")); }
    public double readDouble() { return Double.parseDouble(read("double")); }
    public boolean readBoolean() { return Boolean.parseBoolean(read("boolean")); }

    @Override
    public String toString() {
        return content.toString();
    }

    static class Data {
        private final String identifier;
        private final String value;

        Data(String identifier, String value) {
            this.identifier = identifier;
            this.value = value;
        }

        @Override
        public @NotNull String toString() {
            return String.format("Data(identifier=%s, value=%s)", identifier, value);
        }
    }

}
