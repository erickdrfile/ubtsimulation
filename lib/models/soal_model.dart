class SoalModel {
  final String idSoal;
  final int paket;
  final int nomor;
  final String tipe;
  final String kategori;
  final String pembuka;
  final String gambar;
  final List<String> pilihan;
  final int jawabanBenar;
  final String penjelasanBenar;
  final Map<String, String> jawabanSalah;
  final String tipsCepat;

  SoalModel({
    required this.idSoal,
    required this.paket,
    required this.nomor,
    required this.tipe,
    required this.kategori,
    required this.pembuka,
    required this.gambar,
    required this.pilihan,
    required this.jawabanBenar,
    required this.penjelasanBenar,
    required this.jawabanSalah,
    required this.tipsCepat,
  });

  factory SoalModel.fromJson(Map<String, dynamic> json) {
    return SoalModel(
      idSoal: json['id_soal'],
      paket: json['paket'],
      nomor: json['nomor'],
      tipe: json['tipe'],
      kategori: json['kategori'],
      pembuka: json['pembuka'],
      gambar: json['gambar'],
      pilihan: List<String>.from(json['pilihan']),
      jawabanBenar: json['jawaban_benar'],
      penjelasanBenar: json['penjelasan_benar'],
      jawabanSalah: Map<String, String>.from(json['jawaban_salah']),
      tipsCepat: json['tips_cepat'],
    );
  }
}
