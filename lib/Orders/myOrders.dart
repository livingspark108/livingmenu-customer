import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:living_menu_mobile/Constants/animatedRoute.dart';
import 'package:living_menu_mobile/Constants/appFontSizes.dart';
import 'package:living_menu_mobile/Models/ordersModel.dart';
import 'package:living_menu_mobile/Orders/orderHistory.dart';
import 'package:living_menu_mobile/network/apiService.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../Constants/appStrings.dart';
// import 'package:livingmenuapp/orderhistory/OrderSummery.dart';
// import 'package:livingmenuapp/Support.dart';

class Myorders extends StatefulWidget {
  const Myorders({Key? key}) : super(key: key);

  @override
  State<Myorders> createState() => _MyordersState();
}

class _MyordersState extends State<Myorders> {
  late double h, w;
  late double fontSize12;
  late double fontSize13;
  late double fontSize14;
  late double fontSize15;
  late double fontSize16;
  late double fontSize18;
  late double fontSize20;
  late double fontSize48;
  bool _isLoading = false;

  ApiService apiService = ApiService();
  Orders allOrders = Orders();
  List<Apr> currentOrders = [];

  int selectedMonthIndex = 0;
  String selectedMonth = "Dec";




  List<String> months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  // Dummy data for orders (replace this with your actual data)
  List<OrderData> orders = [
    OrderData(
        date: '25/12/23',
        time: '14:45',
        items: '2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, ',
        amount: '1,000'),
    OrderData(
        date: '25/12/23',
        time: '14:45',
        items: '2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, ',
        amount: '1,000'),
    OrderData(
        date: '25/12/23',
        time: '14:45',
        items: '2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, ',
        amount: '1,000'),
    OrderData(
        date: '25/12/23',
        time: '14:45',
        items: '2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, ',
        amount: '1,000'),
    // Add more orders as needed
  ];

