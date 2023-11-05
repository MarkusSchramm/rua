import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'package:rua/src/config/config.dart';

import '../viewmodels/local_user_bloc.dart';
import '../viewmodels/local_user_event.dart';
import '../viewmodels/local_user_state.dart';
import '../widgets/bottom_button.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final String name = qrScannerName;
  bool _isFront = false;
  bool _isActive = false;
  QRViewController? _controller;
  Barcode? result;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    _controller?.pauseCamera();
  }

  @override
  void dispose() {
    _controller?.pauseCamera();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: RuaAppBar(parentName: name),
        drawer: RuaDrawer(parentName: name),
        bottomNavigationBar: _buildBottomBar(context),
        body: Column(
          children: [
            Expanded(
              flex: 10,
              child: _buildQrView(context)
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  result?.code?? 'NO QR CODE',
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ),
          ],
        ),
    );
  }

  _buildBottomBar(BuildContext context) {
    return BlocBuilder<LocalUserBloc, LocalUserState> (
      builder: (context, state) => BottomAppBar(
        child: Row(
          children: [
            BottomButton(
              icon: _isActive ? Icons.pause : Icons.play_arrow,
              toolTip: 'Enable QR',
              onPressed: () =>  _onPlayPressed(context),
            ),
            BottomButton(
              icon: RandomUserAppRoute.home.icon,
              toolTip: RandomUserAppRoute.home.name,
              onPressed: () => _onHomeButtonPressed(context),
            ),
            BottomButton(
              icon: _isFront ? Icons.camera_alt : Icons.camera,
              toolTip: 'Toggle Camera',
              onPressed: () => _onChangeCameraPressed(context),
            ),
          ],
        ),
      ),
    );
  }

  void _onPlayPressed(BuildContext context) async {
    if(_isActive) {
      await _controller?.pauseCamera();
    } else {
      await _controller?.resumeCamera();
    }
    setState(() {
      _isActive = !_isActive;
    });
  }

  void _onHomeButtonPressed(BuildContext context) {
    Navigator.pushReplacementNamed(context, homeRoute);
  }

  void _onChangeCameraPressed(BuildContext context) async {
    await _controller?.flipCamera();
    setState(() {
      _isFront = !_isFront;
    });
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
      controller.scannedDataStream.listen((scanData) {
        setState(() {
          result = scanData;
        });
      });
    });
    //Navigator.pushNamed(context, userDetailsRoute, arguments: user);
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return BlocBuilder<LocalUserBloc, LocalUserState>(
      builder: (context, state) {
        BlocProvider.of<LocalUserBloc>(context).add(const GetSavedUsers());
        if(state.users != null) {
          for(var user in state.users!) {
            if(user.email == result?.code){
              Navigator.pushNamed(context, userDetailsRoute, arguments: user);
            }
          }
        }
        return QRView(
          key: _qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderColor: Colors.red,
              borderRadius: 10,
              borderLength: 30,
              borderWidth: 10,
              cutOutSize: scanArea
          ),
        );
      });
  }
}