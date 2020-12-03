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

  /// decode listTopping dan masukkan ke model [ToppingMartabakModel]
  ///
  /// contoh format encoded [listTopping]:
  /// ```
  /// "modifier": [
  ///     {
  ///         "im_id": 1,
  ///         "im_item": 95,
  ///         "im_modifier": 1,
  ///         "modifier": {
  ///             "m_id": 1,
  ///             "m_nama": "Topping Red Velvet",
  ///             "detail": [
  ///                 {
  ///                     "mddt_id": 21,
  ///                     "mddt_modifier": 1,
  ///                     "mddt_nomor": 1,
  ///                     "mddt_nama": "Green Tea",
  ///                     "mddt_harga": 5000,
  ///                     "mddt_selected": 0
  ///                 },
  ///                 {
  ///                     "mddt_id": 22,
  ///                     "mddt_modifier": 1,
  ///                     "mddt_nomor": 2,
  ///                     "mddt_nama": "Vanilla",
  ///                     "mddt_harga": 5000,
  ///                     "mddt_selected": 0
  ///                 },
  ///                 {
  ///                     "mddt_id": 23,
  ///                     "mddt_modifier": 1,
  ///                     "mddt_nomor": 3,
  ///                     "mddt_nama": "Keju",
  ///                     "mddt_harga": 5000,
  ///                     "mddt_selected": 0
  ///                 }
  ///             ]
  ///         }
  ///     }
  /// ],
  /// ```
  String listTopping;

  /// decode listVarian dan masukkan ke model [MartabakVarianModel]
  ///
  /// contoh encoded [listVarian]:
  /// ```
  /// "varian": [
  ///     {
  ///         "iv_id": 1,
  ///         "iv_item": 95,
  ///         "iv_nama": "Martabak Red Velvet Green Tea",
  ///         "iv_harga": 50000,
  ///         "harga": []
  ///     }
  /// ]
  /// ```
  String listVarian;

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

  /// untuk kondisi ketika customer dibuat dari applikasi mobile
  bool isNew;

  Customer({
    this.isNew = false,
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

  /// untuk [json.encode()] || [jsonEncode()]
  Map toJson() => {
        "iv_id": idVarian,
        "iv_nama": namaVarian,
        "iv_harga": hargaVarian,
        "iv_selected": isSelected,
      };

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

  /// untuk [json.encode()] || [jsonEncode()]

  Map toJson() {
    return {
      "modifier": {
        "m_id": idTopping,
        "m_nama": namaTopping,
        "detail": listTopping,
      },
    };
  }

  ToppingMartabakModel({
    this.idTopping,
    this.namaTopping,
    this.listTopping,
  });
}

class DetailToppingMartabakModel {
  /// [mddt_modifier]
  String idTopping;
  String namaTopping;

  /// [mddt_id]
  String idDetailTopping;
  String nomorTopping;
  bool isSelected;
  double hargaTopping;

  /// untuk [json.encode()] || [jsonEncode()]
  Map toJson() => {
        "mddt_id": idDetailTopping,
        "mddt_modifier": idTopping,
        "mddt_nomor": nomorTopping,
        "mddt_nama": namaTopping,
        "mddt_harga": hargaTopping,
        "mddt_selected": isSelected ? 1 : 0,
      };

  DetailToppingMartabakModel({
    this.hargaTopping,
    this.idTopping,
    this.isSelected,
    this.namaTopping,
    this.idDetailTopping,
    this.nomorTopping,
  });
}
