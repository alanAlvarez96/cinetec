import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'TDA/Asientos.dart';

class Reservaciones extends StatefulWidget{
  num idFuncion;
  Reservaciones(this.idFuncion);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReservacioneState(idFuncion);
  }
}

class ReservacioneState extends State<Reservaciones>{
  num idFuncion;
  ReservacioneState(this.idFuncion);
  Asientos asiento;
  Map reservacion;
  List<Asientos> list=new List<Asientos>();
  final _saved=Set<Asientos>();
  final GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  List<Asientos> asientos=new List<Asientos>();
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
    Asientos asiento;
    String pelicula;
    // TODO: implement initState
    super.initState();
    setState(() {
      for(int i=0;i<10;i++){
        asiento=new Asientos(i,"a${i}");
        asientos.add(asiento);
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.save),
            onPressed:(){
              _saved.forEach((asiento){
                list.add(asiento);
              });
            reservacion={
              "funcion":idFuncion,
              "asientos":list
            };
            print(jsonEncode(reservacion));
            list.clear();
            _showSnackBar("reservacion guardada");
            }
        ),
        bottomNavigationBar: bottomMenu,
        body:ListView.builder(
            itemCount: asientos.length,
            itemBuilder: (BuildContext context,int index) {
              final _isSaved=_saved.contains(asientos[index]);
              return new Card(
                elevation: 5.0,
                  child: new Column(
                    children: <Widget>[
                      new ListTile(
                        title: new Text(
                          asientos[index].asiento,
                          style: new TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                        trailing: new Icon(
                          _isSaved? Icons.check_circle : Icons.check_circle_outline,
                          color:_isSaved? Colors.green : null,
                        ),
                        onTap: () {
                          setState(() {
                            _isSaved? _saved.remove(asientos[index]) : _saved.add(asientos[index]);
                          });
                          _saved.forEach((asiento){
                              print("${asiento.idAsiento}:${asiento.asiento}");
                          });
                          //_showSnackBar("asiento ${asientos[index].idAsiento}");
                        },
                      )
                    ],
                  ));
            }
        )
      ),
    );
  }

}