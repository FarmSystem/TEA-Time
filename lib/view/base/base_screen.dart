
import 'package:flutter/material.dart';
import 'package:get/get.dart';

@immutable
abstract class BaseScreen<T extends GetxController> extends GetView<T> {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {

    if (!viewModel.initialized) {
      initViewModel();
    }

    return Container(
      decoration: BoxDecoration(
        color: unSafeAreaColor,
        image: backgroundImagePath != null
          ? DecorationImage(
          image: AssetImage(backgroundImagePath!),
          fit: BoxFit.cover,
        ) : null,
      ),
      child: wrapWithOuterSafeArea
        ? SafeArea(
        top: setTopOuterSafeArea,
        bottom: setBottomOuterSafeArea,
        child: _buildScaffold(context),
      ) : _buildScaffold(context),
    );
  }

  /// Scaffold는 기본적인 Material 디자인 레이아웃을 구성하는 위젯
  /// Default는 appBar, body, bottomNavigationBar
  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: safeAreaColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: buildAppBar(context),
      body: wrapWithInnerSafeArea
        ? SafeArea(
        bottom: false,
        child: buildBody(context),
      ) : buildBody(context),
    );
  }

  /// 뷰 모델 초기화
  @protected
  void initViewModel() {
    viewModel.initialized;
  }

  @protected
  void disposeViewModel() {
    viewModel.dispose();
  }

  /// 뷰 모델
  @protected
  T get viewModel => controller;

  /// unSafeArea의 색상 (default: Colors.transparent)
  @protected
  Color? get unSafeAreaColor => Colors.transparent;

  /// SafeArea의 색상 (default: Colors.transparent)
  @protected
  Color? get safeAreaColor => Colors.transparent;

  /// 배경화면 이미지 경로
  @protected
  String? get backgroundImagePath => null;

  /// 키보드가 올라왔을 때 화면이 밀리는 것을 방지 (default: true)
  @protected
  bool get resizeToAvoidBottomInset => true;

  /// Scaffold 외부를 SafeArea로 감싸는지 (default: true)
  @protected
  bool get wrapWithOuterSafeArea => true;

  /// Scaffold 내부 body를 SafeArea로 감싸는지 (default: false)
  @protected
  bool get wrapWithInnerSafeArea => false;

  /// Scaffold의 Top extendBody (default: false)
  @protected
  bool get setTopOuterSafeArea => false;

  /// Scaffold의 Bottom extendBody (default: true)
  @protected
  bool get setBottomOuterSafeArea => true;

  /// AppBar
  @protected
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  /// Body
  @protected
  Widget buildBody(BuildContext context);

  /// BottomNavigationBar
  @protected
  Widget? buildBottomNavigationBar(BuildContext context) => null;
}