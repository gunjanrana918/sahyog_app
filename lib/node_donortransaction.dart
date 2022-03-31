class nodetransaction {
  late String did;
  late String tid;
  late String transamount;
  late String tcreatedate;

  nodetransaction(
    this.did,
    this.tid,
    this.transamount,
    this.tcreatedate,
  );

  nodetransaction.fromJson(
      String did, String tid, String transamount, String tcreatedate) {
    this.did = did;
    this.tid = tid;
    this.transamount = transamount;
    this.tcreatedate = tcreatedate;
  }
}
