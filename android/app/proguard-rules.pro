# Flutter specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.embedding.** { *; }

# Play Core library rules
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }

# Keep Flutter engine classes
-keep class io.flutter.embedding.android.FlutterActivity { *; }
-keep class io.flutter.embedding.android.FlutterFragmentActivity { *; }
-keep class io.flutter.embedding.engine.** { *; }

# Preserve native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Preserve annotated methods
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Prevent proguard from stripping interface information
-keep interface * extends android.os.IInterface

# Preserve reflection-based code
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes InnerClasses
-keepattributes EnclosingMethod

# Ignore warnings
-dontwarn android.support.**
-dontwarn androidx.**
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**

# Additional Flutter/Dart specific rules
-dontwarn io.flutter.**
-dontwarn org.gradle.**