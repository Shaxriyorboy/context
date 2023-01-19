import 'package:flutter/material.dart';

class ExampleInheritedNotifierEnd extends StatelessWidget {
  const ExampleInheritedNotifierEnd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SimpleCalWidget(),
        ),
      ),
    );
  }
}

class SimpleCalWidget extends StatefulWidget {
  const SimpleCalWidget({Key? key}) : super(key: key);

  @override
  State<SimpleCalWidget> createState() => _SimpleCalWidgetState();
}

class _SimpleCalWidgetState extends State<SimpleCalWidget> {
  final _model = SimpleCalWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SimpleCalWidgetProvider(
          model: _model,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              FirstNumberWidget(),
              SizedBox(height: 10),
              SecondNumberWidget(),
              SizedBox(height: 10),
              SumButtonWidget(),
              SizedBox(height: 10),
              ResultWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class FirstNumberWidget extends StatelessWidget {
  const FirstNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (value) =>
      SimpleCalWidgetProvider.read(context)?.firstNumber = value,
    );
  }
}

class SecondNumberWidget extends StatelessWidget {
  const SecondNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (value) =>
      SimpleCalWidgetProvider.read(context)?.secondNumber = value,
    );
  }
}

class SumButtonWidget extends StatelessWidget {
  const SumButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => SimpleCalWidgetProvider.read(context)?.sum(),
      child: const Text('sum of numbers'),
    );
  }
}


class ResultWidget extends StatelessWidget {
  const ResultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _value = SimpleCalWidgetProvider.watch(context)?.sumResult ?? '0';
    return Text(
      "Result: $_value",
      style: const TextStyle(fontSize: 24),
    );
  }
}

class SimpleCalWidgetModel extends ChangeNotifier{
  int? _firstNumber;
  int? _secondNumber;
  int? sumResult;

  set firstNumber ( String value ) => _firstNumber = int.parse(value);

  set secondNumber ( String value ) => _secondNumber = int.parse(value);

  void sum(){
    int? sumResult;

    if(_firstNumber != null && _secondNumber != null){
      sumResult = _firstNumber! + _secondNumber!;
    }else{
      sumResult = null;
    }

    if(this.sumResult != sumResult){
      this.sumResult = sumResult;
      notifyListeners();
    }
  }
}

class SimpleCalWidgetProvider extends InheritedNotifier<SimpleCalWidgetModel>{
  const SimpleCalWidgetProvider({
    Key? key,
    required SimpleCalWidgetModel model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static SimpleCalWidgetModel? watch(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<SimpleCalWidgetProvider>()?.notifier;
  }

  static SimpleCalWidgetModel? read(BuildContext context){
    final widget = context.getElementForInheritedWidgetOfExactType<SimpleCalWidgetProvider>()?.widget;
    return widget is SimpleCalWidgetProvider?widget.notifier:null;
  }
}