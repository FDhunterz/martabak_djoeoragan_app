class Cabang {
  String id, nama;

  bool operator ==(Object other) => other is Cabang && other.id == id;

  int get hashCode => id.hashCode;

  Cabang({
    this.id,
    this.nama,
  });
}

class Outlet {
  String id, nama, idCabang;

  bool operator ==(Object other) => other is Outlet && other.id == id;

  int get hashCode => id.hashCode;

  Outlet({
    this.nama,
    this.id,
    this.idCabang,
  });
}
