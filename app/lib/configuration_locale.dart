class ConfigurationLocale {
  static const ConfigurationLocale _instance = ConfigurationLocale();
  static ConfigurationLocale get instance => _instance;
  final bool _peutSeConnecter;

  const ConfigurationLocale({bool peutSeConnecter = true})
    : _peutSeConnecter = peutSeConnecter;

  bool get peutSeConnecter => _peutSeConnecter;
  static bool canConnect() => _instance._peutSeConnecter;
}
