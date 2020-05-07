class NotaPenjualan {
  String id,
      nota,
      tanggal,
      subTotal,
      diskonPlus,
      pajak,
      bayar,
      harga,
      grandTotal,
      customer,
      telpon,
      alamat,
      kasir;

  List<Item> detailNotaPenjualan;

  NotaPenjualan({
    this.id,
    this.harga,
    this.alamat,
    this.bayar,
    this.customer,
    this.diskonPlus,
    this.grandTotal,
    this.kasir,
    this.nota,
    this.pajak,
    this.subTotal,
    this.tanggal,
    this.telpon,
    this.detailNotaPenjualan,
  });
}

class Item {
  String penjualanKasir, nomor, idItem, namaItem, qty, harga, diskon, total;

  Item({
    this.harga,
    this.diskon,
    this.idItem,
    this.namaItem,
    this.nomor,
    this.penjualanKasir,
    this.qty,
    this.total,
  });
}
