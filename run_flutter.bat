@echo off
REM Flutter 国内镜像配置
set PUB_HOSTED_URL=https://pub.flutter-io.cn
set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

echo ========================================
echo  Flutter 阅读追踪应用 - 刘锦耀
echo  国内镜像模式
echo ========================================
echo.

flutter pub get
flutter run
