import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_flutter_mvvm/view_models/my_home_page_view_model.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // const MyHomePage({Key? key, required this.title}) : super(key: key) {
  //  runSomeCodeInInit();
  // }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<MyHomePageViewModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            _CounterWidget(counter: viewModel.counter),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _CounterWidget extends StatelessWidget {
  final int? counter;

  const _CounterWidget({super.key, required this.counter});

  @override
  Widget build(BuildContext context) {
    return counter == null
        ? const Column(
            children: [
              SizedBox(height: _Constant.progressIndicatorSpacing),
              CircularProgressIndicator(),
            ],
          )
        : Text(
            '${counter!}',
            style: Theme.of(context).textTheme.headlineMedium,
          );
  }
}

class _Constant {
  static const double progressIndicatorSpacing = 10;

  // A private constructor
  _Constant._();
}
