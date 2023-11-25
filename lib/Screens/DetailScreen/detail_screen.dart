import 'package:flutter/material.dart';
import 'package:retro_netflix/Constants/constant.dart';

class DetailScreen extends StatefulWidget {
  final int index;
  final List shows;

  DetailScreen({
    required this.index,
    required this.shows,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isExpanded = false;

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
    String truncateSummary(String summary) {
      // Customize the logic for truncating here
      if (summary.length > 100) {
        return '${summary.substring(0, 100)}...';
      }
      return summary;
    }

    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: width * 0.05,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Show Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          widget.shows[widget.index]['show']['image'] == null
                              ? 'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png'
                              : widget.shows[widget.index]['show']['image']
                                          ['medium'] ==
                                      null
                                  ? 'https://developers.google.com/static/maps/documentation/streetview/images/error-image-generic.png'
                                  : widget.shows[widget.index]['show']['image']
                                      ['medium'],
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            widget.shows[widget.index]['show']['name'] == null
                                ? 'N/A'
                                : widget.shows[widget.index]['show']['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            'Genres: ${widget.shows[widget.index]['show']['genres'].isEmpty ? 'N/A' : widget.shows[widget.index]['show']['genres']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            'Rating: ${widget.shows[widget.index]['show']['rating']['average'] == null ? 'N/A' : widget.shows[widget.index]['show']['rating']['average']}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            'Source: ${widget.shows[widget.index]['show']['network'] == null ? widget.shows[widget.index]['show']['webChannel'] == null ? 'N/A' : widget.shows[widget.index]['show']['webChannel']['name'] : widget.shows[widget.index]['show']['network']['name'] == null ? 'N/A' : widget.shows[widget.index]['show']['network']['name']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 16),
                        SizedBox(
                          width: width * 0.4,
                          child: Text(
                            'Language: ${widget.shows[widget.index]['show']['language']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  isExpanded
                      ? widget.shows[widget.index]['show']['summary']
                      : truncateSummary(
                          widget.shows[widget.index]['show']['summary']),
                  style: TextStyle(fontSize: 16),
                ),

                // Add Read More / Show Less button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded;
                    });
                  },
                  child: Text(
                    isExpanded ? 'Show Less' : 'Read More',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
