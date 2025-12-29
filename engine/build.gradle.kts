plugins {
    base
}

allprojects {
    group = "io.nexum"
    version = "0.0.1-SNAPSHOT"
}

subprojects {
    apply(plugin = "java")

    repositories {
        mavenCentral()
    }

    tasks.withType<JavaCompile>().configureEach {
        options.release.set(17)
    }
}
