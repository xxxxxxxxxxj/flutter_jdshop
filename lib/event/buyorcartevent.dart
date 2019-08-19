import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class BuyOrCartEvent {
  int _flag;

  @override
  String toString() {
    return 'BuyOrCartEvent{_flag: $_flag}';
  }

  BuyOrCartEvent.name();

  BuyOrCartEvent(this._flag);

  int get flag => _flag;

  set flag(int value) {
    _flag = value;
  }
}
