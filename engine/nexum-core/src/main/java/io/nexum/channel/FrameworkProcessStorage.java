package io.nexum.channel;


import io.nexum.exceptions.AlreadyInitialized;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.*;

public class FrameworkProcessStorage {
    private final Process frameworkProcess;
    private static @Nullable FrameworkProcessStorage instance;

    private FrameworkProcessStorage(Process frameworkProcess) {
        this.frameworkProcess = frameworkProcess;
    }

    public Process getFrameworkProcess() {
        return frameworkProcess;
    }

    private static Process launch(LauncherMode mode, File frameworkDir) throws IOException {
        final List<String> command = new ArrayList<>();

        switch (mode) {
            case DEV:
                command.add("dart");
                command.add("run");
                command.add("--enable-asserts");
                command.add("lib/main.dart");
                break;

            case RELEASE:
                File exe = extractExecutable("framework.exe");
                command.add(exe.getAbsolutePath());
                break;
        }

        ProcessBuilder processBuilder = new ProcessBuilder(command);
        processBuilder.directory(frameworkDir);
        processBuilder.redirectErrorStream(false);

        return processBuilder.start();
    }

    private static File extractExecutable(String resourcePath) throws IOException {
        // Cria um arquivo temporário
        String fileName = Paths.get(resourcePath).getFileName().toString();
        Path tempFile = Files.createTempFile("nexum-framework-", "-" + fileName);

        // Copia do JAR para o temp file
        try (InputStream is = FrameworkProcessStorage.class.getClassLoader().getResourceAsStream(resourcePath)) {
            if (is == null) throw new FileNotFoundException("Resource not found: " + resourcePath);
            Files.copy(is, tempFile, StandardCopyOption.REPLACE_EXISTING);
        }

        // Permite execução (Linux / macOS)
        tempFile.toFile().setExecutable(true);

        return tempFile.toFile();
    }

    public static FrameworkProcessStorage initialize(@NotNull String frameworkPath) throws IOException {
        if(instance != null) throw new AlreadyInitialized("FrameworkManager já foi inicializado");

        instance = new FrameworkProcessStorage(launch(
                io.nexum.RunInfo.IS_RELEASE ? LauncherMode.RELEASE : LauncherMode.DEV,
                new File(frameworkPath)
        ));

        return instance;
    }

    public static @NotNull FrameworkProcessStorage getInstance() {
        return Objects.requireNonNull(instance);
    }

    public static boolean isInitialized() {
        return instance != null;
    }
}
