import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Herramientas/Strings.dart';
class UserAccount extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AccountState();
  }
}

class AccountState extends State<UserAccount> {
  final GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  List respuesta;
  String registro=" ",compras=" ",registroaux;
  List<String> aux;
  void initState() {
    // TODO: implement initState
    super.initState();
    cargar();
  }
  void cargar() async{
    Future<String> getDatos() async{
      String ruta="${Strings.url}Reservacion/get/1";
      int i;
      Map data;
      final response= await http.get(Uri.encodeFull(ruta));
      if(response.statusCode==200){
        data=jsonDecode(response.body);
        if(data['valid']==1){
          respuesta=data['reservaciones'];
          registroaux=respuesta[0]['registro'];
          aux=registroaux.split("T");
          setState(() {
            registro=aux[0];
            compras=respuesta[0]['book'].toString();
          });
        }
      }
      else
        throw Exception("no se puedo realizar la peticion");
    }
    getDatos();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Mi cuenta"),
          backgroundColor: Colors.amber,
        ),
        key: _scaffoldKey,
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 100.0),
                      height: 300.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
                            child: Material(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                              elevation: 5.0,
                              color: Colors.amber,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 50.0,width: 400,),
                                  Text("Alan Alvarez Vasquez",
                                    style:TextStyle(
                                      color: Colors.white,
                                        fontSize: 18.0
                                    ),
                                    textAlign: TextAlign.center,),
                                  SizedBox(height: 50.0,width: 400,),
                                  Text("Fecha de registro:${registro}",style:TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0
                                  ),textAlign: TextAlign.center,),
                                  SizedBox(height: 50.0,width: 400,),
                                  Text("Compras realizadas:${compras}",
                                    style:TextStyle(
                                        color: Colors.white,
                                      fontSize: 18.0
                                    ),textAlign: TextAlign.center,)
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ) ,
      ),
    );
  }

}