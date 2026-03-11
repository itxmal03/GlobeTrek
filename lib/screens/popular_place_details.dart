import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:globe_trek/core/constants/size_config.dart';
import 'package:globe_trek/viewModels/popular_places_view_model.dart';
import 'package:provider/provider.dart';

class PopularPlaceDetails extends StatefulWidget {
  const PopularPlaceDetails({super.key});

  @override
  State<PopularPlaceDetails> createState() => _PopularPlaceDetailsState();
}

class _PopularPlaceDetailsState extends State<PopularPlaceDetails> {
  @override
  void initState() {
    super.initState();
    final popularVM = Provider.of<PopularPlacesViewModel>(
      context,
      listen: false,
    );
    popularVM.getPlaces();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<PopularPlacesViewModel>(
            builder: (context, value, child) => Column(
              children: [
                SizedBox(height: 30),
                Container(
                  height: SizeConfig.hp(25),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        value.placesList[0].image.toString(),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "Explore the World",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    InkWell(
                      onTap: () async {},
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 240,
                  child: Consumer<PopularPlacesViewModel>(
                    builder: (context, val, child) {
                      if (val.isLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (val.placesList.isEmpty) {
                        return Center(child: Text("No places found"));
                      }
                      final popularImagesList = val.placesList;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 165,
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  popularImagesList[index].image!,
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(16),

                                  bottomRight: Radius.circular(16),
                                ),
                                color: Colors.black54,
                              ),
                              width: double.infinity,
                              padding: EdgeInsets.all(8),
                              child: Text(
                                popularImagesList[index].name!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
