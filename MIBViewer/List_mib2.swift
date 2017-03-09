//
//  List_mib2.swift
//  MIBViewer
//
//  Created by Pawel on 11.01.2017.
//  Copyright © 2017 PawelLearning. All rights reserved.
//

import Foundation

struct List_mib2 {
    
    let names:[String] = ["mib-2",
        "system",
        "sysDescr",
        "sysObjectID",
        "sysUpTime",
        "sysContact",
        "sysName",
        "sysLocation",
        "sysServices",
        "interfaces",
        "ifNumber",
        "ifTable",
        "ifEntry",
        "ifIndex",
        "ifDescr",
        "ifType",
        "ifMtu",
        "ifSpeed",
        "ifPhysAddress",
        "ifAdminStatus",
        "ifOperStatus",
        "ifLastChange",
        "ifInOctets",
        "ifInUcastPkts",
        "ifInNUcastPkts",
        "ifInDiscards",
        "ifInErrors",
        "ifInUnknownProtos",
        "ifOutOctets",
        "ifOutUcastPkts",
        "ifOutNUcastPkts",
        "ifOutDiscards",
        "ifOutErrors",
        "ifOutQLen",
        "ifSpecific",
        "at",
        "atTable",
        "atEntry",
        "atIfIndex",
        "atPhysAddress",
        "atNetAddress",
        "ip",
        "ipForwarding",
        "ipDefaultTTL",
        "ipInReceives",
        "ipInHdrErrors",
        "ipInAddrErrors",
        "ipForwDatagrams",
        "ipInUnknownProtos",
        "ipInDiscards",
        "ipInDelivers",
        "ipOutRequests",
        "ipOutDiscards",
        "ipOutNoRoutes",
        "ipReasmTimeout",
        "ipReasmReqds",
        "ipReasmOKs",
        "ipReasmFails",
        "ipFragOKs",
        "ipFragFails",
        "ipFragCreates",
        "ipAddrTable",
        "ipAddrEntry",
        "ipAdEntAddr",
        "ipAdEntIfIndex",
        "ipAdEntNetMask",
        "ipAdEntBcastAddrame",
        "ipAdEntReasmMaxSize",
        "ipRouteTable",
        "ipRouteEntry",
        "ipRouteDest",
        "ipRouteIfIndex",
        "ipRouteMetric1",
        "ipRouteMetric2",
        "ipRouteMetric3",
        "ipRouteMetric4",
        "ipRouteNextHop",
        "ipRouteType",
        "ipRouteProto",
        "ipRouteAge",
        "ipRouteMask",
        "ipRouteMetric5",
        "ipRouteInfo",
        "ipNetToMediaTable",
        "ipNetToMediaEntry",
        "ipNetToMediaIfIndex",
        "ipNetToMediaPhysAddress",
        "ipNetToMediaNetAddress",
        "ipNetToMediaType",
        "ipRoutingDiscards",
        "icmp",
        "icmpInMsgs",
        "icmpInErrors",
        "icmpInDestUnreachs",
        "icmpInTimeExcds",
        "icmpInParmProbs",
        "icmpInSrcQuenchs",
        "icmpInRedirects",
        "icmpInEchos",
        "icmpInEchoReps",
        "icmpInTimestamps",
        "icmpInTimestampReps",
        "icmpInAddrMasks",
        "icmpInAddrMaskReps",
        "icmpOutMsgs",
        "icmpOutErrors",
        "icmpOutDestUnreachs",
        "icmpOutTimeExcds",
        "icmpOutParmProbs",
        "icmpOutSrcQuenchs",
        "icmpOutRedirects",
        "icmpOutEchos",
        "icmpOutEchoReps",
        "icmpOutTimestamps",
        "icmpOutTimestampReps",
        "icmpOutAddrMasks",
        "icmpOutAddrMaskReps",
        "tcp",
        "tcpRtoAlgorithm",
        "tcpRtoMin",
        "tcpRtoMax",
        "tcpMaxConn",
        "tcpActiveOpens",
        "tcpPassiveOpens",
        "tcpAttemptFails",
        "tcpEstabResets",
        "tcpCurrEstab",
        "tcpInSegs",
        "tcpOutSegs",
        "tcpRetransSegs",
        "tcpConnTable",
        "tcpConnEntry",
        "tcpConnState",
        "tcpConnLocalAddress",
        "tcpConnLocalPort",
        "tcpConnRemAddress",
        "tcpConnRemPort",
        "tcpInErrs",
        "tcpOutRsts",
        "udp",
        "udpInDatagrams",
        "udpNoPorts",
        "udpInErrors",
        "udpOutDatagrams",
        "udpTable",
        "udpEntry",
        "udpLocalAddress",
        "udpLocalPort",
        "egp",
        "egpInMsgs",
        "egpInErrors",
        "egpOutMsgs",
        "egpOutErrors",
        "egpNeighTable",
        "egpNeighEntry",
        "egpNeighState",
        "egpNeighAddr",
        "egpNeighAs",
        "egpNeighInMsgs",
        "egpNeighInErrs",
        "egpNeighOutMsgs",
        "egpNeighOutErrs",
        "egpNeighInErrMsgs",
        "egpNeighOutErrMsgs",
        "egpNeighStateUps",
        "egpNeighStateDowns",
        "egpNeighIntervalHello",
        "egpNeighIntervalPoll",
        "egpNeighMode",
        "egpNeighEventTrigger",
        "egpAs",
        
        " transmission",
        
        "snmp",
        "snmpInPkts",
        "snmpOutPkts",
        "snmpInBadVersions",
        "snmpInBadCommunityNames",
        "snmpInBadCommunityUses",
        "snmpInASNParseErrs",
        "snmpInTooBigs",
        "snmpInNoSuchNames",
        "snmpInBadValues",
        "snmpInReadOnlys",
        "snmpInGenErrs",
        "snmpInTotalReqVars",
        "snmpInTotalSetVars",
        "snmpInGetRequests",
        "snmpInGetNexts",
        "snmpInSetRequests",
        "snmpInGetResponses",
        "snmpInTraps",
        "snmpOutTooBigs",
        "snmpOutNoSuchNames",
        "snmpOutBadValues",
        "snmpOutGenErrs",
        "snmpOutGetRequests",
        "snmpOutGetNexts",
        "snmpOutSetRequests",
        "snmpOutGetResponses",
        "snmpOutTraps",
        "snmpEnableAuthenTraps"
    ]
    
