class DiskonModel {
  int id, idItem, isConfirm, isDouble, isActive, periode;
  String kode, nama, tipe, mulai, akhir, catatan, tanggal;
  DiskonModel({
    this.akhir,
    this.catatan,
    this.id,
    this.idItem,
    this.isActive,
    this.isConfirm,
    this.isDouble,
    this.kode,
    this.mulai,
    this.nama,
    this.tanggal,
    this.tipe,
    this.periode,
  });
}

List<DTipe> listDTipe = [
  DTipe(
    id: 'ITEM',
    text: 'Potongan harga item',
  ),
  DTipe(
    id: 'SUB',
    text: 'Potongan berdasarkan total pembelian',
  ),
];

class DTipe {
  String id, text;

  bool operator ==(Object other) => other is DTipe && other.id == id;

  int get hashCode => id.hashCode;

  DTipe({
    this.id,
    this.text,
  });
}

class Produk {
  String id, nama;

  bool operator ==(Object other) => other is Produk && other.id == id;

  int get hashCode => id.hashCode;

  Produk({
    this.id,
    this.nama,
  });
}
