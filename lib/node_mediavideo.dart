class nodemediavideo {
  late String rmid;
  late String rmmedia;
  late String rmtype;

  nodemediavideo(this.rmid, this.rmmedia, this.rmtype);

  nodemediavideo.fromJson(
    String rmid,
    String rmmedia,
    String rmtype,
  ) {
    this.rmid = rmid;
    this.rmmedia = rmmedia;
    this.rmtype = rmtype;
  }
}
