import 'dart:io';

class BarangModels {
  const BarangModels(
      {required this.idBarang,
      required this.namaBarang,
      required this.kodeBarang,
      required this.hargaBarang,
      required this.stokBarang,
      required this.imageBarang});
  final int idBarang;
  final String namaBarang;
  final String kodeBarang;
  final int hargaBarang;
  final int stokBarang;
  final File imageBarang;
}
