class Asientos{
  num idAsiento;
  String asiento;
  Asientos(this.idAsiento,this.asiento);
  toJson() {
    return {
      'idAsiento': idAsiento,
      'asiento':asiento,
    };
  }
}