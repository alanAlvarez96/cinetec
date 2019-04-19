import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Herramientas/Strings.dart';
import 'Funciones.dart';
class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginState();
  }
}

class LoginState extends State <Login>{
  final GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  final mailController=TextEditingController();
  final passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    _showSnackBar(String texto){
      final snackBar= new SnackBar(
        content:new Text(texto),
        duration:new Duration(seconds: 5) ,
        backgroundColor: Colors.amber,
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
    Future<String> login() async{
      Map validate;
      String ruta= "${Strings.url}/Usuarios,login";
      /*http.post(ruta,body: {
        "correo":mailController.text,
        "password":passwordController.text
      }).then((response){
        validate=jsonDecode(response.body);
        if(validate['valid']==1){
          //Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)=>new DashBoard()));
        }
        if(validate['valid']==2){
          _showSnackBar("usuario o contraseña incorrectos");
        }
      });*/
      _showSnackBar("usuario o contraseña incorrectos");
      Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)=>new Lista()));
    }
    //construccion de cajas de texto
    final txtEmail=TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: mailController,
      decoration: InputDecoration(
        hintText: 'Correo',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final txtPwd=TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Contraseña',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final loginButton= Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed:(){
          login();
        },
        padding: EdgeInsets.all(12),
        color: Colors.amber,
        child: Text('Iniciar sesión', style: TextStyle(color: Colors.white)),
      ),
    );
//metodo login
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            txtEmail,
            SizedBox(height: 30.0),
            txtPwd,
            SizedBox(height: 30.0),
            loginButton
          ],
        ),
      ),
    );
  }

}