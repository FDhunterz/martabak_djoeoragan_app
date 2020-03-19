import 'package:flutter/material.dart';
import 'package:martabakdjoeragan_app/utils/martabakModel.dart';

class CartBloc with ChangeNotifier {
  List<MartabakModel> _cart = <MartabakModel>[];
  double _total = 0;
  double _ppn = 0;
  double _totalPenjualan = 0;

  List<MartabakModel> get cart => _cart;

  double get totalHarga {
    double totalX = 0;
    for (int i = 0; i < _cart.length; i++) {
      totalX += (double.parse(_cart[i].sysprice) * _cart[i].qty);
    }
    _total = totalX;

    return totalX;
  }

  double get ppn {
    _ppn = _total * 0.1;

    return _ppn;
  }

  double get totalHargaPenjualan {
    double totalPenjualan = _ppn + _total;

    return totalPenjualan;
  }

  void addToCart(MartabakModel model) {
    bool isTidakAda = true;
    for (int i = 0; i < _cart.length; i++) {
      if (_cart[i].id == model.id) {
        _cart[i].qty += 1;
        isTidakAda = false;
        notifyListeners();
        break;
      }
    }

    if (isTidakAda) {
      _cart.add(model);
      notifyListeners();
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
    notifyListeners();
  }
}
