import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'TDA/Funcion.dart';
import 'Reservacion.dart';
import 'Herramientas/Strings.dart';
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
  List respuesta;
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
    cargar();
  }
  void cargar()async{
    Future<String> getFunciones() async{
      String ruta="${Strings.url}funciones/funciones";
      Funcion funcion;
      List<Funcion> funcionesaux= new List<Funcion>();
      int i;
      Map data;
      final response= await http.get(Uri.encodeFull(ruta));
      if(response.statusCode==200){
        data=jsonDecode(response.body);
        if(data['valid']==1){
          respuesta=data['funciones'];
          for(i=0;i<respuesta.length;i++){
            funcion=new Funcion(respuesta[i]['idfuncion']
                , respuesta[i]['titulo']
                , respuesta[i]['horario']
                , respuesta[i]['sala']
                , respuesta[i]['idioma']);
            funcionesaux.add(funcion);
          }
          setState(() {
            funciones=funcionesaux;
          });
        }
      }
      else
        throw Exception("no se puedo realizar la peticion");
    }
    getFunciones();
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
                        funciones[index].titulo,
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