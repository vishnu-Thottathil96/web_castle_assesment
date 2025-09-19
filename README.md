Features

Authentication: Login using API, storing tokens securely in FlutterSecureStorage.

Home Screen:

Dynamic banners, products, brands, and categories.

Pull-to-refresh support.

Horizontal & vertical scrolling lists.

UI/UX:

Responsive design using ScreenUtil.

Reusable widgets like ProductCard, BannerCarousel, CategoryGrid.

Shimmer loading effect for placeholders.

Routing: Managed via GoRouter for smooth navigation.

State Management: Riverpod for both auth and home screens.

Dependencies

flutter_riverpod – State management

flutter_screenutil – Responsive layout

google_fonts – Custom fonts

flutter_secure_storage – Secure token storage

http – API calls

dartz – Functional programming utilities

Notes

The API base URL and endpoints are defined in core/config/api_config.

Tokens are securely stored in infrastructure/services/secure_storage_services.
