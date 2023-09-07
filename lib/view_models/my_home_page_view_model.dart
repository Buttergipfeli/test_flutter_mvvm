import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_flutter_mvvm/shared_preference_keys/counter_keys.dart';

class MyHomePageViewModel extends ChangeNotifier {
  int? _counter;

  MyHomePageViewModel() {
    _loadCounter();
  }

  int? get counter => _counter;

  increment() {
    if (_counter == null) return;
    _counter = _counter! + 1;
    // compute((_) => _saveCounterToPrefs(), null);
    // compute(_saveCounterToPrefs, _counter);
    // The compute function offloads tasks to an isolated thread.
    // However, not everything can be isolated, especially SharedPreferences.
    _saveCounterToPrefs();
    notifyListeners();
  }

  _saveCounterToPrefs() async {
    if (_counter == null) return;
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(CounterKeys.counterKey, _counter!);
  }

  _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt(CounterKeys.counterKey);
    notifyListeners();
  }
}
