import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:martabakdjoeragan_app/pages/penjualan/pointofsale_topping.dart';
import 'package:martabakdjoeragan_app/utils/martabakModel.dart';

class KasirBloc with ChangeNotifier {
  List<MartabakModel> _cart = List<MartabakModel>();
  List<KuponBelanja> _kupon = List<KuponBelanja>();
  List<HargaPenjualan> _listHarga = List<HargaPenjualan>();
  List<MartabakModel> _list = List<MartabakModel>();
  List<KategoriItem> _kategori = List<KategoriItem>();
  KategoriItem _selectedKategori;
  HargaPenjualan _selectedHargaPenjualan;
  Customer _selectedCustomer;
  double _total = 0;
  double _ppn = 0;
  double _settingPpn = 0;
  String _encodedRequest;

  TextEditingController _jumlahBayarController = TextEditingController(
    text: 0.toString(),
  );
  double kembalian = 0;
  TextEditingController _catatanController = TextEditingController();

  TextEditingController get jumlahBayarController => _jumlahBayarController;

  /// get list kategori item
  UnmodifiableListView<KategoriItem> get listKategori =>
      UnmodifiableListView(_kategori);

  KategoriItem get getSelectedKategoriItem => _selectedKategori;

  /// get list barang yg ditambahkan ke keranjang
  UnmodifiableListView<MartabakModel> get cart => UnmodifiableListView(_cart);

  /// get list kupon
  UnmodifiableListView<KuponBelanja> get kupon => UnmodifiableListView(_kupon);

  /// get list item
  UnmodifiableListView<MartabakModel> get listItem =>
      UnmodifiableListView(_list);

  /// get customer yang dipilih
  Customer get selectedCustomer => _selectedCustomer;

  /// get harga penjualan yang dipilih
  HargaPenjualan get selectedHargaPenjualan => _selectedHargaPenjualan;

  /// get listHarga
  UnmodifiableListView<HargaPenjualan> get listHarga =>
      UnmodifiableListView(_listHarga);

  /// get catatanController
  TextEditingController get catatanController => _catatanController;

  /// total kuantitas keranjang
  int get totalQtyKeranjang {
    int total = 0;

    for (var data in _cart) {
      total += data.qty;
    }

    return total;
  }

  /// get total harga asli (belum ditambah ppn dan dikurangi diskon)
  double get totalHarga {
    double totalX = 0;

    for (int i = 0; i < _cart.length; i++) {
      double harga = 0;
      double listHargaVarian = 0;
      double listHargaTopping = 0;
      if (_cart[i].listVarian.length != 0 && _cart[i].listTopping.length != 0) {
        for (var data in _cart[i].listVarian) {
          if (data.isSelected) {
            listHargaVarian += data.hargaVarian;
          }
        }

        for (var dataT in _cart[i].listTopping) {
          for (var dataTD in dataT.listTopping) {
            if (dataTD.isSelected) {
              listHargaTopping += dataTD.hargaTopping;
            }
          }
        }
      } else if (_cart[i].listTopping.length != 0) {
        for (var dataT in _cart[i].listTopping) {
          for (var dataTD in dataT.listTopping) {
            if (dataTD.isSelected) {
              listHargaTopping += dataTD.hargaTopping;
            }
          }
        }
        harga = _cart[i].diskon != null
            ? double.parse(_cart[i].sysprice) - double.parse(_cart[i].diskon)
            : double.parse(_cart[i].sysprice);
      } else {
        harga = _cart[i].diskon != null
            ? double.parse(_cart[i].sysprice) - double.parse(_cart[i].diskon)
            : double.parse(_cart[i].sysprice);
      }
      totalX += (harga + listHargaTopping + listHargaVarian) * _cart[i].qty;
    }
    _total = totalX;

    return totalX;
  }

