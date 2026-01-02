package io.nexum.channel;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

enum FriendlyBufferValueTypes {
    INTEGER(0),
    BOOL(1),
    FLOAT(2),
    DOUBLE(3),
    STRING(4);

    public final int id;

    FriendlyBufferValueTypes(int id) {
        this.id = id;
    }

    static FriendlyBufferValueTypes fromId(int id) {
        for (FriendlyBufferValueTypes t : values()) {
            if (t.id == id) return t;
        }
        throw new IllegalStateException("Tipo desconhecido: " + id);
    }
}

class MismatchedTypesException extends RuntimeException {
    public MismatchedTypesException(FriendlyBufferValueTypes expected, FriendlyBufferValueTypes received) {
        super("Tipo incompatível: esperado " + expected + ", recebido " + received);
    }
}

public class FriendlyBuffer {
    private final List<Byte> buffer;
    private int readOffset = 0;

    public FriendlyBuffer() {
        this(new ArrayList<>());
    }

    public FriendlyBuffer(List<Byte> buffer) {
        this.buffer = buffer;
    }

    public FriendlyBuffer(byte[] bytes) {
        this();

        for(final byte b : bytes) {
            buffer.add(b);
        }
    }

    // ================= WRITE =================

    private void writeType(FriendlyBufferValueTypes type) {
        buffer.add((byte) type.id);
    }

    public void writeBool(boolean value) {
        writeType(FriendlyBufferValueTypes.BOOL);
        buffer.add((byte) (value ? 1 : 0));
    }

    public void writeInt(int value) {
        writeType(FriendlyBufferValueTypes.INTEGER);

        ByteBuffer bb = ByteBuffer.allocate(4)
                .order(ByteOrder.LITTLE_ENDIAN)
                .putInt(value);

        addBytes(bb.array());
    }

    public void writeFloat(float value) {
        writeType(FriendlyBufferValueTypes.FLOAT);

        ByteBuffer bb = ByteBuffer.allocate(4)
                .order(ByteOrder.LITTLE_ENDIAN)
                .putFloat(value);

        addBytes(bb.array());
    }

    public void writeDouble(double value) {
        writeType(FriendlyBufferValueTypes.DOUBLE);

        ByteBuffer bb = ByteBuffer.allocate(8)
                .order(ByteOrder.LITTLE_ENDIAN)
                .putDouble(value);

        addBytes(bb.array());
    }

    public void writeString(String value) {
        writeType(FriendlyBufferValueTypes.STRING);

        byte[] bytes = value.getBytes(StandardCharsets.UTF_8);

        ByteBuffer length = ByteBuffer.allocate(4)
                .order(ByteOrder.LITTLE_ENDIAN)
                .putInt(bytes.length);

        addBytes(length.array());
        addBytes(bytes);
    }

    // ================= READ =================

    private FriendlyBufferValueTypes readType() {
        if (readOffset >= buffer.size()) {
            throw new IllegalStateException("Fim do buffer");
        }
        return FriendlyBufferValueTypes.fromId(buffer.get(readOffset++) & 0xFF);
    }

    public boolean readBool() {
        FriendlyBufferValueTypes type = readType();
        if (type != FriendlyBufferValueTypes.BOOL) {
            throw new MismatchedTypesException(FriendlyBufferValueTypes.BOOL, type);
        }
        return buffer.get(readOffset++) != 0;
    }

    public int readInt() {
        FriendlyBufferValueTypes type = readType();
        if (type != FriendlyBufferValueTypes.INTEGER) {
            throw new MismatchedTypesException(FriendlyBufferValueTypes.INTEGER, type);
        }

        byte[] bytes = readBytes(4);

        return ByteBuffer.wrap(bytes)
                .order(ByteOrder.LITTLE_ENDIAN)
                .getInt();
    }

    public float readFloat() {
        FriendlyBufferValueTypes type = readType();
        if (type != FriendlyBufferValueTypes.FLOAT) {
            throw new MismatchedTypesException(FriendlyBufferValueTypes.FLOAT, type);
        }

        byte[] bytes = readBytes(4);

        return ByteBuffer.wrap(bytes)
                .order(ByteOrder.LITTLE_ENDIAN)
                .getFloat();
    }

    public double readDouble() {
        FriendlyBufferValueTypes type = readType();
        if (type != FriendlyBufferValueTypes.DOUBLE) {
            throw new MismatchedTypesException(FriendlyBufferValueTypes.DOUBLE, type);
        }

        byte[] bytes = readBytes(8);

        return ByteBuffer.wrap(bytes)
                .order(ByteOrder.LITTLE_ENDIAN)
                .getDouble();
    }

    public String readString() {
        FriendlyBufferValueTypes type = readType();

        if(type != FriendlyBufferValueTypes.STRING) {
            throw new MismatchedTypesException(FriendlyBufferValueTypes.STRING, type);
        }

        byte[] lengthBytes = readBytes(4);
        int length = ByteBuffer.wrap(lengthBytes)
                .order(ByteOrder.LITTLE_ENDIAN)
                .getInt();

        byte[] stringBytes = readBytes(length);
        return new String(stringBytes, StandardCharsets.UTF_8);
    }

    // ================= UTILS =================

    private void addBytes(byte[] bytes) {
        for (byte b : bytes) {
            buffer.add(b);
        }
    }

    private byte[] readBytes(int count) {
        if (readOffset + count > buffer.size()) {
            throw new IllegalStateException("Buffer insuficiente");
        }

        byte[] bytes = new byte[count];
        for (int i = 0; i < count; i++) {
            bytes[i] = buffer.get(readOffset++);
        }
        return bytes;
    }

    public byte[] toBytes() {
        byte[] out = new byte[buffer.size()];
        for (int i = 0; i < buffer.size(); i++) {
            out[i] = buffer.get(i);
        }
        return out;
    }

    public boolean isEOF() {
        return readOffset >= buffer.size();
    }

    public void resetRead() {
        readOffset = 0;
    }
}
