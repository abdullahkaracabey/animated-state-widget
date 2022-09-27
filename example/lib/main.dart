import 'package:animated_state_widget/animated_state_controller.dart';
import 'package:animated_state_widget/animated_state_widget.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated State Widget Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Animated State Widget Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _controller = AnimatedStateController();
  final _controllerAppBar = AnimatedStateController();
  var _isDone = true;
  void _onSubmit(AnimatedStateController controller) async {
    controller.start();

    await Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        controller.error();
      });
    });

    await Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        controller.init();
      });
    });

    _isDone = !_isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            AnimatedStateWidget(
              controller: _controllerAppBar,
              // duration: const Duration(seconds: 1),
              child: TextButton(
                  onPressed: ()=>_onSubmit(_controllerAppBar), child: const Icon(Icons.add, color:Colors.white)),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            const Expanded(child: Text("Hello World")),
            Expanded(
              child: Center(
                child: AnimatedStateWidget(
                  controller: _controller,
                  // duration: const Duration(seconds: 1),
                  child: ElevatedButton(
                      onPressed: () => _onSubmit(_controller), child: const Text("Click Me")),
                ),
              ),
            ),
              ],
            ),
            AnimatedStateWidget(
              controller: _controller,
              // duration: const Duration(seconds: 1),
              child: Container(
                color: Colors.amber,
                child: TextButton(
                    onPressed: () => _onSubmit(_controller), child: const Text("Click Me")),
              ),
            ),
          ],
        ));
  }
}
