import 'package:flutter/material.dart';

class ExampleInheritWidgetStart extends StatelessWidget {
  const ExampleInheritWidgetStart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: DateOwnerStateFull(),
        ),
      ),
    );
  }
}

class DateOwnerStateFull extends StatefulWidget {
  const DateOwnerStateFull({Key? key}) : super(key: key);

  @override
  State<DateOwnerStateFull> createState() => _DateOwnerStateFullState();
}

class _DateOwnerStateFullState extends State<DateOwnerStateFull> {
  var _value = 0;

  void increment() {
    _value += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => increment(),
          child: const Text("Tap"),
        ),
        DataProviderInherit(
          value: _value,
          child: const DateConsumerStateless(),
        ),
      ],
    );
  }
}

class DateConsumerStateless extends StatelessWidget {
  const DateConsumerStateless({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = context.dependOnInheritedWidgetOfExactType<DataProviderInherit>()?.value??0;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("$value"),
        const DateConsumerStateFull(),
      ],
    );
  }
}

class DateConsumerStateFull extends StatefulWidget {
  const DateConsumerStateFull({Key? key}) : super(key: key);

  @override
  State<DateConsumerStateFull> createState() => _DateConsumerStateFullState();
}

class _DateConsumerStateFullState extends State<DateConsumerStateFull> {
  @override
  Widget build(BuildContext context) {
    final element =
        context.getElementForInheritedWidgetOfExactType<DataProviderInherit>();
    if (element != null) {
      context.dependOnInheritedElement(element);
    }
    final dataProvider = element?.widget as DataProviderInherit;
    final value = dataProvider.value;
    return Text("$value");
  }
}

class DataProviderInherit extends InheritedWidget {
  final int value;

  const DataProviderInherit({
    Key? key,
    required this.value,
    required Widget child,
  }) : super(key: key, child: child);

  static DataProviderInherit of(BuildContext context) {
    final DataProviderInherit? result =
        context.dependOnInheritedWidgetOfExactType<DataProviderInherit>();
    assert(result != null, 'No DataProviderInherit found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DataProviderInherit oldWidget) {
    return value != oldWidget.value;
  }
}
