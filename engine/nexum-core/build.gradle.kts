plugins {
    id("java")
    id("java-library")
}

/* -------------------------------------------------------
 *  1️⃣ Configurações do Java
 * ------------------------------------------------------- */
java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(17))
    }
}
tasks.withType<JavaCompile>().configureEach {
    options.release.set(17)
    options.encoding = "UTF-8"
}

/* -------------------------------------------------------
 *  2️⃣ Repositórios e dependências
 * ------------------------------------------------------- */
repositories {
    mavenCentral()
}
dependencies {
    implementation("org.jetbrains:annotations:24.1.0")

    testImplementation(platform("org.junit:junit-bom:5.10.0"))
    testImplementation("org.junit.jupiter:junit-jupiter")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

/* -------------------------------------------------------
 *  3️⃣ Paths auxiliares (Dart)
 * ------------------------------------------------------- */
val coreBuildDir = project(":nexum-core").layout.buildDirectory
val dartOutput = coreBuildDir.file("dart/${findProperty("dart_output")}")
val dartMain = file("${rootDir}/${findProperty("dart_main_dir")}/${findProperty("dart_main")}")

/* -------------------------------------------------------
 *  4️⃣ Tarefa que compila o Dart
 * ------------------------------------------------------- */
val compileDart by tasks.register<Exec>("compileDart") {
    group = "build"
    description = "Compila o código Dart para um executável nativo."

    // Garante que o diretório de destino exista antes de chamar o compilador
    doFirst {
        dartOutput.get().asFile.parentFile.mkdirs()
    }

    commandLine(
        "dart",
        "compile",
        "exe",
        dartMain.absolutePath,
        "-o",
        dartOutput.get().asFile.absolutePath
    )

    // Declaração de inputs/outputs (necessário para up‑to‑date checking)
    inputs.file(dartMain)               // o .dart que será compilado
    outputs.file(dartOutput)            // o .exe resultante
}

/* -------------------------------------------------------
 *  5️⃣ Compila Dart **apenas** nos builds/assembles
 * ------------------------------------------------------- */
compileDart.onlyIf {
    // Só executa se o grafo de tarefas contiver build/assemble (ou algo que dependa deles,
    // como :jar). Assim, `./gradlew compileJava` ou `./gradlew test` não vão disparar a
    // compilação do Dart.
    gradle.taskGraph.hasTask(":build") ||
            gradle.taskGraph.hasTask(":assemble")
}

/* -------------------------------------------------------
 *  6️⃣ Geração de código (Version / RunInfo)
 * ------------------------------------------------------- */
val generateVersion by tasks.registering {
    val outDir = layout.buildDirectory.dir("generated/version")

    inputs.property("version", project.version)
    outputs.dir(outDir)

    doLast {
        val file = outDir.get().file("Version.java").asFile
        file.parentFile.mkdirs()
        file.writeText(
            """
            package io.nexum;

            public final class Version {
                public static final String VERSION = "${project.version}";
            }
            """.trimIndent()
        )
    }
}

val generateRunInfo by tasks.registering {
    val isRelease = gradle.startParameter.taskNames.any {
        it in listOf("build", "assemble", "jar") || it.endsWith(":build")
    }

    val outDir = layout.buildDirectory.dir("generated/runInfo")

    inputs.property("is_release", isRelease)
    outputs.dir(outDir)

    doLast {
        val file = outDir.get().file("RunInfo.java").asFile
        file.parentFile.mkdirs()
        file.writeText(
            """
            package io.nexum;

            public final class RunInfo {
                public static final boolean IS_RELEASE = $isRelease;
            }
            """.trimIndent()
        )
    }
}

/* -------------------------------------------------------
 *  7️⃣ Configurações dos sourceSets
 * ------------------------------------------------------- */
sourceSets["main"].java.srcDirs(
    layout.buildDirectory.dir("generated/version"),
    layout.buildDirectory.dir("generated/runInfo")
)
sourceSets["test"].java.srcDirs(
    layout.buildDirectory.dir("generated/version"),
    layout.buildDirectory.dir("generated/runInfo")
)

sourceSets {
    named("main") {
        // O diretório onde o binário Dart será colocado será tratado como recurso.
        resources.srcDir(layout.buildDirectory.dir("dart"))
    }
}

/* -------------------------------------------------------
 *  8️⃣ Incluir o binário Dart nos recursos do JAR
 * ------------------------------------------------------- */
tasks.named<Copy>("processResources") {
    // Garante que o binário já tenha sido criado antes da cópia
    dependsOn(compileDart)

    // Copia o exe para dentro do diretório de recursos do JAR.
    // Dentro do JAR ele ficará em:  /dart/<nome‑do‑arquivo>.exe
    from(dartOutput) {
        into("dart")
    }
}

/* -------------------------------------------------------
 *  9️⃣ Encadeamento de dependências (build → compileDart)
 * ------------------------------------------------------- */
tasks.named("build") {
    dependsOn(compileDart)   // garante que o Dart seja compilado antes do build
}

/* -------------------------------------------------------
 * 10️⃣ Compilação Java depende das classes geradas
 * ------------------------------------------------------- */
tasks.named("compileJava") {
    dependsOn(generateVersion, generateRunInfo)
}
tasks.named("compileTestJava") {
    dependsOn(generateVersion, generateRunInfo)
}

/* -------------------------------------------------------
 * 11️⃣ Configurações de teste
 * ------------------------------------------------------- */
tasks.test {
    // Não falha se nenhum teste for descoberto – opcional.
    failOnNoDiscoveredTests = false
}