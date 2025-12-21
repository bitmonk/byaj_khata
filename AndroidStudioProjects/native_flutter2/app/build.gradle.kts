plugins {
    alias(libs.plugins.android.application)
    alias(libs.plugins.kotlin.android)
}

repositories {
    google()
    mavenCentral()
    maven { url = uri("/Users/og/AndroidStudioProjects/native_flutter/build/host/outputs/repo") }
    maven { url = uri("https://storage.googleapis.com/download.flutter.io") }
}

android {
    namespace = "com.example.native_flutter"
    compileSdk = 36

    defaultConfig {
        applicationId = "com.example.native_flutter"
        minSdk = 24
        targetSdk = 36
        versionCode = 1
        versionName = "1.0"

        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    kotlinOptions {
        jvmTarget = "11"
    }
}

dependencies {
//    implementation(project(":flutter"))
    implementation(libs.androidx.core.ktx)
    implementation(libs.androidx.appcompat)
    implementation(libs.material)
    implementation(libs.androidx.activity)
    implementation(libs.androidx.constraintlayout)
    testImplementation(libs.junit)
    androidTestImplementation(libs.androidx.junit)
    androidTestImplementation(libs.androidx.espresso.core)
    // Kotlin stdlib is provided by the Kotlin Gradle plugin; remove explicit older stdlib
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.10.2")

    // AndroidX Test libraries should use testImplementation / androidTestImplementation appropriately
    testImplementation("junit:junit:4.13.2")
    androidTestImplementation("androidx.test:runner:1.7.0")
    androidTestImplementation("androidx.test.espresso:espresso-core:3.7.0")

    // Keep debug/profile/release variants for the embedded Flutter AAR module
    debugImplementation("com.fluttern.native_flutter:flutter_debug:1.0")
//    add("profileImplementation", "com.fluttern.native_flutter:flutter_profile:1.0")
    add("releaseImplementation", "com.fluttern.native_flutter:flutter_release:1.0")
}