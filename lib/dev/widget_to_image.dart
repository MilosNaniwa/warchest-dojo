import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_save/image_save.dart';
import 'package:warchest_dojo/const/unit_class_const.dart';
import 'package:warchest_dojo/widget/unit_coin.dart';

class WidgetToImagePage extends StatefulWidget {
  const WidgetToImagePage({Key? key}) : super(key: key);

  @override
  WidgetToImagePageState createState() => WidgetToImagePageState();
}

class WidgetToImagePageState extends State<WidgetToImagePage> {
  final GlobalKey _globalKey = GlobalKey(); // 1. GlobalKey生成

  late String _unitClass;

  @override
  void initState() {
    super.initState();
    _unitClass = UnitClassConst.cavalry;
  }

  // 4. ボタンが押された際の処理
  Future<void> _exportToImage({
    required String fileName,
  }) async {
    // 現在描画されているWidgetを取得する
    RenderRepaintBoundary? boundary =
        _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

    if (boundary.debugNeedsPaint) {
      print("Waiting for boundary to be painted.");
      await Future.delayed(const Duration(milliseconds: 20));
      return _exportToImage(
        fileName: fileName,
      );
    }

    // 取得したWidgetからイメージファイルをキャプチャする
    ui.Image image = await boundary.toImage(
      pixelRatio: 3.0,
    );

    // 以下はお好みで
    // PNG形式化
    ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    // バイトデータ化
    final imageData = byteData!.buffer.asUint8List();

    await ImageSave.saveImage(imageData, "$fileName.png");

    print("ok");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("sample"),
      ),
      body: InteractiveViewer(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () async {
                    final list = [
                      UnitClassConst.sword,
                      UnitClassConst.scout,
                      UnitClassConst.pike,
                      UnitClassConst.crossbow,
                      UnitClassConst.knight,
                      UnitClassConst.cavalry,
                      UnitClassConst.lightCavalry,
                      UnitClassConst.warriorPriest,
                      UnitClassConst.royalGuard,
                      UnitClassConst.lancer,
                      UnitClassConst.marshall,
                      UnitClassConst.ensign,
                      UnitClassConst.footman,
                      UnitClassConst.berserker,
                      UnitClassConst.archer,
                      UnitClassConst.mercenary,
                      UnitClassConst.blueRoyal,
                      UnitClassConst.redRoyal,
                    ];

                    for (final unitClass in list) {
                      await _exportToImage(
                        fileName: unitClass,
                      );

                      setState(() {
                        _unitClass = unitClass;
                      });

                      await Future.delayed(const Duration(seconds: 1));
                    }
                  },
                  child: const Icon(
                    Icons.image,
                  ),
                ),
                RepaintBoundary(
                  key: _globalKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UnitCoinContainer(
                      unitClass: _unitClass,
                      size: 256,
                      shouldHide: false,
                      isSelected: false,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
