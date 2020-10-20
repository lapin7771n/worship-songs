version=0.4.0
buildNumber=30
betaVersion=-beta4

# Build Android
cd android || exit
./gradlew clean
cd ..
flutter clean
flutter build apk --release --build-name=$version$betaVersion --build-number=$buildNumber
flutter build appbundle --release --build-name=$version$betaVersion --build-number=$buildNumber

#Build iOS
flutter build ios --release --build-name=$version --build-number=$buildNumber
