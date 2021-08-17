import 'package:flutter/material.dart';
import 'package:flutter_bloc/home.dart';
import 'bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(title: 'Flutter Bloc Pattern'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final bloc = Bloc();

  changePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<String>(
                stream: bloc.email,
                builder: (context, snapshot) => TextField(
                  onChanged: bloc.emailOnChanged,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    hintText: "Enter your email",
                    errorText: snapshot.error?.toString(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                width: 20,
              ),
              StreamBuilder<String>(
                stream: bloc.password,
                builder: (context, snapshot) => TextField(
                  onChanged: bloc.passwordOnChanged,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Enter your password",
                    errorText: snapshot.error?.toString(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
                width: 20,
              ),
              StreamBuilder<bool>(
                stream: bloc.submitCheck,
                builder: (context, snapshot) => ElevatedButton(
                  onPressed:
                      snapshot.hasData ? () => changePage(context) : null,
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
