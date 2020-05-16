class Env {
  Env(this.baseUrl);

  final String baseUrl;
}

mixin EnvValue {
  static final Env development = Env('http://192.168.43.191:8080');
  static final Env production = Env('https://chattingan.cleverapps.io');
}