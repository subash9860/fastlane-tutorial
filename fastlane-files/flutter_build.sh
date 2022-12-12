#!/bin/bash
cd ../../
if [ "$1" == "--apk_prod" ]
then
   echo "Building APK... in Prod"
   flutter build apk --obfuscate --split-debug-info=./ --release --dart-define=isProd=true &&
    echo "Changing name to $2"
    cp ./build/app/outputs/flutter-apk/app-release.apk ./build/app/outputs/flutter-apk/"$2-prod".apk
    
elif [ "$1" == "--apk_stg" ]
then
   echo "Building APK... in staging"
   flutter build apk --obfuscate --split-debug-info=./ --release &&
   cp ./build/app/outputs/flutter-apk/app-release.apk ./build/app/outputs/flutter-apk/"$2-staging".apk

else
   echo $1
   sed -i '/version:/d' pubspec.yaml
   echo '\n'
   echo -e version: 1.0.$1+$1 >> pubspec.yaml
   echo "Building AAB... version $1"
   flutter build appbundle --obfuscate --split-debug-info=./ --release --dart-define=isProd=true &&
   echo "build completed"
fi