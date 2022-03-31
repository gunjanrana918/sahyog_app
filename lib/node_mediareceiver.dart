class nodemedia {
  late String rmid;
  late String rmmedia;
  late String rmtype;

  nodemedia(this.rmid, this.rmmedia, this.rmtype);

  nodemedia.fromJson(
    String rmid,
    String rmmedia,
    String rmtype,
  ) {
    this.rmid = rmid;
    this.rmmedia = rmmedia;
    this.rmtype = rmtype;
  }
}
