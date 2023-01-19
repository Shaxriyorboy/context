import 'package:flutter/material.dart';

final key = GlobalKey<_ColoredWidgetState>();

class Context extends StatelessWidget {
  const Context({Key? key}) : super(key: key);

  static void nextScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const NextScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Context"),
      ),
      body: SafeArea(
        child: Center(
          child: ElevatedButton(
              onPressed: () => nextScreen(context),
              child: const Text("Example Screen")),
        ),
      ),
    );
  }
}

class NextScreen extends StatelessWidget {
  const NextScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: ColoredWidget(
          initialColor: Colors.teal,
          child: Padding(
            padding: EdgeInsets.all(40),
            child: ColoredWidget(
              initialColor: Colors.green,
              child: Padding(
                padding: EdgeInsets.all(40),
                child: ColoredWidget(
                  initialColor: Colors.amberAccent,
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: ColorButton(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ColoredWidget extends StatefulWidget {
  final Widget child;
  final Color initialColor;

  const ColoredWidget(
      {Key? key, required this.child, required this.initialColor})
      : super(key: key);

  @override
  State<ColoredWidget> createState() => _ColoredWidgetState();
}

class _ColoredWidgetState extends State<ColoredWidget> {
  late Color color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    color = widget.initialColor;
  }

  void changeColor(Color color) {
    setState(() {
      this.color = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: widget.child,
    );
  }
}

class ColorButton extends StatelessWidget {
  const ColorButton({Key? key}) : super(key: key);

  void _onPressed(BuildContext context) {
    // context
    //     .findAncestorStateOfType<_ColoredWidgetState>()!
    //     .changeColor(Colors.black);

    // context.findRootAncestorStateOfType<_ColoredWidgetState>()?.changeColor(Colors.red);

    // key.currentState!.changeColor(Colors.red);

    // final dd = context.findRenderObject()?.runtimeType;

    context.findAncestorWidgetOfExactType<NextScreen>()?.key;
  }

  @override
  Widget build(BuildContext context) {
    return ColoredWidget(
      key: key,
      initialColor: Colors.blue,
      child: Center(
        child: ElevatedButton(
          onPressed: () => _onPressed(context),
          child: const Text("Tap"),
        ),
      ),
    );
  }
}
