import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Models/searchModel.dart';
import 'package:living_menu_mobile/network/apiService.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../Constants/appFontSizes.dart';
import '../Constants/appStrings.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search>{
  late double w, h;
  bool _isDescriptionOpen = false;
  bool _isRecentSearchVisible = true;
  int selectedCatIndex = 0;
  int selectedMonthIndex = 0;
  int addOnsFirstItemSelectedIndex = 0;
  Map<int, bool> _addOnClickedStatus = {};
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  ApiService apiService = ApiService();
  late List<SearchProduct> searchProduct;
  bool _isLoading = false;

  final List<String> _items = [
    'Tandoori Roti Plane',
    'Tandoori Roti Butter',
    'Tawa Roti Plane',
    'Tawa Roti Butter',
    'Naan',
    'Laccha Paratha',
    'Matar Paneer',
    'Palak Paneer'
  ];
  List<String> _filteredItems = [];

  double calculateTextWidth(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width;
  }

  @override
  void initState() {
    super.initState();
    _filteredItems = _items; // Initially, display all items
  }

  void _filterItems(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredItems = _items;
      });
    } else {
      setState(() {
        _filteredItems = _items
            .where((item) =>
            item.toLowerCase().contains(query.toLowerCase())) // Case-insensitive
            .toList();
      });
    }
  }

  List<String> productAddOns = [
    'Base',
    'Add-ons',
    'Sprinklers',
    'Preferences',
  ];

  Future<void> getSearchItems(String text) async {
    apiService.searchProduct(context, text, AppStrings.RESTAURANT_ID).then((onValue){
      setState(() {
        searchProduct = onValue;
        print('Search Products--------> ${searchProduct}');
        _isRecentSearchVisible = false;
        _isLoading = false;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);

    List<String> category = [
      'Starter', 'Ice Cream', 'Desert', 'North Indian', 'South Indian', 'Fast Food', 'Chicken', 'Fish', 'Sea Foods', 'Italian Food', 'Chinese Food', 'Dec'
    ];

    List<String> categoryList = List.from(category);
    List<String> productAddOnsList = List.from(productAddOns);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: _isLoading,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h * 0.07),
                // Back Button and Search Bar
                Padding(
                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                  child: Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01, right: w * 0.03),
                          child: SvgPicture.asset('assets/icons/header_back.svg'),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Container(
                              height: h * 0.06,
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F1F1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: w * 0.05),
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: _filterItems,
                                  focusNode: _focusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  textInputAction: TextInputAction.done,
                                  onSubmitted: (text) {
                                    // This is triggered when the "Done" button is pressed
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    getSearchItems(text);
                                    _focusNode.unfocus(); // Optionally dismiss the keyboard
                                  },
                                  onEditingComplete: () {
                                    // Optionally handle the action when editing is complete
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    getSearchItems(_searchController.text);
                                    _focusNode.unfocus(); // Optionally dismiss the keyboard
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(right: w * 0.0),
                                      child: IconButton(
                                        onPressed: () {
                                          _searchController.clear();
                                          _filterItems('');
                                        },
                                        icon: SvgPicture.asset(
                                          'assets/icons/search_cross.svg',
                                          height: h * 0.02,
                                          width: h * 0.02,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    labelText: 'Search',
                                    border: InputBorder.none,
                                    hintText: '',
                                    floatingLabelBehavior: FloatingLabelBehavior.never,
                                    contentPadding: EdgeInsets.symmetric(vertical: h * 0.02),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.02),
                Container(
                  height: h * 0.001,
                  width: w,
                  color: Color(0xFFF1F1F1),
                ),
                SizedBox(height: h * 0.02),
                Visibility(
                  visible: _isRecentSearchVisible,
                  child: Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                    child: Text('Recent Searches',
                      style: TextStyle(
                        fontSize: fontSizes.fontSize14,
                        fontFamily: 'Poppins_regular',
                        fontWeight: FontWeight.w600,
                        color: Colors.black
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_isRecentSearchVisible,
                  child: Padding(
                    padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                    child: Text('Search Results',
                      style: TextStyle(
                          fontSize: fontSizes.fontSize24,
                          fontFamily: 'Supreme_bold',
                          fontWeight: FontWeight.w700,
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                // Search Results
                Visibility(
                  visible: _isRecentSearchVisible,
                  child: Expanded(
                    child: _filteredItems.isEmpty
                        ? Center(child: Text('No items found.')) : Padding(
                          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: _filteredItems.length,
                            itemBuilder: (context, index) {
                                return _buildRecentSearchItems(_filteredItems[index]);
                              },
                          ),
                        ),
                  ),
                ),

                Visibility(
                  visible: !_isRecentSearchVisible,
                  child: Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: h * 0.02,left: w * 0.05, right: w * 0.05),
                      // child: Container(
                      //   height: itemHeight * innerItemCount + 1, // Calculate total height
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: searchProduct.length,
                        itemBuilder: (BuildContext context, int rowIndex) {
                          SearchProduct product = searchProduct[rowIndex];
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
                              child: _buildSearchItems(context, product),
                            ),
                          );
                        },
                      ),
                      // ),
                    ),
                  ),
                ),
              ],
            ),


            Positioned(
                bottom: 0,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 600),
                  curve: Curves.easeInOut,
                  width: w,
                  constraints: BoxConstraints(
                    maxHeight: _isDescriptionOpen ? h * 0.8 : 0, // Max height is 30% of screen
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
      ),
    );
  }

  Widget _buildRecentSearchItems(String itemName){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      child: Column(
        children: [
          SizedBox(height: h * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(itemName,
                style: TextStyle(
                    fontSize: fontSizes.fontSize14,
                    fontFamily: 'Poppins_regular',
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                ),
              ),
              SvgPicture.asset('assets/icons/arrow_insert.svg')
            ],
          ),
          SizedBox(height: h * 0.02),
          Container(
            height: h * 0.001,
            width: w,
            color: Color(0xFFF1F1F1),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchItems(BuildContext context, SearchProduct product){
    AppFontSizes fontSizes = AppFontSizes(context);
    return Container(
      height: h * 0.138,
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
                  Text(product.title ?? '',
                    style: TextStyle(
                        fontSize: fontSizes.fontSize16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins_bold'
                    ),
                  ),
                  Container(
                    height: h * 0.045,
                    child: Text(product.shortDescription ?? '',
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
                      SvgPicture.asset('assets/icons/veg_icon.svg',
                        width: w * 0.03,
                      ),
                      SizedBox(width: w * 0.01,),
                      Text('4.3',
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
                      Text('(30K+)',
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
                      Text('28 min',
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
                child: Image.asset(
                  'assets/images/cheese_pizza_profile.png',
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
                  child: SvgPicture.asset(
                    'assets/icons/favourite_icon.svg',
                    width: w * 0.06, // Adjust size of the bookmark image
                  ),
                ),
              ),

              Positioned(
                bottom: 0, // Align to the top
                right: 0, // Align to the right
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
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAddOnsItem(int selectedIndex, int rowIndex, int index){
    bool isSelected = rowIndex == selectedIndex;
    bool isAddClicked = _addOnClickedStatus[rowIndex] ?? false;
    if (index == 0) {
      return _buildRadioItem(isSelected);
    }else if(index == 1){
      return _buildAddSubtractItem();
    }else if(index == 2){
      return _buildCheckBoxItem();
    }else {
      return _buildInstructionItem();
    }
    // return SizedBox.shrink();
  }

  Widget _buildRadioItem(bool isSelected){
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
                    child: Image.asset('assets/images/pizza_base.png',
                      height: h * 0.05,
                    ),
                  ),
                  SizedBox(width: w * 0.025,),
                  Text('Plane Base',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Pippins_semi_bold',
                        color: Colors.black
                    ),
                  ),

                ],
              ),
              SvgPicture.asset(
                  isSelected
                      ? 'assets/icons/circle_selected.svg'
                      : 'assets/icons/circle_unselected.svg'
              )
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

  Widget _buildAddSubtractItem(){
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
                    child: Image.asset('assets/images/pepsi.png',
                      height: h * 0.05,
                    ),
                  ),
                  SizedBox(width: w * 0.025,),
                  Text('Pepsi',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: fontSizes.fontSize12,
                        fontFamily: 'Pippins_semi_bold',
                        color: Colors.black
                    ),
                  ),
                  Text('+ 15/-',
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

  Widget _buildCheckBoxItem(){
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
                    child: Image.asset('assets/images/oregano.png',
                      height: h * 0.05,
                    ),
                  ),
                  SizedBox(width: w * 0.025,),
                  Text('Oregano (x2)',
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

}
