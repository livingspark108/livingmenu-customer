import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_menu_mobile/Models/walletFilteredTransaction.dart';
import 'package:living_menu_mobile/Models/walletTransectionModel.dart';
import 'package:intl/intl.dart';
import 'package:living_menu_mobile/network/apiService.dart';

import '../Constants/appFontSizes.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletTransaction extends StatefulWidget {
  const WalletTransaction({Key? key, required this.allTransactions}) : super(key: key);
  final List<Transaction> allTransactions;

  @override
  State<WalletTransaction> createState() => _WalletTransactionState();
}

class _WalletTransactionState extends State<WalletTransaction>{
  late double w, h;
  List<Transaction>? transactions;
  bool isFilterVisible = false;
  int? selectedYear;
  int? selectedMonth;
  ApiService apiService = ApiService();
  List<FilteredTransaction>? filteredTransaction;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transactions = widget.allTransactions;
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    AppFontSizes fontSizes = AppFontSizes(context);
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.06),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: SvgPicture.asset('assets/icons/header_back.svg'),
                        ),
                      ),
                      SizedBox(height: h * 0.02,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('All Transactions',
                            style: TextStyle(
                                fontFamily: 'Supreme_bold',
                                fontWeight: FontWeight.w700,
                                fontSize: fontSizes.fontSize24
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                if(isFilterVisible) {
                                  isFilterVisible = false;
                                }else {
                                  isFilterVisible = true;
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFF1F1F1),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01, left: w * 0.04, right: w * 0.04),
                                child: Row(
                                  children: [
                                    Text('Filter',
                                      style: TextStyle(
                                          fontFamily: 'Supreme_bold',
                                          fontWeight: FontWeight.w800,
                                          fontSize: fontSizes.fontSize14
                                      ),
                                    ),
                                    SizedBox(width: w * 0.02,),
                                    SvgPicture.asset('assets/icons/down_arrow_black.svg'),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h * 0.02,),
                Container(
                  height: h * 0.001,
                  width: w,
                  color: Color(0xFFF1F1F1),
                ),

                // SizedBox(height: h * 0.02,),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: transactions?.length ?? 0,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index){
                          final transaction = transactions![index];
                          return _buildTransactionItem(transaction);
                        }
                    ),
                  ),
                ),

              ],
            ),
          ),
          Positioned(
            bottom: 0,
              child: showFilter(isFilterVisible, fontSizes)
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Transaction transaction){
    AppFontSizes fontSizes = AppFontSizes(context);
    String? purchaseDate = transaction.date;
    String? formattedDate;
    double? amount = transaction.amount;
    bool type = false;
    if(transaction.type == "credit"){
      type = true;
    }else {
      type = false;
    }
    if(purchaseDate != null) {
      DateTime dateTime = DateTime.parse(purchaseDate);
      // Format the date to "19/12/23"
      formattedDate = DateFormat("dd/MM/yy (HH:mm)").format(dateTime);
      // Format the time to "15:36"
      // formattedTime = DateFormat("HH:mm").format(dateTime);
    }else {
      formattedDate = 'No Date';
      // formattedTime = 'No Time';
    }
    return Container(
      child: Column(
        children: [
          SizedBox(height: h * 0.02,),
          Padding(
            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(transaction.transactionId ?? '',
                      style: TextStyle(
                          fontFamily: 'Poppins_regular',
                          fontSize: fontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black
                      ),
                    ),
                    Text(formattedDate,
                      style: TextStyle(
                          fontFamily: 'Poppins_regular',
                          fontSize: fontSizes.fontSize12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF606060)
                      ),
                    ),
                  ],
                ),
                Text(type ? '+${amount}' : '-${amount}',
                  style: TextStyle(
                      fontFamily: 'Poppins_regular',
                      fontSize: fontSizes.fontSize14,
                      fontWeight: FontWeight.w500,
                      color: type ? Color(0xFF001FFF) : Colors.black
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: h * 0.02,),
          Container(
            height: h * 0.001,
            width: w,
            color: Color(0xFFF1F1F1),
          ),
        ],
      ),
    );
  }

  Widget showFilter(bool isVisible, AppFontSizes fontSizes){
    return Visibility(
      visible: isVisible,
      child: AnimatedContainer(
          duration: Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        width: w,
        height: h * 0.3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 20,
              spreadRadius: 10,
              color:
              Color.fromRGBO(0, 0, 0, 0.3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04, top: h * 0.03),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Month',
                    style: TextStyle(
                      fontSize: fontSizes.fontSize16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins_regular',
                      color: Colors.black,
                    ),
                  ),
                  Text('Select Year',
                    style: TextStyle(
                      fontSize: fontSizes.fontSize16,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins_regular',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.01,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      _selectMonth(context);
                    },
                    child: Container(
                      height: h * 0.05,
                      width: w * 0.44,
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.only(left: w * 0.04, bottom: h * 0.005, right: w * 0.04),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFF1F1F1),
                        // color: Colors.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(selectedMonth != null ? "$selectedMonth" : "",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: fontSizes.fontSize12,
                                fontFamily: 'Poppins_regular',
                                color: Colors.black
                            ),
                          ),
                          SvgPicture.asset('assets/icons/arrow_down_black_small.svg')

                        ],
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: (){
                      _selectYear(context);
                    },
                    child: Container(
                      height: h * 0.05,
                      width: w * 0.44,
                      alignment: Alignment.center,
                      padding:
                      EdgeInsets.only(left: w * 0.04, bottom: h * 0.005, right: w * 0.04),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFF1F1F1),
                        // color: Colors.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(selectedYear != null ? "$selectedYear" : "",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: fontSizes.fontSize12,
                                fontFamily: 'Poppins_regular',
                                color: Colors.black
                            ),
                          ),
                          SvgPicture.asset('assets/icons/arrow_down_black_small.svg')

                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                height: h * 0.1,
                width: w,
                color: Colors.white,
                child: Column(
                  children: [
                    /* Container(
                      height: h * 0.001,
                      width: w,
                      color: Color(0xFFF1F1F1),
                    ),*/
                    Padding(
                      padding: EdgeInsets.only(top: h * 0.04),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if(selectedMonth == null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please select month'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }else if(selectedYear == null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please select year'),
                                  duration: Duration(seconds: 3),
                                ),
                              );
                            }else {
                              print(selectedMonth);
                              print(selectedYear);
                              apiService.getWalletFilteredTransaction(context, selectedMonth.toString(), selectedYear.toString()).then((value) {
                                setState(() {
                                  filteredTransaction = value;
                                  transactions!.clear();
                                  if (filteredTransaction != null) {
                                    for (var tran in filteredTransaction!) {
                                      transactions?.add(Transaction(
                                        transactionId: tran.transactionId,
                                        amount: tran.amount,
                                        type: tran.type,
                                        date: tran.date,
                                      ));
                                    }
                                  }
                                  // walletBalance = walletTransaction.walletBalance;
                                  print('Wallet Filter Transection--------------------->>> ${filteredTransaction}');


                                  isFilterVisible = false;
                                  isVisible = false;
                                });
                              });
                            }
                          });

                        },
                        child: Container(
                          height: h * 0.06,
                          width: w,
                          decoration: BoxDecoration(
                            color: Color(0xFF001FFF),

                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontFamily: 'Poppins_semi_bold',
                                  fontWeight: FontWeight.w600,
                                  fontSize: fontSizes.fontSize16,
                                  color: Colors.white
                                // fontSize: 14
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _selectMonth(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Select Month",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedMonth = index + 1;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: selectedMonth == index + 1 ? Colors.blue : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            color: selectedMonth == index + 1 ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectYear(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Select Year",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20, // Adjust range if needed
                  itemBuilder: (context, index) {
                    int year = 2020 + index; // Start year
                    return ListTile(
                      title: Text("$year"),
                      onTap: () {
                        setState(() {
                          selectedYear = year;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

}
