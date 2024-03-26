import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:toserba/controller/api%20controller/user_account_api_controller.dart';
import 'package:toserba/models/user_account_model.dart';
import 'package:toserba/widget/d/detail_order_appbar_widget.dart';
import 'package:toserba/widget/order_summary_widget.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key, this.userAccountModel});

  final UserAccountModel? userAccountModel;

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> with TickerProviderStateMixin {
  final _userController = UserAccountApiController();
  final _flutterSecureStorage = const FlutterSecureStorage();
  late UserAccountModel userAccountModel = UserAccountModel(
      userAccountId: 0,
      email: '',
      password: '',
      username: '',
      createdAt: DateTime(0),
      updateAt: DateTime(0),
      userAddressEntity: [],
      pembelianModel: []);
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late AnimationController _expandedAnimationController;
  late Animation<double> _expandedAnimation;

  @override
  void initState() {
    super.initState();

    _loadItem();
    _isLoading = false;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.white));

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();

    _expandedAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
          milliseconds: 400), // Change this duration to your desired value
    );

    _expandedAnimation = CurvedAnimation(
      parent: _expandedAnimationController,
      curve: const Interval(
        0.0, 1.0, // Kurva animasi mulai setelah delay
        curve: Curves.easeInOut,
      ),
    );
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      _expandedAnimationController.forward();
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _loadItem() async {
    setState(() {
      _isLoading = true;
    });
    var id = await _flutterSecureStorage.read(key: 'user-account-id');

    userAccountModel = await _userController.loadUserData(int.parse(id!));

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: Get.width * 0.1,
          ),
          AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Opacity(
                opacity: _animation.value,
                child:
                    SizedBox(child: DetailAppbarWidget(user: userAccountModel)),
              );
            },
          ),
          _isLoading == true
              ? Container(
                  margin: EdgeInsets.only(top: Get.width * 0.1),
                  child: CircularProgressIndicator())
              : Expanded(
                  child: AnimatedBuilder(
                    animation: _expandedAnimationController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _expandedAnimation.value,
                        child: Column(
                          children: [
                            Expanded(
                              child: OrderSummaryWidget(
                                  userAccountModel: userAccountModel),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
