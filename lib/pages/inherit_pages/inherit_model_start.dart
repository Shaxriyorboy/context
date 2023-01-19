import 'package:flutter/material.dart';

class ExampleInheritModelStart extends StatelessWidget {
  const ExampleInheritModelStart({Key? key}) : super(key: key);

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
  var _valueOne = 0;
  var _valueTwo = 0;

  void incrementOne() {
    _valueOne += 1;
    setState(() {});
  }

  void incrementTwo() {
    _valueTwo += 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => incrementOne(),
          child: const Text("Tap -1"),
        ),
        ElevatedButton(
          onPressed: () => incrementTwo(),
          child: const Text("Tap -2"),
        ),
        DataProviderInherit(
          valueOne: _valueOne,
          valueTwo: _valueTwo,
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
    print("Update One");
    final value = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherit>(
                aspect: "one")
            ?.valueOne ??
        0;
    return Column(
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
    print("Update Two");
    var value = context
            .dependOnInheritedWidgetOfExactType<DataProviderInherit>(
                aspect: "two")
            ?.valueTwo ??
        0;
    return Text("$value");
  }
}

class DataProviderInherit extends InheritedModel<String> {
  final int valueOne;
  final int valueTwo;

  const DataProviderInherit({
    Key? key,
    required this.valueOne,
    required this.valueTwo,
    required Widget child,
  }) : super(key: key, child: child);

  static DataProviderInherit of(BuildContext context) {
    final DataProviderInherit? result =
        context.dependOnInheritedWidgetOfExactType<DataProviderInherit>();
    assert(result != null, 'No DateProvider found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(DataProviderInherit oldWidget) {
    return valueOne != oldWidget.valueOne || valueTwo != oldWidget.valueTwo;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant DataProviderInherit oldWidget,
    Set<String> dependencies,
  ) {
    final isValueOneUpdated =
        valueOne != oldWidget.valueOne && dependencies.contains('one');
    final isValueTwoUpdated =
        valueTwo != oldWidget.valueTwo && dependencies.contains('two');

    return isValueOneUpdated || isValueTwoUpdated;
  }
}
