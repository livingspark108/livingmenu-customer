import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:living_menu_mobile/Cart/cart.dart';
import 'package:living_menu_mobile/ComingSoon/comingSoon.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Constants/appFontSizes.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:living_menu_mobile/Constants/appStrings.dart';
import 'package:living_menu_mobile/Delivery/deliveryTime.dart';
import 'package:living_menu_mobile/Home/mainScreen.dart';
import 'package:living_menu_mobile/Models/homeModel.dart';
import 'package:living_menu_mobile/Notification/notifications.dart';
import 'package:living_menu_mobile/Payment/paymeny.dart';
import 'package:living_menu_mobile/Profile/profile.dart';
import 'package:living_menu_mobile/RestaurantOutlets/selectRestaurantLocation.dart';
import 'package:living_menu_mobile/Search/search.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../Models/productListModel.dart';
import '../Models/productsListModel.dart';
import '../network/apiService.dart';


class  HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  late double w, h;
  int activeIndex = 0;
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  bool _isDescriptionOpen = false;
  int selectedCatIndex = 0;
  int addOnsFirstItemSelectedIndex = 0;
  Map<int, bool> _addOnClickedStatus = {};
  bool isDineIn = false;
  bool _isLoading = false;
  final ApiService apiService = ApiService();
  HomeM homeM = HomeM();
  ProductsCategory productCategory = ProductsCategory();
  Products _products = Products();

  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();
  Map<String, int> productQuantities = {};

  // This method syncs the scroll of two controllers
  void _syncScroll(ScrollController scrolled, ScrollController synced) {
    scrolled.addListener(() {
      if (scrolled.hasClients && synced.hasClients) {
        // Scroll the synced controller the same amount
        synced.jumpTo(scrolled.offset);
      }
    });
  }
  int selectedMonthIndex = 0;


  final List<String> imgList = [
    'assets/images/first_pager_img.jpg',
    'assets/images/banner_two.jpg',
    'assets/images/banner_three.jpg',
    // Add more images here
  ];
  Future<void> getDineIn() async {
    // setState(() {
    //   _isLoading = true; // Show loading indicator
    // });
    final prefs = await SharedPreferences.getInstance();
    isDineIn = prefs.getBool('isDineIn')!;
    print('isDineIn: $isDineIn');
    // _isLoading = false;
    // setState(() {
    //   _isLoading = false;
    // });
  }
  @override
  void initState() {
    super.initState();
    setState(() {
      _isLoading = true;
    });
    _pageController = PageController();
    _startAutoScroll();
    getDineIn();
    // Link horizontal and vertical scrolling
    _syncScroll(_horizontalScrollController, _verticalScrollController);
    _syncScroll(_verticalScrollController, _horizontalScrollController);
    selectedMonthIndex = 0;
    selectedCatIndex = 0;
    print('HOME_INIT_STATE');
    apiService.getHomeDetail(AppStrings.RESTAURANT_ID, '26.975915', '75.769116').then((value) {
      setState(() {
        homeM = value;
        print('HOME---------------: ${value}');
        print('HOME2---------------: ${homeM.restaurantAddress}');

        apiService.getProduct(AppStrings.RESTAURANT_ID).then((value) {
          setState(() {
            productCategory = value;
            productCategory.data?.forEach((category) {
              category.products?.forEach((product) {
                productQuantities[product.id ?? ''] = 0; // Start all products with quantity 0
              });
            });

            print('ProductCat---------------: ${value}');
            print('ProductMessage---------------: ${productCategory.message}');
            _isLoading = false;
          });
        });

      });
    });

  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0; // Reset to the first page
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }





  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    // Dispose controllers when not needed
    _horizontalScrollController.dispose();
    _verticalScrollController.dispose();
    super.dispose();
  }

  double calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width;
  }


  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);


    int currentCatIndex = 0;
    List<String> category = [
      'Starter', 'Ice Cream', 'Desert', 'North Indian', 'South Indian', 'Fast Food', 'Chicken', 'Fish', 'Sea Foods', 'Italian Food', 'Chinese Food', 'Dec'
    ];
    /*List<String> categoryList = [];
    for (int i = currentCatIndex; i >= 0; i--) {
      categoryList.add(category[i]);
    }*/
    List<String> categoryList = List.from(category);
    List<String> productAddOnsList = List.from(productAddOns);



    // TODO: implement build
    return !isDineIn ? Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: _isLoading,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: w,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.05, left: w * 0.03, right: w * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      _showAddressPopup(context);
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/work_icon.svg',
                                            width: w * 0.04,
                                          ),
                                          SizedBox(width: w * 0.015,),
                                          Text('Work',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins_regular',
                                              fontSize: fontSizes.fontSize14,
                                            ),
                                          ),
                                          SizedBox(width: w * 0.015,),
                                          SvgPicture.asset(
                                            'assets/icons/down_arrow_black.svg',
                                            width: w * 0.04,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Notifications()));
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/notification_icon.svg',
                                          width: w * 0.08,
                                        ),
                                      ),
                                      SizedBox(width: w * 0.025,),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Cart()));
                                        },
                                        child: Stack(
                                          children: [
                                            SvgPicture.asset(
                                              'assets/icons/cart_blank.svg',
                                              width: w * 0.08,
                                            ),
                                            Positioned(
                                              bottom: h * 0.007,
                                                left: w * 0.032,
                                                child: Text((homeM.cartItemsCount ?? 0).toString(),
                                                  style: TextStyle(
                                                    fontFamily: 'Supreme_bold',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: fontSizes.fontSize12,
                                                    color: Color(0xFF001FFF)
                                                  ),
                                                ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: w * 0.03,),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => const Profile()));
                                        },
                                        child: Container(
                                          height: h * 0.029,
                                          width: w * 0.062,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Color(0xFF001FFF), Color(0xFF001FFF)], // Set your gradient colors
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: BorderRadius.circular(25), // Adjust the border radius
                                          ),
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(25), // Ensure the same radius is applied to the image
                                                  child: Image.asset(
                                                    'assets/images/profile_img.png',
                                                    height: h * 0.027,
                                                    width: w * 0.058,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: (){
                                  Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Search()));
                                },
                                child: Container(
                                  height: h * 0.06,
                                  width: w ,
                                  decoration: BoxDecoration(
                                      color: Color(0xFFF1F1F1),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: w * 0.05),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset('assets/icons/search_icon.svg'),
                                        SizedBox(width: w * 0.05,),
                                        Text('Search',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Poppins_regular',
                                            fontSize: fontSizes.fontSize14,
                                            color: Color(0xFF606060)
                                          ),
                                        ),
                                        /*Expanded(
                                          child: TextField(
                                            textAlignVertical: TextAlignVertical.center,
                                            decoration: InputDecoration(
                                              labelText: 'Search',
                                              border: InputBorder.none,
                                              hintText: '',
                                              // isDense: true,
                                              floatingLabelBehavior: FloatingLabelBehavior.never,
                                              contentPadding: EdgeInsets.symmetric(vertical: h * 0.02),
                                            ),
                                          ),
                                        )*/

                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: h * 0.02,),

                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, AnimatedRoute.createRouteRightToLeft(DeliveryTime()));
                              },
                              child: Container(
                                width: w,
                                height: h * 0.038,
                                color: Color(0xFFEEE3FF),

                                child: Padding(
                                  padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('Delivery Status',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_semi_bold',
                                                fontWeight: FontWeight.w600,
                                                fontSize: fontSizes.fontSize12
                                            ),
                                          ),
                                          SizedBox(width: w * 0.01,),
                                          Container(
                                            height: h * 0.004,
                                            width: w * 0.008,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: w * 0.01,),
                                          Text(homeM.deliveryStatus ?? '',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_semi_bold',
                                                fontWeight: FontWeight.w600,
                                                fontSize: fontSizes.fontSize12
                                            ),
                                          ),
                                        ],
                                      ),
                                      SvgPicture.asset('assets/icons/right_arrow.svg',)
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: h * 0.02, bottom: 8.0),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    /*PageView.builder(
                                      controller: _pageController,
                                      itemCount: imgList.length,
                                      itemBuilder: (context, index){
                                        return _buildPagerItems(imgList[index]);
                                      }
                                  )*/
                                    Padding(
                                      padding: EdgeInsets.only(left: w * 0.03),
                                      child: Container(
                                        width: double.infinity, // Ensures it takes full width
                                        height: h * 0.12,
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                            height: h * 0.12,
                                            padEnds: false,
                                            aspectRatio: 1,
                                            viewportFraction: 0.72,
                                            initialPage: 0,
                                            enableInfiniteScroll: true,
                                            reverse: false,
                                            autoPlay: true,
                                            autoPlayInterval: const Duration(seconds: 3),
                                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: false,
                                            // disableCenter: true,

                                            scrollDirection: Axis.horizontal,
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                activeIndex = index; // Update active index
                                              });
                                            },
                                          ),
                                          items: [
                                            _buildPagerItems('assets/images/first_pager_img.png'),
                                            _buildPagerItems('assets/images/second_pager_img.png'),
                                            _buildPagerItems('assets/images/banner_two.jpg'),
                                            _buildPagerItems('assets/images/banner_three.jpg'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10, // Position the indicator above the image's bottom
                                      child: buildIndicator(4),
                                    ),
                                  ],

                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05, top: h * 0.015, right: w * 0.05),
                              child: Row(
                                children: [
                                  Text('Restaurant Map View: ',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_medium',
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize18
                                    ),
                                  ),

                                  Expanded(
                                    child: Text(homeM.restaurantAddress ?? '',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontWeight: FontWeight.w400,
                                          fontSize: fontSizes.fontSize15
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: h * 0.02),
                              height: h * 0.01,
                              width: w,
                              color: Color(0xFFF1F1F1),
                            ),

                            Container(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('Full Menu',
                                            style: TextStyle(
                                                fontFamily: 'Supreme_bold',
                                                fontWeight: FontWeight.w700,
                                                fontSize: fontSizes.fontSize24
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text('${homeM.restaurantOpenTime ?? ''}' ' - ' '${homeM.restaurantCloseTime ?? ''}',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontWeight: FontWeight.w500,
                                                fontSize: fontSizes.fontSize14,
                                                color: Color(0xFF939393)
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: h * 0.02),
                                    width: w,
                                    height: h * 0.001,
                                    color: Color(0xFFF1F1F1),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),



                      _isLoading ? Container() : Padding(
                        padding: EdgeInsets.only(left: w * 0.05, top: h * 0.03),
                        child: Container(
                          height: h * 0.0285,
                          width: w,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: h * 0.002),
                                child: SvgPicture.asset('assets/icons/cat_list_icon.svg',
                                  width: w * 0.02,
                                  height: h * 0.025,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(width: w * 0.04,),
                              Container(
                                height: h * 0.0285,
                                width: w * 0.005,
                                color: Color(0xFF606060),
                              ),
                              SizedBox(width: w * 0.01,),
                              Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    // itemCount: categoryList.length,
                                    itemCount: productCategory.data?.length,
                                    itemBuilder: (context, index){
                                      TextStyle textStyle = TextStyle(
                                          fontSize: fontSizes.fontSize14,
                                          fontFamily: 'Poppins_semi_bold',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black
                                      );

                                      // Calculate text width dynamically
                                      // double textWidth = calculateTextWidth(categoryList[index], textStyle);
                                      double textWidth = calculateTextWidth(productCategory.data![index].title.toString(), textStyle);

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCatIndex = index; // Update the selected month index
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Container(
                                            margin: EdgeInsets.zero, // Ensure no margin is applied
                                            padding: EdgeInsets.zero,
                                            child: Center(

                                              child: Column(
                                                children: [
                                                  Text(
                                                    // categoryList[index],
                                                    productCategory.data![index].title.toString(),
                                                    style: TextStyle(
                                                      // fontSize: 15,
                                                      fontSize: fontSizes.fontSize14,
                                                      fontFamily: 'Poppins_semi_bold',
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: h * 0.003,
                                                    // width: w * 0.1,
                                                    width: textWidth + w * 0.02,
                                                    /*color: selectedMonthIndex == index
                                                     ? Colors.black // Highlight for selected
                                                     : Colors.transparent,*/
                                                    decoration: BoxDecoration(
                                                      color: selectedCatIndex == index
                                                          ? Color(0xFF000000) // Highlight selected month
                                                          : Colors.transparent, // No background for unselected months
                                                      borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(10),
                                                          topLeft: Radius.circular(10)
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                      _isLoading ? Container() : Column(
                        children: [
                          ListView.builder(
                            itemCount: productCategory.data!.length,
                            // itemCount: 3,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            // physics: BouncingScrollPhysics(),
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: w * 0.04, top: h * 0.03),
                                    child: Text(productCategory.data?[index].title.toString() ?? '',
                                    // child: Text('Starter',

                                      style: TextStyle(
                                          fontSize: fontSizes.fontSize24,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: 'Supreme_bold'

                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(top: h * 0.02,left: w * 0.05, right: w * 0.05),
                                    // child: Container(
                                    //   height: itemHeight * innerItemCount + 1, // Calculate total height
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: productCategory.data?[index].products?.length,
                                      // itemCount: 4,
                                      itemBuilder: (BuildContext context, int rowIndex) {
                                        Products products = productCategory.data![index].products![rowIndex];
                                        return InkWell(
                                          onTap: (){
                                            setState(() {
                                              if (products.groupedVariations?.isNotEmpty ?? false) {
                                                print("GroupedVariations is not empty!");
                                                _isDescriptionOpen = true;
                                                _products = products;
                                                productDescription(context, products);
                                              } else {
                                                print("GroupedVariations is empty!");
                                                _isDescriptionOpen = false;
                                              }

                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(bottom: h * 0.02), // Space between items
                                            child:  _buildItems(context, products),
                                          ),
                                        );
                                      },
                                    ),
                                    // ),
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: h * 0.1,),
                        ],
                      ),
                    ],
                  )
              ),
            ),

            Visibility(
              visible: true,
              child: Positioned(
                  bottom: h * 0.01,
                  left: w * 0.05,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Cart()));
                    },
                    child: Container(
                      height: h * 0.0879,
                      width: w * 0.9,
                      decoration: BoxDecoration(
                          color: Color(0xFFFFE000),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: h * 0.004,),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: h * 0.0195,
                              padEnds: false,
                              aspectRatio: 1,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration: const Duration(milliseconds: 300),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: false,
                              // disableCenter: true,

                              scrollDirection: Axis.horizontal,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  activeIndex = index; // Update active index
                                });
                              },
                            ),
                            items: [
                              _buildPromotionItems('Shop for ₹44 more to save ₹50', '20FLAT', 'double_message'),
                              _buildPromotionItems('Earn 30 Coins', '', 'single_message'),
                              _buildPromotionItems('Get 10% Prepaid Discount', '', 'single_message'),
                              /*_buildPagerItems('assets/images/first_pager_img.png'),
                              _buildPagerItems('assets/images/second_pager_img.png'),
                              _buildPagerItems('assets/images/banner_two.jpg'),
                              _buildPagerItems('assets/images/banner_three.jpg'),*/
                            ],
                          ),
                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Shop for ₹44 more to save ₹50 | ',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSizes.fontSize12,
                                  fontFamily: 'Supreme_bold'
                                ),
                              ),
                              Text('20FLAT',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: fontSizes.fontSize12,
                                    fontFamily: 'Supreme_bold'
                                ),
                              ),
                            ],
                          ),*/
                          SizedBox(height: h * 0.004,),
                          Container(
                            height: h * 0.06,
                            width: w,
                            decoration: BoxDecoration(
                                color: Color(0xFF001FFF),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset('assets/icons/cart_bag_white.svg'),
                                  Padding(
                                    padding: EdgeInsets.only(top: h * 0.012),
                                    child: Column(
                                      children: [
                                        Text('View Cart',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: fontSizes.fontSize16,
                                              fontFamily: 'Poppins_regular',
                                              color: Colors.white,
                                              height: 1
                                          ),
                                        ),
                                        Text('₹${homeM.cartItemsPrice ?? 0} total before taxes',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: fontSizes.fontSize12,
                                              fontFamily: 'Poppins_regular',
                                              color: Colors.white
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.15),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.005, bottom: h * 0.005),
                                      child: Text((homeM.cartItemsCount ?? 0).toString() ,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: fontSizes.fontSize16,
                                            fontFamily: 'Supreme_bold',
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
              ),
            ),

            Positioned(
                bottom: 0,
                child: Container(),
                // child: _products == null ? Container()
                //     : _ProductDescription(_products)

            ),

            /*Positioned(
                bottom: 0,
                // child: Container(),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  width: w,
                  constraints: BoxConstraints(
                    maxHeight: _isDescriptionOpen ? h * 0.7 : 0, // Max height is 30% of screen
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 10.0,
                      ),
                    ],
                  ),
                  child: _products == null
                      ? Center(child: Text('No product data available'))
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(_products.title ?? '',
                                  style: TextStyle(
                                      fontFamily: 'Supreme_bold',
                                      fontSize: fontSizes.fontSize24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(
                                  width: w * 0.8,
                                  child: Text(_products.shortDescription ?? '',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_regular',
                                        fontSize: fontSizes.fontSize12,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF7B7B7B)
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _isDescriptionOpen = false;
                                  });
                                },
                                child: SvgPicture.asset('assets/icons/cross_gray_bg.svg')
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: h * 0.015,),

                      Expanded(
                        child: SingleChildScrollView(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              FocusScope.of(context).unfocus(); // Unfocuses the text field when tapping outside
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: h * 0.2,
                                    width: w,
                                    child: Image.asset('assets/images/cheese_pizza_profile.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            *//*Image.asset('assets/images/no_onion_garlic_icons.png',
                                  height: h * 0.017,
                                ),*//*
                                            Text(
                                              '₹${_products.price ?? 0.0}',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins_regular',
                                                  fontSize: fontSizes.fontSize12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black
                                              ),
                                            ),
                                            SizedBox(width: w * 0.02,),
                                            Container(
                                              height: h * 0.015,
                                              width: w * 0.001,
                                              color: Color(0xFF606060),
                                            ),
                                            SizedBox(width: w * 0.02,),
                                            SvgPicture.asset('assets/icons/watch.svg',
                                                color: Color(0xFF606060)
                                            ),
                                            SizedBox(width: w * 0.01,),
                                            Text(_products.makingTime ?? '',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins_regular',
                                                  fontSize: fontSizes.fontSize12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF606060)
                                              ),
                                            ),
                                            SizedBox(width: w * 0.02,),
                                            Container(
                                              height: h * 0.015,
                                              width: w * 0.001,
                                              color: Color(0xFF606060),
                                            ),
                                            SizedBox(width: w * 0.02,),
                                            SvgPicture.asset('assets/icons/like_thumb.svg',
                                                color: Color(0xFF606060)
                                            ),
                                            SizedBox(width: w * 0.01,),
                                            Text('${_products.peopleCountRate} likes',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins_regular',
                                                  fontSize: fontSizes.fontSize12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF606060)
                                              ),
                                            ),

                                            SizedBox(width: w * 0.02,),
                                            Container(
                                              height: h * 0.015,
                                              width: w * 0.001,
                                              color: Color(0xFF606060),
                                            ),
                                            SizedBox(width: w * 0.02,),

                                            if(_products.veg == true && _products.nonVeg == false)
                                              SvgPicture.asset('assets/icons/veg_icon.svg',
                                                width: w * 0.05,
                                              )
                                            else if(_products.veg == true && _products.nonVeg == true)
                                              SvgPicture.asset('assets/icons/non_veg_icon.svg',
                                                width: w * 0.05,
                                              )
                                            else if (_products.veg == true && _products.jain == true)
                                                SvgPicture.asset('assets/icons/jain_icon.svg',
                                                  width: w * 0.05,
                                                )
                                              else
                                                SvgPicture.asset('assets/icons/nong_icon.svg',
                                                  width: w * 0.05,
                                                ),


                                            SizedBox(width: w * 0.01,),

                                          ],
                                        ),

                                        SizedBox(height: h * 0.012,),
                                        Text(_products.shortDescription ?? '',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontSize: fontSizes.fontSize12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF606060)
                                          ),
                                        ),

                                        SizedBox(height: h * 0.02,),
                                        Container(
                                          height: h * 0.0285,
                                          width: w,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: h * 0.002),
                                                child: SvgPicture.asset('assets/icons/cat_list_icon.svg',
                                                  width: w * 0.02,
                                                  height: h * 0.025,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              SizedBox(width: w * 0.04,),
                                              Container(
                                                height: h * 0.0285,
                                                width: w * 0.005,
                                                color: Color(0xFF606060),
                                              ),
                                              SizedBox(width: w * 0.01,),
                                              Expanded(
                                                child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: _products.groupedVariations?.length ?? 0,
                                                    itemBuilder: (context, index){
                                                      TextStyle textStyle = TextStyle(
                                                        fontSize: fontSizes.fontSize15,
                                                        fontFamily: 'Poppins_semi_bold',
                                                        fontWeight: FontWeight.w700,
                                                        color: selectedMonthIndex == index ? Colors.black : Colors.grey, // Highlight selected item
                                                      );

                                                      // Calculate text width dynamically
                                                      // double textWidth = calculateTextWidth(productAddOnsList[index], textStyle);
                                                      String? keyName = _products.groupedVariations?[index].type;
                                                      double textWidth = calculateTextWidth(keyName ?? '', textStyle);

                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedMonthIndex = index; // Update the selected month index
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                          child: Container(
                                                            margin: EdgeInsets.zero, // Ensure no margin is applied
                                                            padding: EdgeInsets.zero,
                                                            child: Center(

                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    // productAddOnsList[index],
                                                                    keyName ?? '',
                                                                    style: TextStyle(
                                                                        fontSize: fontSizes.fontSize14,
                                                                        fontFamily: 'Poppins_semi_bold',
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.black
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: h * 0.003,
                                                                    width: textWidth + w * 0.02,
                                                                    decoration: BoxDecoration(
                                                                      color: selectedMonthIndex == index
                                                                          ? Color(0xFF000000) // Highlight selected month
                                                                          : Colors.transparent, // No background for unselected months
                                                                      borderRadius: BorderRadius.only(
                                                                          topRight: Radius.circular(10),
                                                                          topLeft: Radius.circular(10)
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // SizedBox(height: h * 0.02,),


                                      ],
                                    ),
                                  ),


                                  ListView.builder(
                                    // itemCount: productAddOnsList.length,
                                    // itemCount: products.groupedVariations?.addons?["addon"]?.length ?? 0,
                                    itemCount: _products.groupedVariations?.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      // String keyName = getKeyNameByIndex(products.groupedVariations!.addons!, index);
                                      String? title = _products.groupedVariations?[index].type;
                                      return Column(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.03),
                                            child: Text(title ?? '',
                                              style: TextStyle(
                                                  fontSize: fontSizes.fontSize16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins_semi_bold'
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(top: h * 0.02,left: w * 0.05, right: w * 0.05),
                                            // child: Container(
                                            //   height: itemHeight * innerItemCount + 1, // Calculate total height
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: _products.groupedVariations?[index].variations?.length ?? 0,
                                              itemBuilder: (BuildContext context, int rowIndex) {
                                                *//*GroupedVariations? variations = products.groupedVariations;
                                    Map<String, List<Addon>>? addOns = variations!.addons;
                                    Addon addOn = addOns[rowIndex];*//*
                                                Variation variation = Variation();
                                                if(_products.groupedVariations?[index].variations?[rowIndex] != null){
                                                  variation = _products.groupedVariations![index].variations![rowIndex];
                                                }

                                                String? type = _products.groupedVariations?[index].variations?[rowIndex].selectionType;
                                                bool isLastItem = rowIndex == (_products.groupedVariations?[index].variations?.length ?? 0) - 1;
                                                return InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      addOnsFirstItemSelectedIndex = rowIndex;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: isLastItem ? EdgeInsets.only(bottom: h * 0.00) : EdgeInsets.only(bottom: h * 0.02), // Space between items
                                                    child: _buildAddOnsItem(variation, type ?? ''),
                                                  ),
                                                );
                                              },
                                            ),
                                            // ),
                                          ),
                                          Container(
                                            width: w,
                                            height: h * 0.01,
                                            color: Color(0xFFF1F1F1),
                                          ),
                                        ],
                                      );
                                    },
                                  ),

                                  SizedBox(height: h * 0.015,),


                                  Padding(
                                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Preferences',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_semi_bold',
                                              fontWeight: FontWeight.w600,
                                              fontSize: fontSizes.fontSize16,
                                              color: Colors.black
                                          ),
                                        ),
                                        Text('Optional',
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontWeight: FontWeight.w500,
                                              fontSize: fontSizes.fontSize12,
                                              color: Color(0xFF7B7B7B)
                                          ),
                                        ),
                                        SizedBox(height: h * 0.015,),
                                        Container(
                                          height: h * 0.1,
                                          width: w,
                                          // alignment: Alignment.center,
                                          padding:
                                          EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(8),
                                            color: Color(0xFFF1F1F1),
                                            // color: Colors.red,
                                          ),
                                          child: TextFormField(
                                            maxLines: null, // Allows the text field to expand with multiple lines
                                            textAlignVertical: TextAlignVertical.top,
                                            cursorColor: Colors.red,
                                            decoration: InputDecoration(
                                              // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                              floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                              labelText: 'e.g. ring the bell after dropoff, leave next to the porch, call upon arrival, etc.',
                                              labelStyle: TextStyle(
                                                // Custom style for the label
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_regular',
                                                color: Color(0xFF606060), // Label color
                                              ),
                                              filled: true,
                                              fillColor: Color(0xFFF1F1F1),
                                              isCollapsed: true,
                                              border: InputBorder.none,
                                            ).copyWith(isDense: true),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: h * 0.03,),
                                  productQuantities[_products.id ?? ''] == 0
                                      ? GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        int updatedQuantity = (productQuantities[_products.id ?? ''] ?? 0) + 1;
                                        productQuantities[_products.id ?? ''] = updatedQuantity;
                                        print("Updated Quantity: $updatedQuantity");
                                      });
                                    },
                                    child: Container(
                                      width: w * 0.4,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Color(0xFFE8E8E8),
                                              width: 1
                                          )
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01),
                                          child: Text('ADD',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Supreme_bold',
                                                fontSize: fontSizes.fontSize24,
                                                color: Colors.black
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )

                                      : Container(
                                    width: w * 0.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xFFE8E8E8),
                                            width: 1
                                        )
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          // SizedBox(width: w * 0.03,),
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: (){
                                              setState(() {
                                                int updatedQuantity = (productQuantities[_products.id ?? ''] ?? 0) - 1;
                                                productQuantities[_products.id ?? ''] = updatedQuantity;
                                                print("Updated Quantity: $updatedQuantity");
                                              });
                                            },
                                            child: Container(
                                                height: h * 0.05,
                                                width: w * 0.1,
                                                child: Center(child: SvgPicture.asset(
                                                    productQuantities[_products.id ?? ''] == 1
                                                        ? 'assets/icons/delete_enable.svg'
                                                        : 'assets/icons/subtract.svg'
                                                ))
                                            ),
                                          ),
                                          SizedBox(width: w * 0.05,),
                                          Text(productQuantities[_products.id ?? ''].toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Supreme_bold',
                                                fontSize: fontSizes.fontSize24,
                                                color: Colors.black
                                            ),
                                          ),
                                          SizedBox(width: w * 0.02,),
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: (){
                                              setState(() {
                                                int updatedQuantity = (productQuantities[_products.id ?? ''] ?? 0) + 1;
                                                productQuantities[_products.id ?? ''] = updatedQuantity;
                                                print("Updated Quantity: $updatedQuantity");
                                              });
                                            },
                                            child: Container(
                                                height: h * 0.05,
                                                width: w * 0.13,
                                                child: Center(child: SvgPicture.asset('assets/icons/add.svg'))
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.06,),

                                  Padding(
                                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF001FFF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02, bottom: h * 0.02),
                                            child: Text('Continue Shopping',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins_semi_bold',
                                                  fontSize: fontSizes.fontSize16,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: w * 0.04, top: h * 0.02, bottom: h * 0.02),
                                            child: Text('₹899.01',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins_semi_bold',
                                                  fontSize: fontSizes.fontSize16,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.03,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )

            ),*/

          ],
        ),
      ),
    )



    // DINEIN Content Start

    : Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: _isLoading,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                  child: Column(
                    children: [
                      Container(
                        width: w,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: h * 0.05, left: w * 0.03, right: w * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      _showAddressPopup(context);
                                    },
                                    child: Container(
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/icons/dine_in_home.svg',
                                            width: w * 0.04,
                                          ),
                                          SizedBox(width: w * 0.015,),
                                          Text('Dine In',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins_regular',
                                              fontSize: fontSizes.fontSize14,
                                            ),
                                          ),
                                          SizedBox(width: w * 0.015,),
                                          Container(
                                            height: h * 0.006,
                                            width: w * 0.012,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(width: w * 0.015,),
                                          Text('Table 32',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Poppins_regular',
                                              fontSize: fontSizes.fontSize14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Notifications()));
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/notification_icon.svg',
                                          width: w * 0.08,
                                        ),
                                      ),
                                      SizedBox(width: w * 0.025,),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Cart()));
                                        },
                                        child: SvgPicture.asset(
                                          'assets/icons/cart_bag_icon.svg',
                                          width: w * 0.06,
                                        ),
                                      ),
                                      SizedBox(width: w * 0.03,),
                                      GestureDetector(
                                        onTap: (){
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context) => const Profile()));
                                        },
                                        child: Container(
                                          height: h * 0.029,
                                          width: w * 0.062,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [Color(0xFF001FFF), Color(0xFF001FFF)], // Set your gradient colors
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                            borderRadius: BorderRadius.circular(25), // Adjust the border radius
                                          ),
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(25), // Ensure the same radius is applied to the image
                                                  child: Image.asset(
                                                    'assets/images/profile_img.png',
                                                    height: h * 0.027,
                                                    width: w * 0.058,
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Search()));
                                    },
                                    child: Container(
                                      height: h * 0.06,
                                      width: w * 0.78,

                                      decoration: BoxDecoration(
                                          color: Color(0xFFF1F1F1),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(left: w * 0.05),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset('assets/icons/search_icon.svg'),
                                            SizedBox(width: w * 0.05,),
                                            Text('Search',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Poppins_regular',
                                                  fontSize: fontSizes.fontSize14,
                                                  color: Color(0xFF606060)
                                              ),
                                            ),
                                            /*Expanded(
                                              child: TextField(
                                                textAlignVertical: TextAlignVertical.center,
                                                decoration: InputDecoration(
                                                  labelText: 'Search',
                                                  border: InputBorder.none,
                                                  hintText: '',
                                                  // isDense: true,
                                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                                  contentPadding: EdgeInsets.symmetric(vertical: h * 0.02),
                                                ),
                                              ),

                                            )*/

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, AnimatedRoute.createRouteRightToLeft(SelectRestaurantLocation()));
                                    },
                                      child: SvgPicture.asset('assets/icons/restaurant_grey_bg.svg')
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: h * 0.02,),

                            GestureDetector(
                              onTap: (){
                                Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Payment()));
                              },
                              child: Container(
                                width: w,
                                height: h * 0.038,
                                color: Color(0xFFFFD3D3),

                                child: Padding(
                                  padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('Pending Payment',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_semi_bold',
                                                fontWeight: FontWeight.w600,
                                                fontSize: fontSizes.fontSize12
                                            ),
                                          ),
                                          SizedBox(width: w * 0.01,),
                                          Container(
                                            height: h * 0.004,
                                            width: w * 0.008,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: w * 0.01,),
                                          Text('Pay ₹320 here',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_semi_bold',
                                                fontWeight: FontWeight.w600,
                                                fontSize: fontSizes.fontSize12
                                            ),
                                          ),
                                        ],
                                      ),
                                      SvgPicture.asset('assets/icons/right_arrow.svg',)
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(top: h * 0.02, bottom: 8.0),
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    /*PageView.builder(
                                      controller: _pageController,
                                      itemCount: imgList.length,
                                      itemBuilder: (context, index){
                                        return _buildPagerItems(imgList[index]);
                                      }
                                  )*/
                                    Padding(
                                      padding: EdgeInsets.only(left: w * 0.03),
                                      child: Container(
                                        width: double.infinity, // Ensures it takes full width
                                        height: h * 0.12,
                                        child: CarouselSlider(
                                          options: CarouselOptions(
                                            height: h * 0.12,
                                            padEnds: false,
                                            aspectRatio: 1,
                                            viewportFraction: 0.72,
                                            initialPage: 0,
                                            enableInfiniteScroll: true,
                                            reverse: false,
                                            autoPlay: true,
                                            autoPlayInterval: const Duration(seconds: 3),
                                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: false,
                                            // disableCenter: true,

                                            scrollDirection: Axis.horizontal,
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                activeIndex = index; // Update active index
                                              });
                                            },
                                          ),
                                          items: [
                                            _buildPagerItems('assets/images/first_pager_img.png'),
                                            _buildPagerItems('assets/images/second_pager_img.png'),
                                            _buildPagerItems('assets/images/banner_two.jpg'),
                                            _buildPagerItems('assets/images/banner_three.jpg'),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10, // Position the indicator above the image's bottom
                                      child: buildIndicator(4),
                                    ),
                                  ],

                                ),
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: w * 0.05, top: h * 0.015, right: w * 0.05),
                              child: Row(
                                children: [
                                  Text('Restaurant Map View: ',
                                    style: TextStyle(
                                        fontFamily: 'Poppins_medium',
                                        fontWeight: FontWeight.w500,
                                        fontSize: fontSizes.fontSize18
                                    ),
                                  ),

                                  Expanded(
                                    child: Text('B22 - Viman Nagar, Patrakar colony, mansarover',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontWeight: FontWeight.w400,
                                          fontSize: fontSizes.fontSize15
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: h * 0.02),
                              height: h * 0.01,
                              width: w,
                              color: Color(0xFFF1F1F1),
                            ),

                            Container(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text('Full Menu',
                                            style: TextStyle(
                                                fontFamily: 'Supreme_bold',
                                                fontWeight: FontWeight.w700,
                                                fontSize: fontSizes.fontSize24
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text('10:00 AM - 12:15 AM',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontWeight: FontWeight.w500,
                                                fontSize: fontSizes.fontSize14,
                                                color: Color(0xFF939393)
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: h * 0.02),
                                    width: w,
                                    height: h * 0.001,
                                    color: Color(0xFFF1F1F1),
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                      ),



                      Padding(
                        padding: EdgeInsets.only(left: w * 0.05, top: h * 0.03),
                        child: Container(
                          height: h * 0.0285,
                          width: w,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: h * 0.002),
                                child: SvgPicture.asset('assets/icons/cat_list_icon.svg',
                                  width: w * 0.02,
                                  height: h * 0.025,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(width: w * 0.04,),
                              Container(
                                height: h * 0.0285,
                                width: w * 0.005,
                                color: Color(0xFF606060),
                              ),
                              SizedBox(width: w * 0.01,),
                              Expanded(
                                child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: categoryList.length,
                                    itemBuilder: (context, index){
                                      TextStyle textStyle = TextStyle(
                                          fontSize: fontSizes.fontSize14,
                                          fontFamily: 'Poppins_semi_bold',
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black
                                      );

                                      // Calculate text width dynamically
                                      double textWidth = calculateTextWidth(categoryList[index], textStyle);

                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedCatIndex = index; // Update the selected month index
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Container(
                                            margin: EdgeInsets.zero, // Ensure no margin is applied
                                            padding: EdgeInsets.zero,
                                            /*decoration: BoxDecoration(
                                           color: selectedMonthIndex == index
                                               ? Color(0xFFDADADA) // Highlight selected month
                                               : Colors.transparent, // No background for unselected months
                                           borderRadius: BorderRadius.circular(8),
                                         ),*/
                                            // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                            child: Center(

                                              child: Column(
                                                children: [
                                                  Text(
                                                    categoryList[index],
                                                    style: TextStyle(
                                                      // fontSize: 15,
                                                      fontSize: fontSizes.fontSize14,
                                                      fontFamily: 'Poppins_semi_bold',
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Container(
                                                    height: h * 0.003,
                                                    // width: w * 0.1,
                                                    width: textWidth + w * 0.02,
                                                    /*color: selectedMonthIndex == index
                                                     ? Colors.black // Highlight for selected
                                                     : Colors.transparent,*/
                                                    decoration: BoxDecoration(
                                                      color: selectedCatIndex == index
                                                          ? Color(0xFF000000) // Highlight selected month
                                                          : Colors.transparent, // No background for unselected months
                                                      borderRadius: BorderRadius.only(
                                                          topRight: Radius.circular(10),
                                                          topLeft: Radius.circular(10)
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                      ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: w * 0.04, top: h * 0.03),
                                child: Text('Starter',
                                  style: TextStyle(
                                      fontSize: fontSizes.fontSize24,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Supreme_bold'
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: h * 0.02,left: w * 0.05, right: w * 0.05),
                                // child: Container(
                                //   height: itemHeight * innerItemCount + 1, // Calculate total height
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 4,
                                  itemBuilder: (BuildContext context, int rowIndex) {
                                    return InkWell(
                                      onTap: (){
                                        setState(() {
                                          if(!_isDescriptionOpen){
                                            _isDescriptionOpen = true;
                                          }else {
                                            _isDescriptionOpen = false;
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(bottom: h * 0.02), // Space between items
                                        // child: _buildItems(context),
                                      ),
                                    );
                                  },
                                ),
                                // ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  )
              ),
            ),

            Positioned(
                bottom: h * 0.01,
                left: w * 0.05,
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Cart()));
                  },
                  child: Container(
                    height: h * 0.0879,
                    width: w * 0.9,
                    decoration: BoxDecoration(
                        color: Color(0xFFFFE000),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: h * 0.004,),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: h * 0.0195,
                            padEnds: false,
                            aspectRatio: 1,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration: const Duration(milliseconds: 300),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: false,
                            // disableCenter: true,

                            scrollDirection: Axis.horizontal,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index; // Update active index
                              });
                            },
                          ),
                          items: [
                            _buildPromotionItems('Shop for ₹44 more to save ₹50', '20FLAT', 'double_message'),
                            _buildPromotionItems('Earn 30 Coins', '', 'single_message'),
                            _buildPromotionItems('Get 10% Prepaid Discount', '', 'single_message'),
                            /*_buildPagerItems('assets/images/first_pager_img.png'),
                            _buildPagerItems('assets/images/second_pager_img.png'),
                            _buildPagerItems('assets/images/banner_two.jpg'),
                            _buildPagerItems('assets/images/banner_three.jpg'),*/
                          ],
                        ),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Shop for ₹44 more to save ₹50 | ',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: fontSizes.fontSize12,
                                fontFamily: 'Supreme_bold'
                              ),
                            ),
                            Text('20FLAT',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: fontSizes.fontSize12,
                                  fontFamily: 'Supreme_bold'
                              ),
                            ),
                          ],
                        ),*/
                        SizedBox(height: h * 0.004,),
                        Container(
                          height: h * 0.06,
                          width: w,
                          decoration: BoxDecoration(
                              color: Color(0xFF001FFF),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset('assets/icons/cart_bag_white.svg'),
                                Padding(
                                  padding: EdgeInsets.only(top: h * 0.012),
                                  child: Column(
                                    children: [
                                      Text('View Cart',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: fontSizes.fontSize16,
                                            fontFamily: 'Poppins_regular',
                                            color: Colors.white,
                                            height: 1
                                        ),
                                      ),
                                      Text('₹899.01 total before taxes',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: fontSizes.fontSize12,
                                            fontFamily: 'Poppins_regular',
                                            color: Colors.white
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.005, bottom: h * 0.005),
                                    child: Text('3',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: fontSizes.fontSize16,
                                          fontFamily: 'Supreme_bold',
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ),

            Positioned(
                bottom: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  width: w,
                  constraints: BoxConstraints(
                    maxHeight: _isDescriptionOpen ? h * 0.7 : 0, // Max height is 30% of screen
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10.0,
                        spreadRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Cheese Pizza',
                                  style: TextStyle(
                                      fontFamily: 'Supreme_bold',
                                      fontSize: fontSizes.fontSize24,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black
                                  ),
                                ),
                                Text('Plain Base • 1x Pepsi • 2x Oregano • 1x Chilli Flakes',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontSize: fontSizes.fontSize12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF7B7B7B)
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                                onTap: (){
                                  setState(() {
                                    _isDescriptionOpen = false;
                                  });
                                },
                                child: SvgPicture.asset('assets/icons/cross_gray_bg.svg')
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: h * 0.015,),

                      Expanded(
                        child: SingleChildScrollView(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              FocusScope.of(context).unfocus(); // Unfocuses the text field when tapping outside
                            },
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    height: h * 0.2,
                                    width: w,
                                    child: Image.asset('assets/images/cheese_pizza_profile.png',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset('assets/images/no_onion_garlic_icons.png',
                                              height: h * 0.017,
                                            ),
                                            SizedBox(width: w * 0.01,),
                                            Text('NONG',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins_regular',
                                                  fontSize: fontSizes.fontSize12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF017F01)
                                              ),
                                            ),
                                            SizedBox(width: w * 0.02,),
                                            Container(
                                              height: h * 0.015,
                                              width: w * 0.001,
                                              color: Color(0xFF606060),
                                            ),
                                            SizedBox(width: w * 0.02,),
                                            SvgPicture.asset('assets/icons/watch.svg',
                                                color: Color(0xFF606060)
                                            ),
                                            SizedBox(width: w * 0.01,),
                                            Text('30 min',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins_regular',
                                                  fontSize: fontSizes.fontSize12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF606060)
                                              ),
                                            ),
                                            SizedBox(width: w * 0.02,),
                                            Container(
                                              height: h * 0.015,
                                              width: w * 0.001,
                                              color: Color(0xFF606060),
                                            ),
                                            SizedBox(width: w * 0.02,),
                                            SvgPicture.asset('assets/icons/like_thumb.svg',
                                                color: Color(0xFF606060)
                                            ),
                                            SizedBox(width: w * 0.01,),
                                            Text('238 likes',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins_regular',
                                                  fontSize: fontSizes.fontSize12,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF606060)
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: h * 0.012,),
                                        Text(AppStrings.PRODUCT_DESCRIPTION,
                                          style: TextStyle(
                                              fontFamily: 'Poppins_regular',
                                              fontSize: fontSizes.fontSize12,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF606060)
                                          ),
                                        ),

                                        SizedBox(height: h * 0.02,),
                                        Container(
                                          height: h * 0.0285,
                                          width: w,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(top: h * 0.002),
                                                child: SvgPicture.asset('assets/icons/cat_list_icon.svg',
                                                  width: w * 0.02,
                                                  height: h * 0.025,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              SizedBox(width: w * 0.04,),
                                              Container(
                                                height: h * 0.0285,
                                                width: w * 0.005,
                                                color: Color(0xFF606060),
                                              ),
                                              SizedBox(width: w * 0.01,),
                                              Expanded(
                                                child: ListView.builder(
                                                    padding: EdgeInsets.zero,
                                                    shrinkWrap: true,
                                                    scrollDirection: Axis.horizontal,
                                                    itemCount: productAddOnsList.length,
                                                    itemBuilder: (context, index){
                                                      TextStyle textStyle = TextStyle(
                                                        fontSize: fontSizes.fontSize15,
                                                        fontFamily: 'Poppins_semi_bold',
                                                        fontWeight: FontWeight.w700,
                                                        color: selectedMonthIndex == index ? Colors.black : Colors.grey, // Highlight selected item
                                                      );

                                                      // Calculate text width dynamically
                                                      double textWidth = calculateTextWidth(productAddOnsList[index], textStyle);

                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            selectedMonthIndex = index; // Update the selected month index
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                          child: Container(
                                                            margin: EdgeInsets.zero, // Ensure no margin is applied
                                                            padding: EdgeInsets.zero,
                                                            child: Center(

                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    productAddOnsList[index],
                                                                    style: TextStyle(
                                                                        fontSize: fontSizes.fontSize14,
                                                                        fontFamily: 'Poppins_semi_bold',
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.black
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    height: h * 0.003,
                                                                    width: textWidth + w * 0.02,
                                                                    decoration: BoxDecoration(
                                                                      color: selectedMonthIndex == index
                                                                          ? Color(0xFF000000) // Highlight selected month
                                                                          : Colors.transparent, // No background for unselected months
                                                                      borderRadius: BorderRadius.only(
                                                                          topRight: Radius.circular(10),
                                                                          topLeft: Radius.circular(10)
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // SizedBox(height: h * 0.02,),


                                      ],
                                    ),
                                  ),


                                  ListView.builder(
                                    itemCount: productAddOnsList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      return Column(
                                        // mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.03),
                                            child: Text(productAddOnsList[index],
                                              style: TextStyle(
                                                  fontSize: fontSizes.fontSize16,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins_semi_bold'
                                              ),
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.only(top: h * 0.02,left: w * 0.05, right: w * 0.05),
                                            // child: Container(
                                            //   height: itemHeight * innerItemCount + 1, // Calculate total height
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemCount: index == 3 ? 1 : 3,
                                              itemBuilder: (BuildContext context, int rowIndex) {
                                                return InkWell(
                                                  onTap: (){
                                                    setState(() {
                                                      addOnsFirstItemSelectedIndex = rowIndex;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(bottom: h * 0.02), // Space between items
                                                    // child: _buildAddOnsItem(addOnsFirstItemSelectedIndex, rowIndex, index),
                                                  ),
                                                );
                                              },
                                            ),
                                            // ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  SizedBox(height: h * 0.01,),
                                  Container(
                                    width: w * 0.4,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Color(0xFFE8E8E8),
                                            width: 1
                                        )
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(width: w * 0.03,),
                                          SvgPicture.asset('assets/icons/delete_enable.svg'),
                                          SizedBox(width: w * 0.05,),
                                          Text('1',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'Supreme_bold',
                                                fontSize: fontSizes.fontSize24,
                                                color: Colors.black
                                            ),
                                          ),
                                          SizedBox(width: w * 0.02,),
                                          SvgPicture.asset('assets/icons/add.svg'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.06,),

                                  Padding(
                                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF001FFF),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02, bottom: h * 0.02),
                                            child: Text('Continue Shopping',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins_semi_bold',
                                                  fontSize: fontSizes.fontSize16,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(right: w * 0.04, top: h * 0.02, bottom: h * 0.02),
                                            child: Text('₹899.01',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Poppins_semi_bold',
                                                  fontSize: fontSizes.fontSize16,
                                                  color: Colors.white
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.03,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }
















  /*@override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);


    int currentCatIndex = 0;
    List<String> category = [
      'Starter', 'Ice Cream', 'Desert', 'North Indian', 'South Indian', 'Fast Food', 'Chicken', 'Fish', 'Sea Foods', 'Italian Food', 'Chinese Food', 'Dec'
    ];
    *//*List<String> categoryList = [];
    for (int i = currentCatIndex; i >= 0; i--) {
      categoryList.add(category[i]);
    }*//*
    List<String> categoryList = List.from(category);
    List<String> productAddOnsList = List.from(productAddOns);

    

    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: w,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: h * 0.05, left: w * 0.03, right: w * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  _showAddressPopup(context);
                                },
                                child: Container(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/work_icon.svg',
                                        width: w * 0.04,
                                      ),
                                      SizedBox(width: w * 0.015,),
                                      Text('Work',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins_regular',
                                          fontSize: fontSizes.fontSize14,
                                        ),
                                      ),
                                      SizedBox(width: w * 0.015,),
                                      SvgPicture.asset(
                                        'assets/icons/down_arrow_black.svg',
                                        width: w * 0.04,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Notifications()));
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/notification_icon.svg',
                                      width: w * 0.08,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.025,),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Cart()));
                                    },
                                    child: SvgPicture.asset(
                                      'assets/icons/cart_bag_icon.svg',
                                      width: w * 0.06,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.03,),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) => const Profile()));
                                    },
                                    child: Container(
                                      height: h * 0.029,
                                      width: w * 0.062,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Color(0xFF001FFF), Color(0xFF001FFF)], // Set your gradient colors
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(25), // Adjust the border radius
                                      ),
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(25), // Ensure the same radius is applied to the image
                                              child: Image.asset(
                                                'assets/images/profile_img.png',
                                                height: h * 0.027,
                                                width: w * 0.058,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
                          child: Container(
                            height: h * 0.06,
                            width: w ,
                            decoration: BoxDecoration(
                                color: Color(0xFFF1F1F1),
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.05),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/search_icon.svg'),
                                  SizedBox(width: w * 0.05,),
                                  Expanded(
                                    child: TextField(
                                      textAlignVertical: TextAlignVertical.center,
                                      decoration: InputDecoration(
                                        labelText: 'Search',
                                        border: InputBorder.none,
                                        hintText: '',
                                        // isDense: true,
                                        floatingLabelBehavior: FloatingLabelBehavior.never,
                                        contentPadding: EdgeInsets.symmetric(vertical: h * 0.02),
                                      ),

                                    ),
                                  )

                                ],
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: h * 0.02,),

                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, AnimatedRoute.createRouteRightToLeft(DeliveryTime()));
                          },
                          child: Container(
                            width: w,
                            height: h * 0.038,
                            color: Color(0xFFFFF7D3),

                            child: Padding(
                              padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('Scheduled Delivery',
                                        style: TextStyle(
                                            fontFamily: 'Poppins_semi_bold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: fontSizes.fontSize12
                                        ),
                                      ),
                                      SizedBox(width: w * 0.01,),
                                      Container(
                                        height: h * 0.004,
                                        width: w * 0.008,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: w * 0.01,),
                                      Text('Tomorrow, 2:40 PM',
                                        style: TextStyle(
                                            fontFamily: 'Poppins_semi_bold',
                                            fontWeight: FontWeight.w600,
                                            fontSize: fontSizes.fontSize12
                                        ),
                                      ),
                                    ],
                                  ),
                                  SvgPicture.asset('assets/icons/right_arrow.svg',)
                                ],
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: h * 0.02, bottom: 8.0),
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                *//*PageView.builder(
                                    controller: _pageController,
                                    itemCount: imgList.length,
                                    itemBuilder: (context, index){
                                      return _buildPagerItems(imgList[index]);
                                    }
                                )*//*
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.03),
                                  child: Container(
                                    width: double.infinity, // Ensures it takes full width
                                    height: h * 0.12,
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                        height: h * 0.12,
                                        padEnds: false,
                                        aspectRatio: 1,
                                        viewportFraction: 0.72,
                                        initialPage: 0,
                                        enableInfiniteScroll: true,
                                        reverse: false,
                                        autoPlay: true,
                                        autoPlayInterval: const Duration(seconds: 3),
                                        autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: false,
                                        // disableCenter: true,

                                        scrollDirection: Axis.horizontal,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            activeIndex = index; // Update active index
                                          });
                                        },
                                      ),
                                      items: [
                                        _buildPagerItems('assets/images/first_pager_img.png'),
                                        _buildPagerItems('assets/images/second_pager_img.png'),
                                        _buildPagerItems('assets/images/banner_two.jpg'),
                                        _buildPagerItems('assets/images/banner_three.jpg'),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 10, // Position the indicator above the image's bottom
                                  child: buildIndicator(4),
                                ),
                              ],

                            ),
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05, top: h * 0.015, right: w * 0.05),
                          child: Row(
                            children: [
                              Text('Restaurant Map View: ',
                                style: TextStyle(
                                  fontFamily: 'Poppins_medium',
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSizes.fontSize18
                                ),
                              ),

                              Expanded(
                                child: Text('B22 - Viman Nagar, Patrakar colony, mansarover',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontWeight: FontWeight.w400,
                                      fontSize: fontSizes.fontSize15
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(top: h * 0.02),
                          height: h * 0.01,
                          width: w,
                          color: Color(0xFFF1F1F1),
                        ),

                        Container(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.02),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text('Full Menu',
                                        style: TextStyle(
                                            fontFamily: 'Supreme_bold',
                                            fontWeight: FontWeight.w700,
                                            fontSize: fontSizes.fontSize24
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text('10:00 AM - 12:15 AM',
                                        style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontWeight: FontWeight.w500,
                                            fontSize: fontSizes.fontSize14,
                                            color: Color(0xFF939393)
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: h * 0.02),
                                width: w,
                                height: h * 0.001,
                                color: Color(0xFFF1F1F1),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),



                 Padding(
                   padding: EdgeInsets.only(left: w * 0.05, top: h * 0.03),
                   child: Container(
                     height: h * 0.0285,
                     width: w,
                     child: Row(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: EdgeInsets.only(top: h * 0.002),
                           child: SvgPicture.asset('assets/icons/cat_list_icon.svg',
                             width: w * 0.02,
                             height: h * 0.025,
                             fit: BoxFit.fill,
                           ),
                         ),
                         SizedBox(width: w * 0.04,),
                         Container(
                           height: h * 0.0285,
                           width: w * 0.005,
                           color: Color(0xFF606060),
                         ),
                         SizedBox(width: w * 0.01,),
                         Expanded(
                           child: ListView.builder(
                               padding: EdgeInsets.zero,
                               shrinkWrap: true,
                               scrollDirection: Axis.horizontal,
                               itemCount: categoryList.length,
                               itemBuilder: (context, index){
                                 TextStyle textStyle = TextStyle(
                                   fontSize: fontSizes.fontSize14,
                                   fontFamily: 'Poppins_semi_bold',
                                   fontWeight: FontWeight.w500,
                                   color: Colors.black
                                 );

                                 // Calculate text width dynamically
                                 double textWidth = calculateTextWidth(categoryList[index], textStyle);

                                 return GestureDetector(
                                   onTap: () {
                                     setState(() {
                                       selectedCatIndex = index; // Update the selected month index
                                     });
                                   },
                                   child: Padding(
                                     padding: EdgeInsets.symmetric(horizontal: 8.0),
                                     child: Container(
                                       margin: EdgeInsets.zero, // Ensure no margin is applied
                                       padding: EdgeInsets.zero,
                                       *//*decoration: BoxDecoration(
                                         color: selectedMonthIndex == index
                                             ? Color(0xFFDADADA) // Highlight selected month
                                             : Colors.transparent, // No background for unselected months
                                         borderRadius: BorderRadius.circular(8),
                                       ),*//*
                                       // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                                       child: Center(

                                         child: Column(
                                           children: [
                                             Text(
                                               categoryList[index],
                                               style: TextStyle(
                                                 // fontSize: 15,
                                                 fontSize: fontSizes.fontSize14,
                                                 fontFamily: 'Poppins_semi_bold',
                                                 fontWeight: FontWeight.w500,
                                                 color: Colors.black,
                                               ),
                                             ),
                                             Container(
                                               height: h * 0.003,
                                               // width: w * 0.1,
                                               width: textWidth + w * 0.02,
                                               *//*color: selectedMonthIndex == index
                                                   ? Colors.black // Highlight for selected
                                                   : Colors.transparent,*//*
                                               decoration: BoxDecoration(
                                                 color: selectedCatIndex == index
                                                     ? Color(0xFF000000) // Highlight selected month
                                                     : Colors.transparent, // No background for unselected months
                                                 borderRadius: BorderRadius.only(
                                                   topRight: Radius.circular(10),
                                                   topLeft: Radius.circular(10)
                                                 ),
                                               ),
                                             )
                                           ],
                                         ),
                                       ),
                                     ),
                                   ),
                                 );
                               }
                           ),
                         ),
                       ],
                     ),
                   ),
                 ),


                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, top: h * 0.03),
                            child: Text('Starter',
                              style: TextStyle(
                                  fontSize: fontSizes.fontSize24,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Supreme_bold'
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: h * 0.02,left: w * 0.05, right: w * 0.05),
                            // child: Container(
                            //   height: itemHeight * innerItemCount + 1, // Calculate total height
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: 4,
                                itemBuilder: (BuildContext context, int rowIndex) {
                                  return InkWell(
                                    onTap: (){
                                      setState(() {
                                        if(!_isDescriptionOpen){
                                          _isDescriptionOpen = true;
                                        }else {
                                          _isDescriptionOpen = false;
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: h * 0.02), // Space between items
                                      child: _buildItems(context),
                                    ),
                                  );
                                },
                              ),
                            // ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              )
            ),
          ),

          Positioned(
              bottom: h * 0.01,
              left: w * 0.05,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, AnimatedRoute.createRouteRightToLeft(Cart()));
                },
                child: Container(
                  height: h * 0.0879,
                  width: w * 0.9,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE000),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: h * 0.004,),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: h * 0.0195,
                          padEnds: false,
                          aspectRatio: 1,
                          viewportFraction: 1,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: false,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          autoPlayAnimationDuration: const Duration(milliseconds: 300),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: false,
                          // disableCenter: true,

                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              activeIndex = index; // Update active index
                            });
                          },
                        ),
                        items: [
                          _buildPromotionItems('Shop for ₹44 more to save ₹50', '20FLAT', 'double_message'),
                          _buildPromotionItems('Earn 30 Coins', '', 'single_message'),
                          _buildPromotionItems('Get 10% Prepaid Discount', '', 'single_message'),
                          *//*_buildPagerItems('assets/images/first_pager_img.png'),
                          _buildPagerItems('assets/images/second_pager_img.png'),
                          _buildPagerItems('assets/images/banner_two.jpg'),
                          _buildPagerItems('assets/images/banner_three.jpg'),*//*
                        ],
                      ),
                      *//*Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Shop for ₹44 more to save ₹50 | ',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: fontSizes.fontSize12,
                              fontFamily: 'Supreme_bold'
                            ),
                          ),
                          Text('20FLAT',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: fontSizes.fontSize12,
                                fontFamily: 'Supreme_bold'
                            ),
                          ),
                        ],
                      ),*//*
                      SizedBox(height: h * 0.004,),
                      Container(
                        height: h * 0.06,
                        width: w,
                        decoration: BoxDecoration(
                            color: Color(0xFF001FFF),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset('assets/icons/cart_bag_white.svg'),
                              Padding(
                                padding: EdgeInsets.only(top: h * 0.012),
                                child: Column(
                                  children: [
                                    Text('View Cart',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize16,
                                          fontFamily: 'Poppins_regular',
                                        color: Colors.white,
                                        height: 1
                                      ),
                                    ),
                                    Text('₹899.01 total before taxes',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: fontSizes.fontSize12,
                                          fontFamily: 'Poppins_regular',
                                        color: Colors.white
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.005, bottom: h * 0.005),
                                  child: Text('3',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: fontSizes.fontSize16,
                                        fontFamily: 'Supreme_bold',
                                        color: Colors.white
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),

          Positioned(
              bottom: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 600),
                curve: Curves.easeInOut,
                width: w,
                constraints: BoxConstraints(
                  maxHeight: _isDescriptionOpen ? h * 0.7 : 0, // Max height is 30% of screen
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: 10.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Cheese Pizza',
                                style: TextStyle(
                                  fontFamily: 'Supreme_bold',
                                  fontSize: fontSizes.fontSize24,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black
                                ),
                              ),
                              Text('Plain Base • 1x Pepsi • 2x Oregano • 1x Chilli Flakes',
                                style: TextStyle(
                                    fontFamily: 'Poppins_regular',
                                    fontSize: fontSizes.fontSize12,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF7B7B7B)
                                ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _isDescriptionOpen = false;
                              });
                            },
                              child: SvgPicture.asset('assets/icons/cross_gray_bg.svg')
                          )
                        ],
                      ),
                    ),

                    SizedBox(height: h * 0.015,),

                    Expanded(
                      child: SingleChildScrollView(
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            FocusScope.of(context).unfocus(); // Unfocuses the text field when tapping outside
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                  height: h * 0.2,
                                  width: w,
                                  child: Image.asset('assets/images/cheese_pizza_profile.png',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Image.asset('assets/images/no_onion_garlic_icons.png',
                                            height: h * 0.017,
                                          ),
                                          SizedBox(width: w * 0.01,),
                                          Text('NONG',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF017F01)
                                            ),
                                          ),
                                          SizedBox(width: w * 0.02,),
                                          Container(
                                            height: h * 0.015,
                                            width: w * 0.001,
                                            color: Color(0xFF606060),
                                          ),
                                          SizedBox(width: w * 0.02,),
                                          SvgPicture.asset('assets/icons/watch.svg',
                                              color: Color(0xFF606060)
                                          ),
                                          SizedBox(width: w * 0.01,),
                                          Text('30 min',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF606060)
                                            ),
                                          ),
                                          SizedBox(width: w * 0.02,),
                                          Container(
                                            height: h * 0.015,
                                            width: w * 0.001,
                                            color: Color(0xFF606060),
                                          ),
                                          SizedBox(width: w * 0.02,),
                                          SvgPicture.asset('assets/icons/like_thumb.svg',
                                              color: Color(0xFF606060)
                                          ),
                                          SizedBox(width: w * 0.01,),
                                          Text('238 likes',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_regular',
                                                fontSize: fontSizes.fontSize12,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF606060)
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: h * 0.012,),
                                      Text(AppStrings.PRODUCT_DESCRIPTION,
                                        style: TextStyle(
                                            fontFamily: 'Poppins_regular',
                                            fontSize: fontSizes.fontSize12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF606060)
                                        ),
                                      ),

                                      SizedBox(height: h * 0.02,),
                                      Container(
                                        height: h * 0.0285,
                                        width: w,
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(top: h * 0.002),
                                              child: SvgPicture.asset('assets/icons/cat_list_icon.svg',
                                                width: w * 0.02,
                                                height: h * 0.025,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(width: w * 0.04,),
                                            Container(
                                              height: h * 0.0285,
                                              width: w * 0.005,
                                              color: Color(0xFF606060),
                                            ),
                                            SizedBox(width: w * 0.01,),
                                            Expanded(
                                              child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  scrollDirection: Axis.horizontal,
                                                  itemCount: productAddOnsList.length,
                                                  itemBuilder: (context, index){
                                                    TextStyle textStyle = TextStyle(
                                                      fontSize: fontSizes.fontSize15,
                                                      fontFamily: 'Poppins_semi_bold',
                                                      fontWeight: FontWeight.w700,
                                                      color: selectedMonthIndex == index ? Colors.black : Colors.grey, // Highlight selected item
                                                    );

                                                    // Calculate text width dynamically
                                                    double textWidth = calculateTextWidth(productAddOnsList[index], textStyle);

                                                    return GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          selectedMonthIndex = index; // Update the selected month index
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                        child: Container(
                                                          margin: EdgeInsets.zero, // Ensure no margin is applied
                                                          padding: EdgeInsets.zero,
                                                          child: Center(

                                                            child: Column(
                                                              children: [
                                                                Text(
                                                                  productAddOnsList[index],
                                                                  style: TextStyle(
                                                                    fontSize: fontSizes.fontSize14,
                                                                    fontFamily: 'Poppins_semi_bold',
                                                                    fontWeight: FontWeight.w500,
                                                                    color: Colors.black
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height: h * 0.003,
                                                                  width: textWidth + w * 0.02,
                                                                  decoration: BoxDecoration(
                                                                    color: selectedMonthIndex == index
                                                                        ? Color(0xFF000000) // Highlight selected month
                                                                        : Colors.transparent, // No background for unselected months
                                                                    borderRadius: BorderRadius.only(
                                                                        topRight: Radius.circular(10),
                                                                        topLeft: Radius.circular(10)
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      // SizedBox(height: h * 0.02,),


                                    ],
                                  ),
                                ),


                                ListView.builder(
                                  itemCount: productAddOnsList.length,
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.04, top: h * 0.03),
                                          child: Text(productAddOnsList[index],
                                            style: TextStyle(
                                                fontSize: fontSizes.fontSize16,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins_semi_bold'
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: EdgeInsets.only(top: h * 0.02,left: w * 0.05, right: w * 0.05),
                                          // child: Container(
                                          //   height: itemHeight * innerItemCount + 1, // Calculate total height
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            padding: EdgeInsets.zero,
                                            physics: NeverScrollableScrollPhysics(),
                                            itemCount: index == 3 ? 1 : 3,
                                            itemBuilder: (BuildContext context, int rowIndex) {
                                              return InkWell(
                                                onTap: (){
                                                  setState(() {
                                                    addOnsFirstItemSelectedIndex = rowIndex;
                                                  });
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(bottom: h * 0.02), // Space between items
                                                  child: _buildAddOnsItem(addOnsFirstItemSelectedIndex, rowIndex, index),
                                                ),
                                              );
                                            },
                                          ),
                                          // ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(height: h * 0.01,),
                                Container(
                                  width: w * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Color(0xFFE8E8E8),
                                      width: 1
                                    )
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(width: w * 0.03,),
                                        SvgPicture.asset('assets/icons/delete_enable.svg'),
                                        SizedBox(width: w * 0.05,),
                                        Text('1',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontFamily: 'Supreme_bold',
                                            fontSize: fontSizes.fontSize24,
                                            color: Colors.black
                                          ),
                                        ),
                                        SizedBox(width: w * 0.02,),
                                        SvgPicture.asset('assets/icons/add.svg'),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: h * 0.06,),

                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF001FFF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02, bottom: h * 0.02),
                                          child: Text('Continue Shopping',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins_semi_bold',
                                                fontSize: fontSizes.fontSize16,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: w * 0.04, top: h * 0.02, bottom: h * 0.02),
                                          child: Text('₹899.01',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins_semi_bold',
                                                fontSize: fontSizes.fontSize16,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: h * 0.03,),






                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              )
          ),

        ],
      ),
    );
  }*/

  void productDescription(BuildContext context, Products products){
    AppFontSizes fontSizes = AppFontSizes(context);
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ), builder: (context){
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
        return AnimatedContainer(
          duration: Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          width: w,
          height: h * 0.8,
          /*constraints: BoxConstraints(
          maxHeight: _isDescriptionOpen ? h * 0.7 : 0, // Max height is 30% of screen
        ),*/
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                spreadRadius: 10.0,
              ),
            ],
          ),
          child: products == null
              ? Center(child: Text('No product data available'))
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(products.title ?? '',
                          style: TextStyle(
                              fontFamily: 'Supreme_bold',
                              fontSize: fontSizes.fontSize24,
                              fontWeight: FontWeight.w700,
                              color: Colors.black
                          ),
                        ),
                        SizedBox(
                          width: w * 0.8,
                          child: Text(products.shortDescription ?? '',
                            style: TextStyle(
                                fontFamily: 'Poppins_regular',
                                fontSize: fontSizes.fontSize12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF7B7B7B)
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: (){
                          setState(() {
                            _isDescriptionOpen = false;
                            Navigator.pop(context);
                          });
                        },
                        child: SvgPicture.asset('assets/icons/cross_gray_bg.svg')
                    )
                  ],
                ),
              ),

              SizedBox(height: h * 0.015,),

              Expanded(
                child: SingleChildScrollView(
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      FocusScope.of(context).unfocus(); // Unfocuses the text field when tapping outside
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            height: h * 0.2,
                            width: w,
                            /*child: Image.asset('assets/images/cheese_pizza_profile.png',
                              fit: BoxFit.fill,
                            ),*/
                            child: CachedNetworkImage(
                              imageUrl: ApiService.imageBaseUrl + (products.image ?? ''),
                              placeholder: (context, url) => Center(
                                child: SizedBox(
                                    height: h * 0.02,
                                    width: w * 0.04,
                                    child: CircularProgressIndicator(strokeWidth: 2.0,)
                                ),
                              ), // Show while loading
                              errorWidget: (context, url, error) => Icon(Icons.error), // Show on error
                              height: h * 0.138,
                              width: w * 0.29,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    /*Image.asset('assets/images/no_onion_garlic_icons.png',
                                  height: h * 0.017,
                                ),*/
                                    Text(
                                      '₹${products.price ?? 0.0}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontSize: fontSizes.fontSize12,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black
                                      ),
                                    ),
                                    SizedBox(width: w * 0.02,),
                                    Container(
                                      height: h * 0.015,
                                      width: w * 0.001,
                                      color: Color(0xFF606060),
                                    ),
                                    SizedBox(width: w * 0.02,),
                                    SvgPicture.asset('assets/icons/watch.svg',
                                        color: Color(0xFF606060)
                                    ),
                                    SizedBox(width: w * 0.01,),
                                    Text(products.makingTime ?? '',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontSize: fontSizes.fontSize12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF606060)
                                      ),
                                    ),
                                    SizedBox(width: w * 0.02,),
                                    Container(
                                      height: h * 0.015,
                                      width: w * 0.001,
                                      color: Color(0xFF606060),
                                    ),
                                    SizedBox(width: w * 0.02,),
                                    SvgPicture.asset('assets/icons/like_thumb.svg',
                                        color: Color(0xFF606060)
                                    ),
                                    SizedBox(width: w * 0.01,),
                                    Text('${products.peopleCountRate} likes',
                                      style: TextStyle(
                                          fontFamily: 'Poppins_regular',
                                          fontSize: fontSizes.fontSize12,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFF606060)
                                      ),
                                    ),

                                    SizedBox(width: w * 0.02,),
                                    Container(
                                      height: h * 0.015,
                                      width: w * 0.001,
                                      color: Color(0xFF606060),
                                    ),
                                    SizedBox(width: w * 0.02,),

                                    if(products.veg == true && products.nonVeg == false)
                                      SvgPicture.asset('assets/icons/veg_icon.svg',
                                        width: w * 0.05,
                                      )
                                    else if(products.veg == true && products.nonVeg == true)
                                      SvgPicture.asset('assets/icons/non_veg_icon.svg',
                                        width: w * 0.05,
                                      )
                                    else if (products.veg == true && products.jain == true)
                                        SvgPicture.asset('assets/icons/jain_icon.svg',
                                          width: w * 0.05,
                                        )
                                      else
                                        SvgPicture.asset('assets/icons/nong_icon.svg',
                                          width: w * 0.05,
                                        ),


                                    SizedBox(width: w * 0.01,),

                                  ],
                                ),

                                SizedBox(height: h * 0.012,),
                                Text(products.shortDescription ?? '',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontSize: fontSizes.fontSize12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF606060)
                                  ),
                                ),

                                SizedBox(height: h * 0.02,),
                                Container(
                                  height: h * 0.0285,
                                  width: w,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top: h * 0.002),
                                        child: SvgPicture.asset('assets/icons/cat_list_icon.svg',
                                          width: w * 0.02,
                                          height: h * 0.025,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      SizedBox(width: w * 0.04,),
                                      Container(
                                        height: h * 0.0285,
                                        width: w * 0.005,
                                        color: Color(0xFF606060),
                                      ),
                                      SizedBox(width: w * 0.01,),
                                      Expanded(
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: products.groupedVariations?.length ?? 0,
                                            itemBuilder: (context, index){
                                              TextStyle textStyle = TextStyle(
                                                fontSize: fontSizes.fontSize15,
                                                fontFamily: 'Poppins_semi_bold',
                                                fontWeight: FontWeight.w700,
                                                color: selectedMonthIndex == index ? Colors.black : Colors.grey, // Highlight selected item
                                              );

                                              // Calculate text width dynamically
                                              // double textWidth = calculateTextWidth(productAddOnsList[index], textStyle);
                                              String? keyName = products.groupedVariations?[index].type;
                                              double textWidth = calculateTextWidth(keyName ?? '', textStyle);

                                              return GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedMonthIndex = index; // Update the selected month index
                                                  });
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Container(
                                                    margin: EdgeInsets.zero, // Ensure no margin is applied
                                                    padding: EdgeInsets.zero,
                                                    child: Center(

                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            // productAddOnsList[index],
                                                            keyName ?? '',
                                                            style: TextStyle(
                                                                fontSize: fontSizes.fontSize14,
                                                                fontFamily: 'Poppins_semi_bold',
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.black
                                                            ),
                                                          ),
                                                          Container(
                                                            height: h * 0.003,
                                                            width: textWidth + w * 0.02,
                                                            decoration: BoxDecoration(
                                                              color: selectedMonthIndex == index
                                                                  ? Color(0xFF000000) // Highlight selected month
                                                                  : Colors.transparent, // No background for unselected months
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius.circular(10),
                                                                  topLeft: Radius.circular(10)
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // SizedBox(height: h * 0.02,),


                              ],
                            ),
                          ),


                          ListView.builder(
                            // itemCount: productAddOnsList.length,
                            // itemCount: products.groupedVariations?.addons?["addon"]?.length ?? 0,
                            itemCount: products.groupedVariations?.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              // String keyName = getKeyNameByIndex(products.groupedVariations!.addons!, index);
                              String? title = products.groupedVariations?[index].type;
                              return Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: w * 0.04, top: h * 0.03),
                                    child: Text(title ?? '',
                                      style: TextStyle(
                                          fontSize: fontSizes.fontSize16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins_semi_bold'
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(top: h * 0.02,left: w * 0.05, right: w * 0.05),
                                    // child: Container(
                                    //   height: itemHeight * innerItemCount + 1, // Calculate total height
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: products.groupedVariations?[index].variations?.length ?? 0,
                                      itemBuilder: (BuildContext context, int rowIndex) {
                                        /*GroupedVariations? variations = products.groupedVariations;
                                    Map<String, List<Addon>>? addOns = variations!.addons;
                                    Addon addOn = addOns[rowIndex];*/
                                        Variation variation = Variation();
                                        if(products.groupedVariations?[index].variations?[rowIndex] != null){
                                          variation = products.groupedVariations![index].variations![rowIndex];
                                        }

                                        String? type = products.groupedVariations?[index].variations?[rowIndex].selectionType;
                                        bool isLastItem = rowIndex == (products.groupedVariations?[index].variations?.length ?? 0) - 1;
                                        return InkWell(
                                          onTap: (){
                                            setState(() {
                                              addOnsFirstItemSelectedIndex = rowIndex;
                                            });
                                          },
                                          child: Padding(
                                            padding: isLastItem ? EdgeInsets.only(bottom: h * 0.00) : EdgeInsets.only(bottom: h * 0.02), // Space between items
                                            child: _buildAddOnsItem(variation, type ?? ''),
                                          ),
                                        );
                                      },
                                    ),
                                    // ),
                                  ),
                                  Container(
                                    width: w,
                                    height: h * 0.01,
                                    color: Color(0xFFF1F1F1),
                                  ),
                                ],
                              );
                            },
                          ),

                          SizedBox(height: h * 0.015,),


                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Preferences',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_semi_bold',
                                      fontWeight: FontWeight.w600,
                                      fontSize: fontSizes.fontSize16,
                                      color: Colors.black
                                  ),
                                ),
                                Text('Optional',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontWeight: FontWeight.w500,
                                      fontSize: fontSizes.fontSize12,
                                      color: Color(0xFF7B7B7B)
                                  ),
                                ),
                                SizedBox(height: h * 0.015,),
                                Container(
                                  height: h * 0.1,
                                  width: w,
                                  // alignment: Alignment.center,
                                  padding:
                                  EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFFF1F1F1),
                                    // color: Colors.red,
                                  ),
                                  child: TextFormField(
                                    maxLines: null, // Allows the text field to expand with multiple lines
                                    textAlignVertical: TextAlignVertical.top,
                                    cursorColor: Colors.red,
                                    decoration: InputDecoration(
                                      // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                      labelText: 'e.g. ring the bell after dropoff, leave next to the porch, call upon arrival, etc.',
                                      labelStyle: TextStyle(
                                        // Custom style for the label
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Poppins_regular',
                                        color: Color(0xFF606060), // Label color
                                      ),
                                      filled: true,
                                      fillColor: Color(0xFFF1F1F1),
                                      isCollapsed: true,
                                      border: InputBorder.none,
                                    ).copyWith(isDense: true),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.03,),
                          productQuantities[products.id ?? ''] == 0
                              ? GestureDetector(
                            onTap: (){
                              setState(() {
                                int updatedQuantity = (productQuantities[products.id ?? ''] ?? 0) + 1;
                                productQuantities[products.id ?? ''] = updatedQuantity;
                                print("Updated Quantity: $updatedQuantity");
                              });
                            },
                            child: Container(
                              width: w * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color(0xFFE8E8E8),
                                      width: 1
                                  )
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01),
                                  child: Text('ADD',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Supreme_bold',
                                        fontSize: fontSizes.fontSize24,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )

                              : Container(
                            width: w * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Color(0xFFE8E8E8),
                                    width: 1
                                )
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // SizedBox(width: w * 0.03,),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      setState(() {
                                        int updatedQuantity = (productQuantities[products.id ?? ''] ?? 0) - 1;
                                        productQuantities[products.id ?? ''] = updatedQuantity;
                                        print("Updated Quantity: $updatedQuantity");
                                      });
                                    },
                                    child: Container(
                                        height: h * 0.05,
                                        width: w * 0.1,
                                        child: Center(child: SvgPicture.asset(
                                            productQuantities[products.id ?? ''] == 1
                                                ? 'assets/icons/delete_enable.svg'
                                                : 'assets/icons/subtract.svg'
                                        ))
                                    ),
                                  ),
                                  SizedBox(width: w * 0.05,),
                                  Text(productQuantities[products.id ?? ''].toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Supreme_bold',
                                        fontSize: fontSizes.fontSize24,
                                        color: Colors.black
                                    ),
                                  ),
                                  SizedBox(width: w * 0.02,),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: (){
                                      setState(() {
                                        int updatedQuantity = (productQuantities[products.id ?? ''] ?? 0) + 1;
                                        productQuantities[products.id ?? ''] = updatedQuantity;
                                        print("Updated Quantity: $updatedQuantity");
                                      });
                                    },
                                    child: Container(
                                        height: h * 0.05,
                                        width: w * 0.13,
                                        child: Center(child: SvgPicture.asset('assets/icons/add.svg'))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: h * 0.06,),

                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF001FFF),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02, bottom: h * 0.02),
                                    child: Text('Continue Shopping',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins_semi_bold',
                                          fontSize: fontSizes.fontSize16,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: w * 0.04, top: h * 0.02, bottom: h * 0.02),
                                    child: Text('₹899.01',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontFamily: 'Poppins_semi_bold',
                                          fontSize: fontSizes.fontSize16,
                                          color: Colors.white
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: h * 0.03,),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
    });
  }

  Widget _ProductDescription(Products products){
    AppFontSizes fontSizes = AppFontSizes(context);
    return AnimatedContainer(
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      width: w,
      constraints: BoxConstraints(
        maxHeight: _isDescriptionOpen ? h * 0.7 : 0, // Max height is 30% of screen
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            spreadRadius: 10.0,
          ),
        ],
      ),
      child: products == null
          ? Center(child: Text('No product data available'))
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(products.title ?? '',
                      style: TextStyle(
                          fontFamily: 'Supreme_bold',
                          fontSize: fontSizes.fontSize24,
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(
                      width: w * 0.8,
                      child: Text(products.shortDescription ?? '',
                        style: TextStyle(
                            fontFamily: 'Poppins_regular',
                            fontSize: fontSizes.fontSize12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF7B7B7B)
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                    onTap: (){
                      setState(() {
                        _isDescriptionOpen = false;
                      });
                    },
                    child: SvgPicture.asset('assets/icons/cross_gray_bg.svg')
                )
              ],
            ),
          ),

          SizedBox(height: h * 0.015,),

          Expanded(
            child: SingleChildScrollView(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).unfocus(); // Unfocuses the text field when tapping outside
                },
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        height: h * 0.2,
                        width: w,
                        child: Image.asset('assets/images/cheese_pizza_profile.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: h * 0.02, left: w * 0.04, right: w * 0.04),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                /*Image.asset('assets/images/no_onion_garlic_icons.png',
                                  height: h * 0.017,
                                ),*/
                                Text(
                                  '₹${products.price ?? 0.0}',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontSize: fontSizes.fontSize12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black
                                  ),
                                ),
                                SizedBox(width: w * 0.02,),
                                Container(
                                  height: h * 0.015,
                                  width: w * 0.001,
                                  color: Color(0xFF606060),
                                ),
                                SizedBox(width: w * 0.02,),
                                SvgPicture.asset('assets/icons/watch.svg',
                                    color: Color(0xFF606060)
                                ),
                                SizedBox(width: w * 0.01,),
                                Text(products.makingTime ?? '',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontSize: fontSizes.fontSize12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF606060)
                                  ),
                                ),
                                SizedBox(width: w * 0.02,),
                                Container(
                                  height: h * 0.015,
                                  width: w * 0.001,
                                  color: Color(0xFF606060),
                                ),
                                SizedBox(width: w * 0.02,),
                                SvgPicture.asset('assets/icons/like_thumb.svg',
                                    color: Color(0xFF606060)
                                ),
                                SizedBox(width: w * 0.01,),
                                Text('${products.peopleCountRate} likes',
                                  style: TextStyle(
                                      fontFamily: 'Poppins_regular',
                                      fontSize: fontSizes.fontSize12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xFF606060)
                                  ),
                                ),

                                SizedBox(width: w * 0.02,),
                                Container(
                                  height: h * 0.015,
                                  width: w * 0.001,
                                  color: Color(0xFF606060),
                                ),
                                SizedBox(width: w * 0.02,),

                                if(products.veg == true && products.nonVeg == false)
                                  SvgPicture.asset('assets/icons/veg_icon.svg',
                                    width: w * 0.05,
                                  )
                                else if(products.veg == true && products.nonVeg == true)
                                  SvgPicture.asset('assets/icons/non_veg_icon.svg',
                                    width: w * 0.05,
                                  )
                                else if (products.veg == true && products.jain == true)
                                    SvgPicture.asset('assets/icons/jain_icon.svg',
                                      width: w * 0.05,
                                    )
                                  else
                                    SvgPicture.asset('assets/icons/nong_icon.svg',
                                      width: w * 0.05,
                                    ),


                                SizedBox(width: w * 0.01,),

                              ],
                            ),

                            SizedBox(height: h * 0.012,),
                            Text(products.shortDescription ?? '',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontSize: fontSizes.fontSize12,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF606060)
                              ),
                            ),

                            SizedBox(height: h * 0.02,),
                            Container(
                              height: h * 0.0285,
                              width: w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: h * 0.002),
                                    child: SvgPicture.asset('assets/icons/cat_list_icon.svg',
                                      width: w * 0.02,
                                      height: h * 0.025,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(width: w * 0.04,),
                                  Container(
                                    height: h * 0.0285,
                                    width: w * 0.005,
                                    color: Color(0xFF606060),
                                  ),
                                  SizedBox(width: w * 0.01,),
                                  Expanded(
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: products.groupedVariations?.length ?? 0,
                                        itemBuilder: (context, index){
                                          TextStyle textStyle = TextStyle(
                                            fontSize: fontSizes.fontSize15,
                                            fontFamily: 'Poppins_semi_bold',
                                            fontWeight: FontWeight.w700,
                                            color: selectedMonthIndex == index ? Colors.black : Colors.grey, // Highlight selected item
                                          );

                                          // Calculate text width dynamically
                                          // double textWidth = calculateTextWidth(productAddOnsList[index], textStyle);
                                          String? keyName = products.groupedVariations?[index].type;
                                          double textWidth = calculateTextWidth(keyName ?? '', textStyle);

                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedMonthIndex = index; // Update the selected month index
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                                              child: Container(
                                                margin: EdgeInsets.zero, // Ensure no margin is applied
                                                padding: EdgeInsets.zero,
                                                child: Center(

                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        // productAddOnsList[index],
                                                        keyName ?? '',
                                                        style: TextStyle(
                                                            fontSize: fontSizes.fontSize14,
                                                            fontFamily: 'Poppins_semi_bold',
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black
                                                        ),
                                                      ),
                                                      Container(
                                                        height: h * 0.003,
                                                        width: textWidth + w * 0.02,
                                                        decoration: BoxDecoration(
                                                          color: selectedMonthIndex == index
                                                              ? Color(0xFF000000) // Highlight selected month
                                                              : Colors.transparent, // No background for unselected months
                                                          borderRadius: BorderRadius.only(
                                                              topRight: Radius.circular(10),
                                                              topLeft: Radius.circular(10)
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // SizedBox(height: h * 0.02,),


                          ],
                        ),
                      ),


                      ListView.builder(
                        // itemCount: productAddOnsList.length,
                        // itemCount: products.groupedVariations?.addons?["addon"]?.length ?? 0,
                        itemCount: products.groupedVariations?.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          // String keyName = getKeyNameByIndex(products.groupedVariations!.addons!, index);
                          String? title = products.groupedVariations?[index].type;
                          return Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: w * 0.04, top: h * 0.03),
                                child: Text(title ?? '',
                                  style: TextStyle(
                                      fontSize: fontSizes.fontSize16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins_semi_bold'
                                  ),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.only(top: h * 0.02,left: w * 0.05, right: w * 0.05),
                                // child: Container(
                                //   height: itemHeight * innerItemCount + 1, // Calculate total height
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: products.groupedVariations?[index].variations?.length ?? 0,
                                  itemBuilder: (BuildContext context, int rowIndex) {
                                    /*GroupedVariations? variations = products.groupedVariations;
                                    Map<String, List<Addon>>? addOns = variations!.addons;
                                    Addon addOn = addOns[rowIndex];*/
                                    Variation variation = Variation();
                                    if(products.groupedVariations?[index].variations?[rowIndex] != null){
                                      variation = products.groupedVariations![index].variations![rowIndex];
                                    }

                                    String? type = products.groupedVariations?[index].variations?[rowIndex].selectionType;
                                    bool isLastItem = rowIndex == (products.groupedVariations?[index].variations?.length ?? 0) - 1;
                                    return InkWell(
                                      onTap: (){
                                        setState(() {
                                          addOnsFirstItemSelectedIndex = rowIndex;
                                        });
                                      },
                                      child: Padding(
                                        padding: isLastItem ? EdgeInsets.only(bottom: h * 0.00) : EdgeInsets.only(bottom: h * 0.02), // Space between items
                                        child: _buildAddOnsItem(variation, type ?? ''),
                                      ),
                                    );
                                  },
                                ),
                                // ),
                              ),
                              Container(
                                width: w,
                                height: h * 0.01,
                                color: Color(0xFFF1F1F1),
                              ),
                            ],
                          );
                        },
                      ),

                      SizedBox(height: h * 0.015,),


                      Padding(
                        padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Preferences',
                              style: TextStyle(
                                fontFamily: 'Poppins_semi_bold',
                                fontWeight: FontWeight.w600,
                                fontSize: fontSizes.fontSize16,
                                color: Colors.black
                              ),
                            ),
                            Text('Optional',
                              style: TextStyle(
                                  fontFamily: 'Poppins_regular',
                                  fontWeight: FontWeight.w500,
                                  fontSize: fontSizes.fontSize12,
                                  color: Color(0xFF7B7B7B)
                              ),
                            ),
                            SizedBox(height: h * 0.015,),
                            Container(
                              height: h * 0.1,
                              width: w,
                              // alignment: Alignment.center,
                              padding:
                              EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xFFF1F1F1),
                                // color: Colors.red,
                              ),
                              child: TextFormField(
                                maxLines: null, // Allows the text field to expand with multiple lines
                                textAlignVertical: TextAlignVertical.top,
                                cursorColor: Colors.red,
                                decoration: InputDecoration(
                                  // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
                                  floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                                  labelText: 'e.g. ring the bell after dropoff, leave next to the porch, call upon arrival, etc.',
                                  labelStyle: TextStyle(
                                    // Custom style for the label
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Poppins_regular',
                                    color: Color(0xFF606060), // Label color
                                  ),
                                  filled: true,
                                  fillColor: Color(0xFFF1F1F1),
                                  isCollapsed: true,
                                  border: InputBorder.none,
                                ).copyWith(isDense: true),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: h * 0.03,),
                      productQuantities[products.id ?? ''] == 0
                  ? GestureDetector(
                        onTap: (){
                          setState(() {
                            int updatedQuantity = (productQuantities[products.id ?? ''] ?? 0) + 1;
                            productQuantities[products.id ?? ''] = updatedQuantity;
                            print("Updated Quantity: $updatedQuantity");
                          });
                        },
                    child: Container(
                      width: w * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color(0xFFE8E8E8),
                              width: 1
                          )
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01),
                          child: Text('ADD',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Supreme_bold',
                                fontSize: fontSizes.fontSize24,
                                color: Colors.black
                            ),
                          ),
                        ),
                      ),
                    ),
                  )

                      : Container(
                        width: w * 0.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Color(0xFFE8E8E8),
                                width: 1
                            )
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // SizedBox(width: w * 0.03,),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: (){
                                  setState(() {
                                    int updatedQuantity = (productQuantities[products.id ?? ''] ?? 0) - 1;
                                    productQuantities[products.id ?? ''] = updatedQuantity;
                                    print("Updated Quantity: $updatedQuantity");
                                  });
                                },
                                child: Container(
                                  height: h * 0.05,
                                    width: w * 0.1,
                                    child: Center(child: SvgPicture.asset(
                                        productQuantities[products.id ?? ''] == 1
                                            ? 'assets/icons/delete_enable.svg'
                                            : 'assets/icons/subtract.svg'
                                    ))
                                ),
                              ),
                              SizedBox(width: w * 0.05,),
                              Text(productQuantities[products.id ?? ''].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'Supreme_bold',
                                    fontSize: fontSizes.fontSize24,
                                    color: Colors.black
                                ),
                              ),
                              SizedBox(width: w * 0.02,),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: (){
                                  setState(() {
                                    int updatedQuantity = (productQuantities[products.id ?? ''] ?? 0) + 1;
                                    productQuantities[products.id ?? ''] = updatedQuantity;
                                    print("Updated Quantity: $updatedQuantity");
                                  });
                                },
                                child: Container(
                                    height: h * 0.05,
                                    width: w * 0.13,
                                    child: Center(child: SvgPicture.asset('assets/icons/add.svg'))
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.06,),

                      Padding(
                        padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF001FFF),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: w * 0.04, top: h * 0.02, bottom: h * 0.02),
                                child: Text('Continue Shopping',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins_semi_bold',
                                      fontSize: fontSizes.fontSize16,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: w * 0.04, top: h * 0.02, bottom: h * 0.02),
                                child: Text('₹899.01',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Poppins_semi_bold',
                                      fontSize: fontSizes.fontSize16,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.03,),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*String getKeyNameByIndex(Map<String, List<Addon>> addons, int index) {
    if (index < 0 || index >= addons.keys.length) {
      throw RangeError("Index out of range");
    }

    // Convert the keys iterable to a list and access the key by index
    return addons.keys.toList()[index];
  }*/


  Widget _buildItems(BuildContext context, Products products){
    AppFontSizes fontSizes = AppFontSizes(context);

    int itemCount = 0;
    return Container(
      height: h * 0.144,
      width: w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
              color: Color(0xFFF1F1F1),
              width: 1
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: h * 0.015, left: w * 0.05, right: w * 0.05),
            child: Container(
              width: w * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('Cheese Pizza',
                  Text(products.title ?? '',
                    style: TextStyle(
                        fontSize: fontSizes.fontSize16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins_bold'
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text('₹${products.price}',
                    style: TextStyle(
                        fontSize: fontSizes.fontSize12,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins_regular',
                      color: Colors.black
                    ),
                  ),
                  // Text('Corn, Mozzarella Cheese, Mint Mayonnaise',
                  Container(
                    height: h * 0.038,
                    child: Text((products.shortDescription != 'null') ? products.shortDescription ?? '' : '',
                      style: TextStyle(
                          fontSize: fontSizes.fontSize12,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins_regular',
                          color: Color(0xFF606060)
                        // height: 1
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: h * 0.012,),
                  Row(
                    children: [
                      /*Image.asset('assets/Veg_icon.png',
                        width: w * 0.03,
                      ),*/
                      if(products.veg == true && products.nonVeg == false)
                        SvgPicture.asset('assets/icons/veg_icon.svg',
                          width: w * 0.03,
                        )
                      else if(products.veg == true && products.nonVeg == true)
                        SvgPicture.asset('assets/icons/non_veg_icon.svg',
                          width: w * 0.03,
                        )
                      else if (products.veg == true && products.jain == true)
                        SvgPicture.asset('assets/icons/jain_icon.svg',
                          width: w * 0.03,
                        )
                      else
                        SvgPicture.asset('assets/icons/nong_icon.svg',
                          width: w * 0.03,
                        ),

                      /*products.type == 'veg' ?
                      SvgPicture.asset('assets/icons/veg_icon.svg',
                        width: w * 0.03,
                      )
                      : SvgPicture.asset('assets/icons/non_veg_icon.svg',
                        width: w * 0.03,
                        ),*/
                      SizedBox(width: w * 0.01,),
                      Text(products.starRating.toString() ?? '0.0',
                        style: TextStyle(
                            fontSize: fontSizes.fontSize12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins_regular',
                            color: Color(0xFF606060)
                          // height: 1
                        ),
                      ),
                      SizedBox(width: w * 0.01,),
                      /*Image.asset('assets/star_new.png',
                        width: w * 0.03,
                      ),*/
                      SvgPicture.asset('assets/icons/Star.svg',
                        width: w * 0.03,
                      ),
                      SizedBox(width: w * 0.01,),
                      Text('(${products.peopleCountRate})',
                        style: TextStyle(
                            fontSize: fontSizes.fontSize12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins_regular',
                            color: Color(0xFF606060)
                          // height: 1
                        ),
                      ),
                      SizedBox(width: w * 0.01,),
                      Container(
                        height: h * 0.004,
                        width: w * 0.008,
                        color: Colors.black,
                      ),
                      SizedBox(width: w * 0.01,),
                      /*Image.asset('assets/watch_new.png',
                        width: w * 0.03,
                      ),*/
                      SvgPicture.asset('assets/icons/time_icon.svg',
                        width: w * 0.03,
                      ),
                      // SizedBox(width: w * 0.01,),
                      Text(products.makingTime ?? '',
                        style: TextStyle(
                            fontSize: fontSizes.fontSize12,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins_regular',
                            color: Color(0xFF606060)
                          // height: 1
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)
                ), // Ensure the same radius is applied to the image
                /*child: Image.asset(
                  'assets/images/cheese_pizza_profile.png',
                  height: h * 0.138,
                  width: w * 0.29,
                  fit: BoxFit.fill,
                ),*/
                child: CachedNetworkImage(
                  imageUrl: ApiService.imageBaseUrl + (products.image ?? ''),
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: h * 0.02,
                        width: w * 0.04,
                        child: CircularProgressIndicator(strokeWidth: 2.0,)
                    ),
                  ), // Show while loading
                  errorWidget: (context, url, error) => Icon(Icons.error), // Show on error
                  height: h * 0.138,
                  width: w * 0.29,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 0, // Align to the top
                right: 0, // Align to the right
                child: Padding(
                  padding: EdgeInsets.only(right: w * 0.01, top: h * 0.008), // Add padding if you want some space from the edge
                  child: GestureDetector(
                    onTap: (){
                      apiService.saveProduct(products.id ?? '', AppStrings.RESTAURANT_ID, context).then((value) {

                      });
                    },
                    child: SvgPicture.asset(
                      'assets/icons/favourite_icon.svg',
                      width: w * 0.06, // Adjust size of the bookmark image
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: productQuantities[products.id ?? ''] == 0,
                child: Positioned(
                  bottom: 0, // Align to the top
                  right: 0, // Align to the right
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        if (products.groupedVariations?.isNotEmpty ?? false) {
                          productDescription(context, products);
                        }else {
                          print("Product ID: ${products.id}");
                          int updatedQuantity = (productQuantities[products
                              .id!] ?? 0) + 1;
                          productQuantities[products.id!] = updatedQuantity;
                          print("Updated Quantity: $updatedQuantity");

                          /*if ((productQuantities[products.id] ?? 0) > 0) {
                          productQuantities[products.id ?? ''] = (productQuantities[products.id] ?? 0) + 1;

                        }*/
                          // itemCount++;
                          print(productQuantities[products.id ?? '']);
                        }
                      });

                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: w * 0.005, bottom: h * 0.002), // Add padding if you want some space from the edge
                      /*child: Image.asset(
                        'assets/ract_add.png',
                        width: w * 0.1, // Adjust size of the bookmark image
                      ),*/
                      child: SvgPicture.asset(
                        'assets/icons/add.svg',
                        width: w * 0.1, // Adjust size of the bookmark image
                      ),
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: (productQuantities[products.id ?? ''] ?? 0) > 0,
                child: Positioned(
                  bottom: h * 0.01, // Align to the top
                  right: w * 0.01, // Align to the right
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: w * 0.04,),
                        GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              setState(() {
                                int updatedQuantity = (productQuantities[products.id!] ?? 0) - 1;
                                productQuantities[products.id!] = updatedQuantity;
                                print("Updated Quantity: $updatedQuantity");
                                /*if ((productQuantities[products.id] ?? 0) > 0) {
                                  productQuantities[products.id ?? ''] = (productQuantities[products.id] ?? 0) - 1;

                                }*/
                                /*if(itemCount > 1){
                                  itemCount--;
                                }*/
                              });
                            },
                            child: Container(
                              height: h * 0.03,
                              child: SvgPicture.asset(
                                  (productQuantities[products.id ?? ''] ?? 0) > 1 ? 'assets/icons/subtract.svg' : 'assets/icons/delete_black.svg'),
                            )
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.01, bottom: h * 0.01),
                          child: Text(productQuantities[products.id ?? ''].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: fontSizes.fontSize16,
                                fontFamily: 'Supreme_bold'
                            ),
                          ),
                        ),
                        GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              setState(() {
                                if (products.groupedVariations?.isNotEmpty ?? false) {
                                  productDescription(context, products);
                                }else {
                                  int updatedQuantity = (productQuantities[products
                                      .id!] ?? 0) + 1;
                                  productQuantities[products.id!] =
                                      updatedQuantity;
                                  print("Updated Quantity: $updatedQuantity");
                                }
                                /*if ((productQuantities[products.id] ?? 0) > 0) {
                                  productQuantities[products.id ?? ''] = (productQuantities[products.id] ?? 0) + 1;

                                }*/
                                // itemCount++;
                              });
                            },
                            child: Container(
                                height: h * 0.03,
                                child: SvgPicture.asset('assets/icons/add_black.svg'))
                        ),
                        SizedBox(width: w * 0.04,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }


  Widget _buildAddOnsItem(Variation variation, String type){
    // bool isSelected = rowIndex == selectedIndex;
    // bool isAddClicked = _addOnClickedStatus[rowIndex] ?? false;
    if (type == 'radio') {
      return _buildRadioItem(variation);
    }else if(type == 'checkbox'){
      return _buildCheckBoxItem(variation);
    }else {
      return _buildAddSubtractItem(variation);
    }
    // return SizedBox.shrink();
  }

  Widget _buildRadioItem(Variation variation){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    /*child: Image.asset('assets/images/pizza_base.png',
                      height: h * 0.05,
                    ),*/
                    child: CachedNetworkImage(
                      imageUrl: ApiService.imageBaseUrl + (variation.image ?? ''),
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                            height: h * 0.02,
                            width: w * 0.04,
                            child: CircularProgressIndicator(strokeWidth: 2.0,)
                        ),
                      ), // Show while loading
                      errorWidget: (context, url, error) => Icon(Icons.error), // Show on error
                      height: h * 0.055,
                      width: w * 0.12,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: w * 0.025,),
                  Text(variation.name ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Pippins_semi_bold',
                        color: Colors.black
                    ),
                  ),

                ],
              ),
              SvgPicture.asset('assets/icons/circle_unselected.svg'
              )
              /*SvgPicture.asset(
                  isSelected
                      ? 'assets/icons/circle_selected.svg'
                      : 'assets/icons/circle_unselected.svg'
              )*/
            ],
          ),
          SizedBox(height: h * 0.015,),
          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          )
        ],
      ),
    );
  }

  Widget _buildAddSubtractItem(Variation variation){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    /*child: Image.asset('assets/images/pepsi.png',
                      height: h * 0.05,
                    ),*/
                    child: CachedNetworkImage(
                      imageUrl: ApiService.imageBaseUrl + (variation.image ?? ''),
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                            height: h * 0.02,
                            width: w * 0.04,
                            child: CircularProgressIndicator(strokeWidth: 2.0,)
                        ),
                      ), // Show while loading
                      errorWidget: (context, url, error) => Icon(Icons.error), // Show on error
                      height: h * 0.055,
                      width: w * 0.12,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: w * 0.025,),
                  Text(variation.name ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Pippins_semi_bold',
                        color: Colors.black
                    ),
                  ),
                  Text('+ ${variation.price}/-',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Pippins_regular',
                        color: Color(0xFF7B7B7B)
                    ),
                  ),

                ],
              ),
              // I want to show and hide below things on every item click
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        // _addOnClickedStatus[rowIndex] =
                        // !_addOnClickedStatus[rowIndex]!;
                        // print(_addOnClickedStatus);
                      });
                    },
                    child: Visibility(
                      // visible: !isAddClicked,
                      visible: true,
                      child: SvgPicture.asset('assets/icons/plus_white_bg.svg'
                      ),
                    ),
                  ),

                  Visibility(
                    // visible: isAddClicked,
                    visible: false,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.02, top: h * 0.005, bottom: h * 0.005),
                                child: SvgPicture.asset('assets/icons/delete_black.svg'),
                              )
                          ),
                          SizedBox(width: w * 0.02,),
                          Text('1',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: fontSizes.fontSize12,
                                fontFamily: 'Pippins_regular',
                                color: Colors.black
                            ),
                          ),
                          SizedBox(width: w * 0.02,),
                          Container(
                              child: Padding(
                                padding: EdgeInsets.only(right: w * 0.02, top: h * 0.005, bottom: h * 0.005),
                                child: SvgPicture.asset('assets/icons/add_small.svg'),
                              )
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
          SizedBox(height: h * 0.015,),
          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          )
        ],
      ),
    );
  }

  Widget _buildCheckBoxItem(Variation variation){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    /*child: Image.asset('assets/images/oregano.png',
                      height: h * 0.05,
                    ),*/
                    child: CachedNetworkImage(
                      imageUrl: ApiService.imageBaseUrl + (variation.image ?? ''),
                      placeholder: (context, url) => Center(
                        child: SizedBox(
                            height: h * 0.02,
                            width: w * 0.04,
                            child: CircularProgressIndicator(strokeWidth: 2.0,)
                        ),
                      ), // Show while loading
                      errorWidget: (context, url, error) => Icon(Icons.error), // Show on error
                      height: h * 0.055,
                      width: w * 0.12,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: w * 0.025,),
                  Text(variation.name ?? '',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Pippins_semi_bold',
                        color: Colors.black
                    ),
                  ),

                ],
              ),
              SvgPicture.asset('assets/icons/check_black_selected.svg')
              /*SvgPicture.asset(
                  isSelected
                      ? 'assets/icons/circle_selected.svg'
                      : 'assets/icons/circle_unselected.svg'
              )*/
            ],
          ),
          SizedBox(height: h * 0.015,),
          Container(
            width: w,
            height: h * 0.001,
            color: Color(0xFFF1F1F1),
          )
        ],
      ),
    );
  }

  Widget _buildInstructionItem(){
    return Container(
      height: h * 0.1,
      width: w,
      // alignment: Alignment.center,
      padding:
      EdgeInsets.only(left: w * 0.03, bottom: h * 0.005),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFFF1F1F1),
        // color: Colors.red,
      ),
      child: TextFormField(
        maxLines: null, // Allows the text field to expand with multiple lines
        textAlignVertical: TextAlignVertical.top,
        cursorColor: Colors.red,
        decoration: InputDecoration(
          // prefixIcon: SvgPicture.asset('assets/icons/search_gray.svg',),
          floatingLabelBehavior:
          FloatingLabelBehavior.never,
          labelText: 'e.g. ring the bell after dropoff, leave next to the porch, call upon arrival, etc.',
          labelStyle: TextStyle(
            // Custom style for the label
            fontSize: 14,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins_regular',
            color: Color(0xFF606060), // Label color
          ),
          filled: true,
          fillColor: Color(0xFFF1F1F1),
          isCollapsed: true,
          border: InputBorder.none,
        ).copyWith(isDense: true),
      ),
    );
  }

  Widget _buildPagerItems(String assetPath){
    return Container(
      width: w * 0.67,
      height: h * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          assetPath,
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildPromotionItems(String message, String code, String type){
    AppFontSizes fontSizes = AppFontSizes(context);
    return type == 'double_message' ?Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: fontSizes.fontSize12,
              fontFamily: 'Supreme_bold'
          ),
        ),
        SizedBox(width: w * 0.02,),
        Container(
          height: h * 0.015,
          width: w * 0.002,
          color: Colors.black,
        ),
        SizedBox(width: w * 0.02,),
        Text(code,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: fontSizes.fontSize12,
              fontFamily: 'Supreme_bold'
          ),
        ),
      ],
    ) : Text(message,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: fontSizes.fontSize12,
          fontFamily: 'Supreme_bold'
      ),
    );
  }

  Widget buildIndicator(int imageCount) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: imageCount, // The number of images in the carousel
      effect: ScrollingDotsEffect(
        dotWidth: 6,
        dotHeight: 6,
        activeDotColor: Color(0xFFB0B0B0), // Active dot color
        dotColor: Colors.white, // Inactive dot color
      ),
    );
  }


  void _showAddressPopup(BuildContext context){
    AppFontSizes fontSizes = AppFontSizes(context);
    int selectedIndex = 0;
    showModalBottomSheet(
      // isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (BuildContext context){
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return SingleChildScrollView(
                  child: Container(
                    width: w,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: h * 0.02,),
                        Container(
                          width: w * 0.35,
                          height: h * 0.005,
                          decoration: BoxDecoration(
                              color: Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(10)
                            // color: Colors.black
                          ),
                        ),



                        SizedBox(height: h * 0.03,),
                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Choose Address',
                                style: TextStyle(
                                    fontFamily: 'Supreme_bold',
                                    fontWeight: FontWeight.w700,
                                    fontSize: fontSizes.fontSize24,
                                    color: Colors.black
                                ),
                              ),
                              Text('Choose Address for delivery',
                                style: TextStyle(
                                    fontFamily: 'Poppins_regular',
                                    fontWeight: FontWeight.w500,
                                    fontSize: fontSizes.fontSize14,
                                    color: Color(0xFF939393)
                                ),
                              ),
                              SizedBox(height: h * 0.03,),

                              ListView.builder(
                                itemCount: 4,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, index){
                                  return InkWell(
                                    onTap: (){
                                      setModalState((){
                                        selectedIndex = index;
                                      });
                                    },
                                      child: _buildAddressItem(index, selectedIndex)
                                  );
                                  }
                              ),
                              SizedBox(height: h * 0.02,),

                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Color(0xFFF1F1F1)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.01, bottom: h * 0.01),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset('assets/icons/add_black.svg'),
                                          SizedBox(width: w * 0.02,),
                                          Text('Add new address',
                                            style: TextStyle(
                                                fontFamily: 'Poppins_semi_bold',
                                                fontWeight: FontWeight.w600,
                                                fontSize: fontSizes.fontSize12,
                                                color: Colors.black
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: h * 0.02,),


                            ],
                          ),
                        ),

                        Container(
                          height: h * 0.001,
                          width: w,
                          color: Color(0xFFF1F1F1),
                        ),

                        SizedBox(height: h * 0.02,),

                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                          child: Container(
                            width: w,
                            height: h * 0.05,
                            decoration: BoxDecoration(
                              color: Color(0xFF001FFF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text('Update',
                                style: TextStyle(
                                  fontSize: fontSizes.fontSize16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Poppins_semi_bold',
                                  color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: h * 0.02,),

                        Padding(
                          padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                          child: Container(
                            width: w,
                            height: h * 0.05,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text('Cancel',
                                style: TextStyle(
                                    fontSize: fontSizes.fontSize16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins_semi_bold',
                                    color: Colors.black
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.02,),
                      ],
                    ),

                  ),
                );
              }
          );
        }
    );
  }

  Widget _buildAddressItem(int index, int selectedIndex){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      height: h * 0.05,
      width: w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: w * 0.07,
                  child: SvgPicture.asset('assets/icons/map_pin_small.svg')
              ),
              // SizedBox(width: w * 0.02,),
              Text('Yatendra',
                style: TextStyle(
                    fontFamily: 'Poppins_regular',
                    fontWeight: FontWeight.w600,
                    fontSize: fontSizes.fontSize14,
                    color: Colors.black
                ),
              ),
            ],
          ),
          SvgPicture.asset(
            selectedIndex == index
                ? 'assets/icons/tick_selected.svg'
                : 'assets/icons/tick_unselected.svg', // Different icon for unselected
          ),

          // I want to change below Image on item click
          // SvgPicture.asset('assets/icons/tick_selected.svg'),
        ],
      ),
    );
  }

}

// Sample categories list
List<String> categories = [
  'Drink',
  'Fast Food',
  'Ice Cream',
  'Desert',
  'North Indian',
  'South Indian',
  'Snacks',
  'Healthy',
  'Breakfast',
];

List<String> productAddOns = [
  'Base',
  'Add-ons',
  'Sprinklers',
  'Preferences',
];
