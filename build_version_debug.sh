buildNumber=16
version=0.0.$buildNumber

flutter clean
flutter build apk --release --build-name=$version --build-number=$buildNumber
flutter build ios --release --build-name=$version --build-number=$buildNumber
