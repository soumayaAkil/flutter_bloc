import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../core/constants/my_colors.dart';
import '../../../main.dart';
import '../../../router.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'package:path_provider/path_provider.dart';
class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State {
  String? localFilePath;
  @override
  void initState() {
    super.initState();
    _downloadAndSavePdf('https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf');
  }
  Future<void> _downloadAndSavePdf(String url) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/downloaded.pdf');
      if (!file.existsSync()) {
        final response = await Dio().get(url, options: Options(responseType: ResponseType.bytes));
        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        await raf.close();
      }
      setState(() {
        localFilePath = file.path;
      });
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController(text: '7733');
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),

        ),
        backgroundColor: MyColors.colorPrimary,
        centerTitle: true,
        title: Column(children: [
          Text(
            'Test',
            style: TextStyle(color: MyColors.white),
          ),
        ]),
      ),
        body:localFilePath != null
            ? PDFView(
          filePath: localFilePath!,
          onViewCreated: (PDFViewController pdfViewController) {
            print('PDF view created');
          },
          onRender: (_pages) {
            print('PDF rendered with $_pages pages');
          },
          onError: (error) {
            print('PDF Error displaying PDF: $error');
          },
          onPageError: (page, error) {
            print('PDF Error displaying page $page: $error');
          },
        )
            : Center(child: CircularProgressIndicator()),

    );
  }



}

