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

    tasks.withType<Test> {
        enableAssertions = true
    }

    tasks.withType<JavaExec>().configureEach {
        jvmArgs("-ea")
    }
}
