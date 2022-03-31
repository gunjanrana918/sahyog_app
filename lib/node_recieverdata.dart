class Nodereciever {
  late String rid;
  late String rname;
  late String rdphoto;

  Nodereciever(
    this.rid,
    this.rname,
    this.rdphoto,
  );

  Nodereciever.fromJson(
    String rid,
    String rname,
    String rdphoto,
  ) {
    this.rid = rid;
    this.rname = rname;
    this.rdphoto = rdphoto;
  }
}
