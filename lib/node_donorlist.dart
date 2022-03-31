class Nodedonor {
  late String did;
  late String dname;
  late String dimage;
  late String transamount;

  Nodedonor(this.did, this.dname, this.dimage, this.transamount);

  Nodedonor.fromJson(String did, String dname, String dimage,
      String transamount) {
    this.did = did;
    this.dname = dname;
    this.dimage = dimage;
    this.transamount = transamount;
  }
}
