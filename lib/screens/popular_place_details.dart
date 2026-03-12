import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globe_trek/core/constants/size_config.dart';
import 'package:globe_trek/models/popular_places_model.dart';
import 'package:globe_trek/viewModels/popular_places_view_model.dart';
import 'package:provider/provider.dart';

const _kAccent = Colors.blueAccent;

class PopularPlaceDetails extends StatefulWidget {
  final String name;
  final String city;
  final String country;
  final double lat;
  final double lng;
  final double rating;
  final String description;
  final String image;
  final Gallery gallery;

  const PopularPlaceDetails({
    super.key,
    required this.name,
    required this.city,
    required this.country,
    required this.lat,
    required this.lng,
    required this.rating,
    required this.description,
    required this.image,
    required this.gallery,
  });

  @override
  State<PopularPlaceDetails> createState() => _PopularPlaceDetailsState();
}

class _PopularPlaceDetailsState extends State<PopularPlaceDetails>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
 
  double _scrollOffset = 0.0;
  int _selectedImageIndex = 0;
  bool _isSaved = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() => _scrollOffset = _scrollController.offset);
      });

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    _fadeController.forward();
    _slideController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PopularPlacesViewModel>(context, listen: false).getPlaces();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final List<String?> images = [
      widget.gallery.img1,
      widget.gallery.img2,
      widget.gallery.img3,
    ];

    final double heroHeight = SizeConfig.hp(45);
    final double parallaxOffset = _scrollOffset * 0.45;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: _HeroSection(
              image: widget.gallery.img1 ?? widget.image,
              heroHeight: heroHeight,
              parallaxOffset: parallaxOffset,
              name: widget.name,
              city: widget.city,
              country: widget.country,
              rating: widget.rating,
              isSaved: _isSaved,
              onSaveToggle: () => setState(() => _isSaved = !_isSaved),
            ),
          ),

          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFF5F7FA),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 48),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 44,
                            height: 4,
                            margin: const EdgeInsets.only(bottom: 28),
                            decoration: BoxDecoration(
                              color: Colors.blueAccent.withValues(alpha: 0.18),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),

                        _RatingChip(rating: widget.rating),
                        const SizedBox(height: 32),

                        _SectionLabel(label: 'About'),
                        const SizedBox(height: 12),
                        Text(
                          widget.description,
                          style: const TextStyle(
                            color: Color(0xFF4A5568),
                            fontSize: 15.5,
                            height: 1.8,
                            letterSpacing: 0.1,
                          ),
                        ),
                        const SizedBox(height: 36),

                        _SectionLabel(label: 'Gallery'),
                        const SizedBox(height: 16),
                        _GallerySection(
                          images: images,
                          selectedIndex: _selectedImageIndex,
                          onSelect: (i) =>
                              setState(() => _selectedImageIndex = i),
                        ),
                        const SizedBox(height: 36),

                        _SectionLabel(label: 'Location'),
                        const SizedBox(height: 16),
                        locationCard(
                          city: widget.city,
                          country: widget.country,
                          lat: widget.lat.toString(),
                          lng: widget.lng.toString(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final double opacity = (_scrollOffset / 180).clamp(0.0, 1.0);
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        color: Color.fromRGBO(245, 247, 250, opacity),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: _CircleIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
            onHero: _scrollOffset < 60,
          ),
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  final String image;
  final double heroHeight;
  final double parallaxOffset;
  final String name;
  final String city;
  final String country;
  final double rating;
  final bool isSaved;
  final VoidCallback onSaveToggle;

  const _HeroSection({
    required this.image,
    required this.heroHeight,
    required this.parallaxOffset,
    required this.name,
    required this.city,
    required this.country,
    required this.rating,
    required this.isSaved,
    required this.onSaveToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: heroHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            child: Transform.translate(
              offset: Offset(0, -parallaxOffset),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                height: heroHeight + 80,
                placeholder: (_, _) => Container(
                  color: const Color(0xFFE2E8F0),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: _kAccent,
                      strokeWidth: 1.5,
                    ),
                  ),
                ),
                errorWidget: (_, _, _) => Container(
                  color: const Color(0xFFE2E8F0),
                  child: const Icon(
                    Icons.broken_image_rounded,
                    color: Colors.black26,
                    size: 48,
                  ),
                ),
              ),
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Color(0xCC0D1B3E)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.38, 1.0],
              ),
            ),
          ),

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0x550D1B3E), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
          ),

          Positioned(
            left: 24,
            right: 72,
            bottom: 28,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.blueAccent.withValues(alpha: 0.55),
                      width: 0.8,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: Color(0xFF90C4FF),
                        size: 13,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$city, $country'.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFFBEDAFF),
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            right: 24,
            bottom: 28,
            child: GestureDetector(
              onTap: onSaveToggle,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSaved ? Colors.blueAccent : Colors.white24,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSaved
                        ? Colors.blueAccent
                        : Colors.white.withValues(alpha: 0.35),
                    width: 1,
                  ),
                  boxShadow: isSaved
                      ? [
                          BoxShadow(
                            color: Colors.blueAccent.withValues(alpha: 0.5),
                            blurRadius: 20,
                            spreadRadius: 1,
                          ),
                        ]
                      : [],
                ),
                child: Icon(
                  isSaved
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RatingChip extends StatelessWidget {
  final double rating;
  const _RatingChip({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.blueAccent.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: List.generate(5, (i) {
              final filled = i < rating.floor();
              final half = !filled && i < rating;
              return Icon(
                half
                    ? Icons.star_half_rounded
                    : filled
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                color: Colors.blueAccent,
                size: 20,
              );
            }),
          ),
          const SizedBox(width: 10),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: Color(0xFF1A202C),
              fontSize: 17,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '/ 5.0',
            style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _GallerySection extends StatelessWidget {
  final List<String?> images;
  final int selectedIndex;
  final ValueChanged<int> onSelect;

  const _GallerySection({
    required this.images,
    required this.selectedIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 380),
          transitionBuilder: (child, anim) =>
              FadeTransition(opacity: anim, child: child),
          child: ClipRRect(
            key: ValueKey(selectedIndex),
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: images[selectedIndex].toString(),
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (_, _) => Container(
                height: 220,
                color: const Color(0xFFE2E8F0),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: _kAccent,
                    strokeWidth: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(images.length, (i) {
            final bool sel = i == selectedIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () => onSelect(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  margin: EdgeInsets.only(right: i < images.length - 1 ? 8 : 0),
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: sel ? Colors.blueAccent : Colors.transparent,
                      width: 2.2,
                    ),
                    boxShadow: sel
                        ? [
                            BoxShadow(
                              color: Colors.blueAccent.withValues(alpha: 0.28),
                              blurRadius: 12,
                              spreadRadius: 1,
                            ),
                          ]
                        : [],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: images[i].toString(),
                          fit: BoxFit.cover,
                        ),
                        if (!sel)
                          Container(
                            color: Colors.white.withValues(alpha: 0.30),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

Widget locationCard({
  required String city,
  required String country,
  required String lat,
  required String lng,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.blueAccent.withValues(alpha: 0.07),
          blurRadius: 18,
          offset: const Offset(0, 4),
        ),
      ],
      border: Border.all(
        color: Colors.blueAccent.withValues(alpha: 0.1),
        width: 1,
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blueAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(Icons.map_rounded, color: _kAccent, size: 24),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$city, $country',
                style: const TextStyle(
                  color: Color(0xFF1A202C),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '$lat° N  ·  $lng° E',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 12,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withValues(alpha: 0.35),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: const Text(
            'View Map',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    ),
  );
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3.5,
          height: 19,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1A202C),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool onHero; // true = over image, false = scrolled into light bg

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
    this.onHero = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 40,
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: onHero ? Colors.black.withOpacity(0.35) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: onHero
                ? Colors.white.withOpacity(0.2)
                : Colors.blueAccent.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 8),
          ],
        ),
        child: Icon(
          icon,
          color: onHero ? Colors.white : Colors.blueAccent,
          size: 18,
        ),
      ),
    );
  }
}