  /// get diskon
  double get totalDiskon {
    double totalDiskon = 0;
    List<KuponBelanja> _kuponX = this._kupon;

    for (int i = 0; i < _kuponX.length; i++) {
      if (_kuponX[i].selected == '1') {
        int persen = _kuponX[i].dPersen == 'null' || _kuponX[i].dPersen == null
            ? 0
            : int.parse(_kuponX[i].dPersen);
        double nilai =
            _kuponX[i].nominal == 'null' || _kuponX[i].nominal == null
                ? 0
                : double.parse(_kuponX[i].nominal);

        if (_kuponX[i].dPersen != 'null') {
          double cek = _total * (persen / 100);

          if (cek > double.parse(_kuponX[i].dMaxDiskon)) {
            totalDiskon += double.parse(_kuponX[i].dMaxDiskon);
          } else {
            totalDiskon += cek;
          }
        } else {
          totalDiskon += nilai;
        }
      }
    }
    double diskonItem = 0;
    for (var data in _cart) {
      diskonItem +=
          double.parse(data.diskon != null ? data.diskon : '0') * data.qty;
    }
    return totalDiskon + diskonItem;
  }

  /// get setting ppn
  double get getSettingPpn {
    return _settingPpn;
  }

  /// men set variabel settingPpn
  void settingPPN(double persenPpn) {
    _settingPpn = persenPpn;

    notifyListeners();
  }

  /// get ppn
  double get ppn {
    _ppn = _total * (_settingPpn / 100);

    return _ppn;
  }

  /// get total harga penjualan beserta diskon dan ppn
  double get totalHargaPenjualan {
    double totalPenjualan = 0;
    List<KuponBelanja> _kuponX = this._kupon;
    double totalDiskon = 0;

    for (int i = 0; i < _kuponX.length; i++) {
      if (_kuponX[i].selected == '1') {
        int persen = _kuponX[i].dPersen == 'null' || _kuponX[i].dPersen == null
            ? 0
            : int.parse(_kuponX[i].dPersen);
        double nilai =
            _kuponX[i].nominal == 'null' || _kuponX[i].nominal == null
                ? 0
                : double.parse(_kuponX[i].nominal);

        if (_kuponX[i].dPersen != 'null') {
          double cek = _total * (persen / 100);

          if (cek > double.parse(_kuponX[i].dMaxDiskon)) {
            totalDiskon += double.parse(_kuponX[i].dMaxDiskon);
          } else {
            totalDiskon += cek;
          }
        } else {
          totalDiskon += nilai;
        }
      }
    }

    totalPenjualan = (_total * (_settingPpn / 100)) + _total - totalDiskon;

    return totalPenjualan;
  }

  void setEncodedRequest(String encoded) {
    _encodedRequest = encoded;
    notifyListeners();
  }

  void resetItemSetelahGantiGroupHarga({
    @required Function onStart,
    @required Function onFinish,
    @required Function(String) onError,
  }) {
    onStart();
    try {
      var responseJson = jsonDecode(_encodedRequest);

      clearListItem();

      for (var data in responseJson['item']) {
        var diskonX;
        var priceX;

        if (this.selectedHargaPenjualan != null) {
          if (this.selectedHargaPenjualan.id == '99999') {
            diskonX = data['diskon'] != null
                ? data['diskon']['diskon'].toString()
                : null;
            priceX = data['i_harga_jual'].toString();
          } else {
            diskonX = null;

            priceX = data['i_harga_jual'].toString();

            for (var dataS in data['harga_jual']) {
              if (data['i_id'].toString() == dataS['ghdt_item'].toString()) {
                priceX = dataS['ghdt_harga'].toString();
              }
            }
          }
        } else {
          diskonX = data['diskon'] != null
              ? data['diskon']['diskon'].toString()
              : null;

          priceX = data['i_harga_jual'].toString();
        }

        List<ToppingMartabakModel> _listY = List<ToppingMartabakModel>();
        List<MartabakVarianModel> _listZ = List<MartabakVarianModel>();
        for (var dataY in data['modifier']) {
          List<DetailToppingMartabakModel> _listAA = List();
          for (var dataYD in dataY['modifier']['detail']) {
            _listAA.add(
              DetailToppingMartabakModel(
                idTopping: dataYD['mddt_modifier'].toString(),
                hargaTopping: double.parse(dataYD['mddt_harga'].toString()),
                idDetailTopping: dataYD['mddt_id'].toString(),
                isSelected: false,
                namaTopping: dataYD['mddt_nama'],
                nomorTopping: dataYD['mddt_nomor'].toString(),
              ),
            );
          }
          _listY.add(
            ToppingMartabakModel(
              idTopping: dataY['modifier']['m_id'].toString(),
              namaTopping: dataY['modifier']['m_nama'],
              listTopping: _listAA,
            ),
          );
        }

        for (var dataZ in data['varian']) {
          _listZ.add(
            MartabakVarianModel(
              idVarian: dataZ['iv_id'].toString(),
              hargaVarian: double.parse(dataZ['iv_harga'].toString()),
              isSelected: false,
              namaVarian: dataZ['iv_nama'],
            ),
          );
        }

        _list.add(
          MartabakModel(
            id: int.parse(data['i_id'].toString()),
            name: data['i_nama'],
            img: data['i_gambar1'],
            price: priceX,
            sysprice: priceX,
            desc: data['i_kode'],
            idKategoriItem: data['i_kategori'].toString(),
            qty: 1,
            details: data['i_kode'],
            diskon: diskonX,
            listTopping: _listY,
            listVarian: _listZ,
          ),
        );
      }

      Future.delayed(const Duration(milliseconds: 500), () {
        // Here you can write your code

        onFinish();
      });
    } catch (e) {
      onError(e.toString());
    }
    notifyListeners();
  }

