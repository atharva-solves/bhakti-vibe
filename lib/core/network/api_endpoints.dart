class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = 'https://appy.trycatchtech.com/v3/all_god/';

  static const String festivalCategoryList = 'all_god_festival_list';
  static const String aartiListByFestival = 'arti_list_by_festival';
  static const String getSingleAarti = 'get_single_aarti';
  static const String trendingAarti = 'trending_aarti?category_id=1,2';
  static const String recentlyPlayedAarti = 'trending_aarti?category_id=1,3';

  static const String wallpaperCategories='all_god_wallpaper_category_list';
  static const String wallpaperPosts='all_god_wallpaper_post_list';
  static const String trendingWallpapers='trending_wallpaper?category_id=1,2';
  static const String recentlyUsedWallpaper='trending_wallpaper?category_id=1,3';
}
