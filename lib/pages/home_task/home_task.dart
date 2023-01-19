import 'package:context/models/post_model.dart';
import 'package:context/services/http_service.dart';
import 'package:flutter/material.dart';

class HomeTask extends StatefulWidget {
  const HomeTask({Key? key}) : super(key: key);

  @override
  State<HomeTask> createState() => _HomeTaskState();
}

class _HomeTaskState extends State<HomeTask> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SimpleCalWidget(),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    SimpleCalWidgetModel().apiGetPost();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SimpleCalWidgetProvider(
          model: _model,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const FirstNumberWidget(),
              const SizedBox(height: 10),
              const SecondNumberWidget(),
              const SizedBox(height: 10),
              const SumButtonWidget(),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    itemCount: _model.posts.length,
                    itemBuilder: (context, index) {
                      return ResultWidget(index: index,);
                    }),
              )
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
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (value) =>
          SimpleCalWidgetProvider.read(context)?.title = value,
    );
  }
}

class SecondNumberWidget extends StatelessWidget {
  const SecondNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (value) =>
          SimpleCalWidgetProvider.read(context)?.body = value,
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
  final int? index;
  const ResultWidget({Key? key,this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _body = SimpleCalWidgetProvider.watch(context)?.posts[index!].body ?? 'body';
    var _title = SimpleCalWidgetProvider.watch(context)?.posts[index!].title ?? 'title';
    return ListTile(
      title: Text(
        "Title: $_title",
        style: const TextStyle(fontSize: 24),
      ),
      subtitle: Text(
        "Body: $_body",
        style: const TextStyle(fontSize: 24),
      ),
    );
  }
}

class SimpleCalWidgetModel extends ChangeNotifier {
  String? _title;
  String? _body;
  List<Post> posts = [];

  set title(String value) => _title = value;

  set body(String value) => _body = value;

  void apiGetPost()async{
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if(response != null){
      var result = Network.parsePostList(response);
      posts = result;
      notifyListeners();
      print(posts.toString());
    }
  }

  void sum() async{

    if (_title != null && _body != null) {
      Post post = Post(title: _title,body: _body);
      var response = await Network.POST(Network.API_CREATE, Network.paramsCreate(post));
      if(response != null){
        print(response.toString());
        posts = Network.parsePostList(response);
        notifyListeners();
      }
      print(posts[0].title);
    } else {

    }
  }
}

class SimpleCalWidgetProvider extends InheritedNotifier<SimpleCalWidgetModel> {
  const SimpleCalWidgetProvider({
    Key? key,
    required SimpleCalWidgetModel model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static SimpleCalWidgetModel? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SimpleCalWidgetProvider>()
        ?.notifier;
  }

  static SimpleCalWidgetModel? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<SimpleCalWidgetProvider>()
        ?.widget;
    return widget is SimpleCalWidgetProvider ? widget.notifier : null;
  }
}
