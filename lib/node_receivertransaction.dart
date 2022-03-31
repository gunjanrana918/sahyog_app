class node_receivetrans {
  late String rid;
  late String tid;
  late String transamount;
  late String tcreatedate;

  node_receivetrans(
    this.rid,
    this.tid,
    this.transamount,
    this.tcreatedate,
  );

  node_receivetrans.fromJson(
      String did, String tid, String transamount, String tcreatedate) {
    this.rid = rid;
    this.tid = tid;
    this.transamount = transamount;
    this.tcreatedate = tcreatedate;
  }
}
