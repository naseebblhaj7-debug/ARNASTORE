import 'package:flutter/material.dart';
import 'ditals_page.dart';
import '../widgets/product_card.dart';
import '../widgets/circular_category.dart';
import '../widgets/search_bar.dart';

class ProductsPage extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteItems;
  final Function(Map<String, dynamic>) toggleFavorite;
  final Function(Map<String, dynamic>) addToCart;

  const ProductsPage({
    super.key,
    required this.favoriteItems,
    required this.toggleFavorite,
    required this.addToCart,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final Color brandGold = const Color(0xFFCAB273);
  final Color darkText = const Color(0xFF31231C);
  final Color searchBarColor = const Color(0xFFF8F8F8);

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  TextEditingController searchController = TextEditingController();

  String searchText = "";
  String selectedCategory = "All";

  final List<String> tabCategories = [
    "All",
    "Rings",
    "Earrings",
    "Necklace",
    "Bracelet",
  ];

  final List<Map<String, dynamic>> products = [
    {
      "category": "Rings",
      "image": "images/r1.jpg",
      "image2": "images/r1-2.jpg",
      "title": "Golden Ring",
      "price": "\$120",
      "description":
          "Elegant golden ring crafted with a luxurious modern design.",
    },
    {
      "category": "Rings",
      "image": "images/r2.jpg",
      "image2": "images/r2-2.jpg",
      "title": "Luxury Ring",
      "price": "\$150",
      "description":
          "Premium luxury ring featuring a sophisticated handcrafted design.",
    },
    {
      "category": "Rings",
      "image": "images/r3.jpg",
      "image2": "images/r3-2.jpg",
      "title": "Diamond Ring",
      "price": "\$200",
      "description": "Beautiful diamond ring with sparkling stones.",
    },
    {
      "category": "Rings",
      "image": "images/r4.jpg",
      "image2": "images/r4-2.jpg",
      "title": "Silver Ring",
      "price": "\$90",
      "description": "Minimal silver ring with a sleek modern style.",
    },
    {
      "category": "Earrings",
      "image": "images/e1.jpg",
      "image2": "images/e1-2.jpg",
      "title": "Elegant Earrings",
      "price": "\$80",
      "description":
          "Elegant lightweight earrings designed to complement outfits.",
    },
    {
      "category": "Earrings",
      "image": "images/e2.jpg",
      "image2": "images/e2-2.jpg",
      "title": "Gold Earrings",
      "price": "\$110",
      "description":
          "Classic gold earrings crafted with a smooth premium finish.",
    },
    {
      "category": "Earrings",
      "image": "images/e3.jpg",
      "image2": "images/e3-2.jpg",
      "title": "Luxury Earrings",
      "price": "\$140",
      "description": "Luxury earrings featuring an exclusive elegant design.",
    },
    {
      "category": "Earrings",
      "image": "images/e4.jpg",
      "image2": "images/e4-2.jpg",
      "title": "Diamond Earrings",
      "price": "\$170",
      "description": "Sparkling diamond earrings with premium shine.",
    },
    {
      "category": "Necklace",
      "image": "images/n1.webp",
      "image2": "images/n1-2.jpg",
      "title": "Golden Necklace",
      "price": "\$220",
      "description":
          "Luxury golden necklace with a sophisticated elegant touch.",
    },
    {
      "category": "Necklace",
      "image": "images/n2.jpg",
      "image2": "images/n2-2.jpg",
      "title": "Luxury Necklace",
      "price": "\$260",
      "description":
          "Premium luxury necklace designed with fine artistic details.",
    },
    {
      "category": "Necklace",
      "image": "images/n3.jpg",
      "image2": "images/n3-2.webp",
      "title": "Diamond Necklace",
      "price": "\$320",
      "description": "Stunning diamond necklace featuring brilliant stones.",
    },
    {
      "category": "Necklace",
      "image": "images/n4.webp",
      "image2": "images/n4-2.jpg",
      "title": "Elegant Necklace","price": "\$180",
      "description": "Elegant necklace designed for modern daily fashion.",
    },
    {
      "category": "Bracelet",
      "image": "images/b1.webp",
      "image2": "images/b1-2.jpg",
      "title": "Golden Bracelet",
      "price": "\$100",
      "description": "Golden bracelet with a luxurious modern style.",
    },
    {
      "category": "Bracelet",
      "image": "images/b2.webp",
      "image2": "images/b2-2.jpg",
      "title": "Silver Bracelet",
      "price": "\$85",
      "description": "Simple silver bracelet with a clean elegant design.",
    },
    {
      "category": "Bracelet",
      "image": "images/b3.jpg",
      "image2": "images/b3-2.jpg",
      "title": "Luxury Bracelet",
      "price": "\$160",
      "description": "Luxury bracelet featuring premium materials.",
    },
    {
      "category": "Bracelet",
      "image": "images/b4.jpg",
      "image2": "images/b4-2.webp",
      "title": "Diamond Bracelet",
      "price": "\$210",
      "description":
          "Diamond bracelet with brilliant shine and elegant details.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = products.where((p) {
      final matchesCategory =
          selectedCategory == "All" || p["category"] == selectedCategory;
      final matchesSearch = p["title"].toString().toLowerCase().contains(
        searchText,
      );
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                /// LOCATION
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Location",
                          style: TextStyle(color: Colors.grey, fontSize: 13),
                        ),
                        Row(
                          children: [
                            Icon(Icons.location_on, color: brandGold, size: 20),
                            const SizedBox(width: 5),
                            Text(
                              "Tripoli, Libya",
                              style: TextStyle(
                                color: darkText,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Icon(Icons.keyboard_arrow_down, color: darkText),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 25),
                /// SEARCH + FILTER
                SearchBarWidget(
                  focusNode: _focusNode,
                  controller: searchController,
                  isFocused: _isFocused,
                  brandGold: brandGold,
                  onChanged: (value) =>
                      setState(() => searchText = value.toLowerCase()),
                  onFilterLow: () {
                    setState(() {
                      products.sort(
                        (a, b) => int.parse(
                          a["price"].replaceAll("\$", ""),
                        ).compareTo(int.parse(b["price"].replaceAll("\$", ""))),
                      );
                    });
                  },
                  onFilterHigh: () {
                    setState(() {
                      products.sort(
                        (a, b) => int.parse(
                          b["price"].replaceAll("\$", ""),
                        ).compareTo(int.parse(a["price"].replaceAll("\$", ""))),
                      );
                    });
                  },
                  onReset: () {
                    setState(() {
                      selectedCategory = "All";
                      searchText = "";
                    });
                  },
                ),

                const SizedBox(height: 35),

                /// CATEGORIES TITLE
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        color: darkText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "See All",
                      style: TextStyle(
                        color: brandGold,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// CIRCULAR CATEGORIES
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CircularCategory(
                      label: "Rings",
                      imagePath: "images/mat1.webp",
                    ),
                    CircularCategory(
                      label: "Earrings",
                      imagePath: "images/mat2.jpg",
                    ),
                    CircularCategory(
                      label: "Necklace",
                      imagePath: "images/mat3.jpg",
                    ),
                    CircularCategory(
                      label: "Bracelet",
                      imagePath: "images/mat4.jpg",
                    ),
                  ],
                ),

                const SizedBox(height: 30),
                /// FILTER BUTTONS (Tabs)
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: tabCategories.length,
                    itemBuilder: (context, index) {
                      bool isSelected =
                          selectedCategory == tabCategories[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = tabCategories[index];
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          decoration: BoxDecoration(
                            color: isSelected ? brandGold : Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: brandGold,
                              width: isSelected ? 0 : 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              tabCategories[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : brandGold,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 30),

                /// PRODUCTS GRID
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filtered.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    childAspectRatio: 0.72,
                  ),
                  itemBuilder: (context, index) {
                    final product = filtered[index];
                    final isLiked = widget.favoriteItems.any(
                      (item) => item["title"] == product["title"],
                    );
                    return GestureDetector(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                ProductDetailsPage(product: product),
                          ),
                        );
                        if (result != null) widget.addToCart(result);
                      },
                      child: ProductCard(
                        product: product,
                        isLiked: isLiked,
                        onFavoriteToggle: () => widget.toggleFavorite(product),
                        onAddToCart: () =>
                            widget.addToCart(product), // ✅ أضف هذا السطر
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}