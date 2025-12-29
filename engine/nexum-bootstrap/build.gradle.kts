plugins {
    id("java")
    id("application")
}

application {
    mainClass = "io.nexum.bootstrap.Main"
}

repositories {
    mavenCentral()
}

dependencies {
    implementation(project(":nexum-core"))
    implementation("org.jetbrains:annotations:24.1.0")

    testImplementation(platform("org.junit:junit-bom:5.10.0"))
    testImplementation("org.junit.jupiter:junit-jupiter")
    testRuntimeOnly("org.junit.platform:junit-platform-launcher")
}

java {
    toolchain {
        languageVersion.set(JavaLanguageVersion.of(17))
    }
}

tasks.withType<JavaCompile>().configureEach {
    options.release.set(17)
    options.encoding = "UTF-8"
}

tasks.test {
    useJUnitPlatform()
}

tasks.jar {
    manifest {
        attributes(
            "Main-Class" to application.mainClass.get()
        )
    }

    // inclui todas as classes do próprio módulo
    from(sourceSets.main.get().output)

    // inclui as classes e resources do core
    from({
        project(":nexum-core").sourceSets["main"].output
    })

    // inclui todas as dependências runtime (se quiser)
    from({
        configurations.runtimeClasspath.get()
            .filter { it.name.endsWith(".jar") }
            .map { zipTree(it) }
    })

    duplicatesStrategy = DuplicatesStrategy.EXCLUDE
}

tasks.jar {
    dependsOn(":nexum-core:jar")
}