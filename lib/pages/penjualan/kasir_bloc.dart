import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:martabakdjoeragan_app/utils/martabakModel.dart';

class KasirBloc with ChangeNotifier {
  List<MartabakModel> _cart = <MartabakModel>[];
  List<KuponBelanja> _kupon = List<KuponBelanja>();
  List<HargaPenjualan> _listHarga = List<HargaPenjualan>();
  HargaPenjualan _selectedHargaPenjualan;
  Customer _selectedCustomer;
  double _total = 0;
  double _ppn = 0;

  // get list barang yg ditambahkan ke keranjang
  List<MartabakModel> get cart => _cart;

  // get list kupon
  List<KuponBelanja> get kupon => _kupon;

  // get customer yang dipilih
  Customer get selectedCustomer => _selectedCustomer;

  // get harga penjualan yang dipilih
  HargaPenjualan get selectedHargaPenjualan => _selectedHargaPenjualan;

  // get listHarga
  List<HargaPenjualan> get listHarga => _listHarga;

  // get total harga asli (belum ditambah ppn dan dikurangi diskon)
  double get totalHarga {
    double totalX = 0;

    for (int i = 0; i < _cart.length; i++) {
      double harga = _cart[i].diskon != null
          ? double.parse(_cart[i].sysprice) - double.parse(_cart[i].diskon)
          : double.parse(_cart[i].sysprice);
      totalX += (harga) * _cart[i].qty;
    }
    _total = totalX;

    return totalX;
  }

  // get diskon
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

    return totalDiskon;
  }

  // get ppn
  double get ppn {
    _ppn = _total * 0.1;

    return _ppn;
  }

  // get total harga penjualan beserta diskon dan ppn
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

    totalPenjualan = (_total * 0.1) + _total - totalDiskon;

    return totalPenjualan;
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

  // add HargaPenjualan
  void addHargaPenjualan(HargaPenjualan hargaX) {
    _listHarga.add(hargaX);
    notifyListeners();
  }

  // clear harga penjualan
  void clearHargaPenjualan() {
    _listHarga = List<HargaPenjualan>();
    notifyListeners();
  }

  void unsetSelectedHargaPenjualan() {
    this._selectedHargaPenjualan = null;
    notifyListeners();
  }

  // set harga penjualan yang dipilih
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

  // cek apakah totalPenjualan melebihi Minimal Pembelian Kupon.

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

  // update kupon yang dipilih
  // dan mengecek kupon bisa double atau tidak

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
      }
    }
    notifyListeners();
  }

  void setCustomer(Customer customerX) {
    _selectedCustomer = customerX;
    notifyListeners();
  }

  void unsetCustomer() {
    _selectedCustomer = null;
    notifyListeners();
  }

  void addToCart(MartabakModel model) {
    bool isTidakAda = true;
    for (int i = 0; i < _cart.length; i++) {
      if (_cart[i].id == model.id) {
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

  void clearCart() {
    this.totalHarga;
    this.totalHargaPenjualan;
    this.ppn;
    this.isKuponPass();
    _cart.clear();
    notifyListeners();
  }
}
