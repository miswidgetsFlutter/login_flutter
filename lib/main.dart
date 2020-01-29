import 'package:flutter/material.dart';
import 'dart:async';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter app',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controlUsuario = new TextEditingController();
  TextEditingController controlContrasena = new TextEditingController();

  Future<List> obtenerUsuario() async {
    var url = "http://192.168.1.69/api_login_flutter/obtenerUsuario.php";
    final response = await http.post(url, body: {
      "usuario": controlUsuario.text,
      "contrasena": controlContrasena.text
    });
    if (response.body == "CORRECTO") {
      Toast.show("LOGIN CORRECTO", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.green,
          textColor: Colors.white);
    } else if (response.body == "ERROR") {
      Toast.show("LOGIN INCORRECTO", context,
          duration: Toast.LENGTH_LONG,
          gravity: Toast.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 5, top: 30, right: 5),
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/more.jpg",
              scale: 1.5,
              //width: 200.0,
              //height: 100.0,
              //fit: BoxFit.contain,
            ),
            Container(
              padding: EdgeInsets.only(left: 50, top: 25, right: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    controller: controlUsuario,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: "USUARIO",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextField(
                    controller: controlContrasena,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "CONTRASENA",
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(50),
              child: RaisedButton(
                color: Colors.green,
                textColor: Colors.white,
                child: Text("INICIAR SESION"),
                onPressed: () {
                  obtenerUsuario();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
