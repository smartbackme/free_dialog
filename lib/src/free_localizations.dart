

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FreeLocalizations {

  final Locale locale;

  FreeLocalizations(this.locale);

  Map<String, FreeString> values = {
    'en': EnFreeString(),
    'zh': ChFreeString(),
    'ja': JpFreeString(),
  };

  FreeString? get currentLocalization {
    if (values.containsKey(locale.languageCode)) {
      return values[locale.languageCode];
    }
    return values["en"];
  }

  static const FreeLocalizationsDelegate delegate = FreeLocalizationsDelegate();

  //为了使用方便，我们定义一个静态方法
  static FreeLocalizations? of(BuildContext context) {
    return Localizations.of<FreeLocalizations>(context, FreeLocalizations);
  }

  static FreeString getFreeString(BuildContext context) {
    return Localizations.of<FreeLocalizations>(context, FreeLocalizations)?.currentLocalization??EnFreeString();
  }


}


class FreeLocalizationsDelegate extends LocalizationsDelegate<FreeLocalizations> {

  const FreeLocalizationsDelegate();
  ///是否支持某个Local
  @override
  bool isSupported(Locale locale) {
    return [
      'en',
      'zh',
      'ja',
    ].contains(locale.languageCode);
  }
/// Flutter会调用此类加载相应的Locale资源类
  @override
  Future<FreeLocalizations> load(Locale locale) {
    return SynchronousFuture<FreeLocalizations>(
        FreeLocalizations(locale));
  }

  ///shouldReload的返回值决定当Localizations组件重新build时，
  ///是否调用load方法重新加载Locale资源。一般情况下，
  ///Locale资源只应该在Locale切换时加载一次，
  ///不需要每次在Localizations重新build时都加载，
  ///所以返回false即可。可能有些人会担心返回false的话在APP
  ///启动后用户再改变系统语言时load方法将不会被调用，所以Locale资源将不会被加载。
  ///事实上，每当Locale改变时Flutter都会再调用load方法加载新的Locale，
  ///无论shouldReload返回true还是false。
  @override
  bool shouldReload(covariant LocalizationsDelegate<FreeLocalizations> old) => false;

}



abstract class FreeString {

  String? pressOk;

  String? pressCancel;

}

/// Simplified Chinese
class ChFreeString implements FreeString {
  @override
  String? pressCancel = "取消";

  @override
  String? pressOk = "确认";

}

/// English
class EnFreeString implements FreeString {
  @override
  String? pressCancel = "Cancel";

  @override
  String? pressOk = "Ok";

}

/// Japanese
class JpFreeString implements FreeString {

  @override
  String? pressCancel = "いいえ";

  @override
  String? pressOk = "はい";
}