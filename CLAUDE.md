# Portfolio — project conventions

Binh's personal portfolio. Flutter web app (also builds for the other desktop
targets). Single-page, dark "code-editor" aesthetic, Fira Code monospace.

## Hard rules (always follow in this repo)

1. **No inline text styles or colors.** Every `TextStyle` and `Color` used
   anywhere in the project must be defined in
   [lib/constants/theme.dart](lib/constants/theme.dart) — colors in `AppColors`,
   text styles in `AppTextStyles`. Reference those constants from widgets; never
   write a literal `Color(0x...)`, `Colors.*`, or an inline `TextStyle(...)` in a
   page/widget. For headings that resize by breakpoint, use the responsive
   getters in `AppTextStyles` (e.g. `AppTextStyles.sectionTitleFor(isMobile)`).

2. **Use Provider for state management.** App state lives in `ChangeNotifier`s
   under [lib/providers/](lib/providers/) and is consumed with `provider`
   (`context.watch` / `context.read` / `Consumer`). Do not introduce other state
   management packages (GetX, Bloc, Riverpod, etc.).

3. **No inline image/asset paths on pages.** Every asset path must be a constant
   in [lib/constants/images.dart](lib/constants/images.dart) (`ImagesDirectory`).
   Use e.g. `ImagesDirectory.avatar` / `ImagesDirectory.iconChevronRight` — never
   a raw `'assets/...'` string in a widget.

## Layout / structure

- Content lives in [lib/data/portfolio_data.dart](lib/data/portfolio_data.dart).
- Responsiveness uses [lib/helpers/responsive.dart](lib/helpers/responsive.dart)
  (`context.isMobile/.isTablet/.isDesktop`, `Responsive.value(...)`), not a
  third-party responsive package. Always keep the UI working on mobile, tablet
  and desktop.
- Sections: [lib/screens/home/sections/](lib/screens/home/sections/);
  reusable widgets: [lib/screens/home/widgets/](lib/screens/home/widgets/).
