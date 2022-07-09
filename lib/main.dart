import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
    아! 이거 아직 모르겠다. 
*

* state Management 에는 Ephemeral 과 App 이 있다.
* Ephemeral 은 local state 에 관련된거다.
* App 은 Global state 에 관련된거다.
* 1. 공유하고 싶은 클래스 생성
* 2. 이 클래스를 Provider 을 통해서 공유
* 3. Provider.of<xxx>(context) 를 통해서 값을 사용
 */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      ChangeNotifierProxyProvider<CounterChangeNotifier, PlusTwoChangeNotifier>(
        create: (context) => PlusTwoChangeNotifier(),
        update: (_, __, plusTowChangerNotifier) => plusTowChangerNotifier!..increment(),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    var counterChangeNotifier = Provider.of<CounterChangeNotifier>(context); // 객체 만들었고.. 그객체를 위에서 사용한다고 했고
    // 여기서 변수로 받았다.
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              counterChangeNotifier.counter.toString(), // TODO
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.of<CounterChangeNotifier>(context, listen: false).increment(),
        // 괭장히 중요한 부분이다. 내가 만든 클래스의 함수를 실행시킬때 값이 변경되는건 궁금하지 않고 그냥 함수를 받아오고 싶을 때
        // listen : false 로 세팅해준다.
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class CounterChangeNotifier with ChangeNotifier { // setState 대신에 사용할 수 있다.
  int _counter = 0;
  int get counter => _counter;
  increment() {
    _counter++;
    notifyListeners();
  }
}

class PlusTwoChangeNotifier with ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  increment() {
    _counter = _counter + 2;
    notifyListeners();
  }
}