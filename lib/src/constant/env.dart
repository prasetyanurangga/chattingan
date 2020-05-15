class Env {
  Env(this.baseUrl);

  final String baseUrl;
}

mixin EnvValue {
  static final Env development = Env('<YOUR-SERVER-URL-OR-IP>');
  static final Env production = Env('<YOUR-SERVER-URL-OR-IP>');
}