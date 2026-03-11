import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:globe_trek/screens/popular_place_details.dart';
import 'package:globe_trek/viewModels/popular_places_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class AllPopularPlacesScreen extends StatefulWidget {
  const AllPopularPlacesScreen({super.key});

  @override
  State<AllPopularPlacesScreen> createState() => _AllPopularPlacesScreenState();
}

class _AllPopularPlacesScreenState extends State<AllPopularPlacesScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Popular Places",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Consumer<PopularPlacesViewModel>(
          builder: (ctx, val, ch) {
            if (val.isLoading) {
              return Expanded(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade700,
                  highlightColor: Colors.grey.shade100,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Container(
                            height: 35,
                            width: 50,
                            color: Colors.white,
                          ),
                          title: Container(
                            height: 10,
                            width: 89,
                            color: Colors.white,
                          ),
                          subtitle: Container(
                            height: 10,
                            width: 89,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            }
            if (val.errorMessage != null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  Text(
                    val.errorMessage.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      context.read<PopularPlacesViewModel>().getPlaces();
                    },
                    child: Icon(Icons.refresh, size: 50, color: Colors.blue),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<PopularPlacesViewModel>().getPlaces();
                    },
                    child: const Text("Retry", style: TextStyle(fontSize: 20)),
                  ),
                ],
              );
            }

            if (val.placesList.isEmpty && !val.isLoading) {
              return Center(child: Text("No countries found."));
            }
            return Expanded(
              child: AnimationLimiter(
                child: ListView.builder(
                  itemCount: val.placesList.length,
                  itemBuilder: (context, index) {
                    String placeName = val.placesList[index].name!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          horizontalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ListTile(
                              onTap: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>PopularPlaceDetails(
                                name:placeName, 
                                city:val.placesList[index].city! , 
                                country: val.placesList[index].country!, 
                                lat: val.placesList[index].lat!,
                                 lng: val.placesList[index].lng!,
                                 rating: val.placesList[index].rating!,
                                  description: val.placesList[index].description!,
                                   image: val.placesList[index].image!,
                                    gallery: val.placesList[index].gallery!)));
                              },
                              leading: SizedBox(
                                height: 50,
                                width: 70,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: val.placesList[index].image!,
                                    height: 50,
                                    width: 70,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.place),
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                              title: Text(
                                placeName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              subtitle: Text(
                                "${val.placesList[index].country!}— ${val.placesList[index].city!}",
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
