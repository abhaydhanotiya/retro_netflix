import 'package:flutter/material.dart';
import '../../Api/api_value.dart';
import '../../Constants/constant.dart';
import '../../SharedPrefrences/sharedprefrences.dart';
import '../DetailScreen/detail_screen.dart';
import 'home.dart';

class ShowsScreen extends StatefulWidget {
  const ShowsScreen({Key? key});

  @override
  State<ShowsScreen> createState() => _ShowsScreenState();
}

class _ShowsScreenState extends State<ShowsScreen> {
  List shows = [];
  List allShows = [];

  @override
  void initState() {
    super.initState();
    TodaysEpisodeMethod();
    AllShowsMethod();
  }

  Future<dynamic> TodaysEpisodeMethod() async {
    var data = await ApiValue().AllShows();
    print(data);
    setState(() {
      shows = data;
    });
  }

  Future<dynamic> AllShowsMethod() async {
    var data = await ApiValue().AllSearchShows();
    print(data);
    setState(() {
      allShows = data;
    });
  }

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

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/Images/logo2.png',
              height: 30,
              width: 30,
            ),
          ),
          title: Text(
            'Netflix',
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
            ),
          ),
          actions: [
            //select country from dropdown
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    SharedPreferencesHelper.getCountryCode() ?? '',
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  DropdownButton<String>(
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.blackColor,
                    ),
                    underline: SizedBox(),
                    items:
                        <String>['US', 'IN', 'JP', 'CN'].map((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value!,
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        SharedPreferencesHelper.setCountryCode(code: value!);
                        TodaysEpisodeMethod();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: width * 0.9,
              child: Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today\'s Episodes',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    height: height * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: shows.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return DetailScreen(
                                  index: index,
                                  shows: shows,
                                );
                              }),
                            );
                          },
                          child: Container(
                            width: width * 0.4,
                            margin: EdgeInsets.only(
                                right: index == shows.length - 1 ? 0 : 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.backgroundColor2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        shows[index]['show']['image']
                                                    ['medium'] ==
                                                null
                                            ? 'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png'
                                            : shows[index]['show']['image']
                                                ['medium'],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All Shows',
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    height: height * 0.25,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: allShows.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return DetailScreen(
                                  index: index,
                                  shows: allShows,
                                );
                              }),
                            );
                          },
                          child: Container(
                            width: width * 0.4,
                            margin: EdgeInsets.only(
                                right: index == allShows.length - 1 ? 0 : 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.backgroundColor2,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: height * 0.25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        allShows[index]['show']['image'] == null
                                            ? 'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png'
                                            : allShows[index]['show']['image']
                                                        ['medium'] ==
                                                    null
                                                ? 'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png'
                                                : allShows[index]['show']
                                                    ['image']['medium'],
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}
