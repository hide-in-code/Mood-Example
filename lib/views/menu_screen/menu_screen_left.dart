import 'package:flutter/material.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/routes.dart';
import 'package:moodexample/common/utils.dart';
import 'package:moodexample/l10n/gen/app_localizations.dart';

import 'package:moodexample/widgets/show_modal_bottom_detail/show_modal_bottom_detail.dart';

import 'package:moodexample/views/menu_screen/widgets/setting_theme.dart';
import 'package:moodexample/views/menu_screen/widgets/setting_language.dart';
import 'package:moodexample/views/menu_screen/widgets/setting_database.dart';
import 'package:moodexample/views/menu_screen/widgets/setting_key.dart';

/// 外层抽屉菜单（左）
class MenuScreenLeft extends StatelessWidget {
  const MenuScreenLeft({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const SafeArea(
        child: MenuScreenLeftBody(),
      ),
      onTap: () => ZoomDrawer.of(context)?.toggle.call(),
    );
  }
}

class MenuScreenLeftBody extends StatelessWidget {
  const MenuScreenLeftBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      children: [
        const Padding(
          padding: EdgeInsets.only(
            top: 72,
            bottom: 48,
            left: 24,
            right: 24,
          ),
          child: Header(),
        ),
        const Padding(
          padding: EdgeInsets.only(
            bottom: 24,
            left: 24,
            right: 24,
          ),
          child: Menu(),
        ),

        /// 插画
        BlockSemanticsToDrawerClosed(
          child: Container(
            padding: const EdgeInsets.only(left: 24, bottom: 24),
            child: Image.asset(
              'assets/images/woolly/woolly-comet-2.png',
              width: 240,
            ),
          ),
        ),
      ],
    );
  }
}

/// 头部
class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: '关闭设置',
      child: Row(
        children: [
          ClipRRect(
            key: const Key('widget_menu_screen_left_logo'),
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              'assets/images/logo.png',
              width: 42,
              height: 42,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              'Mood',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              semanticsLabel: '',
            ),
          ),
        ],
      ),
    );
  }
}

/// 菜单
class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final double _titleTextSize = 14;
    final double _titleIconSize = 20;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MenuList(
          icon: Icon(
            Remix.database_2_line,
            size: _titleIconSize,
          ),
          title: Text(
            S.of(context).app_setting_database,
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            print('数据');

            /// 底部内容弹出
            showModalBottomDetail(
              context: context,
              child: const SettingDatabase(),
            );
          },
        ),
        MenuList(
          icon: Icon(
            Remix.shield_keyhole_line,
            size: _titleIconSize,
          ),
          title: Text(
            S.of(context).app_setting_security,
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            print('安全');

            /// 底部内容弹出
            showModalBottomDetail(
              context: context,
              child: const SettingKey(),
            );
          },
        ),
        MenuList(
          icon: Icon(
            Remix.bubble_chart_line,
            size: _titleIconSize,
          ),
          title: Text(
            S.of(context).app_setting_theme,
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            print('主题');

            /// 底部内容弹出
            showModalBottomDetail(
              context: context,
              child: const SettingTheme(),
            );
          },
        ),
        MenuList(
          icon: Icon(
            Remix.global_line,
            size: _titleIconSize,
          ),
          title: Text(
            S.of(context).app_setting_language,
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            print('语言');

            /// 底部内容弹出
            showModalBottomDetail(
              context: context,
              child: const SettingLanguage(),
            );
          },
        ),
        MenuList(
          icon: Icon(
            Remix.flask_line,
            size: _titleIconSize,
          ),
          title: Text(
            S.of(context).app_setting_laboratory,
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            print('实验室');
            GoRouter.of(context).pushNamed(Routes.settingLaboratory);
          },
        ),
        MenuList(
          icon: Icon(
            Remix.heart_3_line,
            size: _titleIconSize,
          ),
          title: Text(
            S.of(context).app_setting_about,
            style: TextStyle(
              fontSize: _titleTextSize,
            ),
          ),
          onTap: () {
            print('关于');
            final String url =
                ValueConvert('https://github.com/AmosHuKe/Mood-Example')
                    .encode();
            GoRouter.of(context).pushNamed(
              Routes.webViewPage,
              pathParameters: {'url': url},
            );
          },
        ),
      ],
    );
  }
}

/// 菜单列表
class MenuList extends StatelessWidget {
  const MenuList({
    super.key,
    this.icon,
    required this.title,
    this.onTap,
  });

  // 图标
  final Widget? icon;
  // 标题
  final Widget title;
  // 点击事件
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return BlockSemanticsToDrawerClosed(
      child: ListTile(
        leading: icon,
        title: title,
        textColor: Colors.white,
        iconColor: Colors.white,
        minLeadingWidth: 0,
        horizontalTitleGap: 28,
        onTap: onTap,
      ),
    );
  }
}

/// 侧栏关闭状态下就不显示语义
class BlockSemanticsToDrawerClosed extends StatelessWidget {
  const BlockSemanticsToDrawerClosed({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DrawerState>(
      valueListenable: ZoomDrawer.of(context)!.stateNotifier,
      builder: (_, state, child) => BlockSemantics(
        blocking: state == DrawerState.closed,
        child: child,
      ),
      child: child,
    );
  }
}
