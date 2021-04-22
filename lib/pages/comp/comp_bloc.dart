import 'package:flutter/cupertino.dart';
import 'package:martabakdjoeragan_app/pages/comp/comp_model.dart';

class CompBloc with ChangeNotifier {
  Cabang _cabang;
  Outlet _outlet;
  List<Cabang> _listCabang = [];
  List<Outlet> _listOutlet = [];

  Cabang get selectedCabang => _cabang;

  Outlet get selectedOutlet => _outlet;

  List<Cabang> get listCabang => _listCabang;

  List<Outlet> listOutlet({Cabang filterByCabang}) {
    if (filterByCabang != null) {
      List<Outlet> a = [];
      for (Outlet o in this._listOutlet) {
        if (o.idCabang == filterByCabang.id) {
          a.add(o);
        }
      }
    }

    return _listOutlet;
  }

  void setSelectedCabang(Cabang cabangX) {
    _cabang = cabangX;
    _outlet = null;
    notifyListeners();
  }

  void setSelectedOutlet(Outlet outletX) {
    _outlet = outletX;
    notifyListeners();
  }

  void addCabang(Cabang cabangX) {
    _listCabang.add(cabangX);
    notifyListeners();
  }

  void addOutlet(Outlet outletX) {
    _listOutlet.add(outletX);
    notifyListeners();
  }

  void clearListCabang() {
    _listCabang.clear();
    notifyListeners();
  }

  void clearListOutlet() {
    _listOutlet.clear();
    notifyListeners();
  }

  List<Cabang> cariCabang(String text) {
    List<Cabang> a = [];
    List<Cabang> b = this.listCabang;

    for (Cabang data in b) {
      if (data.nama.toLowerCase().contains(text.toLowerCase())) {
        a.add(data);
      }
    }
    return a;
  }

  List<Outlet> cariOutlet(String text, {Cabang filterByCabang}) {
    List<Outlet> a = [];
    List<Outlet> b = listOutlet();

    for (Outlet data in b) {
      if (filterByCabang != null) {
        if (data.nama.toLowerCase().contains(text.toLowerCase()) &&
            filterByCabang.id == data.idCabang) {
          a.add(data);
        }
      } else {
        if (data.nama.toLowerCase().contains(text.toLowerCase())) {
          a.add(data);
        }
      }
    }
    // notifyListeners();
    return a;
  }
}
