import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class CitySearchDelegate extends SearchDelegate<Location?> {
  String locationName = "";

  Future<String> getCurrentPositionName(Location? position) async {
    try {
      // 좌표를 주소로 변환
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position!.latitude,
        position.longitude,
        localeIdentifier: 'ko_KR', // 한글 주소를 얻기 위해 로캘 설정
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return "${placemark.country} ${placemark.locality} ${placemark.subLocality}";
      } else {
        print("주소를 찾을 수 없습니다.");
      }
    } catch (e) {
      print(e);
      print("주소를 찾을 수 없습니다.");
    }
    return "";
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Location>>(
      future: query.isNotEmpty ? locationFromAddress(query) : Future.value([]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final location = snapshot.data![index];
              return FutureBuilder<String>(
                future: getCurrentPositionName(location),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    return ListTile(
                      title: Text(snapshot.data!),
                      onTap: () {
                        close(context, location);
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
