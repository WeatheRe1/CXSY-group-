@echo off
REM Flutter 启动脚本 (绕过 bat 中的网络检查)
SET FLUTTER_ROOT=D:\flutter\flutter
SET PUB_HOSTED_URL=https://pub.flutter-io.cn
SET FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
SET DART=%FLUTTER_ROOT%\bin\cache\dart-sdk\bin\dart.exe
SET SNAPSHOT=%FLUTTER_ROOT%\bin\cache\flutter_tools.snapshot
SET PKG=%FLUTTER_ROOT%\packages\flutter_tools\.dart_tool\package_config.json

"%DART%" "--packages=%PKG%" "%SNAPSHOT%" %*
