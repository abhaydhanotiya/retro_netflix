import 'package:retro_netflix/Api/api_value.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../Constants/constant.dart';
import '../../DetailScreen/detail_screen.dart';
import '../home.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchText = '';
  String selectedSortOption = 'None';
  String selectedFilterOption = 'None';
  List searchList = [];

  String formattedDate(String dateString) {
    DateTime date = DateTime.parse(dateString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inDays > 365) {
      int years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  }

  Future<dynamic> _searchmethod() async {
    var data = await ApiValue().SearchAllShows(searchText);
    setState(() {
      searchList = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: width * 0.05,
            color: AppColors.primaryColor,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Home(index: 0),
              ),
            );
          },
        ),
        title: Text(
          'Search',
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Center(
              child: Container(
                width: width * 0.9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: height * 0.06,
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                            _searchmethod();
                          });
                        },
                        onSubmitted: (value) {
                          _searchmethod();
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide:
                                BorderSide(color: AppColors.secondaryColor),
                          ),
                          hintText: 'Search',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: AppColors.primaryColor,
                            ),
                            onPressed: () {
                              _searchmethod();
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    searchList.isEmpty
                        ? Container(
                            height: height * 0.8,
                            child: Center(
                              child: Text(
                                'No Search Available',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'Roboto',
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: height, // Adjust the multiplier as needed
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20,
                                childAspectRatio: 0.75,
                              ),
                              scrollDirection: Axis.vertical,
                              itemCount: searchList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return DetailScreen(
                                          index: index,
                                          shows: searchList,
                                        );
                                      }),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.backgroundColor2,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            searchList[index]['show']['image']
                                                        ['medium'] ==
                                                    null
                                                ? 'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png'
                                                : searchList[index]['show']
                                                    ['image']['medium'],
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
