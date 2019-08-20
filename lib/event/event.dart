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

class CartNumEvent {
  int _flag;
  int _num;
  int _index;

  CartNumEvent.name();

  CartNumEvent(this._flag, this._num, this._index);

  int get num => _num;

  set num(int value) {
    _num = value;
  }

  int get flag => _flag;

  set flag(int value) {
    _flag = value;
  }

  int get index => _index;

  set index(int value) {
    _index = value;
  }
}
