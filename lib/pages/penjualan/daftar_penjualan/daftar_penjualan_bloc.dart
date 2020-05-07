import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/pages/penjualan/daftar_penjualan/daftar_penjualan_model.dart';

class DaftarPenjualanBloc with ChangeNotifier {
  List<NotaPenjualan> _listNota = List<NotaPenjualan>();

  // get daftar nota
  List<NotaPenjualan> get getListNota => _listNota;

  // tambah nota ke daftar
  void addNota(NotaPenjualan notaX) {
    _listNota.add(notaX);
    notifyListeners();
  }

  // reset daftar nota
  void clearNota() {
    _listNota = List<NotaPenjualan>();
    notifyListeners();
  }

  // untuk cari nota berdasarkan nota/customer/kasir
  List<NotaPenjualan> listFilteredNota(String text) {
    List<NotaPenjualan> listX = List<NotaPenjualan>();
    List<NotaPenjualan> listY = this.getListNota;

    for (var i in listY) {
      if (i.nota.toLowerCase().contains(text.toLowerCase()) ||
          i.customer.toLowerCase().contains(text.toLowerCase()) ||
          i.kasir.toLowerCase().contains(text.toLowerCase())) {
        listX.add(i);
      }
    }
    return listX;
  }
}
