/// untuk membuat body send request simpan penjualan.
class FormSerializeSimpanPenjualan {
  String cabangs, namaCustomer, noTelp, alamat, jumlahBayar, outlet;

  /// id golongan harga
  String idHargaPenjualan;

  bool isCustomerSelected;

  List<int> listIdItem;
  List<int> listQtyItem;
  List<double> listHargaItem;
  List<String> listDiskonItem;

  // untuk nota offline
  String nota;
  double totalPpn;
  String namaUserMelayani;
  String tanggalPenjualan;
  String namaHargaPenjualan;
  List<String> listNamaItem;
  List<String> listGambarItem;
  // end nota offline

  List<String> listIdVarianItem;
  List<String> listNamaVarianItem;
  List<double> listHargaVarianItem;

  Map<String, List<dynamic>> idToppingItem;
  Map<String, List<dynamic>> namaToppingItem;
  Map<String, List<dynamic>> hargaToppingItem;

  double totalDiskon;

  String catatanPenjualan;

  Map toJson() {
    Map<String, dynamic> formSerialize = Map<String, dynamic>();

    formSerialize['cabangs'] = cabangs;
    // if (isCustomerSelected) {
    formSerialize['c_nama'] = namaCustomer;
    formSerialize['c_telepon'] = noTelp;
    formSerialize['c_alamat'] = alamat;
    // }

    formSerialize['pk_bayar'] = jumlahBayar;
    formSerialize['p_harga'] = idHargaPenjualan;

    formSerialize['pkdt_item'] = listIdItem;
    formSerialize['pkdt_qty'] = listQtyItem;
    formSerialize['pkdt_harga_item'] = listHargaItem;
    formSerialize['pkdt_diskon'] = listDiskonItem;

    formSerialize['pkdt_varian'] = listIdVarianItem;
    formSerialize['pkdt_nama_varian'] = listNamaVarianItem;
    formSerialize['pkdt_modifier'] = listHargaVarianItem;

    formSerialize['id_modifier'] = idToppingItem;
    formSerialize['nama_modifier'] = namaToppingItem;
    formSerialize['harga_modifier'] = hargaToppingItem;

    formSerialize['pk_diskon_plus'] = totalDiskon;
    formSerialize['platform'] = 'android';
    formSerialize['outlet'] = outlet;
    formSerialize['c_catatan'] = catatanPenjualan;

    // untuk nota offline
    formSerialize['pkdt_gambar'] = listGambarItem;
    formSerialize['pkdt_nama_item'] = listNamaItem;
    formSerialize['tanggal_penjualan'] = tanggalPenjualan;
    formSerialize['totalPpn'] = totalPpn;
    formSerialize['namaHargaPenjualan'] = namaHargaPenjualan;
    formSerialize['namaUserMelayani'] = namaUserMelayani;
    formSerialize['nota'] = nota;
    // end nota offline

    return formSerialize;
  }

  FormSerializeSimpanPenjualan({
    this.alamat,
    this.cabangs,
    this.catatanPenjualan,
    this.hargaToppingItem,
    this.idHargaPenjualan,
    this.idToppingItem,
    this.isCustomerSelected,
    this.jumlahBayar,
    this.listDiskonItem,
    this.listHargaItem,
    this.listHargaVarianItem,
    this.listIdItem,
    this.listIdVarianItem,
    this.listNamaVarianItem,
    this.listQtyItem,
    this.namaCustomer,
    this.namaToppingItem,
    this.noTelp,
    this.outlet,
    this.totalDiskon,
    this.listGambarItem,
    this.listNamaItem,
    this.namaHargaPenjualan,
    this.namaUserMelayani,
    this.nota,
    this.tanggalPenjualan,
    this.totalPpn,
  });
}