  List<MartabakModel> cariItem(String text) {
    List<MartabakModel> _listD = List<MartabakModel>();
    List<MartabakModel> _listF = List<MartabakModel>();

    if (_selectedKategori != null) {
      if (_selectedKategori.id == 'all') {
        _listD = List.from(_list);
        // print('if 1');
      } else {
        // print('else 1');
        for (var data in _list) {
          print(data.idKategoriItem);
          print(_selectedKategori.id);
          if (data.idKategoriItem == _selectedKategori.id) {
            _listD.add(data);
          }
        }
      }
    } else {
      _listD = List.from(_list);
      // print('else 2');
    }

    for (var dataF in _listD) {
      if (dataF.name.toLowerCase().contains(text.toLowerCase())) {
        _listF.add(dataF);
      }
    }

    return (_listF);
  }

  /// set kategori item yang dipilih
  void setSelectedKategori(KategoriItem kategori) {
    _selectedKategori = kategori;
    notifyListeners();
  }

  /// clear List Kategori Item
  void clearListKategori() {
    _kategori.clear();
    notifyListeners();
  }

  /// add Kategori Item
  void addKategori(KategoriItem kategori) {
    _kategori.add(kategori);
    notifyListeners();
  }

  /// clear List Item Kasir
  void clearListItem() {
    _list.clear();
    notifyListeners();
  }

  /// add List Item Kasir
  void addItem(MartabakModel martabak) {
    _list.add(martabak);
    notifyListeners();
  }

  void addKupon({
    KuponBelanja kupon,
  }) {
    _kupon.add(kupon);
    notifyListeners();
  }

  void clearKupon() {
    _kupon = List<KuponBelanja>();
    notifyListeners();
  }

  List<KuponBelanja> cariKupon(String cari) {
    List<KuponBelanja> ax = this.kupon;
    List<KuponBelanja> filter = List();
    for (var data in ax) {
      if (data.nama.toLowerCase().contains(cari.toLowerCase()) ||
          data.catatan.toLowerCase().contains(cari.toLowerCase()) ||
          data.dPersen.toLowerCase().contains(cari.toLowerCase()) ||
          data.nominal.toLowerCase().contains(cari.toLowerCase())) {
        filter.add(data);
      }
    }
    return filter;
  }

  /// add HargaPenjualan
  void addHargaPenjualan(HargaPenjualan hargaX) {
    _listHarga.add(hargaX);
    notifyListeners();
  }

  /// clear harga penjualan
  void clearHargaPenjualan() {
    _listHarga = List<HargaPenjualan>();
    notifyListeners();
  }

  void unsetSelectedHargaPenjualan() {
    this._selectedHargaPenjualan = null;
    notifyListeners();
  }

