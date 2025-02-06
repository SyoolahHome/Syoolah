// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PhoenixDNodeInfo extends Equatable {
  final String? nodeId;
  final List<PhoenixDNodeChannelInfo> channels;
  final String? chain;
  final int? blockHeight;
  final String? version;

  PhoenixDNodeInfo({
    required this.nodeId,
    required this.channels,
    required this.chain,
    required this.blockHeight,
    required this.version,
  });

  factory PhoenixDNodeInfo.fromMap(Map<String, dynamic> map) {
    final channels = List<PhoenixDNodeChannelInfo>.from(
      map['channels'].map(
        (x) => PhoenixDNodeChannelInfo.fromMap(x),
      ),
    );

    return PhoenixDNodeInfo(
      nodeId: map['nodeId'],
      channels: channels,
      chain: map['chain'],
      blockHeight: map['blockHeight'],
      version: map['version'],
    );
  }

  @override
  List<Object?> get props => [
        nodeId,
        channels,
      ];
}

class PhoenixDNodeChannelInfo extends Equatable {
  final String? state;
  final String channelId;
  final int? balanceSat;
  final int? inboundLiquiditySat;
  final int? capacitySat;
  final String? fundingTxId;

  PhoenixDNodeChannelInfo({
    required this.channelId,
    required this.state,
    required this.balanceSat,
    required this.inboundLiquiditySat,
    required this.capacitySat,
    required this.fundingTxId,
  });

  factory PhoenixDNodeChannelInfo.fromMap(Map<String, dynamic> map) {
    return PhoenixDNodeChannelInfo(
      state: map['state'],
      channelId: map['channelId'],
      balanceSat: map['balanceSat'],
      inboundLiquiditySat: map['inboundLiquiditySat'],
      capacitySat: map['capacitySat'],
      fundingTxId: map['fundingTxId'],
    );
  }

  @override
  List<Object?> get props => [
        state,
        channelId,
        balanceSat,
        inboundLiquiditySat,
        capacitySat,
        fundingTxId,
      ];
}
