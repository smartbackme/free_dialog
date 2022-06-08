## free_dialog

free_dialog 是一个极简的dialog 方案，可简单更改配置，达到使用效果

### 开始集成

```dart
dependencies:
  free_dialog: ^0.0.1
```

![](https://github.com/smartbackme/free_dialog/blob/main/art/img1.jpg)

![](https://github.com/smartbackme/free_dialog/blob/main/art/img2.jpg)

![](https://github.com/smartbackme/free_dialog/blob/main/art/img3.jpg)

![](https://github.com/smartbackme/free_dialog/blob/main/art/img4.jpg)

![](https://github.com/smartbackme/free_dialog/blob/main/art/img5.jpg)

![](https://github.com/smartbackme/free_dialog/blob/main/art/img6.jpg)

![](https://github.com/smartbackme/free_dialog/blob/main/art/img7.jpg)


### 使用方法：

1. 多语言环境配置（默认为英文）

```dart
      localizationsDelegates: [
        FreeLocalizations.delegate],
      supportedLocales: const [
        Locale('en'),
        Locale('zh'),
        Locale('jp'),
      ],

```

2. 简单使用

请参看demo


## 本代码库参考https://github.com/marcos930807/awesomeDialogs，重构而成