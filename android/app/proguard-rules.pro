# Keep all Razorpay-related classes and annotations
#-keep class com.razorpay.** { *; }
#-keepclassmembers class com.razorpay.** { *; }
# Keep classes that are used in the Flutter engine
-keep class io.flutter.** { *; }
-keep class com.google.firebase.** { *; }
-keep class com.razorpay.** { *; }

# Keep Flutter specific classes
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.app.** { *; }
-keep class androidx.preference.** { *; }


# Keep the annotation
#-keep class proguard.annotation.KeepClassMembers { *; }
