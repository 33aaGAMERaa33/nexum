package io.nexum.helpers;

import io.nexum.RunInfo;
import org.jetbrains.annotations.NotNull;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Logger {
    protected void print(
            @NotNull String identifier,
            @NotNull String level,
            @NotNull String log,
            @NotNull LoggerSide side,
            Object... args
    ) {
        if(RunInfo.IS_RELEASE) return;

        String message = args.length > 0
                ? String.format(log, args)
                : log;

        String timestamp = DateTimeFormatter
                .ofPattern("yyyy-MM-dd HH:mm:ss.SSS")
                .format(LocalDateTime.now());

        final String print = String.format(
                "[%s] [%s] [%s/%s] - %s%n",
                timestamp,
                level,
                side.getSide(),
                identifier,
                message
        );

        if(level.equals("ERROR")) System.err.print(print);
        else System.out.print(print);
    }

    /* ================= LOG ================= */

    public void log(
            @NotNull String identifier,
            @NotNull String log,
            Object... args
    ) {
        print(identifier, "LOG", log, LoggerSide.ENGINE, args);
    }

    public void log(
            @NotNull String identifier,
            @NotNull LoggerSide side,
            @NotNull String log,
            Object... args
    ) {
        print(identifier, "LOG", log, side, args);
    }

    /* ================= DEBUG ================= */

    public void debug(
            @NotNull String identifier,
            @NotNull String log,
            Object... args
    ) {
        print(identifier, "DEBUG", log, LoggerSide.ENGINE, args);
    }

    public void debug(
            @NotNull String identifier,
            @NotNull LoggerSide side,
            @NotNull String log,
            Object... args
    ) {
        print(identifier, "DEBUG", log, side, args);
    }

    /* ================= WARN ================= */

    public void warn(
            @NotNull String identifier,
            @NotNull String log,
            Object... args
    ) {
        print(identifier, "WARN", log, LoggerSide.ENGINE, args);
    }

    public void warn(
            @NotNull String identifier,
            @NotNull LoggerSide side,
            @NotNull String log,
            Object... args
    ) {
        print(identifier, "WARN", log, side, args);
    }

    /* ================= ERROR ================= */

    public void error(
            @NotNull String identifier,
            @NotNull String log,
            Object... args
    ) {
        print(identifier, "ERROR", log, LoggerSide.ENGINE, args);
    }

    public void error(
            @NotNull String identifier,
            @NotNull LoggerSide side,
            @NotNull String log,
            Object... args
    ) {
        print(identifier, "ERROR", log, side, args);
    }

    /* ================= ENUM ================= */

    public enum LoggerSide {
        ENGINE("Engine"),
        FRAMEWORK("Framework");

        private final String side;

        LoggerSide(String side) {
            this.side = side;
        }

        public String getSide() {
            return side;
        }
    }
}
