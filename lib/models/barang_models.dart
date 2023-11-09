import 'dart:io';

class BarangModels {
    BarangModels(
      {required this.idBarang,
      required this.namaBarang,
      required this.kodeBarang,
      required this.hargaBarang,
      required this.stokBarang,
      this.imageBarang,
      required this.accountId,
      required this.hargaJual, 
      required this.unit});
  final int idBarang;
  final String namaBarang;
  final String kodeBarang;
  final int hargaBarang;
  final int stokBarang;
   File? imageBarang;
  final int accountId;
  final int hargaJual;
  final String unit;
}
