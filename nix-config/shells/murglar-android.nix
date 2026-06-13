# shells/murglar-android.nix
{ pkgs ? import <nixpkgs> {} }:

let
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    cmdLineToolsVersion = "13.0";  # Stable; no major updates post-2024
    toolsVersion = "26.1.1";       # Legacy tools (deprecated but required for compatibility)
    platformToolsVersion = "36.0.2";  # Latest as of October 2025
    buildToolsVersions = [ "35.0.0" "36.0.0" ];  # Matches Android 16 (API 36)
    platformVersions = [ "35" "36" ];  # Android 16/API 36
    includeEmulator = true;
    emulatorVersion = "36.4.2";  # Latest canary as of December 19, 2025
    includeSystemImages = true;
    systemImageTypes = [ "google_apis" ];  # Lightweight without Play Store; switch to "google_apis_playstore" for full services
    abiVersions = [ "x86_64" ];
    includeNDK = false;  # Enable if native code is needed
    includeSources = false;  # Optional for debugging
    extraLicenses = [
      "android-sdk-license"
      "android-sdk-preview-license"
      "android-sdk-arm-dbt-license"
      "android-googletv-license"
      "google-gdk-license"
      "intel-android-extra-license"
    ];
  };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    jdk17  # Strictly JDK 17 per Murglar README
    gradle
    kotlin  # Optional for REPL/testing
    androidComposition.androidsdk
    androidComposition.platform-tools
    androidComposition.emulator
  ];

  ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
  ANDROID_HOME = "${androidComposition.androidsdk}/libexec/android-sdk";
  GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${androidComposition.androidsdk}/libexec/android-sdk/build-tools/36.0.0/aapt2";

  # For hardware-accelerated emulator (requires KVM on host)
  NIX_ANDROID_EMULATOR_FLAGS = "-gpu swiftshader_indirect -qemu -enable-kvm";

  shellHook = ''
    export PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$ANDROID_HOME/cmdline-tools/latest/bin:$PATH"
    echo "🤖 Murglar Android environment ready with API 36!"
    echo "   JDK: $(java -version 2>&1 | head -1)"
    echo "   Gradle: $(gradle --version | grep Gradle)"
    echo ""
    echo "   Accept licenses if prompted (run once):"
    echo "   $ yes | sdkmanager --licenses"
    echo ""
    echo "   Create AVD (once):"
    echo "   $ avdmanager create avd -n murglar_test -k 'system-images;android-36;google_apis;x86_64' -d pixel_6"
    echo ""
    echo "   Launch emulator:"
    echo "   $ emulator @murglar_test &"
    echo ""
    echo "   Build plugin:"
    echo "   $ ./gradlew clean assembleDebug"
  '';
}