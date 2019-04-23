import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'TDA/Asientos.dart';
import 'Herramientas/Strings.dart';
import 'Funciones.dart';
class Reservaciones extends StatefulWidget{
  num idFuncion;
  String pelicula;
  Reservaciones(this.idFuncion,this.pelicula);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ReservacioneState(idFuncion,pelicula);
  }
}

class ReservacioneState extends State<Reservaciones>{
  num idFuncion;
  String pelicula;
  ReservacioneState(this.idFuncion,this.pelicula);
  Asientos asiento;
  Map reservacion;
  List<Asientos> list=new List<Asientos>();
  List respuesta=new List();
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

  @override
  void initState() {
    Asientos asiento;
    String pelicula;
    // TODO: implement initState
    super.initState();
    cargar();
  }
  void cargar()async {
    Future<String> getAsientos() async{
      String ruta="${Strings.url}Reservacion/asientos/${idFuncion}";
      Asientos asiento;
      List<Asientos> asientosaux=new List<Asientos>();
      int i;
      Map data;
      final response= await http.get(Uri.encodeFull(ruta));
      if(response.statusCode==200){
        data=jsonDecode(response.body);
        if(data['valid']==1){
          respuesta=data['asientos'];
          for(i=0;i<respuesta.length;i++){
            asiento=new Asientos(respuesta[i]['idasiento'], respuesta[i]['asiento']);
            asientosaux.add(asiento);
          }
          setState(() {
            asientos=asientosaux;
          });
        }
      }
      else
        throw Exception("no se puedo realizar la peticion");
    }
    getAsientos();
  }
  Future<String> reservar(BuildContext context)async{
    var url="${Strings.url}Reservacion/reservar";
    Map valid;
    String body=jsonEncode(reservacion);
    print(body);
    print("entre a reservar");
    print(url);
    http.post("http://192.168.1.143:3000/api/Reservacion/reservar",headers:{
      "content-type": "application/json",
      "accept": "application/json"
    },body:body).then((response){
      if(response.statusCode==200){
        print("realice la peticion");
          valid=jsonDecode(response.body);
          if(valid['valid']==1){
            _showSnackBar("reservacion guardada con exito");
            list.clear();
            Navigator.pop(context);
          }
          else{
            _showSnackBar("Algo salio mal intentelo mas tarde");
            list.clear();
            Navigator.pop(context);
          }
      }
      else{
        print(response.statusCode);
        print("no se pudo realizar la operacion");
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("${pelicula}"),
          backgroundColor:Colors.amber,
        ),
        backgroundColor: Colors.white,
        key: _scaffoldKey,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.save),
            onPressed:()async{
                bool result;
                _saved.forEach((asiento){
                  list.add(asiento);
                });
              reservacion={
                "idUser":1,
                "idFuncion":idFuncion,
                "asientos":list
              };
              print("di click");
              reservar(context);
            }
        ),
        bottomNavigationBar: Container(
          height:55.0,
          child:BottomAppBar(
            color:Colors.amber,
            child:new Row(
              mainAxisAlignment:MainAxisAlignment.spaceAround ,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  icon:Icon(Icons.account_circle,color: Colors.white,),
                  onPressed:(){
                  },
                ),
                IconButton(
                  icon:Icon(Icons.directions_run,color: Colors.white,),
                  onPressed:(){
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ) ,
        ),
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