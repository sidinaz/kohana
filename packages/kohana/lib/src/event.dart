enum AppEventType {
  RESTART,
  LOCALE,
  SHOW_SEARCH,
  IS_WAITING,
  OPEN_DRAWER,
  LOG_IN,
  LOG_OUT,
}

class AppEvent {
  final AppEventType type;
  final dynamic payload;

  AppEvent(this.type, [this.payload]);
}
