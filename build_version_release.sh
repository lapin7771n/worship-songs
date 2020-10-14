version=0.3.0
buildNumber=23

flutter clean
flutter build apk --release --build-name=$version --build-number=$buildNumber
flutter build appbundle --release --build-name=$version --build-number=$buildNumber
flutter build ios --release --build-name=$version --build-number=$buildNumber
