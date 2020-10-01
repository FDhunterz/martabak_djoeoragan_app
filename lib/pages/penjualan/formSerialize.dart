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
  List<String> listIdToppingItem;
  List<String> listNamaToppingItem;
  List<double> listHargaToppingItem;

  Map<String, List<dynamic>> idVarianItem;
  Map<String, List<dynamic>> namaVarianItem;
  Map<String, List<dynamic>> hargaVarianItem;

  double totalDiskon;

  String catatanPenjualan;

  Map toJson() {
    Map<String, dynamic> formSerialize = Map<String, dynamic>();

    formSerialize['cabangs'] = cabangs;
    if (isCustomerSelected) {
      formSerialize['c_nama'] = namaCustomer;
      formSerialize['c_telepon'] = noTelp;
      formSerialize['c_alamat'] = alamat;
    }

    formSerialize['pk_bayar'] = jumlahBayar;
    formSerialize['p_harga'] = idHargaPenjualan;

    formSerialize['pkdt_item'] = listIdItem;
    formSerialize['pkdt_qty'] = listQtyItem;
    formSerialize['pkdt_harga_item'] = listHargaItem;
    formSerialize['pkdt_diskon'] = listDiskonItem;

    formSerialize['pkdt_varian'] = listIdToppingItem;
    formSerialize['pkdt_nama_varian'] = listNamaToppingItem;
    formSerialize['pkdt_modifier'] = listHargaToppingItem;

    formSerialize['id_modifier'] = idVarianItem;
    formSerialize['nama_modifier'] = namaVarianItem;
    formSerialize['harga_modifier'] = hargaVarianItem;

    formSerialize['pk_diskon_plus'] = totalDiskon;
    formSerialize['platform'] = 'android';
    formSerialize['outlet'] = outlet;
    formSerialize['pk_catatan'] = catatanPenjualan;

    return formSerialize;
  }

  FormSerializeSimpanPenjualan({
    this.alamat,
    this.cabangs,
    this.catatanPenjualan,
    this.hargaVarianItem,
    this.idHargaPenjualan,
    this.idVarianItem,
    this.isCustomerSelected,
    this.jumlahBayar,
    this.listDiskonItem,
    this.listHargaItem,
    this.listHargaToppingItem,
    this.listIdItem,
    this.listIdToppingItem,
    this.listNamaToppingItem,
    this.listQtyItem,
    this.namaCustomer,
    this.namaVarianItem,
    this.noTelp,
    this.outlet,
    this.totalDiskon,
  });
}
