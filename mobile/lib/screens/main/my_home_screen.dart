import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hk_mobile/app_theme.dart';
import 'package:hk_mobile/controllers/cart_controller.dart';
import 'package:hk_mobile/controllers/product_controller.dart';
import 'package:hk_mobile/screens/cart/cart_screen.dart';
import 'package:hk_mobile/screens/home/components/discount_banner.dart';
import 'package:hk_mobile/screens/main/components/categories_list_view.dart';
import 'package:hk_mobile/screens/main/components/load_more_btn.dart';
import 'package:hk_mobile/screens/main/components/product_list_view_old.dart';
import 'package:hk_mobile/screens/search/search_screen.dart';
import 'package:hk_mobile/ui_view/title_view.dart';
import 'package:hk_mobile/ui_view/circle_icon_btn.dart';
import 'package:hk_mobile/ui_view/hk_logo.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key, this.animationController}) : super(key: key);

  final AnimationController? animationController;
  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());

  Animation<double>? topBarAnimation;
  List<Widget> listViews = <Widget>[];
  double topBarOpacity = 0.0;

  @override
  void initState() {
    topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: widget.animationController!,
      curve: const Interval(0, 0.5, curve: Curves.fastOutSlowIn),
    ));

    addAllListData();

    scrollController.addListener(() {
      if (scrollController.offset >= 24) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 24 && scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 24) {
          setState(() {
            topBarOpacity = scrollController.offset / 24;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 6;

    listViews.add(DiscountBanner());

    listViews.add(
      TitleView(
        titleTxt: 'Danh mục sản phẩm',
        subTxt: 'Xem thêm',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 2, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(
      CategoriesListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 3, 1.0, curve: Curves.fastOutSlowIn))),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    listViews.add(
      TitleView(
        titleTxt: 'Sản phẩm mới nhất',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
            parent: widget.animationController!,
            curve: const Interval((1 / count) * 0, 1.0, curve: Curves.fastOutSlowIn))),
        animationController: widget.animationController!,
      ),
    );

    listViews.add(ProductsListViewOld());

    // listViews.add(
    //   ProductsListView(
    //     mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
    //       parent: widget.animationController!,
    //       curve: const Interval((1 / count) * 1, 1.0, curve: Curves.fastOutSlowIn),
    //     )),
    //     mainScreenAnimationController: widget.animationController!,
    //   ),
    // );

    listViews.add(LoadMoreBtn());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            _buildMainListView(),
            _buildAppBar(),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMainListView() {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.only(
        top: AppBar().preferredSize.height + MediaQuery.of(context).padding.top + 24,
        bottom: 62 + MediaQuery.of(context).padding.bottom,
      ),
      itemCount: listViews.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        widget.animationController?.forward();
        return listViews[index];
      },
    );
  }

  Widget _buildAppBar() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController!,
          builder: (BuildContext context, Widget? child) {
            return FadeTransition(
              opacity: topBarAnimation!,
              child: Transform(
                transform: Matrix4.translationValues(0.0, 30 * (1.0 - topBarAnimation!.value), 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.white.withOpacity(topBarOpacity),
                    borderRadius: const BorderRadius.only(
                        // bottomRight: Radius.circular(32.0),
                        ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.grey.withOpacity(0.4 * topBarOpacity),
                          offset: const Offset(1.1, 1.1),
                          blurRadius: 10.0),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).padding.top,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16 - 8.0 * topBarOpacity,
                          bottom: 12 - 8.0 * topBarOpacity,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Expanded(
                              child: Padding(
                                //padding: EdgeInsets.all(8.0),
                                padding: EdgeInsets.symmetric(vertical: 9, horizontal: 8),
                                child: HKLogo(),
                              ),
                            ),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: CircleIconBtn(
                                iconData: Icons.search,
                                iconColor: AppTheme.grey,
                                onPress: () {
                                  Get.to(() => SearchScreen());
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            SizedBox(
                              height: 38,
                              width: 38,
                              child: Obx(() {
                                return CircleIconBtn(
                                  badgeContent: cartController.list.length.toString(),
                                  customIcon: Padding(
                                    child: Image.asset('assets/icons/ic_cart.png'),
                                    padding: const EdgeInsets.all(6),
                                  ),
                                  onPress: () {
                                    Get.to(() => CartScreen());
                                  },
                                );
                              }),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
