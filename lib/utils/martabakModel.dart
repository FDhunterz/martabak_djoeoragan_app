class MartabakModel {
  String name,
      img,
      price,
      sysprice,
      desc,
      details,
      diskon,
      diskonDariKupon,
      idKategoriItem;
  int qty, id;
  List<HargaPenjualanPerItem> listHargaPenjualan;
  List<ToppingMartabakModel> listTopping;
  List<MartabakVarianModel> listVarian;

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
    this.idKategoriItem,
    this.listTopping,
    this.listVarian,
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

class KategoriItem {
  String id, text;
  KategoriItem({
    this.id,
    this.text,
  });

  bool operator ==(Object other) => other is KategoriItem && other.id == id;

  int get hashCode => id.hashCode;
}

class MartabakVarianModel {
  String idVarian, namaVarian;
  double hargaVarian;
  bool isSelected;

  MartabakVarianModel({
    this.hargaVarian,
    this.idVarian,
    this.namaVarian,
    this.isSelected,
  });
}

class ToppingMartabakModel {
  String idTopping, namaTopping;
  List<DetailToppingMartabakModel> listTopping;

  ToppingMartabakModel({
    this.idTopping,
    this.namaTopping,
    this.listTopping,
  });
}

class DetailToppingMartabakModel {
  String idTopping, namaTopping, idDetailTopping, nomorTopping;
  bool isSelected;
  double hargaTopping;

  DetailToppingMartabakModel({
    this.hargaTopping,
    this.idTopping,
    this.isSelected,
    this.namaTopping,
    this.idDetailTopping,
    this.nomorTopping,
  });
}
