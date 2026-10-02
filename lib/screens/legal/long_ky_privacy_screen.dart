import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/constants/theme.dart';
import 'package:portfolio/data/portfolio_data.dart';
import 'package:portfolio/helpers/responsive.dart';
import 'package:portfolio/screens/home/widgets/app_logo.dart';
import 'package:portfolio/screens/home/widgets/code_button.dart';
import 'package:portfolio/screens/home/widgets/custom_cursor.dart';
import 'package:portfolio/screens/home/widgets/footer.dart';
import 'package:portfolio/screens/home/widgets/section_container.dart';
import 'package:portfolio/screens/home/widgets/section_heading.dart';

/// A `### N. Heading` block within one language's policy text.
class _PolicyClause {
  final String heading;
  final String body;
  const _PolicyClause(this.heading, this.body);
}

// Content mirrors the Long Ký repo's docs/play-store/privacy-policy.md —
// keep the two in sync when the policy changes.
const String _lastUpdatedVi = '26/09/2026';
const String _lastUpdatedEn = 'September 26, 2026';

// Reuses the same address already shown publicly in this site's own footer.
const String _contactEmail = PortfolioData.email;

const List<_PolicyClause> _clausesVi = <_PolicyClause>[
  _PolicyClause(
    '1. Ứng dụng không thu thập dữ liệu cá nhân',
    'Long Ký không yêu cầu đăng ký hay đăng nhập. Ứng dụng không thu thập '
        'tên, email, số điện thoại, vị trí hay bất kỳ thông tin định danh cá '
        'nhân nào. Ứng dụng không theo dõi người dùng giữa các ứng dụng hay '
        'trang web khác, và không có quảng cáo. Mục 8 dưới đây mô tả thống kê '
        'sử dụng ẩn danh mà ứng dụng có gửi.',
  ),
  _PolicyClause(
    '2. Nội dung được tải từ máy chủ',
    'Văn bản và hình ảnh lịch sử trong ứng dụng được tải xuống từ một mạng '
        'phân phối nội dung (Cloudflare R2) để giữ ứng dụng nhẹ và luôn cập '
        'nhật. Việc tải này không gắn với danh tính cá nhân của bạn; máy chủ '
        'có thể ghi lại nhật ký kỹ thuật thông thường (như địa chỉ IP, thời '
        'điểm truy cập) theo cách mọi máy chủ web vẫn làm, chỉ để vận hành '
        'dịch vụ, không dùng để nhận diện bạn.',
  ),
  _PolicyClause(
    '3. Mua hàng trong ứng dụng',
    'Long Ký có tính năng "Mời Long Ký một chén trà" — một khoản ủng hộ tự '
        'nguyện, không phải giao dịch từ thiện, mua qua Google Play Billing '
        '(ba mức: một, hai hoặc ba chén trà). Mọi thông tin thanh toán (thẻ, '
        'tài khoản) do Google Play xử lý trực tiếp theo Chính sách quyền '
        'riêng tư của Google Play (policies.google.com/privacy). Long Ký '
        'không bao giờ nhìn thấy hay lưu trữ thông tin thanh toán của bạn — '
        'ứng dụng chỉ nhận lại kết quả giao dịch (thành công/thất bại) để '
        'hiển thị lời cảm ơn.',
  ),
  _PolicyClause(
    '4. Lưu trữ trên thiết bị',
    'Ứng dụng lưu một số dữ liệu nhỏ ngay trên máy của bạn (không gửi lên '
        'máy chủ nào của chúng tôi): gói nội dung đã tải để dùng khi không có '
        'mạng, và điểm số/tiến trình Câu đố (điểm tốt nhất theo từng chế độ, '
        'và ngày bạn đã hoàn thành câu đố hôm nay). Dữ liệu này chỉ tồn tại '
        'trên thiết bị của bạn; xoá ứng dụng sẽ xoá luôn dữ liệu này.',
  ),
  _PolicyClause(
    '5. Không dành riêng cho trẻ em, nhưng phù hợp mọi lứa tuổi',
    'Long Ký không được thiết kế đặc biệt cho trẻ em và không thu thập dữ '
        'liệu từ bất kỳ ai, bao gồm trẻ em. Nội dung phù hợp cho mọi lứa tuổi '
        'quan tâm đến lịch sử Việt Nam.',
  ),
  _PolicyClause(
    '6. Thay đổi chính sách',
    'Nếu chính sách này thay đổi, phiên bản mới sẽ được đăng tại cùng địa '
        'chỉ này, với ngày cập nhật ở đầu trang.',
  ),
  _PolicyClause(
    '7. Liên hệ',
    'Có câu hỏi về quyền riêng tư? Liên hệ: $_contactEmail',
  ),
  _PolicyClause(
    '8. Thống kê sử dụng ẩn danh và báo lỗi',
    'Long Ký dùng Firebase Analytics và Firebase Crashlytics (của Google) để '
        'biết trang nào được xem nhiều và phát hiện lỗi/sự cố. Hai công cụ '
        'này ghi nhận: màn hình bạn xem, các thao tác trong ứng dụng (ví dụ: '
        'chơi Câu đố, mở Chào cờ, kéo bản đồ, mở mục ủng hộ), model máy và '
        'phiên bản hệ điều hành, quốc gia ước tính, và một mã định danh '
        'thiết bị ngẫu nhiên do Firebase tạo ra — không gắn với tên, email '
        'hay bất kỳ tài khoản nào của bạn. Khi ứng dụng gặp lỗi, thông tin về '
        'lỗi đó (không kèm nội dung bạn đang xem hay nhập) cũng được gửi để '
        'giúp sửa lỗi. Dữ liệu này do Google xử lý theo Chính sách quyền '
        'riêng tư của Google (policies.google.com/privacy).\n\nBạn có thể tắt '
        'tính năng này bất cứ lúc nào tại Sảnh → Về Long Ký → "Gửi thống kê '
        'ẩn danh". Mặc định tính năng này đang bật.',
  ),
];

