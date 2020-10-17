version=0.3.2
buildNumber=27

flutter clean
flutter build apk --release --build-name=$version --build-number=$buildNumber
flutter build appbundle --release --build-name=$version --build-number=$buildNumber
flutter build ios --release --build-name=$version --build-number=$buildNumber