    let specialNames = ["ifIndex",
                        "ifDescr",
                        "ifType",
                        "ifMtu",
                        "ifSpeed",
                        "ifPhysAddress",
                        "ifAdminStatus",
                        "ifOperStatus",
                        "ifLastChange",
                        "ifInOctets",
                        "ifInUcastPkts",
                        "ifInNUcastPkts",
                        "ifInDiscards",
                        "ifInErrors",
                        "ifInUnknownProtos",
                        "ifOutOctets",
                        "ifOutUcastPkts",
                        "ifOutNUcastPkts",
                        "ifOutDiscards",
                        "ifOutErrors",
                        "ifOutQLen",
                        "ifSpecific",
                        
                        "atIfIndex",
                        "atPhysAddress",
                        "atNetAddress",
                        
                        "ipAdEntAddr",
                        "ipAdEntIfIndex",
                        "ipAdEntNetMask",
                        "ipAdEntBcastAddrame",
                        "ipAdEntReasmMaxSize",
                        
                        "ipRouteDest",
                        "ipRouteIfIndex",
                        "ipRouteMetric1",
                        "ipRouteMetric2",
                        "ipRouteMetric3",
                        "ipRouteMetric4",
                        "ipRouteNextHop",
                        "ipRouteType",
                        "ipRouteProto",
                        "ipRouteAge",
                        "ipRouteMask",
                        "ipRouteMetric5",
                        "ipRouteInfo",
                        
                        "ipNetToMediaIfIndex",
                        "ipNetToMediaPhysAddress",
                        "ipNetToMediaNetAddress",
                        "ipNetToMediaType",
                        
                        "tcpConnState",
                        "tcpConnLocalAddress",
                        "tcpConnLocalPort",
                        "tcpConnRemAddress",
                        "tcpConnRemPort",
                        
                        "udpLocalAddress",
                        "udpLocalPort",			
                        
                        "egpNeighState",
                        "egpNeighAddr",
                        "egpNeighAs",
                        "egpNeighInMsgs",
                        "egpNeighInErrs",
                        "egpNeighOutMsgs",
                        "egpNeighOutErrs",
                        "egpNeighInErrMsgs",
                        "egpNeighOutErrMsgs",
                        "egpNeighStateUps",
                        "egpNeighStateDowns",
                        "egpNeighIntervalHello",
                        "egpNeighIntervalPoll",
                        "egpNeighMode",
                        "egpNeighEventTrigger"
                ]

    
}