  @override
  void initState() {
    super.initState();
    // Set the default selected month to the first one ("This Month")
    setState(() {
      _isLoading = true;
    });
    selectedMonthIndex = 0;


    DateTime now = DateTime.now();
    selectedMonth = DateFormat('MMM').format(now);

    // Find the index of the current month
    int currentMonthIndex = now.month - 1;
    // currentMonth = now.mon

    // Create a list of past months starting from the current one
    List<String> monthList = [];
    for (int i = currentMonthIndex; i >= 0; i--) {
      monthList.add(months[i]);
    }

    // final order = currentOrders[index];

    apiService.getAllOrders().then((value) {
      setState(() {
        allOrders = value;

        // if(allOrders.data)
        print('ProductCat---------------: ${value}');
        print('ProductMessage---------------: ${allOrders.message}');
        // Orders orders = Orders.fromJson(allOrders.data as Map<String, dynamic>);
        currentOrders = allOrders.data?.getOrdersForMonth(selectedMonth) ?? [];
        /*try {
          if (allOrders.data != null && allOrders.data is Map && (allOrders.data as Map).isNotEmpty) {
            currentOrders = allOrders.data!.getOrdersForMonth(selectedMonth) ?? [];
          } else {
            currentOrders = [];
          }
        } catch (e) {
          currentOrders = [];
          _isLoading = false;
          print("Error handling orders: $e");
        }*/
        print('CURRENT_MONTH_DATA---------------- $currentOrders');
        print('CURRENT_MONTH_DATA---------------- ${currentOrders[0].id}');
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);
    fontSize12 = w * 0.029;
    fontSize13 = w * 0.032;
    fontSize14 = w * 0.034;
    fontSize15 = w * 0.0365;
    fontSize16 = w * 0.0385;
    fontSize18 = w * 0.0435;
    fontSize20 = w * 0.0485;
    fontSize48 = w * 0.122;

    DateTime now = DateTime.now();
    String currentMonth = DateFormat('MMM').format(now); // Get current month in abbreviated form, e.g., 'Sep'




    // Find the index of the current month
    int currentMonthIndex = now.month - 1;
    // currentMonth = now.mon

    // Create a list of past months starting from the current one
    List<String> monthList = [];
    for (int i = currentMonthIndex; i >= 0; i--) {
      monthList.add(months[i]);
    }

    // Replace the current month with 'This Month'
   /* if (monthList.isNotEmpty) {
      monthList[0] = 'This Month';
    }*/

    return Scaffold(
      backgroundColor: Colors.white,
      body: Skeletonizer(
        enabled: _isLoading,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 0.06, left: w * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('assets/icons/header_back.svg'),
                      /*child: Image.asset(
                        'assets/Vector (8).png',
                        width: 24,
                        height: 24,
                      ),*/
                    ),
                    SizedBox(height: h * 0.02,),
                    Text('Orders',
                      style: TextStyle(
                          fontFamily: 'Supreme_bold',
                          fontWeight: FontWeight.w700,
                          fontSize: fontSizes.fontSize24
                      ),
                    ),
                  ],
                ),
              ),


              Padding(
                padding: EdgeInsets.only(top: h * 0.015, left: w * 0.04, right: w * 0.04),
                child: SizedBox(
                  height: h * 0.05, // Height for the month selection
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: monthList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedMonthIndex = index;
                            selectedMonth = monthList[index];
                            currentOrders = allOrders.data?.getOrdersForMonth(selectedMonth) ?? [];
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedMonthIndex == index
                                  ? Color(0xFFDADADA) // Highlight selected month
                                  : Colors.transparent, // No background for unselected months
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                            child: Center(
                              child: Text(
                                monthList[index],
                                style: TextStyle(
                                  // fontSize: 15,
                                  fontSize: fontSize15,
                                  fontFamily: 'DM_Sans_medium',
                                  fontWeight: FontWeight.w700,
                                  color: selectedMonthIndex == index
                                      ? Colors.black // Change color for the selected month
                                      : Colors.black, // Lighter color for unselected
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: currentOrders.length,
                  itemBuilder: (context, index) {
                    // OrderData order = orders[index];
                    final order = currentOrders[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, AnimatedRoute.createRouteRightToLeft(OrderHistory()));
                      },
                      child: buildOrderCard(order, index),
                    );
                    // return buildOrderCard(order);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOrderCard(Apr order, int index) {
    AppFontSizes fontSizes = AppFontSizes(context);
    String? orderDateTime = order.createdAt;
    String items = '2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, 2*Burger, 1* Pizza, ';
    DateTime dateTime;
    String formattedDate;
    String formattedTime;
    if(orderDateTime != null) {
      DateTime dateTime = DateTime.parse(orderDateTime);
      // Format the date to "19/12/23"
      formattedDate = DateFormat("dd/MM/yy").format(dateTime);
      // Format the time to "15:36"
      formattedTime = DateFormat("HH:mm").format(dateTime);
    }else {
      formattedDate = 'No Date';
      formattedTime = 'No Time';
    }


    return Padding(
      padding: EdgeInsets.only(left: w * 0.03, right: w * 0.03, top: h * 0.00),
      child: Container(
        height: h * 0.24,
        // width: w * 0.90,
        margin: EdgeInsets.only(top: h * 0.005, ),
        decoration: BoxDecoration(
          // color: Color(0xFFEDEDED),
          color: (index % 2 == 0) ? Colors.white : Color(0xFFEDEDED),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: h * 0.02, right: w * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset('assets/icons/info_red_icon.svg')
                  /*Image.asset(
                    'assets/Frame 34824 (1).png',
                    height: h * 0.023,
                  ),*/
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.142),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(formattedDate,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Supreme_bold',
                        fontSize: fontSizes.fontSize24,
                        fontWeight: FontWeight.w700,
                        height: 1
                    ),
                  ),

                  Text(
                    'RATE',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Supreme_bold',
                      fontSize: fontSizes.fontSize14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05,top: h * 0.002),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        formattedTime,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Poppins_regular',
                            fontSize: fontSize15,
                            fontWeight: FontWeight.w500,
                            height: 1.5
                        ),
                      ),
                      Container(
                        height: h * 0.001,
                        width: w * 0.32,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  RatingBar(
                    ratingWidget: RatingWidget(
                      full: SvgPicture.asset(
                        'assets/icons/star_rating_disable.svg', // Full star image
                        width: 10, // Customize the size as needed
                        height: 10,
                      ),
                      half: SvgPicture.asset(
                        'assets/icons/star_rating_disable.svg', // Full star image
                        width: 10, // Customize the size as needed
                        height: 10,
                      ),
                      empty: SvgPicture.asset(
                        'assets/icons/star_rating_disable.svg', // Full star image
                        width: 10, // Customize the size as needed
                        height: 10,
                      ),
                    ),
                    onRatingUpdate: (rating) {
                      print('Rating: $rating');
                    },
                    ignoreGestures: true,
                    initialRating: 0, // Set the initial rating
                    minRating: 0,
                    itemSize: w * 0.05, // Set the size of each star (image)
                    allowHalfRating: true, // Allows half ratings if needed
                    itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: w * 0.05, top: h * 0.012, right: w * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: w * 0.52,
                    child: Text(
                      items,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.5),
                        fontFamily: 'Poppins_regular',
                        fontSize: fontSizes.fontSize13,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: h * 0.003),
                            child: Text(
                              'INR ₹',
                              style: TextStyle(
                                color: Color(0xFF000000),
                                fontFamily: 'Poppins_regular',
                                fontSize: fontSizes.fontSize14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          SizedBox(width: w * 0.025,),
                          Text(
                            order.subTotal.toString(),
                            style: TextStyle(
                              color: Color(0xFF000000),
                              fontFamily: 'Poppins_medium',
                              fontSize: fontSizes.fontSize22,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.01,),
                      Container(
                        height: h * 0.056,
                        width: w * 0.19,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            'Reorder',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontFamily: 'Supreme_bold',
                              // fontSize: 13.0,
                              fontSize: fontSizes.fontSize13,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class OrderData {
  final String date;
  final String time;
  final String items;
  final String amount;

  OrderData(
      {required this.date,
        required this.time,
        required this.items,
        required this.amount});
}