const List<_PolicyClause> _clausesEn = <_PolicyClause>[
  _PolicyClause(
    '1. The app collects no personal data',
    'Long Ký has no sign-up or sign-in. It does not collect your name, '
        'email, phone number, location, or any other personally identifying '
        'information. It does not track you across other apps or websites, '
        'and carries no advertising. Section 8 below describes the anonymous '
        'usage statistics the app does send.',
  ),
  _PolicyClause(
    '2. Content is fetched from a server',
    "The app's historical text and images are fetched from a "
        'content-delivery network (Cloudflare R2) to keep the app small and '
        'up to date. This fetch is not tied to your identity; the server may '
        'keep ordinary technical logs (such as IP address and request time), '
        'as any web server does, solely to operate the service — never to '
        'identify you.',
  ),
  _PolicyClause(
    '3. In-app purchases',
    'Long Ký offers "Mời Long Ký một chén trà" — a voluntary tip to the '
        'developer, not a charitable transaction — bought through Google '
        'Play Billing (three sizes: one, two or three cups). All payment '
        'information (card, account) is handled directly by Google Play '
        "under Google Play's own Privacy Policy "
        '(policies.google.com/privacy). Long Ký never sees or stores your '
        "payment details — it only receives the transaction's outcome "
        '(succeeded/failed) to show a thank-you message.',
  ),
  _PolicyClause(
    '4. On-device storage',
    'The app stores a small amount of data on your own device only (never '
        'sent to any server we run): a downloaded content pack for offline '
        'use, and your quiz progress (best score per mode, and whether '
        "you've completed today's quiz). This data lives only on your "
        'device; uninstalling the app removes it.',
  ),
  _PolicyClause(
    '5. Not directed at children, but suitable for all ages',
    'Long Ký is not specifically directed at children and collects no data '
        'from anyone, children included. Its content is suitable for anyone '
        'interested in Vietnamese history.',
  ),
  _PolicyClause(
    '6. Changes to this policy',
    'If this policy changes, the new version will be posted at this same '
        'address, with the updated date at the top.',
  ),
  _PolicyClause(
    '7. Contact',
    'Questions about privacy? Contact: $_contactEmail',
  ),
  _PolicyClause(
    '8. Anonymous usage statistics and crash reporting',
    'Long Ký uses Firebase Analytics and Firebase Crashlytics (both Google '
        'services) to see which pages get read and to catch crashes and '
        'errors. These record: which screens you view, in-app actions (e.g. '
        'playing Câu đố, opening Chào cờ, dragging the territory atlas, '
        'opening the tip sheet), your device model and OS version, an '
        'estimated country, and a random device identifier that Firebase '
        'generates — never your name, email, or any account of yours. When '
        'the app hits an error, information about that error (not the '
        'content you were viewing or entering) is also sent, to help fix it. '
        'Google processes this data under its own Privacy Policy '
        '(policies.google.com/privacy).\n\nYou can turn this off at any time '
        'under Sảnh → Về Long Ký → "Share anonymous usage stats". It is on '
        'by default.',
  ),
];

/// Stable public privacy-policy page for the Long Ký mobile app
/// (`binh-nt.dev/long-ky/privacy`), linked from its Play Store listing. Not
/// part of the portfolio's own narrative, so it isn't linked from the home
/// page nav — Google Play only needs the URL to resolve.
class LongKyPrivacyScreen extends StatelessWidget {
  const LongKyPrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const _LegalHeader(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SectionContainer(
                    topPadding: 40,
                    bottomPadding: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          'Long Ký — Chính sách quyền riêng tư / Privacy '
                          'Policy',
                          style: AppTextStyles.detailTitleFor(
                            context.isMobile,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SelectableText(
                          'Cập nhật lần cuối: $_lastUpdatedVi · Last '
                          'updated: $_lastUpdatedEn',
                          style: AppTextStyles.metaValue,
                        ),
                      ],
                    ),
                  ),
                  SectionContainer(
                    topPadding: 16,
                    bottomPadding: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeading(title: 'tiếng-việt'),
                        for (final clause in _clausesVi)
                          _ClauseBlock(clause: clause),
                      ],
                    ),
                  ),
                  SectionContainer(
                    topPadding: 16,
                    bottomPadding: 56,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeading(title: 'english'),
                        for (final clause in _clausesEn)
                          _ClauseBlock(clause: clause),
                      ],
                    ),
                  ),
                  const Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegalHeader extends StatelessWidget {
  const _LegalHeader();

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.value<double>(
      context,
      mobile: 16,
      tablet: 32,
      desktop: 24,
    );
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 16),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: Responsive.maxContentWidth,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CursorTarget(
                child: GestureDetector(
                  onTap: () => _backHome(context),
                  child: const AppLogo(),
                ),
              ),
              CodeTextLink(
                label: '<~ back',
                onPressed: () => _backHome(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _backHome(BuildContext context) {
  if (context.canPop()) {
    context.pop();
  } else {
    context.go('/');
  }
}

class _ClauseBlock extends StatelessWidget {
  final _PolicyClause clause;
  const _ClauseBlock({required this.clause});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(clause.heading, style: AppTextStyles.bold),
          const SizedBox(height: 8),
          SelectableText(clause.body, style: AppTextStyles.body),
        ],
      ),
    );
  }
}
