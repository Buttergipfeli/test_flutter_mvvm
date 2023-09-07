import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePageViewModel extends ChangeNotifier {
  int _counter = 0;
  static const _counterKey = "counter_key";

  MyHomePageViewModel() {
    _loadCounter();
  }

  int get counter => _counter;

  increment() {
    _counter++;
    // compute((_) => _saveCounterToPrefs(), null);
    // compute(_saveCounterToPrefs, _counter);
    // The compute function offloads tasks to an isolated thread.
    // However, not everything can be isolated, especially SharedPreferences.
    _saveCounterToPrefs();
    notifyListeners();
  }

  Future<void> _saveCounterToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(_counterKey, _counter);
  }

  _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt(_counterKey) ?? 0;
    notifyListeners();
  }
}
