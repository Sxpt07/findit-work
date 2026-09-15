import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:findit_worker/features/auth/screens/login_screen.dart';
import 'package:findit_worker/features/worker/screens/quick_report_form_screen.dart';
import 'package:findit_worker/main.dart';

Future<void> _login(WidgetTester tester) async {
  // LoginScreen: ID sudah terisi (HK-84920), isi PIN lalu masuk.
  await tester.enterText(find.byType(TextField).at(1), '84920');
  await tester.tap(find.text('Masuk ➔'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Worker app opens on login screen first', (WidgetTester tester) async {
    await tester.pumpWidget(const WorkerApp());

    expect(find.text('Login Petugas'), findsOneWidget);
    expect(find.text('Masuk ➔'), findsOneWidget);
    expect(find.text('+ Catat Barang Temuan'), findsNothing);
  });

  testWidgets('Lupa PIN opens reset info dialog and closes', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Lupa PIN?'));
    await tester.pumpAndSettle();

    expect(find.text('Lupa PIN / Password?'), findsOneWidget);
    expect(find.text('Cara Reset'), findsOneWidget);
    expect(find.text('Tutup & Mengerti'), findsOneWidget);

    await tester.tap(find.text('Tutup & Mengerti'));
    await tester.pumpAndSettle();

    expect(find.text('Lupa PIN / Password?'), findsNothing);
  });

  testWidgets('Quick capture flow: login -> dashboard -> form -> success -> home', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    // Mock image_picker supaya pemilihan foto berjalan deterministik di test
    // (tidak ada foto yang dipilih -> upload box tetap kosong).
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/image_picker'),
      (call) async => null,
    );

    await tester.pumpWidget(const WorkerApp());
    await tester.pumpAndSettle();

    // 0) Login dulu -> Worker Dashboard
    expect(find.text('Login Petugas'), findsOneWidget);
    await _login(tester);

    // 1) Dashboard -> Quick Capture (langsung ke Form Pencatatan Lengkap)
    expect(find.text('Selamat Bertugas, Siti!'), findsOneWidget);
    expect(find.text('+ Catat Barang Temuan'), findsOneWidget);
    await tester.tap(find.text('+ Catat Barang Temuan'));
    await tester.pumpAndSettle();

    // 2) Form Pencatatan Lengkap terlihat + isi field
    expect(find.text('Nama Barang'), findsOneWidget);
    expect(find.text('Warna Barang'), findsOneWidget);
    expect(find.text('Kategori Barang'), findsOneWidget);
    expect(find.text('Nomor Kamar'), findsOneWidget);
    expect(find.text('Waktu (Tanggal & Jam)'), findsOneWidget);
    expect(find.text('Deskripsi / Catatan Tambahan'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), 'Jam Tangan Pintar');
    await tester.enterText(find.byType(TextField).at(1), 'Hitam');
    await tester.enterText(find.byType(TextField).at(2), '314');
    await tester.enterText(find.byType(TextField).at(3), 'Ditemukan di atas meja nakas sebelah kanan tempat tidur');

    // 3) Submit -> Success Screen
    final submit = find.textContaining('Simpan & Laporkan Temuan');
    final formScrollable = find
        .descendant(
          of: find.byType(QuickReportFormScreen),
          matching: find.byType(Scrollable),
        )
        .first;
    await tester.scrollUntilVisible(submit, 300, scrollable: formScrollable);
    await tester.tap(submit);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Barang Berhasil Tersimpan!'), findsOneWidget);
    expect(find.text('NO. REGISTRASI / TIKET'), findsOneWidget);

    // 4) Kembali ke Beranda Sekarang -> Worker Dashboard
    await tester.tap(find.text('Kembali ke Beranda Sekarang'));
    await tester.pumpAndSettle();

    expect(find.text('Selamat Bertugas, Siti!'), findsOneWidget);
    expect(find.text('+ Catat Barang Temuan'), findsOneWidget);
  });
}