  /// set harga penjualan yang dipilih
  void setHargaPenjualan({
    @required HargaPenjualan hargaX,
    @required BuildContext context,
  }) {
    if (this.cart.length != 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Peringatan!'),
          content: Text(
              'Item yang ada dikeranjang akan dihapus! \n\nApa anda yakin ingin mengganti Kelompok Harga?'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                this.clearCart();
                this.setHargaPenjualan(
                  hargaX: hargaX,
                  context: context,
                );
              },
              child: Text('Ya'),
            ),
            FlatButton(
              color: Colors.orange,
              textColor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Tidak'),
            ),
          ],
        ),
      );
    } else {
      for (var data in this.listHarga) {
        if (data.id == hargaX.id) {
          data.selected = '1';
          _selectedHargaPenjualan = data;
        } else {
          data.selected = '0';
        }
      }
    }
    notifyListeners();
  }

  List<HargaPenjualan> cariHargaPenjualan(String cari) {
    List<HargaPenjualan> ax = this.listHarga;
    List<HargaPenjualan> filter = List();
    for (HargaPenjualan data in ax) {
      if (data.nama.toLowerCase().contains(cari.toLowerCase())) {
        filter.add(data);
      }
    }
    return filter;
  }

  /// cek apakah totalPenjualan melebihi Minimal Pembelian Kupon.
  void isKuponPass() {
    for (var data in _kupon) {
      if (double.parse(data.kategoriHarga) <= this.totalHargaPenjualan) {
        data.disabled = '0';
      } else {
        data.disabled = '1';
        data.selected = '0';
      }
    }
    notifyListeners();
  }

  /// update kupon yang dipilih
  /// dan mengecek kupon bisa double atau tidak
  void updateKupon(KuponBelanja kuponX) {
    for (var data in _kupon) {
      if (data.id == kuponX.id) {
        if (data.selected == '1') {
          data.selected = '0';
        } else {
          data.selected = '1';
        }
      } else if (data.dIsDouble == '0' &&
          data.id != kuponX.id &&
          data.selected == '1') {
        data.selected = '0';
      } else if (data.dIsDouble == '1' && kuponX.dIsDouble == '0') {
        data.selected = '0';
      }
    }
    notifyListeners();
  }

  /// menyimpan variabel customer yang dipilih
  void setCustomer(Customer customerX) {
    _selectedCustomer = customerX;
    notifyListeners();
  }

  /// menghapus customer yang dipilih
  void unsetCustomer() {
    _selectedCustomer = null;
    notifyListeners();
  }

  bool _bandingToppingKeranjangDenganToppingItemDipilih(
    MartabakModel model,
    int i,
  ) {
    List<bool> _listA = List<bool>();
    List<bool> _listB = List<bool>();

    for (int j = 0; j < _cart[i].listTopping.length; j++) {
      var dataK = _cart[i].listTopping[j];
      var dataKX = model.listTopping[j];
      for (int k = 0; k < dataK.listTopping.length; k++) {
        var dataKD = dataK.listTopping[k];
        var dataKDX = dataKX.listTopping[k];

        _listA.add(dataKD.isSelected);
        _listB.add(dataKDX.isSelected);
      }
    }

    print(_listA);
    print(_listB);
    if (IterableEquality().equals(_listA, _listB)) {
      return true;
    }

    return false;
  }

  void addToCart(MartabakModel model) {
    bool isTidakAda = true;
    for (int i = 0; i < _cart.length; i++) {
      if (model.listVarian.length != 0 &&
          model.listTopping.length != 0 &&
          _cart[i].id == model.id &&
          IterableEquality().equals(
              _cart[i].listVarian.map((e) => e.isSelected).toList(),
              model.listVarian.map((e) => e.isSelected).toList()) &&
          _bandingToppingKeranjangDenganToppingItemDipilih(model, i)) {
        _cart[i].qty += model.qty;
        isTidakAda = false;
        this.totalHarga;
        this.totalHargaPenjualan;
        this.ppn;
        this.isKuponPass();
        notifyListeners();

        print('true 1');
        break;
      } else if (model.listVarian.length != 0 &&
          _cart[i].id == model.id &&
          IterableEquality().equals(
              _cart[i].listVarian.map((e) => e.isSelected).toList(),
              model.listVarian.map((e) => e.isSelected).toList())) {
        _cart[i].qty += model.qty;
        isTidakAda = false;
        this.totalHarga;
        this.totalHargaPenjualan;
        this.ppn;
        this.isKuponPass();
        notifyListeners();
        print('true 2');
        break;
      } else if (model.listTopping.length != 0 &&
          _cart[i].id == model.id &&
          _bandingToppingKeranjangDenganToppingItemDipilih(model, i)) {
        _cart[i].qty += model.qty;
        isTidakAda = false;
        this.totalHarga;
        this.totalHargaPenjualan;
        this.ppn;
        this.isKuponPass();
        notifyListeners();
        print('true 3');
        break;
      } else if (_cart[i].id == model.id) {
        print('else 4');
        _cart[i].qty += 1;
        isTidakAda = false;
        this.totalHarga;
        this.totalHargaPenjualan;
        this.ppn;
        this.isKuponPass();
        notifyListeners();
        break;
      }
    }

    if (this.selectedHargaPenjualan != null) {
      if (isTidakAda) {
        print('tidak ada');
        _cart.add(model);
        this.totalHarga;
        this.totalHargaPenjualan;
        this.ppn;
        this.isKuponPass();
        notifyListeners();
      }
    } else {
      Fluttertoast.showToast(msg: 'Pilih Group Harga terlebih dahulu');
    }
  }

  void editCart(MartabakModel model, int i) {
    // bool isTidakAda = true;
    if (model.listVarian.length != 0 && model.listTopping.length != 0) {
      if (_cart[i].id == model.id &&
          _cart[i]
              .listTopping
              .any((modelX) => model.listTopping.contains(modelX)) &&
          _cart[i]
              .listVarian
              .any((element) => model.listVarian.contains(element))) {
        _cart[i].qty = model.qty;
        // isTidakAda = false;
        this.totalHarga;
        this.totalHargaPenjualan;
        this.ppn;
        this.isKuponPass();
        notifyListeners();
      }
    } else if (model.listVarian.length != 0) {
      if (_cart[i].id == model.id &&
          _cart[i]
              .listVarian
              .any((element) => model.listVarian.contains(element))) {
        _cart[i].qty = model.qty;
        // isTidakAda = false;
        this.totalHarga;
        this.totalHargaPenjualan;
        this.ppn;
        this.isKuponPass();
        notifyListeners();
      }
    } else if (model.listTopping.length != 0) {
      if (_cart[i].id == model.id &&
          _cart[i]
              .listTopping
              .any((modelX) => model.listTopping.contains(modelX))) {
        _cart[i].qty = model.qty;
        // isTidakAda = false;
        this.totalHarga;
        this.totalHargaPenjualan;
        this.ppn;
        this.isKuponPass();
        notifyListeners();
      }
    } else {
      if (_cart[i].id == model.id) {
        _cart[i].qty = model.qty;
        // isTidakAda = false;
        this.totalHarga;
        this.totalHargaPenjualan;
        this.ppn;
        this.isKuponPass();
        notifyListeners();
      }
    }

    // if (this.selectedHargaPenjualan != null) {
    //   if (isTidakAda) {
    //     _cart.add(model);
    //     this.totalHarga;
    //     this.totalHargaPenjualan;
    //     this.ppn;
    //     this.isKuponPass();
    //     notifyListeners();
    //   }
    // } else {
    //   Fluttertoast.showToast(msg: 'Pilih Group Harga terlebih dahulu');
    // }
  }

  void deleteCart(int index) {
    _cart.removeAt(index);
    notifyListeners();
  }

  void increaseQtyCartItemByIndex(int i) {
    _cart[i].qty += 1;
    this.totalHarga;
    this.totalHargaPenjualan;
    this.ppn;
    this.isKuponPass();
    notifyListeners();
  }

  void reduceQty(MartabakModel model) {
    for (int i = 0; i < _cart.length; i++) {
      if (_cart[i].id == model.id) {
        if (_cart[i].qty == 1) {
          _cart.removeAt(i);
        } else {
          _cart[i].qty -= 1;
        }
        break;
      }
    }
    this.totalHarga;
    this.totalHargaPenjualan;
    this.ppn;
    this.isKuponPass();
    notifyListeners();
  }

  void reduceQtyByIndex(int i) {
    if (_cart[i].qty == 1) {
      _cart.removeAt(i);
    } else {
      _cart[i].qty -= 1;
    }

    this.totalHarga;
    this.totalHargaPenjualan;
    this.ppn;
    this.isKuponPass();
    notifyListeners();
  }

  void clearCart() {
    this.totalHarga;
    this.totalHargaPenjualan;
    this.ppn;
    this.isKuponPass();
    _cart.clear();
    notifyListeners();
  }
}
