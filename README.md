# Economiza SC

### Commands

- Build runner
```bash
dart run build_runner watch --delete-conflicting-outputs
```

- Run Flutter web with html renderer (fix cors)
```bash
flutter run -d chrome --web-renderer html --dart-define-from-file=.env
```

- Apply changes to icon/logo to any platform
```bash
dart run flutter_launcher_icons
```

- Build app bundle
```bash
flutter build appbundle --release --dart-define-from-file=.env
```
