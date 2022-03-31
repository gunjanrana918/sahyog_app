class noderecieverinfo {
  late String rid;
  late String rdphoto;
  late String ramount;
  late String rgoalamount;
  late String rdescription;

  noderecieverinfo(
    this.rid,
    this.rdphoto,
    this.ramount,
    this.rgoalamount,
    this.rdescription,
  );

  noderecieverinfo.fromJson(
    String rid,
    String rdphoto,
    String ramount,
    String rgoalamount,
    String rdescription,
  ) {
    this.rid = rid;
    this.rdphoto = rdphoto;
    this.rgoalamount = ramount;
    this.rgoalamount = rgoalamount;
    this.rdescription = rdescription;
  }
}
