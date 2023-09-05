import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveCSVToFile(
    List<Map<String, dynamic>> data, context, colstr) async {
  List<List<dynamic>> rows = [];

  // CSV başlıkları
  rows.add(["FullName", "Sicil", "Tarih", "Saat"]);

  // Verileri ekleyin
  for (var item in data) {
    rows.add([item['FullName'], item['Sicil'], item['Tarih'], item['Saat']]);
  }

  try {
    // Uygulamanın dahili depolama dizini
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory!.path}/$colstr.csv';
    final file = File(filePath);
    if (!(await file.parent.exists())) {
      await file.parent.create(recursive: true);
    }
    // CSV dosyasını oluşturun ve verileri yazın
    String csv = const ListToCsvConverter().convert(rows);
    await file.writeAsString(csv);
    await OpenFile.open(filePath);

    // Başarı mesajı
    debugPrint('CSV dosyası kaydedildi: $filePath');

    // Dosya kaydedildikten sonra kullanıcıya geri bildirim verin
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('CSV dosyası dahili depolama alanına kaydedildi.'),
      ),
    );
  } catch (e) {
    debugPrint('Hata oluştu: $e');
    // Hata durumunda kullanıcıya bir hata mesajı gösterebilirsiniz.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('CSV dosyası kaydedilirken bir hata oluştu.'),
      ),
    );
  }
}

void exportDataToCSV(searchResults, context, colstr) {
  List<Map<String, dynamic>> data = [];

  for (var document in searchResults) {
    Map<String, dynamic> itemData = document.data() as Map<String, dynamic>;
    data.add({
      'FullName': itemData['FullName'],
      'Sicil': itemData['Sicil'],
      'Tarih': itemData['Tarih'],
      'Saat': itemData['Saat'],
    });
  }

  saveCSVToFile(data, context, colstr);
}
