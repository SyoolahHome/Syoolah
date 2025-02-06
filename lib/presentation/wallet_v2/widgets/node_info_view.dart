import 'package:ditto/model/phoenixD_node_info.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';

class PhoenixDNodeInfoView extends StatelessWidget {
  const PhoenixDNodeInfoView({
    super.key,
    required this.nodeInfo,
  
  });

  final PhoenixDNodeInfo nodeInfo;
  
  
  @override
  Widget build(BuildContext context) {
    final heightSpace = 10.0;

    final tabs = <(String, Widget)>[
      (
        'Node Information',
        Builder(
          builder: (context) {
            final infoPairs = <String, String?>{
              'Node ID': nodeInfo.nodeId,
              'Chain': nodeInfo.chain,
              'Block Height': nodeInfo.blockHeight.toString(),
              'Version': nodeInfo.version,
            };

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  for (final entry in infoPairs.entries)
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      minVerticalPadding: 0,
                      title: Text(
                        entry.key,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      subtitle: Text(
                        entry.value ?? 'N/A',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.color
                                      ?.withOpacity(0.7),
                                ),
                      ),
                    ),
                  SizedBox(height: heightSpace * 2),
                
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: RoundaboutButton(
                  //     mainColor: Colors.red,
                  //     isOnlyBorder: true,
                  //     isRounded: true,
                  //     onTap: () {
                  //       closeChanTap();
                  //     },
                  //     icon: Icons.close_outlined,
                  //     iconSize: 22.5,
                  //     text: "Close Channel",
                  //   ),
                  // ),
                
                ],
              ),
            );
          },
        )
      ),
      (
        'Channels Details (${nodeInfo.channels.length})',
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (final channel in [
                ...nodeInfo.channels,
              ]) ...[
                SizedBox(height: heightSpace),
                Builder(
                  builder: (context) {
                    final infoPairs = <String, String?>{
                      'Channel ID': channel.channelId,
                      'State': channel.state,
                      'Balance': channel.balanceSat.toString(),
                      'Inbound Liquidity':
                          channel.inboundLiquiditySat.toString(),
                      'Capacity': channel.capacitySat.toString(),
                      'Funding Tx ID': channel.fundingTxId,
                    };

                    return Card(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withOpacity(.15),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            for (final entry in infoPairs.entries)
                              ListTile(
                                title: Text(
                                  entry.key,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                subtitle: Text(
                                  entry.value ?? 'N/A',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .labelMedium
                                            ?.color
                                            ?.withOpacity(0.7),
                                      ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        )
      ),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: MarginedBody(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: (heightSpace * 3) + kToolbarHeight),
            BottomSheetTitleWithIconButton(
              title: "Node Information & channels Details",
            ),
            SizedBox(height: heightSpace * 3),
            TabBar(
              labelColor: Theme.of(context).textTheme.labelMedium?.color,
              overlayColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.onSecondary.withOpacity(.15),
              ),
              tabs: tabs.map((tab) => Tab(child: Text(tab.$1))).toList(),
            ),
            Flexible(
              child: TabBarView(
                children: tabs.map((tab) => tab.$2).toList(),
              ),
            ),
            SizedBox(height: heightSpace * 2),
          ],
        ),
      ),
    );
  }
}
