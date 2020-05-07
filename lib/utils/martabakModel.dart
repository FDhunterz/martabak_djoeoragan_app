class MartabakModel {
  String name, img, price, sysprice, desc, details, diskon, diskonDariKupon;
  int qty, id;
  List<HargaPenjualanPerItem> listHargaPenjualan;

  MartabakModel({
    this.name,
    this.img,
    this.desc,
    this.details,
    this.price,
    this.sysprice,
    this.qty,
    this.id,
    this.diskon,
    this.diskonDariKupon,
    this.listHargaPenjualan,
  });
}

class HargaPenjualanPerItem {
  String idGroup, harga, idItem;

  HargaPenjualanPerItem({
    this.harga,
    this.idGroup,
    this.idItem,
  });
}

class HargaPenjualan {
  String id, nama, selected;

  HargaPenjualan({
    this.id,
    this.nama,
    this.selected,
  });
}

class Customer {
  String idCustomer,
      kodeCustomer,
      namaCustomer,
      alamat,
      namaProvinsi,
      namaKabupatenKota,
      namaKecamatan,
      kodePos,
      noTelp,
      email,
      idProvinsi,
      idKabupatenKota,
      idKecamatan;

  Customer({
    this.idCustomer,
    this.namaCustomer,
    this.kodeCustomer,
    this.alamat,
    this.namaKabupatenKota,
    this.namaKecamatan,
    this.namaProvinsi,
    this.kodePos,
    this.idKabupatenKota,
    this.idKecamatan,
    this.idProvinsi,
    this.email,
    this.noTelp,
  });
}

class KuponBelanja {
  String id,
      nama,
      kategoriHarga,
      nominal,
      dPersen,
      dMaxDiskon,
      dIsDouble,
      catatan,
      selected,
      disabled;

  KuponBelanja({
    this.id,
    this.catatan,
    this.dMaxDiskon,
    this.dIsDouble,
    this.dPersen,
    this.disabled,
    this.kategoriHarga,
    this.nama,
    this.nominal,
    this.selected,
  });
}
