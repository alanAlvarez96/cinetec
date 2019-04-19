import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'TDA/Funcion.dart';
import 'Reservacion.dart';
class Lista extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ListaState();
  }
}
class ListaState extends State<Lista>{
  final GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  List<Funcion> funciones= new List<Funcion>();
  _showSnackBar(String texto){
    final snackBar= new SnackBar(
      content:new Text(texto),
      duration:new Duration(seconds: 5) ,
      backgroundColor: Colors.amber,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
  final bottomMenu=Container(
    height:55.0,
    child:BottomAppBar(
      color:Colors.amber,
      child:new Row(
        mainAxisAlignment:MainAxisAlignment.spaceAround ,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
            icon:Icon(Icons.account_circle,color: Colors.white,),
            onPressed: null,
          ),
          IconButton(
            icon:Icon(Icons.directions_run,color: Colors.white,),
            onPressed: null,
          ),
        ],
      ),
    ) ,
  );
  @override
  void initState() {
    Funcion funcion;
    String pelicula;
    // TODO: implement initState
    super.initState();
    setState(() {
      for(int i=0;i<10;i++){
        pelicula="pelicula ${i}";
        funcion=new Funcion(i, pelicula,"10:00","sala 2");
        funciones.add(funcion);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        bottomNavigationBar: bottomMenu,
        body:ListView.builder(
          itemCount: funciones.length,
          itemBuilder: (BuildContext context,int index) {
            return new Card(
                child: new Column(
                  children: <Widget>[
                    new ListTile(
                      title: new Text(
                        funciones[index].pelicula,
                        style: new TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.bold),
                      ),
                      subtitle: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text('sala: ${funciones[index].sala}',
                                style: new TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.normal)),
                            new Text('Horario: ${funciones[index].horario}',
                                style: new TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.normal))
                          ]),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)=>new Reservaciones(funciones[index].idFuncion)));
                        //_showSnackBar("funcion ${funciones[index].idFuncion}");
                      },
                    )
                  ],
                ));
          }
        ),
      ),
    );
  }

}