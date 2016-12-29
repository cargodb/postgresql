#if os(Linux)
  import libpostgresql_linux
  import GLibc
#else
  import libpostgresql_macos
  import Darwin
#endif

/// Oid values can be found in the following file:
/// https://github.com/postgres/postgres/blob/55c3391d1e6a201b5b891781d21fe682a8c64fe6/src/include/catalog/pg_type.h
internal enum OID: Oid {
    case bool           = 16
    case int2           = 21
    case int4           = 23
    case int8           = 20
    case bytea          = 17
    case char           = 18
    case name           = 19
    case text           = 25
    case bpchar         = 1042
    case varchar        = 1043
    case json           = 114
    case jsonb          = 3802
    case xml            = 142
    case float4         = 700
    case float8         = 701
    case numeric        = 1700
    case date           = 1082
    case time           = 1083
    case timetz         = 1266
    case timestamp      = 1114
    case timestamptz    = 1184
    case interval       = 1186
    case uuid           = 2950
    case point          = 600
    case lseg           = 601
    case path           = 602
    case box            = 603
    case polygon        = 604
    case circle         = 718
    case cidr           = 650
    case inet           = 869
    case macaddr        = 829
    case bit            = 1560
    case varbit         = 1562

    static let arraySupported: Set<Oid> = [
        1000,   // bool
        1005,   // int2
        1007,   // int4
        1016,   // int8
        1001,   // bytea
        1002,   // char
        1003,   // name
        1009,   // text
        1014,   // bpchar
        1015,   // varchar
        199,    // json
        3807,   // jsonb
        143,    // xml
        1021,   // float4
        1022,   // float8
        1231,   // numeric
        1182,   // date
        1183,   // time
        1270,   // timetz
        1115,   // timestamp
        1185,   // timestamptz
        1187,   // interval
        2951,   // uuid
        1017,   // point
        1018,   // lseg
        1019,   // path
        1020,   // box
        1027,   // polygon
        719,    // circle
        651,    // cidr
        1041,   // inet
        1040,   // macaddr
        1561,   // bit
        1563,   // varbit
    ]
}
