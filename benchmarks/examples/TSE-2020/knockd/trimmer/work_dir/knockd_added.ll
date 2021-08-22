; ModuleID = './work_dir/knockd_added.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.__pmlist_t = type { i8*, %struct.__pmlist_t*, %struct.__pmlist_t* }
%struct.pcap = type opaque
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.option = type { i8*, i32, i32*, i32 }
%struct.opendoor = type { [128 x i8], i16, [32 x i16], [32 x i16], i64, i8*, i64, i8*, i32, i32, i32, i32, i32, i32, %struct._IO_FILE*, i8* }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%union.__WAIT_STATUS = type { %struct.in_addr* }
%struct.in_addr = type { i32 }
%struct.ifreq = type { %union.anon, %union.anon.1 }
%union.anon = type { [16 x i8] }
%union.anon.1 = type { %struct.ifmap }
%struct.ifmap = type { i64, i64, i16, i8, i8, i8 }
%struct.sockaddr = type { i16, [14 x i8] }
%struct.sockaddr_in = type { i16, i16, %struct.in_addr, [8 x i8] }
%struct.bpf_program = type { i32, %struct.bpf_insn* }
%struct.bpf_insn = type { i16, i8, i8, i32 }
%struct.tm = type { i32, i32, i32, i32, i32, i32, i32, i32, i32, i64, i8* }
%struct.pcap_pkthdr = type { %struct.timeval, i32, i32 }
%struct.timeval = type { i64, i64 }
%struct.ethhdr = type { [6 x i8], [6 x i8], i16 }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, i32, i32 }
%struct.tcphdr = type { %union.anon.4 }
%union.anon.4 = type { %struct.anon.5 }
%struct.anon.5 = type { i16, i16, i32, i32, i8, i8, i16, i16, i16 }
%struct.anon.6 = type { i16, i16, i32, i32, i16, i16, i16, i16 }
%struct.udphdr = type { %union.anon.7 }
%union.anon.7 = type { %struct.anon.8 }
%struct.anon.8 = type { i16, i16, i16, i16 }
%struct.knocker = type { %struct.opendoor*, i16, [16 x i8], i8*, i64 }
%struct.hostent = type { i8*, i8**, i32, i32, i8** }

@doors = dso_local global %struct.__pmlist_t* null, align 8, !track !0
@attempts = dso_local global %struct.__pmlist_t* null, align 8, !track !1
@cap = dso_local global %struct.pcap* null, align 8, !track !2
@logfd = dso_local global %struct._IO_FILE* null, align 8, !track !3
@lltype = dso_local global i32 -1, align 4
@o_usesyslog = dso_local global i32 0, align 4
@o_verbose = dso_local global i32 0, align 4
@o_debug = dso_local global i32 0, align 4
@o_daemon = dso_local global i32 0, align 4
@o_lookup = dso_local global i32 0, align 4
@o_int = dso_local global [32 x i8] zeroinitializer, align 16, !track !4
@o_cfg = dso_local global [100 x i8] c"/etc/knockd.conf\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", align 16, !track !5
@o_pidfile = dso_local global [100 x i8] c"/var/run/knockd.pid\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00", align 16, !track !6
@o_logfile = dso_local global [100 x i8] zeroinitializer, align 16, !track !7
@myip = common dso_local global [32 x i8] zeroinitializer, align 16, !track !8
@.str.8 = private unnamed_addr constant [11 x i8] c"vDdli:c:hV\00", align 1
@main.opts = internal global [9 x %struct.option] [%struct.option { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i32 0, i32 0), i32 0, i32* null, i32 118 }, %struct.option { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i32 0, i32 0), i32 0, i32* null, i32 68 }, %struct.option { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i32 0, i32 0), i32 0, i32* null, i32 100 }, %struct.option { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.3, i32 0, i32 0), i32 0, i32* null, i32 108 }, %struct.option { i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.4, i32 0, i32 0), i32 1, i32* null, i32 105 }, %struct.option { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.5, i32 0, i32 0), i32 1, i32* null, i32 99 }, %struct.option { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0), i32 0, i32* null, i32 104 }, %struct.option { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.7, i32 0, i32 0), i32 0, i32* null, i32 86 }, %struct.option zeroinitializer], align 16
@optarg = external dso_local global i8*, align 8
@.str.9 = private unnamed_addr constant [5 x i8] c"eth0\00", align 1
@.str.10 = private unnamed_addr constant [7 x i8] c"knockd\00", align 1
@.str.11 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str.12 = private unnamed_addr constant [29 x i8] c"warning: cannot open logfile\00", align 1
@stderr = external dso_local global %struct._IO_FILE*, align 8
@.str.13 = private unnamed_addr constant [23 x i8] c"could not open %s: %s\0A\00", align 1
@.str.14 = private unnamed_addr constant [29 x i8] c"ethernet interface detected\0A\00", align 1
@.str.15 = private unnamed_addr constant [55 x i8] c"ppp interface detected (linux \22cooked\22 encapsulation)\0A\00", align 1
@.str.16 = private unnamed_addr constant [42 x i8] c"raw interface detected, no encapsulation\0A\00", align 1
@.str.17 = private unnamed_addr constant [40 x i8] c"error: unsupported link-layer type: %d\0A\00", align 1
@.str.18 = private unnamed_addr constant [33 x i8] c"could not get IP address for %s\0A\00", align 1
@.str.19 = private unnamed_addr constant [14 x i8] c"Local IP: %s\0A\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"daemon\00", align 1
@.str.20 = private unnamed_addr constant [2 x i8] c"w\00", align 1
@.str.21 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str.22 = private unnamed_addr constant [34 x i8] c"could not create pid file %s: %s\0A\00", align 1
@.str.23 = private unnamed_addr constant [33 x i8] c"could not create pid file %s: %s\00", align 1
@.str.24 = private unnamed_addr constant [20 x i8] c"listening on %s...\0A\00", align 1
@.str.25 = private unnamed_addr constant [29 x i8] c"starting up, listening on %s\00", align 1
@.str.26 = private unnamed_addr constant [35 x i8] c"bailed out of main loop! (ret=%d)\0A\00", align 1
@.str.27 = private unnamed_addr constant [5 x i8] c"pcap\00", align 1
@.str.134 = private unnamed_addr constant [33 x i8] c"packet is not IPv4, ignoring...\0A\00", align 1
@.str.135 = private unnamed_addr constant [44 x i8] c"error: could not understand IP address: %s\0A\00", align 1
@.str.136 = private unnamed_addr constant [47 x i8] c"packet destined for another host, ignoring...\0A\00", align 1
@.str.137 = private unnamed_addr constant [4 x i8] c"tcp\00", align 1
@.str.138 = private unnamed_addr constant [4 x i8] c"udp\00", align 1
@.str.139 = private unnamed_addr constant [15 x i8] c"%04d-%02d-%02d\00", align 1
@.str.140 = private unnamed_addr constant [15 x i8] c"%02d:%02d:%02d\00", align 1
@.str.141 = private unnamed_addr constant [36 x i8] c"%s %s: %s: %s:%d -> %s:%d %d bytes\0A\00", align 1
@.str.142 = private unnamed_addr constant [40 x i8] c"removing successful knock attempt (%s)\0A\00", align 1
@.str.143 = private unnamed_addr constant [36 x i8] c"removing failed knock attempt (%s)\0A\00", align 1
@.str.144 = private unnamed_addr constant [42 x i8] c"%s (%s): %s: sequence timeout (stage %d)\0A\00", align 1
@.str.145 = private unnamed_addr constant [37 x i8] c"%s: %s: sequence timeout (stage %d)\0A\00", align 1
@.str.146 = private unnamed_addr constant [32 x i8] c"packet is not FIN, ignoring...\0A\00", align 1
@.str.147 = private unnamed_addr constant [33 x i8] c"packet is not !FIN, ignoring...\0A\00", align 1
@.str.148 = private unnamed_addr constant [32 x i8] c"packet is not SYN, ignoring...\0A\00", align 1
@.str.149 = private unnamed_addr constant [33 x i8] c"packet is not !SYN, ignoring...\0A\00", align 1
@.str.150 = private unnamed_addr constant [32 x i8] c"packet is not RST, ignoring...\0A\00", align 1
@.str.151 = private unnamed_addr constant [33 x i8] c"packet is not !RST, ignoring...\0A\00", align 1
@.str.152 = private unnamed_addr constant [32 x i8] c"packet is not PSH, ignoring...\0A\00", align 1
@.str.153 = private unnamed_addr constant [33 x i8] c"packet is not !PSH, ignoring...\0A\00", align 1
@.str.154 = private unnamed_addr constant [32 x i8] c"packet is not ACK, ignoring...\0A\00", align 1
@.str.155 = private unnamed_addr constant [33 x i8] c"packet is not !ACK, ignoring...\0A\00", align 1
@.str.156 = private unnamed_addr constant [32 x i8] c"packet is not URG, ignoring...\0A\00", align 1
@.str.157 = private unnamed_addr constant [33 x i8] c"packet is not !URG, ignoring...\0A\00", align 1
@.str.158 = private unnamed_addr constant [23 x i8] c"%s (%s): %s: Stage %d\0A\00", align 1
@.str.159 = private unnamed_addr constant [22 x i8] c"%s (%s): %s: Stage %d\00", align 1
@.str.160 = private unnamed_addr constant [18 x i8] c"%s: %s: Stage %d\0A\00", align 1
@.str.161 = private unnamed_addr constant [17 x i8] c"%s: %s: Stage %d\00", align 1
@.str.162 = private unnamed_addr constant [26 x i8] c"%s (%s): %s: OPEN SESAME\0A\00", align 1
@.str.163 = private unnamed_addr constant [25 x i8] c"%s (%s): %s: OPEN SESAME\00", align 1
@.str.164 = private unnamed_addr constant [21 x i8] c"%s: %s: OPEN SESAME\0A\00", align 1
@.str.165 = private unnamed_addr constant [20 x i8] c"%s: %s: OPEN SESAME\00", align 1
@.str.166 = private unnamed_addr constant [70 x i8] c"error: parsed start command has been truncated! --> won't execute it\0A\00", align 1
@.str.167 = private unnamed_addr constant [69 x i8] c"error: parsed start command has been truncated! --> won't execute it\00", align 1
@.str.168 = private unnamed_addr constant [80 x i8] c"error: parsed stop command has been truncated! --> won't execute start command\0A\00", align 1
@.str.169 = private unnamed_addr constant [79 x i8] c"error: parsed stop command has been truncated! --> won't execute start command\00", align 1
@.str.170 = private unnamed_addr constant [30 x i8] c"%s (%s): %s: command timeout\0A\00", align 1
@.str.171 = private unnamed_addr constant [29 x i8] c"%s (%s): %s: command timeout\00", align 1
@.str.172 = private unnamed_addr constant [25 x i8] c"%s: %s: command timeout\0A\00", align 1
@.str.173 = private unnamed_addr constant [24 x i8] c"%s: %s: command timeout\00", align 1
@.str.56 = private unnamed_addr constant [7 x i8] c"malloc\00", align 1
@.str.174 = private unnamed_addr constant [22 x i8] c"%s (%s): %s: Stage 1\0A\00", align 1
@.str.175 = private unnamed_addr constant [21 x i8] c"%s (%s): %s: Stage 1\00", align 1
@.str.176 = private unnamed_addr constant [17 x i8] c"%s: %s: Stage 1\0A\00", align 1
@.str.177 = private unnamed_addr constant [16 x i8] c"%s: %s: Stage 1\00", align 1
@.str.109 = private unnamed_addr constant [90 x i8] c"no more sequences left in the one time sequences file for door %s --> disabling the door\0A\00", align 1
@.str.110 = private unnamed_addr constant [27 x i8] c"new sequence for door %s: \00", align 1
@.str.30 = private unnamed_addr constant [8 x i8] c"%u:udp\0A\00", align 1
@.str.31 = private unnamed_addr constant [8 x i8] c"%u:udp,\00", align 1
@.str.32 = private unnamed_addr constant [8 x i8] c"%u:tcp\0A\00", align 1
@.str.33 = private unnamed_addr constant [8 x i8] c"%u:tcp,\00", align 1
@stdout = external dso_local global %struct._IO_FILE*, align 8
@.str.86 = private unnamed_addr constant [2 x i8] c",\00", align 1
@.str.102 = private unnamed_addr constant [54 x i8] c"config: section %s: too many ports in knock sequence\0A\00", align 1
@.str.103 = private unnamed_addr constant [53 x i8] c"error: section %s: too many ports in knock sequence\0A\00", align 1
@.str.104 = private unnamed_addr constant [2 x i8] c":\00", align 1
@.str.105 = private unnamed_addr constant [4 x i8] c"TCP\00", align 1
@.str.106 = private unnamed_addr constant [4 x i8] c"UDP\00", align 1
@.str.107 = private unnamed_addr constant [56 x i8] c"config: section %s: unknown protocol in knock sequence\0A\00", align 1
@.str.108 = private unnamed_addr constant [55 x i8] c"error: section %s: unknown protocol in knock sequence\0A\00", align 1
@.str.111 = private unnamed_addr constant [81 x i8] c"error while disabling used one time sequence for door %s --> disabling the door\0A\00", align 1
@.str.129 = private unnamed_addr constant [25 x i8] c"%s: running command: %s\0A\00", align 1
@.str.130 = private unnamed_addr constant [29 x i8] c"error: command fork failed!\0A\00", align 1
@.str.131 = private unnamed_addr constant [28 x i8] c"error: command fork failed!\00", align 1
@.str.132 = private unnamed_addr constant [48 x i8] c"%s: command returned non-zero status code (%d)\0A\00", align 1
@.str.133 = private unnamed_addr constant [47 x i8] c"%s: command returned non-zero status code (%d)\00", align 1
@.str.128 = private unnamed_addr constant [5 x i8] c"%IP%\00", align 1
@.str.38 = private unnamed_addr constant [28 x i8] c"Re-reading config file: %s\0A\00", align 1
@.str.28 = private unnamed_addr constant [3 x i8] c"%s\00", align 1
@.str.29 = private unnamed_addr constant [31 x i8] c"[%04d-%02d-%02d %02d:%02d] %s\0A\00", align 1
@.str.112 = private unnamed_addr constant [16 x i8] c"((tcp dst port \00", align 1
@.str.113 = private unnamed_addr constant [5 x i8] c" or \00", align 1
@.str.114 = private unnamed_addr constant [4 x i8] c"%hu\00", align 1
@.str.115 = private unnamed_addr constant [2 x i8] c")\00", align 1
@.str.116 = private unnamed_addr constant [30 x i8] c" and tcp[tcpflags] & tcp-fin \00", align 1
@.str.117 = private unnamed_addr constant [5 x i8] c"!= 0\00", align 1
@.str.118 = private unnamed_addr constant [5 x i8] c"== 0\00", align 1
@.str.119 = private unnamed_addr constant [30 x i8] c" and tcp[tcpflags] & tcp-syn \00", align 1
@.str.120 = private unnamed_addr constant [30 x i8] c" and tcp[tcpflags] & tcp-rst \00", align 1
@.str.121 = private unnamed_addr constant [30 x i8] c" and tcp[tcpflags] & tcp-psh \00", align 1
@.str.122 = private unnamed_addr constant [30 x i8] c" and tcp[tcpflags] & tcp-ack \00", align 1
@.str.123 = private unnamed_addr constant [30 x i8] c" and tcp[tcpflags] & tcp-urg \00", align 1
@.str.124 = private unnamed_addr constant [15 x i8] c"(udp dst port \00", align 1
@.str.125 = private unnamed_addr constant [8 x i8] c"realloc\00", align 1
@.str.126 = private unnamed_addr constant [10 x i8] c"dst host \00", align 1
@.str.127 = private unnamed_addr constant [7 x i8] c" and (\00", align 1
@.str.34 = private unnamed_addr constant [32 x i8] c"waiting for child processes...\0A\00", align 1
@.str.35 = private unnamed_addr constant [31 x i8] c"waiting for child processes...\00", align 1
@.str.36 = private unnamed_addr constant [12 x i8] c"closing...\0A\00", align 1
@.str.37 = private unnamed_addr constant [14 x i8] c"shutting down\00", align 1
@.str.52 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.53 = private unnamed_addr constant [27 x i8] c"config: new section: '%s'\0A\00", align 1
@.str.54 = private unnamed_addr constant [35 x i8] c"config: line %d: bad section name\0A\00", align 1
@.str.55 = private unnamed_addr constant [8 x i8] c"options\00", align 1
@.str.57 = private unnamed_addr constant [58 x i8] c"config: line %d: all directives must belong to a section\0A\00", align 1
@.str.58 = private unnamed_addr constant [2 x i8] c"=\00", align 1
@.str.59 = private unnamed_addr constant [31 x i8] c"config: line %d: syntax error\0A\00", align 1
@.str.60 = private unnamed_addr constant [10 x i8] c"USESYSLOG\00", align 1
@.str.61 = private unnamed_addr constant [19 x i8] c"config: usesyslog\0A\00", align 1
@.str.62 = private unnamed_addr constant [8 x i8] c"LOGFILE\00", align 1
@.str.63 = private unnamed_addr constant [22 x i8] c"config: log file: %s\0A\00", align 1
@.str.64 = private unnamed_addr constant [8 x i8] c"PIDFILE\00", align 1
@.str.65 = private unnamed_addr constant [22 x i8] c"config: pid file: %s\0A\00", align 1
@.str.66 = private unnamed_addr constant [10 x i8] c"INTERFACE\00", align 1
@.str.67 = private unnamed_addr constant [23 x i8] c"config: interface: %s\0A\00", align 1
@.str.68 = private unnamed_addr constant [62 x i8] c"config: line %d: \22%s\22 can only be used within a Door section\0A\00", align 1
@.str.69 = private unnamed_addr constant [9 x i8] c"SEQUENCE\00", align 1
@.str.70 = private unnamed_addr constant [23 x i8] c"config: %s: sequence: \00", align 1
@.str.71 = private unnamed_addr constant [19 x i8] c"ONE_TIME_SEQUENCES\00", align 1
@.str.72 = private unnamed_addr constant [3 x i8] c"r+\00", align 1
@.str.73 = private unnamed_addr constant [41 x i8] c"config: %s: one time sequences file: %s\0A\00", align 1
@.str.74 = private unnamed_addr constant [66 x i8] c"config: no more sequences left in the one time sequences file %s\0A\00", align 1
@.str.75 = private unnamed_addr constant [12 x i8] c"SEQ_TIMEOUT\00", align 1
@.str.76 = private unnamed_addr constant [8 x i8] c"TIMEOUT\00", align 1
@.str.77 = private unnamed_addr constant [29 x i8] c"config: %s: seq_timeout: %d\0A\00", align 1
@.str.78 = private unnamed_addr constant [14 x i8] c"START_COMMAND\00", align 1
@.str.79 = private unnamed_addr constant [8 x i8] c"COMMAND\00", align 1
@.str.80 = private unnamed_addr constant [31 x i8] c"config: %s: start_command: %s\0A\00", align 1
@.str.81 = private unnamed_addr constant [12 x i8] c"CMD_TIMEOUT\00", align 1
@.str.82 = private unnamed_addr constant [29 x i8] c"config: %s: cmd_timeout: %d\0A\00", align 1
@.str.83 = private unnamed_addr constant [13 x i8] c"STOP_COMMAND\00", align 1
@.str.84 = private unnamed_addr constant [30 x i8] c"config: %s: stop_command: %s\0A\00", align 1
@.str.85 = private unnamed_addr constant [9 x i8] c"TCPFLAGS\00", align 1
@.str.87 = private unnamed_addr constant [4 x i8] c"FIN\00", align 1
@.str.88 = private unnamed_addr constant [5 x i8] c"!FIN\00", align 1
@.str.89 = private unnamed_addr constant [4 x i8] c"SYN\00", align 1
@.str.90 = private unnamed_addr constant [5 x i8] c"!SYN\00", align 1
@.str.91 = private unnamed_addr constant [4 x i8] c"RST\00", align 1
@.str.92 = private unnamed_addr constant [5 x i8] c"!RST\00", align 1
@.str.93 = private unnamed_addr constant [4 x i8] c"PSH\00", align 1
@.str.94 = private unnamed_addr constant [5 x i8] c"!PSH\00", align 1
@.str.95 = private unnamed_addr constant [4 x i8] c"ACK\00", align 1
@.str.96 = private unnamed_addr constant [5 x i8] c"!ACK\00", align 1
@.str.97 = private unnamed_addr constant [4 x i8] c"URG\00", align 1
@.str.98 = private unnamed_addr constant [5 x i8] c"!URG\00", align 1
@.str.99 = private unnamed_addr constant [41 x i8] c"config: line %d: unrecognized flag \22%s\22\0A\00", align 1
@.str.100 = private unnamed_addr constant [22 x i8] c"config: tcp flag: %s\0A\00", align 1
@.str.101 = private unnamed_addr constant [49 x i8] c"error: section '%s' has an empty knock sequence\0A\00", align 1
@.str.39 = private unnamed_addr constant [25 x i8] c"usage: knockd [options]\0A\00", align 1
@.str.40 = private unnamed_addr constant [10 x i8] c"options:\0A\00", align 1
@.str.41 = private unnamed_addr constant [74 x i8] c"  -i, --interface <int>  network interface to listen on (default \22eth0\22)\0A\00", align 1
@.str.42 = private unnamed_addr constant [42 x i8] c"  -d, --daemon           run as a daemon\0A\00", align 1
@.str.43 = private unnamed_addr constant [55 x i8] c"  -c, --config <file>    use an alternate config file\0A\00", align 1
@.str.44 = private unnamed_addr constant [48 x i8] c"  -D, --debug            output debug messages\0A\00", align 1
@.str.45 = private unnamed_addr constant [68 x i8] c"  -l, --lookup           lookup DNS names (may be a security risk)\0A\00", align 1
@.str.46 = private unnamed_addr constant [37 x i8] c"  -v, --verbose          be verbose\0A\00", align 1
@.str.47 = private unnamed_addr constant [42 x i8] c"  -V, --version          display version\0A\00", align 1
@.str.48 = private unnamed_addr constant [36 x i8] c"  -h, --help             this help\0A\00", align 1
@.str.49 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.50 = private unnamed_addr constant [11 x i8] c"knockd %s\0A\00", align 1
@version = internal global [4 x i8] c"0.5\00", align 1
@.str.51 = private unnamed_addr constant [58 x i8] c"Copyright (C) 2004-2005 Judd Vinet <jvinet@zeroflux.org>\0A\00", align 1
@.str = private unnamed_addr constant [8 x i8] c"verbose\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"debug\00", align 1
@.str.3 = private unnamed_addr constant [7 x i8] c"lookup\00", align 1
@.str.4 = private unnamed_addr constant [10 x i8] c"interface\00", align 1
@.str.5 = private unnamed_addr constant [7 x i8] c"config\00", align 1
@.str.6 = private unnamed_addr constant [5 x i8] c"help\00", align 1
@.str.7 = private unnamed_addr constant [8 x i8] c"version\00", align 1
@.str.178 = private unnamed_addr constant [8 x i8] c"COLUMNS\00", align 1
@.str.1.179 = private unnamed_addr constant [4 x i8] c"%s \00", align 1
@.str.2.180 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.3.181 = private unnamed_addr constant [2 x i8] c" \00", align 1
@.str.4.182 = private unnamed_addr constant [6 x i8] c"None\0A\00", align 1
@0 = private constant [6 x i8] c"knockd"
@1 = private constant [2 x i8] c"-i"
@2 = private constant [4 x i8] c"eth0"
@__argv_new__ = global i8** null, !track !9

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32, i8**) #0 {
  %3 = call i8* @malloc(i64 32)
  %4 = bitcast i8* %3 to i8**
  store i8** %4, i8*** @__argv_new__
  %5 = load i8**, i8*** @__argv_new__
  %6 = getelementptr i8*, i8** %5, i32 0
  %7 = call i8* @malloc(i64 100)
  store i8* %7, i8** %6
  %8 = load i8*, i8** %6
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @0, i32 0, i32 0), i64 100, i1 false)
  %9 = getelementptr i8, i8* %8, i32 6
  store i8 0, i8* %9
  %10 = load i8**, i8*** @__argv_new__
  %11 = getelementptr i8*, i8** %10, i32 1
  %12 = call i8* @malloc(i64 100)
  store i8* %12, i8** %11
  %13 = load i8*, i8** %11
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @1, i32 0, i32 0), i64 100, i1 false)
  %14 = getelementptr i8, i8* %13, i32 2
  store i8 0, i8* %14
  %15 = load i8**, i8*** @__argv_new__
  %16 = getelementptr i8*, i8** %15, i32 2
  %17 = call i8* @malloc(i64 100)
  store i8* %17, i8** %16
  %18 = load i8*, i8** %16
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %18, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @2, i32 0, i32 0), i64 100, i1 false)
  %19 = getelementptr i8, i8* %18, i32 4
  store i8 0, i8* %19
  %20 = load i8**, i8*** @__argv_new__
  %21 = getelementptr i8*, i8** %20, i32 3
  store i8* null, i8** %21
  %22 = alloca [256 x i8], align 16, !track !12
  %23 = alloca i32, align 4
  %24 = bitcast [256 x i8]* %22 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 16 %24, i8 0, i64 256, i1 false)
  store i32 1, i32* %23, align 4
  %25 = getelementptr [11 x i8], [11 x i8]* @.str.8, i32 0, i32 0
  %26 = getelementptr [9 x %struct.option], [9 x %struct.option]* @main.opts, i32 0, i32 0
  %27 = call i32 @getopt_long(i32 3, i8** %20, i8* %25, %struct.option* %26, i32* %23) #7, !track_argc !13
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %.lr.ph.preheader, label %.loopexit

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %48
  %29 = phi i32 [ %51, %48 ], [ %27, %.lr.ph.preheader ]
  call void @unroll_loop(i32 1)
  %30 = icmp slt i32 %29, 0
  br i1 %30, label %.loopexit.loopexit, label %31

; <label>:31:                                     ; preds = %.lr.ph
  switch i32 %29, label %47 [
    i32 0, label %48
    i32 118, label %32
    i32 68, label %33
    i32 100, label %34
    i32 108, label %35
    i32 105, label %36
    i32 99, label %41
    i32 86, label %46
  ]

; <label>:32:                                     ; preds = %31
  store i32 1, i32* @o_verbose, align 4
  br label %48

; <label>:33:                                     ; preds = %31
  store i32 1, i32* @o_debug, align 4
  br label %48

; <label>:34:                                     ; preds = %31
  store i32 1, i32* @o_daemon, align 4
  br label %48

; <label>:35:                                     ; preds = %31
  store i32 1, i32* @o_lookup, align 4
  br label %48

; <label>:36:                                     ; preds = %31
  %37 = load i8*, i8** @optarg, align 8
  %38 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %39 = call i8* @strncpy(i8* %38, i8* %37, i64 31) #7, !track !14
  %40 = getelementptr [32 x i8], [32 x i8]* @o_int, i64 0, i64 31
  store i8 0, i8* %40, align 1
  br label %48

; <label>:41:                                     ; preds = %31
  %42 = load i8*, i8** @optarg, align 8
  %43 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i32 0, i32 0
  %44 = call i8* @strncpy(i8* %43, i8* %42, i64 99) #7, !track !15
  %45 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99
  store i8 0, i8* %45, align 1
  br label %48

; <label>:46:                                     ; preds = %31
  call void @ver()
  br label %47

; <label>:47:                                     ; preds = %46, %31
  call void @usage()
  br label %48

; <label>:48:                                     ; preds = %31, %47, %41, %36, %35, %34, %33, %32
  %49 = getelementptr [11 x i8], [11 x i8]* @.str.8, i32 0, i32 0
  %50 = getelementptr [9 x %struct.option], [9 x %struct.option]* @main.opts, i32 0, i32 0
  %51 = call i32 @getopt_long(i32 3, i8** %20, i8* %49, %struct.option* %50, i32* %23) #7, !track_argc !13
  %52 = icmp ne i32 %51, 0
  br i1 %52, label %.lr.ph, label %.loopexit.loopexit

.loopexit.loopexit:                               ; preds = %.lr.ph, %48
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %2
  %53 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i32 0, i32 0
  %54 = call i32 @parseconfig(i8* %53)
  %55 = icmp ne i32 %54, 0
  br i1 %55, label %56, label %57

; <label>:56:                                     ; preds = %.loopexit
  call void @exit(i32 1) #9
  unreachable

; <label>:57:                                     ; preds = %.loopexit
  %58 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %59 = call i64 @strlen(i8* %58) #10
  %60 = icmp eq i64 %59, 0
  br i1 %60, label %61, label %65

; <label>:61:                                     ; preds = %57
  %62 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %63 = getelementptr [5 x i8], [5 x i8]* @.str.9, i32 0, i32 0
  %64 = call i8* @strncpy(i8* %62, i8* %63, i64 32) #7, !track !16
  br label %65

; <label>:65:                                     ; preds = %61, %57
  %66 = load i32, i32* @o_usesyslog, align 4
  %67 = icmp ne i32 %66, 0
  br i1 %67, label %68, label %70

; <label>:68:                                     ; preds = %65
  %69 = getelementptr [7 x i8], [7 x i8]* @.str.10, i32 0, i32 0
  call void @openlog(i8* %69, i32 0, i32 8)
  br label %70

; <label>:70:                                     ; preds = %68, %65
  %71 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  %72 = call i64 @strlen(i8* %71) #10
  %73 = icmp ne i64 %72, 0
  br i1 %73, label %74, label %82

; <label>:74:                                     ; preds = %70
  %75 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  %76 = getelementptr [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %77 = call %struct._IO_FILE* @fopen(i8* %75, i8* %76), !track !17
  store %struct._IO_FILE* %77, %struct._IO_FILE** @logfd, align 8
  %78 = load %struct._IO_FILE*, %struct._IO_FILE** @logfd, align 8
  %79 = icmp eq %struct._IO_FILE* %78, null
  br i1 %79, label %80, label %82

; <label>:80:                                     ; preds = %74
  %81 = getelementptr [29 x i8], [29 x i8]* @.str.12, i32 0, i32 0
  call void @perror(i8* %81)
  br label %82

; <label>:82:                                     ; preds = %74, %80, %70
  %83 = getelementptr inbounds [256 x i8], [256 x i8]* %22, i32 0, i32 0
  %84 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %85 = call %struct.pcap* @pcap_open_live(i8* %84, i32 65535, i32 0, i32 0, i8* %83)
  store %struct.pcap* %85, %struct.pcap** @cap, align 8
  %86 = getelementptr inbounds [256 x i8], [256 x i8]* %22, i32 0, i32 0
  %87 = call i64 @strlen(i8* %86) #10
  %88 = icmp ne i64 %87, 0
  br i1 %88, label %89, label %95

; <label>:89:                                     ; preds = %82
  %90 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %91 = getelementptr inbounds [256 x i8], [256 x i8]* %22, i32 0, i32 0
  %92 = getelementptr [23 x i8], [23 x i8]* @.str.13, i32 0, i32 0
  %93 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %94 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %90, i8* %92, i8* %93, i8* %91)
  br label %95

; <label>:95:                                     ; preds = %89, %82
  %96 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %97 = icmp eq %struct.pcap* %96, null
  br i1 %97, label %98, label %99

; <label>:98:                                     ; preds = %95
  call void @exit(i32 1) #9
  unreachable

; <label>:99:                                     ; preds = %95
  %100 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %101 = call i32 @pcap_datalink(%struct.pcap* %100)
  store i32 %101, i32* @lltype, align 4
  %102 = load i32, i32* @lltype, align 4
  switch i32 %102, label %109 [
    i32 1, label %103
    i32 113, label %105
    i32 12, label %107
  ]

; <label>:103:                                    ; preds = %99
  %104 = getelementptr [29 x i8], [29 x i8]* @.str.14, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %104)
  br label %114

; <label>:105:                                    ; preds = %99
  %106 = getelementptr [55 x i8], [55 x i8]* @.str.15, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %106)
  br label %114

; <label>:107:                                    ; preds = %99
  %108 = getelementptr [42 x i8], [42 x i8]* @.str.16, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %108)
  br label %114

; <label>:109:                                    ; preds = %99
  %110 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %111 = load i32, i32* @lltype, align 4
  %112 = getelementptr [40 x i8], [40 x i8]* @.str.17, i32 0, i32 0
  %113 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %110, i8* %112, i32 %111)
  call void @cleanup(i32 1)
  br label %114

; <label>:114:                                    ; preds = %109, %107, %105, %103
  %115 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %116 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %117 = call i8* @get_ip(i8* %115, i8* %116, i32 32)
  %118 = icmp eq i8* %117, null
  br i1 %118, label %119, label %124

; <label>:119:                                    ; preds = %114
  %120 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %121 = getelementptr [33 x i8], [33 x i8]* @.str.18, i32 0, i32 0
  %122 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %123 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %120, i8* %121, i8* %122)
  call void @cleanup(i32 1)
  br label %127

; <label>:124:                                    ; preds = %114
  %125 = getelementptr [14 x i8], [14 x i8]* @.str.19, i32 0, i32 0
  %126 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %125, i8* %126)
  br label %127

; <label>:127:                                    ; preds = %124, %119
  call void @generate_pcap_filter()
  %128 = load i32, i32* @o_daemon, align 4
  %129 = icmp ne i32 %128, 0
  br i1 %129, label %130, label %156

; <label>:130:                                    ; preds = %127
  %131 = call i32 @daemon(i32 0, i32 0) #7
  %132 = icmp slt i32 %131, 0
  br i1 %132, label %133, label %135

; <label>:133:                                    ; preds = %130
  %134 = getelementptr [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  call void @perror(i8* %134)
  call void @cleanup(i32 1)
  br label %135

; <label>:135:                                    ; preds = %133, %130
  %136 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  %137 = getelementptr [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %138 = call %struct._IO_FILE* @fopen(i8* %136, i8* %137), !track !18
  %139 = icmp ne %struct._IO_FILE* %138, null
  br i1 %139, label %140, label %145

; <label>:140:                                    ; preds = %135
  %141 = call i32 @getpid() #7
  %142 = getelementptr [4 x i8], [4 x i8]* @.str.21, i32 0, i32 0
  %143 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %138, i8* %142, i32 %141)
  %144 = call i32 @fclose(%struct._IO_FILE* %138)
  br label %156

; <label>:145:                                    ; preds = %135
  %146 = call i32* @__errno_location() #11
  %147 = load i32, i32* %146, align 4
  %148 = call i8* @strerror(i32 %147) #7
  %149 = getelementptr [34 x i8], [34 x i8]* @.str.22, i32 0, i32 0
  %150 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %149, i8* %150, i8* %148)
  %151 = call i32* @__errno_location() #11
  %152 = load i32, i32* %151, align 4
  %153 = call i8* @strerror(i32 %152) #7
  %154 = getelementptr [33 x i8], [33 x i8]* @.str.23, i32 0, i32 0
  %155 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %154, i8* %155, i8* %153)
  br label %156

; <label>:156:                                    ; preds = %140, %145, %127
  %157 = call void (i32)* @signal(i32 2, void (i32)* @cleanup) #7
  %158 = call void (i32)* @signal(i32 15, void (i32)* @cleanup) #7
  %159 = call void (i32)* @signal(i32 17, void (i32)* @child_exit) #7
  %160 = call void (i32)* @signal(i32 1, void (i32)* @read_cfg) #7
  %161 = getelementptr [20 x i8], [20 x i8]* @.str.24, i32 0, i32 0
  %162 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %161, i8* %162)
  %163 = getelementptr [29 x i8], [29 x i8]* @.str.25, i32 0, i32 0
  %164 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %163, i8* %164)
  br label %165

; <label>:165:                                    ; preds = %156, %165
  call void @unroll_loop(i32 0)
  %166 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %167 = call i32 @pcap_dispatch(%struct.pcap* %166, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %168 = icmp sge i32 %167, 0
  br i1 %168, label %165, label %169

; <label>:169:                                    ; preds = %165
  %.0.lcssa = phi i32 [ %167, %165 ]
  %170 = getelementptr [35 x i8], [35 x i8]* @.str.26, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %170, i32 %.0.lcssa)
  %171 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %172 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %171, i8* %172)
  call void @cleanup(i32 0)
  call void @exit(i32 0) #9
  unreachable
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1) #1

; Function Attrs: nounwind
declare dso_local i32 @getopt_long(i32, i8**, i8*, %struct.option*, i32*) #2

; Function Attrs: nounwind
declare dso_local i8* @strncpy(i8*, i8*, i64) #2

; Function Attrs: noinline nounwind uwtable
define dso_local void @ver() #0 {
  %1 = getelementptr [11 x i8], [11 x i8]* @.str.50, i32 0, i32 0
  %2 = getelementptr [4 x i8], [4 x i8]* @version, i32 0, i32 0
  %3 = call i32 (i8*, ...) @printf(i8* %1, i8* %2)
  %4 = getelementptr [58 x i8], [58 x i8]* @.str.51, i32 0, i32 0
  %5 = call i32 (i8*, ...) @printf(i8* %4)
  call void @exit(i32 0) #9
  unreachable
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @usage() #0 {
  %1 = getelementptr [25 x i8], [25 x i8]* @.str.39, i32 0, i32 0
  %2 = call i32 (i8*, ...) @printf(i8* %1)
  %3 = getelementptr [10 x i8], [10 x i8]* @.str.40, i32 0, i32 0
  %4 = call i32 (i8*, ...) @printf(i8* %3)
  %5 = getelementptr [74 x i8], [74 x i8]* @.str.41, i32 0, i32 0
  %6 = call i32 (i8*, ...) @printf(i8* %5)
  %7 = getelementptr [42 x i8], [42 x i8]* @.str.42, i32 0, i32 0
  %8 = call i32 (i8*, ...) @printf(i8* %7)
  %9 = getelementptr [55 x i8], [55 x i8]* @.str.43, i32 0, i32 0
  %10 = call i32 (i8*, ...) @printf(i8* %9)
  %11 = getelementptr [48 x i8], [48 x i8]* @.str.44, i32 0, i32 0
  %12 = call i32 (i8*, ...) @printf(i8* %11)
  %13 = getelementptr [68 x i8], [68 x i8]* @.str.45, i32 0, i32 0
  %14 = call i32 (i8*, ...) @printf(i8* %13)
  %15 = getelementptr [37 x i8], [37 x i8]* @.str.46, i32 0, i32 0
  %16 = call i32 (i8*, ...) @printf(i8* %15)
  %17 = getelementptr [42 x i8], [42 x i8]* @.str.47, i32 0, i32 0
  %18 = call i32 (i8*, ...) @printf(i8* %17)
  %19 = getelementptr [36 x i8], [36 x i8]* @.str.48, i32 0, i32 0
  %20 = call i32 (i8*, ...) @printf(i8* %19)
  %21 = getelementptr [2 x i8], [2 x i8]* @.str.49, i32 0, i32 0
  %22 = call i32 (i8*, ...) @printf(i8* %21)
  call void @exit(i32 1) #9
  unreachable
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @parseconfig(i8*) #0 {
  %2 = alloca [101 x i8], align 16, !track !19
  %3 = alloca i8*, align 8, !track !20
  %4 = alloca [256 x i8], align 16, !track !21
  store i8* null, i8** %3, align 8
  %5 = bitcast [256 x i8]* %4 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 16 %5, i8 0, i64 256, i1 false)
  %6 = getelementptr [2 x i8], [2 x i8]* @.str.52, i32 0, i32 0
  %7 = call %struct._IO_FILE* @fopen(i8* %0, i8* %6), !track !22
  %8 = icmp eq %struct._IO_FILE* %7, null
  br i1 %8, label %9, label %10

; <label>:9:                                      ; preds = %1
  call void @perror(i8* %0)
  br label %._crit_edge

; <label>:10:                                     ; preds = %1
  %11 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %12 = call i8* @fgets(i8* %11, i32 100, %struct._IO_FILE* %7), !track !23
  %13 = icmp ne i8* %12, null
  br i1 %13, label %.lr.ph43.preheader, label %.outer._crit_edge

.lr.ph43.preheader:                               ; preds = %10
  br label %.lr.ph43

.lr.ph43:                                         ; preds = %.lr.ph43.preheader, %.outer
  %.02.ph49 = phi i32 [ %.lcssa40, %.outer ], [ 0, %.lr.ph43.preheader ]
  %.03.ph48 = phi %struct.opendoor* [ %.2, %.outer ], [ null, %.lr.ph43.preheader ]
  call void @unroll_loop(i32 5)
  br label %14

; <label>:14:                                     ; preds = %.lr.ph43, %26
  %.0242 = phi i32 [ %.02.ph49, %.lr.ph43 ], [ %15, %26 ]
  call void @unroll_loop(i32 2)
  %15 = add nsw i32 %.0242, 1
  %16 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %17 = call i8* @trim(i8* %16)
  %18 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %19 = call i64 @strlen(i8* %18) #10
  %20 = icmp eq i64 %19, 0
  br i1 %20, label %26, label %21

; <label>:21:                                     ; preds = %14
  %22 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  %23 = load i8, i8* %22, align 16
  %24 = sext i8 %23 to i32
  %25 = icmp eq i32 %24, 35
  br i1 %25, label %26, label %29

; <label>:26:                                     ; preds = %21, %14
  %27 = call i8* @fgets(i8* %11, i32 100, %struct._IO_FILE* %7), !track !24
  %28 = icmp ne i8* %27, null
  br i1 %28, label %14, label %.outer._crit_edge.loopexit

; <label>:29:                                     ; preds = %21
  %.lcssa40 = phi i32 [ %15, %21 ]
  %30 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  %31 = load i8, i8* %30, align 16
  %32 = sext i8 %31 to i32
  %33 = icmp eq i32 %32, 91
  br i1 %33, label %34, label %90

; <label>:34:                                     ; preds = %29
  %35 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %36 = call i64 @strlen(i8* %35) #10
  %37 = sub i64 %36, 1
  %38 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 %37
  %39 = load i8, i8* %38, align 1
  %40 = sext i8 %39 to i32
  %41 = icmp eq i32 %40, 93
  br i1 %41, label %42, label %90

; <label>:42:                                     ; preds = %34
  %43 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  store i8* %43, i8** %3, align 8
  %44 = load i8*, i8** %3, align 8
  %45 = getelementptr inbounds i8, i8* %44, i32 1
  store i8* %45, i8** %3, align 8
  %46 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %47 = load i8*, i8** %3, align 8
  %48 = call i8* @strncpy(i8* %46, i8* %47, i64 256) #7, !track !25
  %49 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %50 = call i64 @strlen(i8* %49) #10
  %51 = sub i64 %50, 1
  %52 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i64 0, i64 %51
  store i8 0, i8* %52, align 1
  %53 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %54 = getelementptr [27 x i8], [27 x i8]* @.str.53, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %54, i8* %53)
  %55 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %56 = call i64 @strlen(i8* %55) #10
  %57 = icmp ne i64 %56, 0
  br i1 %57, label %62, label %58

; <label>:58:                                     ; preds = %42
  %.lcssa29 = phi i32 [ %.lcssa40, %42 ]
  %59 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %60 = getelementptr [35 x i8], [35 x i8]* @.str.54, i32 0, i32 0
  %61 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %59, i8* %60, i32 %.lcssa29)
  br label %._crit_edge

; <label>:62:                                     ; preds = %42
  %63 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %64 = getelementptr [8 x i8], [8 x i8]* @.str.55, i32 0, i32 0
  %65 = call i32 @strcmp(i8* %63, i8* %64) #10
  %66 = icmp ne i32 %65, 0
  br i1 %66, label %67, label %.outer

; <label>:67:                                     ; preds = %62
  %68 = call noalias i8* @malloc(i64 336) #7, !track !26
  %69 = bitcast i8* %68 to %struct.opendoor*
  %70 = icmp eq %struct.opendoor* %69, null
  br i1 %70, label %71, label %73

; <label>:71:                                     ; preds = %67
  %72 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %72)
  call void @exit(i32 1) #9
  unreachable

; <label>:73:                                     ; preds = %67
  %74 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %69, i32 0, i32 0
  %75 = getelementptr inbounds [128 x i8], [128 x i8]* %74, i32 0, i32 0
  %76 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %77 = call i8* @strncpy(i8* %75, i8* %76, i64 127) #7, !track !27
  %78 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %69, i32 0, i32 0
  %79 = getelementptr inbounds [128 x i8], [128 x i8]* %78, i64 0, i64 127
  store i8 0, i8* %79, align 1
  %80 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %69, i32 0, i32 1
  store i16 0, i16* %80, align 8
  %81 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %69, i32 0, i32 4
  store i64 25, i64* %81, align 8
  %82 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %69, i32 0, i32 5
  store i8* null, i8** %82, align 8
  %83 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %69, i32 0, i32 6
  store i64 10, i64* %83, align 8
  %84 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %69, i32 0, i32 7
  store i8* null, i8** %84, align 8
  %85 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %69, i32 0, i32 14
  store %struct._IO_FILE* null, %struct._IO_FILE** %85, align 8
  %86 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %69, i32 0, i32 15
  store i8* null, i8** %86, align 8
  %87 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %88 = bitcast %struct.opendoor* %69 to i8*
  %89 = call %struct.__pmlist_t* @list_add(%struct.__pmlist_t* %87, i8* %88)
  store %struct.__pmlist_t* %89, %struct.__pmlist_t** @doors, align 8
  br label %.outer

; <label>:90:                                     ; preds = %34, %29
  %91 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %92 = call i64 @strlen(i8* %91) #10
  %93 = icmp ne i64 %92, 0
  br i1 %93, label %98, label %94

; <label>:94:                                     ; preds = %90
  %.lcssa17 = phi i32 [ %.lcssa40, %90 ]
  %95 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %96 = getelementptr [58 x i8], [58 x i8]* @.str.57, i32 0, i32 0
  %97 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %95, i8* %96, i32 %.lcssa17)
  br label %._crit_edge

; <label>:98:                                     ; preds = %90
  %99 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  store i8* %99, i8** %3, align 8
  %100 = getelementptr [2 x i8], [2 x i8]* @.str.58, i32 0, i32 0
  %101 = call i8* @strsep(i8** %3, i8* %100) #7
  %102 = icmp eq i8* %101, null
  br i1 %102, label %103, label %107

; <label>:103:                                    ; preds = %98
  %.lcssa18 = phi i32 [ %.lcssa40, %98 ]
  %104 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %105 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %106 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %104, i8* %105, i32 %.lcssa18)
  br label %._crit_edge

; <label>:107:                                    ; preds = %98
  %108 = call i8* @trim(i8* %101)
  %109 = call i8* @strtoupper(i8* %101)
  %110 = load i8*, i8** %3, align 8
  %111 = icmp eq i8* %110, null
  br i1 %111, label %112, label %122

; <label>:112:                                    ; preds = %107
  %113 = getelementptr [10 x i8], [10 x i8]* @.str.60, i32 0, i32 0
  %114 = call i32 @strcmp(i8* %109, i8* %113) #10
  %115 = icmp ne i32 %114, 0
  br i1 %115, label %118, label %116

; <label>:116:                                    ; preds = %112
  store i32 1, i32* @o_usesyslog, align 4
  %117 = getelementptr [19 x i8], [19 x i8]* @.str.61, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %117)
  br label %.outer

; <label>:118:                                    ; preds = %112
  %.lcssa28 = phi i32 [ %.lcssa40, %112 ]
  %119 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %120 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %121 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %119, i8* %120, i32 %.lcssa28)
  br label %._crit_edge

; <label>:122:                                    ; preds = %107
  %123 = load i8*, i8** %3, align 8
  %124 = call i8* @trim(i8* %123)
  %125 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %126 = getelementptr [8 x i8], [8 x i8]* @.str.55, i32 0, i32 0
  %127 = call i32 @strcmp(i8* %125, i8* %126) #10
  %128 = icmp ne i32 %127, 0
  br i1 %128, label %170, label %129

; <label>:129:                                    ; preds = %122
  %130 = getelementptr [8 x i8], [8 x i8]* @.str.62, i32 0, i32 0
  %131 = call i32 @strcmp(i8* %109, i8* %130) #10
  %132 = icmp ne i32 %131, 0
  br i1 %132, label %140, label %133

; <label>:133:                                    ; preds = %129
  %134 = load i8*, i8** %3, align 8
  %135 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  %136 = call i8* @strncpy(i8* %135, i8* %134, i64 99) #7, !track !28
  %137 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i64 0, i64 99
  store i8 0, i8* %137, align 1
  %138 = getelementptr [22 x i8], [22 x i8]* @.str.63, i32 0, i32 0
  %139 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %138, i8* %139)
  br label %._crit_edge47

; <label>:140:                                    ; preds = %129
  %141 = getelementptr [8 x i8], [8 x i8]* @.str.64, i32 0, i32 0
  %142 = call i32 @strcmp(i8* %109, i8* %141) #10
  %143 = icmp ne i32 %142, 0
  br i1 %143, label %151, label %144

; <label>:144:                                    ; preds = %140
  %145 = load i8*, i8** %3, align 8
  %146 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  %147 = call i8* @strncpy(i8* %146, i8* %145, i64 99) #7, !track !29
  %148 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i64 0, i64 99
  store i8 0, i8* %148, align 1
  %149 = getelementptr [22 x i8], [22 x i8]* @.str.65, i32 0, i32 0
  %150 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %149, i8* %150)
  br label %._crit_edge47

; <label>:151:                                    ; preds = %140
  %152 = getelementptr [10 x i8], [10 x i8]* @.str.66, i32 0, i32 0
  %153 = call i32 @strcmp(i8* %109, i8* %152) #10
  %154 = icmp ne i32 %153, 0
  br i1 %154, label %166, label %155

; <label>:155:                                    ; preds = %151
  %156 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %157 = call i64 @strlen(i8* %156) #10
  %158 = icmp eq i64 %157, 0
  br i1 %158, label %159, label %._crit_edge47

; <label>:159:                                    ; preds = %155
  %160 = load i8*, i8** %3, align 8
  %161 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %162 = call i8* @strncpy(i8* %161, i8* %160, i64 31) #7, !track !30
  %163 = getelementptr [32 x i8], [32 x i8]* @o_int, i64 0, i64 31
  store i8 0, i8* %163, align 1
  %164 = getelementptr [23 x i8], [23 x i8]* @.str.67, i32 0, i32 0
  %165 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %164, i8* %165)
  br label %._crit_edge47

; <label>:166:                                    ; preds = %151
  %.lcssa19 = phi i32 [ %.lcssa40, %151 ]
  %167 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %168 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %169 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %167, i8* %168, i32 %.lcssa19)
  br label %._crit_edge

; <label>:170:                                    ; preds = %122
  %171 = icmp eq %struct.opendoor* %.03.ph48, null
  br i1 %171, label %172, label %176

; <label>:172:                                    ; preds = %170
  %.lcssa20 = phi i32 [ %.lcssa40, %170 ]
  %.lcssa8 = phi i8* [ %109, %170 ]
  %173 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %174 = getelementptr [62 x i8], [62 x i8]* @.str.68, i32 0, i32 0
  %175 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %173, i8* %174, i32 %.lcssa20, i8* %.lcssa8)
  br label %._crit_edge

; <label>:176:                                    ; preds = %170
  %177 = getelementptr [9 x i8], [9 x i8]* @.str.69, i32 0, i32 0
  %178 = call i32 @strcmp(i8* %109, i8* %177) #10
  %179 = icmp ne i32 %178, 0
  br i1 %179, label %188, label %180

; <label>:180:                                    ; preds = %176
  %181 = load i8*, i8** %3, align 8
  %182 = call i32 @parse_port_sequence(i8* %181, %struct.opendoor* %.03.ph48)
  %183 = icmp sgt i32 %182, 0
  br i1 %183, label %._crit_edge.loopexit1, label %184

; <label>:184:                                    ; preds = %180
  %185 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %186 = getelementptr inbounds [128 x i8], [128 x i8]* %185, i32 0, i32 0
  %187 = getelementptr [23 x i8], [23 x i8]* @.str.70, i32 0, i32 0
  call void (%struct.opendoor*, i8*, ...) @dprint_sequence(%struct.opendoor* %.03.ph48, i8* %187, i8* %186)
  br label %._crit_edge47

; <label>:188:                                    ; preds = %176
  %189 = getelementptr [19 x i8], [19 x i8]* @.str.71, i32 0, i32 0
  %190 = call i32 @strcmp(i8* %109, i8* %189) #10
  %191 = icmp ne i32 %190, 0
  br i1 %191, label %214, label %192

; <label>:192:                                    ; preds = %188
  %193 = load i8*, i8** %3, align 8
  %194 = getelementptr [3 x i8], [3 x i8]* @.str.72, i32 0, i32 0
  %195 = call %struct._IO_FILE* @fopen(i8* %193, i8* %194), !track !31
  %196 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 14
  store %struct._IO_FILE* %195, %struct._IO_FILE** %196, align 8
  %197 = icmp eq %struct._IO_FILE* %195, null
  br i1 %197, label %198, label %200

; <label>:198:                                    ; preds = %192
  %199 = load i8*, i8** %3, align 8
  call void @perror(i8* %199)
  br label %._crit_edge

; <label>:200:                                    ; preds = %192
  %201 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %202 = getelementptr inbounds [128 x i8], [128 x i8]* %201, i32 0, i32 0
  %203 = load i8*, i8** %3, align 8
  %204 = getelementptr [41 x i8], [41 x i8]* @.str.73, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %204, i8* %202, i8* %203)
  %205 = call i32 @get_new_one_time_sequence(%struct.opendoor* %.03.ph48)
  %206 = icmp eq i32 %205, 0
  br i1 %206, label %207, label %211

; <label>:207:                                    ; preds = %200
  %208 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %209 = getelementptr inbounds [128 x i8], [128 x i8]* %208, i32 0, i32 0
  %210 = getelementptr [23 x i8], [23 x i8]* @.str.70, i32 0, i32 0
  call void (%struct.opendoor*, i8*, ...) @dprint_sequence(%struct.opendoor* %.03.ph48, i8* %210, i8* %209)
  br label %._crit_edge47

; <label>:211:                                    ; preds = %200
  %212 = load i8*, i8** %3, align 8
  %213 = getelementptr [66 x i8], [66 x i8]* @.str.74, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %213, i8* %212)
  br label %._crit_edge

; <label>:214:                                    ; preds = %188
  %215 = getelementptr [12 x i8], [12 x i8]* @.str.75, i32 0, i32 0
  %216 = call i32 @strcmp(i8* %109, i8* %215) #10
  %217 = icmp ne i32 %216, 0
  br i1 %217, label %218, label %222

; <label>:218:                                    ; preds = %214
  %219 = getelementptr [8 x i8], [8 x i8]* @.str.76, i32 0, i32 0
  %220 = call i32 @strcmp(i8* %109, i8* %219) #10
  %221 = icmp ne i32 %220, 0
  br i1 %221, label %232, label %222

; <label>:222:                                    ; preds = %218, %214
  %223 = load i8*, i8** %3, align 8
  %224 = call i32 @atoi(i8* %223) #10
  %225 = sext i32 %224 to i64
  %226 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 4
  store i64 %225, i64* %226, align 8
  %227 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %228 = getelementptr inbounds [128 x i8], [128 x i8]* %227, i32 0, i32 0
  %229 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 4
  %230 = load i64, i64* %229, align 8
  %231 = getelementptr [29 x i8], [29 x i8]* @.str.77, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %231, i8* %228, i64 %230)
  br label %._crit_edge47

; <label>:232:                                    ; preds = %218
  %233 = getelementptr [14 x i8], [14 x i8]* @.str.78, i32 0, i32 0
  %234 = call i32 @strcmp(i8* %109, i8* %233) #10
  %235 = icmp ne i32 %234, 0
  br i1 %235, label %236, label %240

; <label>:236:                                    ; preds = %232
  %237 = getelementptr [8 x i8], [8 x i8]* @.str.79, i32 0, i32 0
  %238 = call i32 @strcmp(i8* %109, i8* %237) #10
  %239 = icmp ne i32 %238, 0
  br i1 %239, label %262, label %240

; <label>:240:                                    ; preds = %236, %232
  %241 = load i8*, i8** %3, align 8
  %242 = call i64 @strlen(i8* %241) #10
  %243 = add i64 %242, 1
  %244 = mul i64 1, %243
  %245 = call noalias i8* @malloc(i64 %244) #7, !track !32
  %246 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  store i8* %245, i8** %246, align 8
  %247 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  %248 = load i8*, i8** %247, align 8
  %249 = icmp eq i8* %248, null
  br i1 %249, label %250, label %252

; <label>:250:                                    ; preds = %240
  %251 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %251)
  call void @exit(i32 1) #9
  unreachable

; <label>:252:                                    ; preds = %240
  %253 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  %254 = load i8*, i8** %253, align 8
  %255 = load i8*, i8** %3, align 8
  %256 = call i8* @strcpy(i8* %254, i8* %255) #7, !track !33
  %257 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %258 = getelementptr inbounds [128 x i8], [128 x i8]* %257, i32 0, i32 0
  %259 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  %260 = load i8*, i8** %259, align 8
  %261 = getelementptr [31 x i8], [31 x i8]* @.str.80, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %261, i8* %258, i8* %260)
  br label %._crit_edge47

; <label>:262:                                    ; preds = %236
  %263 = getelementptr [12 x i8], [12 x i8]* @.str.81, i32 0, i32 0
  %264 = call i32 @strcmp(i8* %109, i8* %263) #10
  %265 = icmp ne i32 %264, 0
  br i1 %265, label %276, label %266

; <label>:266:                                    ; preds = %262
  %267 = load i8*, i8** %3, align 8
  %268 = call i32 @atoi(i8* %267) #10
  %269 = sext i32 %268 to i64
  %270 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 6
  store i64 %269, i64* %270, align 8
  %271 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %272 = getelementptr inbounds [128 x i8], [128 x i8]* %271, i32 0, i32 0
  %273 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 6
  %274 = load i64, i64* %273, align 8
  %275 = getelementptr [29 x i8], [29 x i8]* @.str.82, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %275, i8* %272, i64 %274)
  br label %._crit_edge47

; <label>:276:                                    ; preds = %262
  %277 = getelementptr [13 x i8], [13 x i8]* @.str.83, i32 0, i32 0
  %278 = call i32 @strcmp(i8* %109, i8* %277) #10
  %279 = icmp ne i32 %278, 0
  br i1 %279, label %302, label %280

; <label>:280:                                    ; preds = %276
  %281 = load i8*, i8** %3, align 8
  %282 = call i64 @strlen(i8* %281) #10
  %283 = add i64 %282, 1
  %284 = mul i64 1, %283
  %285 = call noalias i8* @malloc(i64 %284) #7, !track !34
  %286 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  store i8* %285, i8** %286, align 8
  %287 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  %288 = load i8*, i8** %287, align 8
  %289 = icmp eq i8* %288, null
  br i1 %289, label %290, label %292

; <label>:290:                                    ; preds = %280
  %291 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %291)
  call void @exit(i32 1) #9
  unreachable

; <label>:292:                                    ; preds = %280
  %293 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  %294 = load i8*, i8** %293, align 8
  %295 = load i8*, i8** %3, align 8
  %296 = call i8* @strcpy(i8* %294, i8* %295) #7, !track !35
  %297 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %298 = getelementptr inbounds [128 x i8], [128 x i8]* %297, i32 0, i32 0
  %299 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  %300 = load i8*, i8** %299, align 8
  %301 = getelementptr [30 x i8], [30 x i8]* @.str.84, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %301, i8* %298, i8* %300)
  br label %._crit_edge47

; <label>:302:                                    ; preds = %276
  %303 = getelementptr [9 x i8], [9 x i8]* @.str.85, i32 0, i32 0
  %304 = call i32 @strcmp(i8* %109, i8* %303) #10
  %305 = icmp ne i32 %304, 0
  br i1 %305, label %393, label %306

; <label>:306:                                    ; preds = %302
  %307 = load i8*, i8** %3, align 8
  %308 = call i8* @strtoupper(i8* %307)
  %309 = getelementptr [2 x i8], [2 x i8]* @.str.86, i32 0, i32 0
  %310 = call i8* @strsep(i8** %3, i8* %309) #7
  %311 = icmp ne i8* %310, null
  br i1 %311, label %.lr.ph46.preheader, label %._crit_edge47

.lr.ph46.preheader:                               ; preds = %306
  br label %.lr.ph46

.lr.ph46:                                         ; preds = %.lr.ph46.preheader, %388
  %312 = phi i8* [ %391, %388 ], [ %310, %.lr.ph46.preheader ]
  call void @unroll_loop(i32 3)
  %313 = getelementptr [4 x i8], [4 x i8]* @.str.87, i32 0, i32 0
  %314 = call i32 @strcmp(i8* %312, i8* %313) #10
  %315 = icmp ne i32 %314, 0
  br i1 %315, label %318, label %316

; <label>:316:                                    ; preds = %.lr.ph46
  %317 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 8
  store i32 1, i32* %317, align 8
  br label %388

; <label>:318:                                    ; preds = %.lr.ph46
  %319 = getelementptr [5 x i8], [5 x i8]* @.str.88, i32 0, i32 0
  %320 = call i32 @strcmp(i8* %312, i8* %319) #10
  %321 = icmp ne i32 %320, 0
  br i1 %321, label %324, label %322

; <label>:322:                                    ; preds = %318
  %323 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 8
  store i32 2, i32* %323, align 8
  br label %388

; <label>:324:                                    ; preds = %318
  %325 = getelementptr [4 x i8], [4 x i8]* @.str.89, i32 0, i32 0
  %326 = call i32 @strcmp(i8* %312, i8* %325) #10
  %327 = icmp ne i32 %326, 0
  br i1 %327, label %330, label %328

; <label>:328:                                    ; preds = %324
  %329 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 9
  store i32 1, i32* %329, align 4
  br label %388

; <label>:330:                                    ; preds = %324
  %331 = getelementptr [5 x i8], [5 x i8]* @.str.90, i32 0, i32 0
  %332 = call i32 @strcmp(i8* %312, i8* %331) #10
  %333 = icmp ne i32 %332, 0
  br i1 %333, label %336, label %334

; <label>:334:                                    ; preds = %330
  %335 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 9
  store i32 2, i32* %335, align 4
  br label %388

; <label>:336:                                    ; preds = %330
  %337 = getelementptr [4 x i8], [4 x i8]* @.str.91, i32 0, i32 0
  %338 = call i32 @strcmp(i8* %312, i8* %337) #10
  %339 = icmp ne i32 %338, 0
  br i1 %339, label %342, label %340

; <label>:340:                                    ; preds = %336
  %341 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 10
  store i32 1, i32* %341, align 8
  br label %388

; <label>:342:                                    ; preds = %336
  %343 = getelementptr [5 x i8], [5 x i8]* @.str.92, i32 0, i32 0
  %344 = call i32 @strcmp(i8* %312, i8* %343) #10
  %345 = icmp ne i32 %344, 0
  br i1 %345, label %348, label %346

; <label>:346:                                    ; preds = %342
  %347 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 10
  store i32 2, i32* %347, align 8
  br label %388

; <label>:348:                                    ; preds = %342
  %349 = getelementptr [4 x i8], [4 x i8]* @.str.93, i32 0, i32 0
  %350 = call i32 @strcmp(i8* %312, i8* %349) #10
  %351 = icmp ne i32 %350, 0
  br i1 %351, label %354, label %352

; <label>:352:                                    ; preds = %348
  %353 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 11
  store i32 1, i32* %353, align 4
  br label %388

; <label>:354:                                    ; preds = %348
  %355 = getelementptr [5 x i8], [5 x i8]* @.str.94, i32 0, i32 0
  %356 = call i32 @strcmp(i8* %312, i8* %355) #10
  %357 = icmp ne i32 %356, 0
  br i1 %357, label %360, label %358

; <label>:358:                                    ; preds = %354
  %359 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 11
  store i32 2, i32* %359, align 4
  br label %388

; <label>:360:                                    ; preds = %354
  %361 = getelementptr [4 x i8], [4 x i8]* @.str.95, i32 0, i32 0
  %362 = call i32 @strcmp(i8* %312, i8* %361) #10
  %363 = icmp ne i32 %362, 0
  br i1 %363, label %366, label %364

; <label>:364:                                    ; preds = %360
  %365 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 12
  store i32 1, i32* %365, align 8
  br label %388

; <label>:366:                                    ; preds = %360
  %367 = getelementptr [5 x i8], [5 x i8]* @.str.96, i32 0, i32 0
  %368 = call i32 @strcmp(i8* %312, i8* %367) #10
  %369 = icmp ne i32 %368, 0
  br i1 %369, label %372, label %370

; <label>:370:                                    ; preds = %366
  %371 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 12
  store i32 2, i32* %371, align 8
  br label %388

; <label>:372:                                    ; preds = %366
  %373 = getelementptr [4 x i8], [4 x i8]* @.str.97, i32 0, i32 0
  %374 = call i32 @strcmp(i8* %312, i8* %373) #10
  %375 = icmp ne i32 %374, 0
  br i1 %375, label %378, label %376

; <label>:376:                                    ; preds = %372
  %377 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 13
  store i32 1, i32* %377, align 4
  br label %388

; <label>:378:                                    ; preds = %372
  %379 = getelementptr [5 x i8], [5 x i8]* @.str.98, i32 0, i32 0
  %380 = call i32 @strcmp(i8* %312, i8* %379) #10
  %381 = icmp ne i32 %380, 0
  br i1 %381, label %384, label %382

; <label>:382:                                    ; preds = %378
  %383 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 13
  store i32 2, i32* %383, align 4
  br label %388

; <label>:384:                                    ; preds = %378
  %.lcssa27 = phi i32 [ %.lcssa40, %378 ]
  %.lcssa5 = phi i8* [ %312, %378 ]
  %385 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %386 = getelementptr [41 x i8], [41 x i8]* @.str.99, i32 0, i32 0
  %387 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %385, i8* %386, i32 %.lcssa27, i8* %.lcssa5)
  br label %._crit_edge

; <label>:388:                                    ; preds = %322, %334, %346, %358, %370, %382, %376, %364, %352, %340, %328, %316
  %389 = getelementptr [22 x i8], [22 x i8]* @.str.100, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %389, i8* %312)
  %390 = getelementptr [2 x i8], [2 x i8]* @.str.86, i32 0, i32 0
  %391 = call i8* @strsep(i8** %3, i8* %390) #7
  %392 = icmp ne i8* %391, null
  br i1 %392, label %.lr.ph46, label %._crit_edge47.loopexit

; <label>:393:                                    ; preds = %302
  %.lcssa26 = phi i32 [ %.lcssa40, %302 ]
  %394 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %395 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %396 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %394, i8* %395, i32 %.lcssa26)
  br label %._crit_edge

._crit_edge47.loopexit:                           ; preds = %388
  br label %._crit_edge47

._crit_edge47:                                    ; preds = %._crit_edge47.loopexit, %184, %222, %266, %306, %292, %252, %207, %133, %159, %155, %144
  %.0333 = phi %struct.opendoor* [ %.03.ph48, %144 ], [ %.03.ph48, %155 ], [ %.03.ph48, %159 ], [ %.03.ph48, %133 ], [ %.03.ph48, %184 ], [ %.03.ph48, %207 ], [ %.03.ph48, %222 ], [ %.03.ph48, %252 ], [ %.03.ph48, %266 ], [ %.03.ph48, %292 ], [ %.03.ph48, %306 ], [ %.03.ph48, %._crit_edge47.loopexit ]
  %397 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  store i8 0, i8* %397, align 16
  br label %.outer

.outer:                                           ; preds = %116, %._crit_edge47, %62, %73
  %.2 = phi %struct.opendoor* [ %69, %73 ], [ %.03.ph48, %62 ], [ %.0333, %._crit_edge47 ], [ %.03.ph48, %116 ]
  %398 = call i8* @fgets(i8* %11, i32 100, %struct._IO_FILE* %7), !track !36
  %399 = icmp ne i8* %398, null
  br i1 %399, label %.lr.ph43, label %.outer._crit_edge.loopexit3

.outer._crit_edge.loopexit:                       ; preds = %26
  br label %.outer._crit_edge

.outer._crit_edge.loopexit3:                      ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit3, %.outer._crit_edge.loopexit, %10
  %400 = call i32 @fclose(%struct._IO_FILE* %7)
  %401 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %402 = icmp ne %struct.__pmlist_t* %401, null
  br i1 %402, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %.outer._crit_edge
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %416
  %.0141 = phi %struct.__pmlist_t* [ %418, %416 ], [ %401, %.lr.ph.preheader ]
  call void @unroll_loop(i32 4)
  %403 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.0141, i32 0, i32 0
  %404 = load i8*, i8** %403, align 8
  %405 = bitcast i8* %404 to %struct.opendoor*
  %406 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %405, i32 0, i32 1
  %407 = load i16, i16* %406, align 8
  %408 = zext i16 %407 to i32
  %409 = icmp eq i32 %408, 0
  br i1 %409, label %410, label %416

; <label>:410:                                    ; preds = %.lr.ph
  %.lcssa = phi %struct.opendoor* [ %405, %.lr.ph ]
  %411 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %412 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.lcssa, i32 0, i32 0
  %413 = getelementptr inbounds [128 x i8], [128 x i8]* %412, i32 0, i32 0
  %414 = getelementptr [49 x i8], [49 x i8]* @.str.101, i32 0, i32 0
  %415 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %411, i8* %414, i8* %413)
  br label %._crit_edge

; <label>:416:                                    ; preds = %.lr.ph
  %417 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.0141, i32 0, i32 2
  %418 = load %struct.__pmlist_t*, %struct.__pmlist_t** %417, align 8
  %419 = icmp ne %struct.__pmlist_t* %418, null
  br i1 %419, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %416
  %.0.ph = phi i32 [ 0, %416 ]
  br label %._crit_edge

._crit_edge.loopexit1:                            ; preds = %180
  %.0.ph2 = phi i32 [ %182, %180 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit1, %._crit_edge.loopexit, %.outer._crit_edge, %410, %393, %384, %211, %198, %172, %166, %118, %103, %94, %58, %9
  %.0 = phi i32 [ 1, %9 ], [ 1, %58 ], [ 1, %103 ], [ 1, %118 ], [ 1, %172 ], [ 1, %393 ], [ 1, %384 ], [ 1, %198 ], [ 1, %211 ], [ 1, %166 ], [ 1, %94 ], [ 1, %410 ], [ 0, %.outer._crit_edge ], [ %.0.ph, %._crit_edge.loopexit ], [ %.0.ph2, %._crit_edge.loopexit1 ]
  ret i32 %.0
}

; Function Attrs: noreturn nounwind
declare dso_local void @exit(i32) #3

; Function Attrs: nounwind readonly
declare dso_local i64 @strlen(i8*) #4

declare dso_local void @openlog(i8*, i32, i32) #5

declare dso_local %struct._IO_FILE* @fopen(i8*, i8*) #5

declare dso_local void @perror(i8*) #5

declare dso_local %struct.pcap* @pcap_open_live(i8*, i32, i32, i32, i8*) #5

declare dso_local i32 @fprintf(%struct._IO_FILE*, i8*, ...) #5

declare dso_local i32 @pcap_datalink(%struct.pcap*) #5

; Function Attrs: noinline nounwind uwtable
define dso_local void @dprint(i8*, ...) #0 {
  %2 = alloca [1 x %struct.__va_list_tag], align 16
  %3 = load i32, i32* @o_debug, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %14

; <label>:5:                                      ; preds = %1
  %6 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %2, i32 0, i32 0
  %7 = bitcast %struct.__va_list_tag* %6 to i8*
  call void @llvm.va_start(i8* %7)
  %8 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %2, i32 0, i32 0
  %9 = call i32 @vprintf(i8* %0, %struct.__va_list_tag* %8)
  %10 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %2, i32 0, i32 0
  %11 = bitcast %struct.__va_list_tag* %10 to i8*
  call void @llvm.va_end(i8* %11)
  %12 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %13 = call i32 @fflush(%struct._IO_FILE* %12)
  br label %14

; <label>:14:                                     ; preds = %5, %1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @cleanup(i32) #0 {
  %2 = alloca i32, align 4
  %3 = alloca %union.__WAIT_STATUS, align 8
  %4 = getelementptr [32 x i8], [32 x i8]* @.str.34, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %4)
  %5 = getelementptr [31 x i8], [31 x i8]* @.str.35, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %5)
  %6 = bitcast %union.__WAIT_STATUS* %3 to i32**
  store i32* %2, i32** %6, align 8
  %7 = getelementptr inbounds %union.__WAIT_STATUS, %union.__WAIT_STATUS* %3, i32 0, i32 0
  %8 = load %struct.in_addr*, %struct.in_addr** %7, align 8
  %9 = call i32 @wait(%struct.in_addr* %8)
  %10 = getelementptr [12 x i8], [12 x i8]* @.str.36, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %10)
  %11 = getelementptr [14 x i8], [14 x i8]* @.str.37, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %11)
  %12 = load %struct.pcap*, %struct.pcap** @cap, align 8
  call void @pcap_close(%struct.pcap* %12)
  %13 = load i32, i32* @o_daemon, align 4
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %15, label %18

; <label>:15:                                     ; preds = %1
  %16 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  %17 = call i32 @unlink(i8* %16) #7
  br label %18

; <label>:18:                                     ; preds = %15, %1
  call void @exit(i32 %0) #9
  unreachable
}

; Function Attrs: noinline nounwind uwtable
define dso_local i8* @get_ip(i8*, i8*, i32) #0 {
  %4 = alloca %struct.ifreq, align 8, !track !37
  %5 = icmp sle i32 %2, 0
  %6 = icmp eq i8* %1, null
  %or.cond = or i1 %5, %6
  br i1 %or.cond, label %39, label %7

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds i8, i8* %1, i64 0
  store i8 0, i8* %8, align 1
  %9 = call i32 @socket(i32 2, i32 2, i32 0) #7
  %10 = icmp slt i32 %9, 0
  br i1 %10, label %39, label %11

; <label>:11:                                     ; preds = %7
  %12 = getelementptr inbounds %struct.ifreq, %struct.ifreq* %4, i32 0, i32 0
  %13 = bitcast %union.anon* %12 to [16 x i8]*
  %14 = bitcast [16 x i8]* %13 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %14, i8 0, i64 16, i1 false)
  %15 = getelementptr inbounds %struct.ifreq, %struct.ifreq* %4, i32 0, i32 0
  %16 = bitcast %union.anon* %15 to [16 x i8]*
  %17 = getelementptr inbounds [16 x i8], [16 x i8]* %16, i32 0, i32 0
  %18 = call i8* @strncpy(i8* %17, i8* %0, i64 15) #7, !track !38
  %19 = getelementptr inbounds %struct.ifreq, %struct.ifreq* %4, i32 0, i32 0
  %20 = bitcast %union.anon* %19 to [16 x i8]*
  %21 = getelementptr inbounds [16 x i8], [16 x i8]* %20, i64 0, i64 15
  store i8 0, i8* %21, align 1
  %22 = call i32 (i32, i64, ...) @ioctl(i32 %9, i64 35093, %struct.ifreq* %4) #7
  %23 = icmp ne i32 %22, 0
  %24 = call i32 @close(i32 %9)
  br i1 %23, label %39, label %25

; <label>:25:                                     ; preds = %11
  %26 = getelementptr inbounds %struct.ifreq, %struct.ifreq* %4, i32 0, i32 1
  %27 = bitcast %union.anon.1* %26 to %struct.sockaddr*
  %28 = bitcast %struct.sockaddr* %27 to %struct.sockaddr_in*
  %29 = getelementptr inbounds %struct.sockaddr_in, %struct.sockaddr_in* %28, i32 0, i32 2
  %30 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %29, i32 0, i32 0
  %31 = load i32, i32* %30, align 4
  %32 = call i8* @inet_ntoa(i32 %31) #7, !track !39
  %33 = sub nsw i32 %2, 1
  %34 = sext i32 %33 to i64
  %35 = call i8* @strncpy(i8* %1, i8* %32, i64 %34) #7, !track !40
  %36 = sub nsw i32 %2, 1
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds i8, i8* %1, i64 %37
  store i8 0, i8* %38, align 1
  br label %39

; <label>:39:                                     ; preds = %11, %7, %3, %25
  %.0 = phi i8* [ %1, %25 ], [ null, %3 ], [ null, %7 ], [ null, %11 ]
  ret i8* %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @generate_pcap_filter() #0 {
  %1 = alloca i8*, align 8, !track !41
  %2 = alloca [10 x i8], align 1
  %3 = alloca %struct.bpf_program, align 8, !track !42
  store i8* null, i8** %1, align 8
  %4 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %5 = icmp ne %struct.__pmlist_t* %4, null
  br i1 %5, label %.lr.ph51.preheader, label %._crit_edge52

.lr.ph51.preheader:                               ; preds = %0
  br label %.lr.ph51

.lr.ph51:                                         ; preds = %.lr.ph51.preheader, %251
  %.049 = phi %struct.__pmlist_t* [ %253, %251 ], [ %4, %.lr.ph51.preheader ]
  %.0148 = phi i64 [ %.30, %251 ], [ 0, %.lr.ph51.preheader ]
  %.02347 = phi i16 [ %.124, %251 ], [ 0, %.lr.ph51.preheader ]
  call void @unroll_loop(i32 6)
  %6 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.049, i32 0, i32 0
  %7 = load i8*, i8** %6, align 8
  %8 = bitcast i8* %7 to %struct.opendoor*
  %9 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 15
  %10 = load i8*, i8** %9, align 8
  %11 = icmp ne i8* %10, null
  br i1 %11, label %251, label %12

; <label>:12:                                     ; preds = %.lr.ph51
  %13 = load i8*, i8** %1, align 8
  %14 = icmp eq i8* %13, null
  br i1 %14, label %15, label %25

; <label>:15:                                     ; preds = %12
  %16 = mul i64 1, 200
  %17 = call noalias i8* @malloc(i64 %16) #7, !track !43
  store i8* %17, i8** %1, align 8
  %18 = load i8*, i8** %1, align 8
  %19 = icmp eq i8* %18, null
  br i1 %19, label %20, label %22

; <label>:20:                                     ; preds = %15
  %21 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %21)
  call void @cleanup(i32 1)
  br label %22

; <label>:22:                                     ; preds = %20, %15
  %23 = load i8*, i8** %1, align 8
  %24 = getelementptr inbounds i8, i8* %23, i64 0
  store i8 0, i8* %24, align 1
  br label %25

; <label>:25:                                     ; preds = %22, %12
  %.12 = phi i64 [ 200, %22 ], [ %.0148, %12 ]
  %26 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 1
  %27 = load i16, i16* %26, align 8
  %28 = zext i16 %27 to i32
  %29 = icmp ult i32 0, %28
  br i1 %29, label %.lr.ph32.preheader, label %._crit_edge33

.lr.ph32.preheader:                               ; preds = %25
  br label %.lr.ph32

.lr.ph32:                                         ; preds = %.lr.ph32.preheader, %53
  %indvars.iv = phi i64 [ %indvars.iv.next, %53 ], [ 0, %.lr.ph32.preheader ]
  %.230 = phi i64 [ %.4, %53 ], [ %.12, %.lr.ph32.preheader ]
  %.0429 = phi i16 [ %.211, %53 ], [ 0, %.lr.ph32.preheader ]
  %.01528 = phi i16 [ %.217, %53 ], [ 0, %.lr.ph32.preheader ]
  call void @unroll_loop(i32 7)
  %30 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 3
  %31 = getelementptr inbounds [32 x i16], [32 x i16]* %30, i64 0, i64 %indvars.iv
  %32 = load i16, i16* %31, align 2
  %33 = zext i16 %32 to i32
  %34 = icmp eq i32 %33, 6
  br i1 %34, label %35, label %53

; <label>:35:                                     ; preds = %.lr.ph32
  %36 = icmp ne i16 %.0429, 0
  br i1 %36, label %40, label %37

; <label>:37:                                     ; preds = %35
  %38 = getelementptr [16 x i8], [16 x i8]* @.str.112, i32 0, i32 0
  %39 = call i64 @realloc_strcat(i8** %1, i8* %38, i64 %.230)
  br label %43

; <label>:40:                                     ; preds = %35
  %41 = getelementptr [5 x i8], [5 x i8]* @.str.113, i32 0, i32 0
  %42 = call i64 @realloc_strcat(i8** %1, i8* %41, i64 %.230)
  br label %43

; <label>:43:                                     ; preds = %40, %37
  %.116 = phi i16 [ %.01528, %40 ], [ 1, %37 ]
  %.110 = phi i16 [ %.0429, %40 ], [ 1, %37 ]
  %.3 = phi i64 [ %42, %40 ], [ %39, %37 ]
  %44 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %45 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 2
  %46 = getelementptr inbounds [32 x i16], [32 x i16]* %45, i64 0, i64 %indvars.iv
  %47 = load i16, i16* %46, align 2
  %48 = zext i16 %47 to i32
  %49 = getelementptr [4 x i8], [4 x i8]* @.str.114, i32 0, i32 0
  %50 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %44, i64 10, i8* %49, i32 %48) #7
  %51 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %52 = call i64 @realloc_strcat(i8** %1, i8* %51, i64 %.3)
  br label %53

; <label>:53:                                     ; preds = %.lr.ph32, %43
  %.217 = phi i16 [ %.116, %43 ], [ %.01528, %.lr.ph32 ]
  %.211 = phi i16 [ %.110, %43 ], [ %.0429, %.lr.ph32 ]
  %.4 = phi i64 [ %52, %43 ], [ %.230, %.lr.ph32 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %54 = load i16, i16* %26, align 8
  %55 = zext i16 %54 to i32
  %56 = zext i32 %55 to i64
  %57 = icmp ult i64 %indvars.iv.next, %56
  br i1 %57, label %.lr.ph32, label %._crit_edge33.loopexit

._crit_edge33.loopexit:                           ; preds = %53
  %.015.lcssa.ph = phi i16 [ %.217, %53 ]
  %.2.lcssa.ph = phi i64 [ %.4, %53 ]
  br label %._crit_edge33

._crit_edge33:                                    ; preds = %._crit_edge33.loopexit, %25
  %.015.lcssa = phi i16 [ 0, %25 ], [ %.015.lcssa.ph, %._crit_edge33.loopexit ]
  %.2.lcssa = phi i64 [ %.12, %25 ], [ %.2.lcssa.ph, %._crit_edge33.loopexit ]
  %58 = icmp ne i16 %.015.lcssa, 0
  br i1 %58, label %59, label %62

; <label>:59:                                     ; preds = %._crit_edge33
  %60 = getelementptr [2 x i8], [2 x i8]* @.str.115, i32 0, i32 0
  %61 = call i64 @realloc_strcat(i8** %1, i8* %60, i64 %.2.lcssa)
  br label %62

; <label>:62:                                     ; preds = %59, %._crit_edge33
  %.5 = phi i64 [ %61, %59 ], [ %.2.lcssa, %._crit_edge33 ]
  %63 = icmp ne i16 %.015.lcssa, 0
  br i1 %63, label %64, label %187

; <label>:64:                                     ; preds = %62
  %65 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 8
  %66 = load i32, i32* %65, align 8
  %67 = icmp ne i32 %66, 0
  br i1 %67, label %68, label %84

; <label>:68:                                     ; preds = %64
  %69 = getelementptr [30 x i8], [30 x i8]* @.str.116, i32 0, i32 0
  %70 = call i64 @realloc_strcat(i8** %1, i8* %69, i64 %.5)
  %71 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 8
  %72 = load i32, i32* %71, align 8
  %73 = icmp eq i32 %72, 1
  br i1 %73, label %74, label %77

; <label>:74:                                     ; preds = %68
  %75 = getelementptr [5 x i8], [5 x i8]* @.str.117, i32 0, i32 0
  %76 = call i64 @realloc_strcat(i8** %1, i8* %75, i64 %70)
  br label %77

; <label>:77:                                     ; preds = %74, %68
  %.6 = phi i64 [ %76, %74 ], [ %70, %68 ]
  %78 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 8
  %79 = load i32, i32* %78, align 8
  %80 = icmp eq i32 %79, 2
  br i1 %80, label %81, label %84

; <label>:81:                                     ; preds = %77
  %82 = getelementptr [5 x i8], [5 x i8]* @.str.118, i32 0, i32 0
  %83 = call i64 @realloc_strcat(i8** %1, i8* %82, i64 %.6)
  br label %84

; <label>:84:                                     ; preds = %77, %81, %64
  %.8 = phi i64 [ %.5, %64 ], [ %83, %81 ], [ %.6, %77 ]
  %85 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 9
  %86 = load i32, i32* %85, align 4
  %87 = icmp ne i32 %86, 0
  br i1 %87, label %88, label %104

; <label>:88:                                     ; preds = %84
  %89 = getelementptr [30 x i8], [30 x i8]* @.str.119, i32 0, i32 0
  %90 = call i64 @realloc_strcat(i8** %1, i8* %89, i64 %.8)
  %91 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 9
  %92 = load i32, i32* %91, align 4
  %93 = icmp eq i32 %92, 1
  br i1 %93, label %94, label %97

; <label>:94:                                     ; preds = %88
  %95 = getelementptr [5 x i8], [5 x i8]* @.str.117, i32 0, i32 0
  %96 = call i64 @realloc_strcat(i8** %1, i8* %95, i64 %90)
  br label %97

; <label>:97:                                     ; preds = %94, %88
  %.9 = phi i64 [ %96, %94 ], [ %90, %88 ]
  %98 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 9
  %99 = load i32, i32* %98, align 4
  %100 = icmp eq i32 %99, 2
  br i1 %100, label %101, label %104

; <label>:101:                                    ; preds = %97
  %102 = getelementptr [5 x i8], [5 x i8]* @.str.118, i32 0, i32 0
  %103 = call i64 @realloc_strcat(i8** %1, i8* %102, i64 %.9)
  br label %104

; <label>:104:                                    ; preds = %97, %101, %84
  %.11 = phi i64 [ %.8, %84 ], [ %103, %101 ], [ %.9, %97 ]
  %105 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 10
  %106 = load i32, i32* %105, align 8
  %107 = icmp ne i32 %106, 0
  br i1 %107, label %108, label %124

; <label>:108:                                    ; preds = %104
  %109 = getelementptr [30 x i8], [30 x i8]* @.str.120, i32 0, i32 0
  %110 = call i64 @realloc_strcat(i8** %1, i8* %109, i64 %.11)
  %111 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 10
  %112 = load i32, i32* %111, align 8
  %113 = icmp eq i32 %112, 1
  br i1 %113, label %114, label %117

; <label>:114:                                    ; preds = %108
  %115 = getelementptr [5 x i8], [5 x i8]* @.str.117, i32 0, i32 0
  %116 = call i64 @realloc_strcat(i8** %1, i8* %115, i64 %110)
  br label %117

; <label>:117:                                    ; preds = %114, %108
  %.123 = phi i64 [ %116, %114 ], [ %110, %108 ]
  %118 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 10
  %119 = load i32, i32* %118, align 8
  %120 = icmp eq i32 %119, 2
  br i1 %120, label %121, label %124

; <label>:121:                                    ; preds = %117
  %122 = getelementptr [5 x i8], [5 x i8]* @.str.118, i32 0, i32 0
  %123 = call i64 @realloc_strcat(i8** %1, i8* %122, i64 %.123)
  br label %124

; <label>:124:                                    ; preds = %117, %121, %104
  %.14 = phi i64 [ %.11, %104 ], [ %123, %121 ], [ %.123, %117 ]
  %125 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 11
  %126 = load i32, i32* %125, align 4
  %127 = icmp ne i32 %126, 0
  br i1 %127, label %128, label %144

; <label>:128:                                    ; preds = %124
  %129 = getelementptr [30 x i8], [30 x i8]* @.str.121, i32 0, i32 0
  %130 = call i64 @realloc_strcat(i8** %1, i8* %129, i64 %.14)
  %131 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 11
  %132 = load i32, i32* %131, align 4
  %133 = icmp eq i32 %132, 1
  br i1 %133, label %134, label %137

; <label>:134:                                    ; preds = %128
  %135 = getelementptr [5 x i8], [5 x i8]* @.str.117, i32 0, i32 0
  %136 = call i64 @realloc_strcat(i8** %1, i8* %135, i64 %130)
  br label %137

; <label>:137:                                    ; preds = %134, %128
  %.15 = phi i64 [ %136, %134 ], [ %130, %128 ]
  %138 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 11
  %139 = load i32, i32* %138, align 4
  %140 = icmp eq i32 %139, 2
  br i1 %140, label %141, label %144

; <label>:141:                                    ; preds = %137
  %142 = getelementptr [5 x i8], [5 x i8]* @.str.118, i32 0, i32 0
  %143 = call i64 @realloc_strcat(i8** %1, i8* %142, i64 %.15)
  br label %144

; <label>:144:                                    ; preds = %137, %141, %124
  %.17 = phi i64 [ %.14, %124 ], [ %143, %141 ], [ %.15, %137 ]
  %145 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 12
  %146 = load i32, i32* %145, align 8
  %147 = icmp ne i32 %146, 0
  br i1 %147, label %148, label %164

; <label>:148:                                    ; preds = %144
  %149 = getelementptr [30 x i8], [30 x i8]* @.str.122, i32 0, i32 0
  %150 = call i64 @realloc_strcat(i8** %1, i8* %149, i64 %.17)
  %151 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 12
  %152 = load i32, i32* %151, align 8
  %153 = icmp eq i32 %152, 1
  br i1 %153, label %154, label %157

; <label>:154:                                    ; preds = %148
  %155 = getelementptr [5 x i8], [5 x i8]* @.str.117, i32 0, i32 0
  %156 = call i64 @realloc_strcat(i8** %1, i8* %155, i64 %150)
  br label %157

; <label>:157:                                    ; preds = %154, %148
  %.18 = phi i64 [ %156, %154 ], [ %150, %148 ]
  %158 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 12
  %159 = load i32, i32* %158, align 8
  %160 = icmp eq i32 %159, 2
  br i1 %160, label %161, label %164

; <label>:161:                                    ; preds = %157
  %162 = getelementptr [5 x i8], [5 x i8]* @.str.118, i32 0, i32 0
  %163 = call i64 @realloc_strcat(i8** %1, i8* %162, i64 %.18)
  br label %164

; <label>:164:                                    ; preds = %157, %161, %144
  %.20 = phi i64 [ %.17, %144 ], [ %163, %161 ], [ %.18, %157 ]
  %165 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 13
  %166 = load i32, i32* %165, align 4
  %167 = icmp ne i32 %166, 0
  br i1 %167, label %168, label %184

; <label>:168:                                    ; preds = %164
  %169 = getelementptr [30 x i8], [30 x i8]* @.str.123, i32 0, i32 0
  %170 = call i64 @realloc_strcat(i8** %1, i8* %169, i64 %.20)
  %171 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 13
  %172 = load i32, i32* %171, align 4
  %173 = icmp eq i32 %172, 1
  br i1 %173, label %174, label %177

; <label>:174:                                    ; preds = %168
  %175 = getelementptr [5 x i8], [5 x i8]* @.str.117, i32 0, i32 0
  %176 = call i64 @realloc_strcat(i8** %1, i8* %175, i64 %170)
  br label %177

; <label>:177:                                    ; preds = %174, %168
  %.21 = phi i64 [ %176, %174 ], [ %170, %168 ]
  %178 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 13
  %179 = load i32, i32* %178, align 4
  %180 = icmp eq i32 %179, 2
  br i1 %180, label %181, label %184

; <label>:181:                                    ; preds = %177
  %182 = getelementptr [5 x i8], [5 x i8]* @.str.118, i32 0, i32 0
  %183 = call i64 @realloc_strcat(i8** %1, i8* %182, i64 %.21)
  br label %184

; <label>:184:                                    ; preds = %177, %181, %164
  %.23 = phi i64 [ %.20, %164 ], [ %183, %181 ], [ %.21, %177 ]
  %185 = getelementptr [2 x i8], [2 x i8]* @.str.115, i32 0, i32 0
  %186 = call i64 @realloc_strcat(i8** %1, i8* %185, i64 %.23)
  br label %187

; <label>:187:                                    ; preds = %184, %62
  %.24 = phi i64 [ %186, %184 ], [ %.5, %62 ]
  %188 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 1
  %189 = load i16, i16* %188, align 8
  %190 = zext i16 %189 to i32
  %191 = icmp ult i32 0, %190
  br i1 %191, label %.lr.ph41.preheader, label %._crit_edge42

.lr.ph41.preheader:                               ; preds = %187
  br label %.lr.ph41

.lr.ph41:                                         ; preds = %.lr.ph41.preheader, %220
  %indvars.iv45 = phi i64 [ %indvars.iv.next46, %220 ], [ 0, %.lr.ph41.preheader ]
  %.2539 = phi i64 [ %.28, %220 ], [ %.24, %.lr.ph41.preheader ]
  %.31238 = phi i16 [ %.514, %220 ], [ 0, %.lr.ph41.preheader ]
  %.01837 = phi i16 [ %.220, %220 ], [ 0, %.lr.ph41.preheader ]
  call void @unroll_loop(i32 8)
  %192 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 3
  %193 = getelementptr inbounds [32 x i16], [32 x i16]* %192, i64 0, i64 %indvars.iv45
  %194 = load i16, i16* %193, align 2
  %195 = zext i16 %194 to i32
  %196 = icmp eq i32 %195, 17
  br i1 %196, label %197, label %220

; <label>:197:                                    ; preds = %.lr.ph41
  %198 = icmp ne i16 %.31238, 0
  br i1 %198, label %207, label %199

; <label>:199:                                    ; preds = %197
  %200 = icmp ne i16 %.015.lcssa, 0
  br i1 %200, label %201, label %204

; <label>:201:                                    ; preds = %199
  %202 = getelementptr [5 x i8], [5 x i8]* @.str.113, i32 0, i32 0
  %203 = call i64 @realloc_strcat(i8** %1, i8* %202, i64 %.2539)
  br label %204

; <label>:204:                                    ; preds = %201, %199
  %.26 = phi i64 [ %203, %201 ], [ %.2539, %199 ]
  %205 = getelementptr [15 x i8], [15 x i8]* @.str.124, i32 0, i32 0
  %206 = call i64 @realloc_strcat(i8** %1, i8* %205, i64 %.26)
  br label %210

; <label>:207:                                    ; preds = %197
  %208 = getelementptr [5 x i8], [5 x i8]* @.str.113, i32 0, i32 0
  %209 = call i64 @realloc_strcat(i8** %1, i8* %208, i64 %.2539)
  br label %210

; <label>:210:                                    ; preds = %207, %204
  %.119 = phi i16 [ %.01837, %207 ], [ 1, %204 ]
  %.413 = phi i16 [ %.31238, %207 ], [ 1, %204 ]
  %.27 = phi i64 [ %209, %207 ], [ %206, %204 ]
  %211 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %212 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 2
  %213 = getelementptr inbounds [32 x i16], [32 x i16]* %212, i64 0, i64 %indvars.iv45
  %214 = load i16, i16* %213, align 2
  %215 = zext i16 %214 to i32
  %216 = getelementptr [4 x i8], [4 x i8]* @.str.114, i32 0, i32 0
  %217 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %211, i64 10, i8* %216, i32 %215) #7
  %218 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %219 = call i64 @realloc_strcat(i8** %1, i8* %218, i64 %.27)
  br label %220

; <label>:220:                                    ; preds = %.lr.ph41, %210
  %.220 = phi i16 [ %.119, %210 ], [ %.01837, %.lr.ph41 ]
  %.514 = phi i16 [ %.413, %210 ], [ %.31238, %.lr.ph41 ]
  %.28 = phi i64 [ %219, %210 ], [ %.2539, %.lr.ph41 ]
  %indvars.iv.next46 = add nuw nsw i64 %indvars.iv45, 1
  %221 = load i16, i16* %188, align 8
  %222 = zext i16 %221 to i32
  %223 = zext i32 %222 to i64
  %224 = icmp ult i64 %indvars.iv.next46, %223
  br i1 %224, label %.lr.ph41, label %._crit_edge42.loopexit

._crit_edge42.loopexit:                           ; preds = %220
  %.018.lcssa.ph = phi i16 [ %.220, %220 ]
  %.25.lcssa.ph = phi i64 [ %.28, %220 ]
  br label %._crit_edge42

._crit_edge42:                                    ; preds = %._crit_edge42.loopexit, %187
  %.018.lcssa = phi i16 [ 0, %187 ], [ %.018.lcssa.ph, %._crit_edge42.loopexit ]
  %.25.lcssa = phi i64 [ %.24, %187 ], [ %.25.lcssa.ph, %._crit_edge42.loopexit ]
  %225 = icmp ne i16 %.018.lcssa, 0
  br i1 %225, label %226, label %229

; <label>:226:                                    ; preds = %._crit_edge42
  %227 = getelementptr [2 x i8], [2 x i8]* @.str.115, i32 0, i32 0
  %228 = call i64 @realloc_strcat(i8** %1, i8* %227, i64 %.25.lcssa)
  br label %229

; <label>:229:                                    ; preds = %226, %._crit_edge42
  %.29 = phi i64 [ %228, %226 ], [ %.25.lcssa, %._crit_edge42 ]
  %230 = icmp eq i64 %.29, 0
  br i1 %230, label %231, label %233

; <label>:231:                                    ; preds = %229
  %232 = getelementptr [8 x i8], [8 x i8]* @.str.125, i32 0, i32 0
  call void @perror(i8* %232)
  call void @cleanup(i32 1)
  br label %233

; <label>:233:                                    ; preds = %231, %229
  %234 = load i8*, i8** %1, align 8
  %235 = call i64 @strlen(i8* %234) #10
  %236 = add i64 %235, 1
  %237 = call noalias i8* @malloc(i64 %236) #7, !track !44
  %238 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 15
  store i8* %237, i8** %238, align 8
  %239 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 15
  %240 = load i8*, i8** %239, align 8
  %241 = icmp eq i8* %240, null
  br i1 %241, label %242, label %244

; <label>:242:                                    ; preds = %233
  %243 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %243)
  call void @cleanup(i32 1)
  br label %244

; <label>:244:                                    ; preds = %242, %233
  %245 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %8, i32 0, i32 15
  %246 = load i8*, i8** %245, align 8
  %247 = load i8*, i8** %1, align 8
  %248 = call i8* @strcpy(i8* %246, i8* %247) #7, !track !45
  %249 = load i8*, i8** %1, align 8
  %250 = getelementptr inbounds i8, i8* %249, i64 0
  store i8 0, i8* %250, align 1
  br label %251

; <label>:251:                                    ; preds = %.lr.ph51, %244
  %.124 = phi i16 [ 1, %244 ], [ %.02347, %.lr.ph51 ]
  %.30 = phi i64 [ %.29, %244 ], [ %.0148, %.lr.ph51 ]
  %252 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.049, i32 0, i32 2
  %253 = load %struct.__pmlist_t*, %struct.__pmlist_t** %252, align 8
  %254 = icmp ne %struct.__pmlist_t* %253, null
  br i1 %254, label %.lr.ph51, label %._crit_edge52.loopexit

._crit_edge52.loopexit:                           ; preds = %251
  %.023.lcssa.ph = phi i16 [ %.124, %251 ]
  %.01.lcssa.ph = phi i64 [ %.30, %251 ]
  br label %._crit_edge52

._crit_edge52:                                    ; preds = %._crit_edge52.loopexit, %0
  %.023.lcssa = phi i16 [ 0, %0 ], [ %.023.lcssa.ph, %._crit_edge52.loopexit ]
  %.01.lcssa = phi i64 [ 0, %0 ], [ %.01.lcssa.ph, %._crit_edge52.loopexit ]
  %255 = icmp ne i16 %.023.lcssa, 0
  br i1 %255, label %256, label %303

; <label>:256:                                    ; preds = %._crit_edge52
  %257 = getelementptr [10 x i8], [10 x i8]* @.str.126, i32 0, i32 0
  %258 = call i64 @realloc_strcat(i8** %1, i8* %257, i64 %.01.lcssa)
  %259 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %260 = call i64 @realloc_strcat(i8** %1, i8* %259, i64 %258)
  %261 = getelementptr [7 x i8], [7 x i8]* @.str.127, i32 0, i32 0
  %262 = call i64 @realloc_strcat(i8** %1, i8* %261, i64 %260)
  %263 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %264 = icmp ne %struct.__pmlist_t* %263, null
  br i1 %264, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %256
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %277
  %.126 = phi %struct.__pmlist_t* [ %279, %277 ], [ %263, %.lr.ph.preheader ]
  %.3125 = phi i64 [ %.32, %277 ], [ %262, %.lr.ph.preheader ]
  call void @unroll_loop(i32 9)
  %265 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.126, i32 0, i32 0
  %266 = load i8*, i8** %265, align 8
  %267 = bitcast i8* %266 to %struct.opendoor*
  %268 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %267, i32 0, i32 15
  %269 = load i8*, i8** %268, align 8
  %270 = call i64 @realloc_strcat(i8** %1, i8* %269, i64 %.3125)
  %271 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.126, i32 0, i32 2
  %272 = load %struct.__pmlist_t*, %struct.__pmlist_t** %271, align 8
  %273 = icmp ne %struct.__pmlist_t* %272, null
  br i1 %273, label %274, label %277

; <label>:274:                                    ; preds = %.lr.ph
  %275 = getelementptr [5 x i8], [5 x i8]* @.str.113, i32 0, i32 0
  %276 = call i64 @realloc_strcat(i8** %1, i8* %275, i64 %270)
  br label %277

; <label>:277:                                    ; preds = %.lr.ph, %274
  %.32 = phi i64 [ %276, %274 ], [ %270, %.lr.ph ]
  %278 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.126, i32 0, i32 2
  %279 = load %struct.__pmlist_t*, %struct.__pmlist_t** %278, align 8
  %280 = icmp ne %struct.__pmlist_t* %279, null
  br i1 %280, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %277
  %.31.lcssa.ph = phi i64 [ %.32, %277 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %256
  %.31.lcssa = phi i64 [ %262, %256 ], [ %.31.lcssa.ph, %._crit_edge.loopexit ]
  %281 = getelementptr [2 x i8], [2 x i8]* @.str.115, i32 0, i32 0
  %282 = call i64 @realloc_strcat(i8** %1, i8* %281, i64 %.31.lcssa)
  %283 = icmp eq i64 %282, 0
  br i1 %283, label %284, label %286

; <label>:284:                                    ; preds = %._crit_edge
  %285 = getelementptr [8 x i8], [8 x i8]* @.str.125, i32 0, i32 0
  call void @perror(i8* %285)
  call void @cleanup(i32 1)
  br label %286

; <label>:286:                                    ; preds = %284, %._crit_edge
  %287 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %288 = load i8*, i8** %1, align 8
  %289 = call i32 @pcap_compile(%struct.pcap* %287, %struct.bpf_program* %3, i8* %288, i32 1, i32 0)
  %290 = icmp slt i32 %289, 0
  br i1 %290, label %291, label %294

; <label>:291:                                    ; preds = %286
  %292 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %293 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %292, i8* %293)
  call void @cleanup(i32 1)
  br label %294

; <label>:294:                                    ; preds = %291, %286
  %295 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %296 = call i32 @pcap_setfilter(%struct.pcap* %295, %struct.bpf_program* %3)
  %297 = icmp slt i32 %296, 0
  br i1 %297, label %298, label %301

; <label>:298:                                    ; preds = %294
  %299 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %300 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %299, i8* %300)
  call void @cleanup(i32 1)
  br label %301

; <label>:301:                                    ; preds = %298, %294
  call void @pcap_freecode(%struct.bpf_program* %3)
  %302 = load i8*, i8** %1, align 8
  call void @free(i8* %302) #7
  br label %303

; <label>:303:                                    ; preds = %301, %._crit_edge52
  ret void
}

; Function Attrs: nounwind
declare dso_local i32 @daemon(i32, i32) #2

; Function Attrs: nounwind
declare dso_local i32 @getpid() #2

declare dso_local i32 @fclose(%struct._IO_FILE*) #5

; Function Attrs: nounwind readnone
declare dso_local i32* @__errno_location() #6

; Function Attrs: nounwind
declare dso_local i8* @strerror(i32) #2

; Function Attrs: noinline nounwind uwtable
define dso_local void @logprint(i8*, ...) #0 {
  %2 = alloca [1024 x i8], align 16, !track !46
  %3 = alloca [1 x %struct.__va_list_tag], align 16, !track !47
  %4 = alloca i64, align 8
  %5 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %3, i32 0, i32 0
  %6 = bitcast %struct.__va_list_tag* %5 to i8*
  call void @llvm.va_start(i8* %6)
  %7 = getelementptr inbounds [1024 x i8], [1024 x i8]* %2, i32 0, i32 0
  %8 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %3, i32 0, i32 0
  %9 = call i32 @vsnprintf(i8* %7, i64 1024, i8* %0, %struct.__va_list_tag* %8) #7
  %10 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %3, i32 0, i32 0
  %11 = bitcast %struct.__va_list_tag* %10 to i8*
  call void @llvm.va_end(i8* %11)
  %12 = load i32, i32* @o_usesyslog, align 4
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %14, label %17

; <label>:14:                                     ; preds = %1
  %15 = getelementptr inbounds [1024 x i8], [1024 x i8]* %2, i32 0, i32 0
  %16 = getelementptr [3 x i8], [3 x i8]* @.str.28, i32 0, i32 0
  call void (i32, i8*, ...) @syslog(i32 5, i8* %16, i8* %15)
  br label %17

; <label>:17:                                     ; preds = %14, %1
  %18 = load %struct._IO_FILE*, %struct._IO_FILE** @logfd, align 8
  %19 = icmp ne %struct._IO_FILE* %18, null
  br i1 %19, label %20, label %41

; <label>:20:                                     ; preds = %17
  %21 = call i64 @time(i64* null) #7
  store i64 %21, i64* %4, align 8
  %22 = call %struct.tm* @localtime(i64* %4) #7
  %23 = load %struct._IO_FILE*, %struct._IO_FILE** @logfd, align 8
  %24 = getelementptr inbounds %struct.tm, %struct.tm* %22, i32 0, i32 5
  %25 = load i32, i32* %24, align 4
  %26 = add nsw i32 %25, 1900
  %27 = getelementptr inbounds %struct.tm, %struct.tm* %22, i32 0, i32 4
  %28 = load i32, i32* %27, align 8
  %29 = add nsw i32 %28, 1
  %30 = getelementptr inbounds %struct.tm, %struct.tm* %22, i32 0, i32 3
  %31 = load i32, i32* %30, align 4
  %32 = getelementptr inbounds %struct.tm, %struct.tm* %22, i32 0, i32 2
  %33 = load i32, i32* %32, align 8
  %34 = getelementptr inbounds %struct.tm, %struct.tm* %22, i32 0, i32 1
  %35 = load i32, i32* %34, align 4
  %36 = getelementptr inbounds [1024 x i8], [1024 x i8]* %2, i32 0, i32 0
  %37 = getelementptr [31 x i8], [31 x i8]* @.str.29, i32 0, i32 0
  %38 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %23, i8* %37, i32 %26, i32 %29, i32 %31, i32 %33, i32 %35, i8* %36)
  %39 = load %struct._IO_FILE*, %struct._IO_FILE** @logfd, align 8
  %40 = call i32 @fflush(%struct._IO_FILE* %39)
  br label %41

; <label>:41:                                     ; preds = %20, %17
  ret void
}

; Function Attrs: nounwind
declare dso_local void (i32)* @signal(i32, void (i32)*) #2

; Function Attrs: noinline nounwind uwtable
define dso_local void @child_exit(i32) #0 {
  %2 = alloca %union.__WAIT_STATUS, align 8
  %3 = bitcast %union.__WAIT_STATUS* %2 to %struct.in_addr**
  store %struct.in_addr* null, %struct.in_addr** %3, align 8
  %4 = getelementptr inbounds %union.__WAIT_STATUS, %union.__WAIT_STATUS* %2, i32 0, i32 0
  %5 = load %struct.in_addr*, %struct.in_addr** %4, align 8
  %6 = call i32 @wait(%struct.in_addr* %5)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @read_cfg(i32) #0 {
  %2 = getelementptr [28 x i8], [28 x i8]* @.str.38, i32 0, i32 0
  %3 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %2, i8* %3)
  %4 = getelementptr [28 x i8], [28 x i8]* @.str.38, i32 0, i32 0
  %5 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %4, i8* %5)
  %6 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %7 = icmp ne %struct.__pmlist_t* %6, null
  br i1 %7, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %1
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.01 = phi %struct.__pmlist_t* [ %12, %.lr.ph ], [ %6, %.lr.ph.preheader ]
  call void @unroll_loop(i32 10)
  %8 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.01, i32 0, i32 0
  %9 = load i8*, i8** %8, align 8
  %10 = bitcast i8* %9 to %struct.opendoor*
  call void @close_door(%struct.opendoor* %10)
  %11 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.01, i32 0, i32 2
  %12 = load %struct.__pmlist_t*, %struct.__pmlist_t** %11, align 8
  %13 = icmp ne %struct.__pmlist_t* %12, null
  br i1 %13, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %1
  %14 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  call void @list_free(%struct.__pmlist_t* %14)
  %15 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i32 0, i32 0
  %16 = call i32 @parseconfig(i8* %15)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @vprint(i8*, ...) #0 {
  %2 = alloca [1 x %struct.__va_list_tag], align 16
  %3 = load i32, i32* @o_verbose, align 4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %5, label %14

; <label>:5:                                      ; preds = %1
  %6 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %2, i32 0, i32 0
  %7 = bitcast %struct.__va_list_tag* %6 to i8*
  call void @llvm.va_start(i8* %7)
  %8 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %2, i32 0, i32 0
  %9 = call i32 @vprintf(i8* %0, %struct.__va_list_tag* %8)
  %10 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %2, i32 0, i32 0
  %11 = bitcast %struct.__va_list_tag* %10 to i8*
  call void @llvm.va_end(i8* %11)
  %12 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %13 = call i32 @fflush(%struct._IO_FILE* %12)
  br label %14

; <label>:14:                                     ; preds = %5, %1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @sniff(i8*, %struct.pcap_pkthdr*, i8*) #0 {
  %4 = alloca [8 x i8], align 1
  %5 = alloca %struct.in_addr, align 4, !track !48
  %6 = alloca [16 x i8], align 16, !track !49
  %7 = alloca [16 x i8], align 16, !track !50
  %8 = alloca i64, align 8
  %9 = alloca [11 x i8], align 1
  %10 = alloca [9 x i8], align 1
  %11 = alloca [100 x i8], align 16
  %12 = alloca [100 x i8], align 16
  %13 = getelementptr inbounds %struct.pcap_pkthdr, %struct.pcap_pkthdr* %1, i32 0, i32 0
  %14 = getelementptr inbounds %struct.timeval, %struct.timeval* %13, i32 0, i32 0
  %15 = load i64, i64* %14, align 8
  store i64 %15, i64* %8, align 8
  %16 = load i32, i32* @lltype, align 4
  %17 = icmp eq i32 %16, 1
  br i1 %17, label %18, label %28

; <label>:18:                                     ; preds = %3
  %19 = bitcast i8* %2 to %struct.ethhdr*
  %20 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i32 0, i32 2
  %21 = load i16, i16* %20, align 1
  %22 = call zeroext i16 @ntohs(i16 zeroext %21) #11
  %23 = zext i16 %22 to i32
  %24 = icmp ne i32 %23, 2048
  br i1 %24, label %._crit_edge, label %25

; <label>:25:                                     ; preds = %18
  %26 = getelementptr inbounds i8, i8* %2, i64 14
  %27 = bitcast i8* %26 to %struct.iphdr*
  br label %38

; <label>:28:                                     ; preds = %3
  %29 = load i32, i32* @lltype, align 4
  %30 = icmp eq i32 %29, 113
  br i1 %30, label %31, label %34

; <label>:31:                                     ; preds = %28
  %32 = getelementptr inbounds i8, i8* %2, i64 16
  %33 = bitcast i8* %32 to %struct.iphdr*
  br label %38

; <label>:34:                                     ; preds = %28
  %35 = load i32, i32* @lltype, align 4
  %36 = icmp eq i32 %35, 12
  %37 = bitcast i8* %2 to %struct.iphdr*
  %spec.select = select i1 %36, %struct.iphdr* %37, %struct.iphdr* null
  br label %38

; <label>:38:                                     ; preds = %31, %34, %25
  %.213 = phi %struct.iphdr* [ %27, %25 ], [ %33, %31 ], [ %spec.select, %34 ]
  %39 = bitcast %struct.iphdr* %.213 to i8*
  %40 = load i8, i8* %39, align 4
  %41 = lshr i8 %40, 4
  %42 = zext i8 %41 to i32
  %43 = icmp ne i32 %42, 4
  br i1 %43, label %44, label %46

; <label>:44:                                     ; preds = %38
  %45 = getelementptr [33 x i8], [33 x i8]* @.str.134, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %45)
  br label %._crit_edge

; <label>:46:                                     ; preds = %38
  %47 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %48 = load i8, i8* %47, align 1
  %49 = zext i8 %48 to i32
  %50 = icmp eq i32 %49, 1
  br i1 %50, label %._crit_edge, label %51

; <label>:51:                                     ; preds = %46
  %52 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %53 = call i32 @inet_aton(i8* %52, %struct.in_addr* %5) #7
  %54 = icmp eq i32 %53, 0
  br i1 %54, label %55, label %60

; <label>:55:                                     ; preds = %51
  %56 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %57 = getelementptr [44 x i8], [44 x i8]* @.str.135, i32 0, i32 0
  %58 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %59 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %56, i8* %57, i8* %58)
  br label %._crit_edge

; <label>:60:                                     ; preds = %51
  %61 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 9
  %62 = load i32, i32* %61, align 4
  %63 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  %64 = load i32, i32* %63, align 4
  %65 = icmp ne i32 %62, %64
  br i1 %65, label %66, label %68

; <label>:66:                                     ; preds = %60
  %67 = getelementptr [47 x i8], [47 x i8]* @.str.136, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %67)
  br label %._crit_edge

; <label>:68:                                     ; preds = %60
  %69 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %70 = load i8, i8* %69, align 1
  %71 = zext i8 %70 to i32
  %72 = icmp eq i32 %71, 6
  br i1 %72, label %73, label %96

; <label>:73:                                     ; preds = %68
  %74 = getelementptr inbounds [8 x i8], [8 x i8]* %4, i32 0, i32 0
  %75 = getelementptr [4 x i8], [4 x i8]* @.str.137, i32 0, i32 0
  %76 = call i8* @strncpy(i8* %74, i8* %75, i64 8) #7
  %77 = bitcast %struct.iphdr* %.213 to i8*
  %78 = bitcast %struct.iphdr* %.213 to i8*
  %79 = load i8, i8* %78, align 4
  %80 = and i8 %79, 15
  %81 = zext i8 %80 to i32
  %82 = mul nsw i32 %81, 4
  %83 = sext i32 %82 to i64
  %84 = getelementptr inbounds i8, i8* %77, i64 %83
  %85 = bitcast i8* %84 to %struct.tcphdr*
  %86 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %85, i32 0, i32 0
  %87 = bitcast %union.anon.4* %86 to %struct.anon.6*
  %88 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %87, i32 0, i32 0
  %89 = load i16, i16* %88, align 4
  %90 = call zeroext i16 @ntohs(i16 zeroext %89) #11
  %91 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %85, i32 0, i32 0
  %92 = bitcast %union.anon.4* %91 to %struct.anon.6*
  %93 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %92, i32 0, i32 1
  %94 = load i16, i16* %93, align 2
  %95 = call zeroext i16 @ntohs(i16 zeroext %94) #11
  br label %96

; <label>:96:                                     ; preds = %73, %68
  %.017 = phi i16 [ %95, %73 ], [ 0, %68 ]
  %.015 = phi i16 [ %90, %73 ], [ 0, %68 ]
  %.014 = phi %struct.tcphdr* [ %85, %73 ], [ null, %68 ]
  %97 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %98 = load i8, i8* %97, align 1
  %99 = zext i8 %98 to i32
  %100 = icmp eq i32 %99, 17
  br i1 %100, label %101, label %124

; <label>:101:                                    ; preds = %96
  %102 = getelementptr inbounds [8 x i8], [8 x i8]* %4, i32 0, i32 0
  %103 = getelementptr [4 x i8], [4 x i8]* @.str.138, i32 0, i32 0
  %104 = call i8* @strncpy(i8* %102, i8* %103, i64 8) #7
  %105 = bitcast %struct.iphdr* %.213 to i8*
  %106 = bitcast %struct.iphdr* %.213 to i8*
  %107 = load i8, i8* %106, align 4
  %108 = and i8 %107, 15
  %109 = zext i8 %108 to i32
  %110 = mul nsw i32 %109, 4
  %111 = sext i32 %110 to i64
  %112 = getelementptr inbounds i8, i8* %105, i64 %111
  %113 = bitcast i8* %112 to %struct.udphdr*
  %114 = getelementptr inbounds %struct.udphdr, %struct.udphdr* %113, i32 0, i32 0
  %115 = bitcast %union.anon.7* %114 to %struct.anon.8*
  %116 = getelementptr inbounds %struct.anon.8, %struct.anon.8* %115, i32 0, i32 0
  %117 = load i16, i16* %116, align 2
  %118 = call zeroext i16 @ntohs(i16 zeroext %117) #11
  %119 = getelementptr inbounds %struct.udphdr, %struct.udphdr* %113, i32 0, i32 0
  %120 = bitcast %union.anon.7* %119 to %struct.anon.8*
  %121 = getelementptr inbounds %struct.anon.8, %struct.anon.8* %120, i32 0, i32 1
  %122 = load i16, i16* %121, align 2
  %123 = call zeroext i16 @ntohs(i16 zeroext %122) #11
  br label %124

; <label>:124:                                    ; preds = %101, %96
  %.118 = phi i16 [ %123, %101 ], [ %.017, %96 ]
  %.116 = phi i16 [ %118, %101 ], [ %.015, %96 ]
  %125 = call %struct.tm* @localtime(i64* %8) #7
  %126 = getelementptr inbounds [11 x i8], [11 x i8]* %9, i32 0, i32 0
  %127 = getelementptr inbounds %struct.tm, %struct.tm* %125, i32 0, i32 5
  %128 = load i32, i32* %127, align 4
  %129 = add nsw i32 %128, 1900
  %130 = getelementptr inbounds %struct.tm, %struct.tm* %125, i32 0, i32 4
  %131 = load i32, i32* %130, align 8
  %132 = getelementptr inbounds %struct.tm, %struct.tm* %125, i32 0, i32 3
  %133 = load i32, i32* %132, align 4
  %134 = getelementptr [15 x i8], [15 x i8]* @.str.139, i32 0, i32 0
  %135 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %126, i64 11, i8* %134, i32 %129, i32 %131, i32 %133) #7
  %136 = getelementptr inbounds [9 x i8], [9 x i8]* %10, i32 0, i32 0
  %137 = getelementptr inbounds %struct.tm, %struct.tm* %125, i32 0, i32 2
  %138 = load i32, i32* %137, align 8
  %139 = getelementptr inbounds %struct.tm, %struct.tm* %125, i32 0, i32 1
  %140 = load i32, i32* %139, align 4
  %141 = getelementptr inbounds %struct.tm, %struct.tm* %125, i32 0, i32 0
  %142 = load i32, i32* %141, align 8
  %143 = getelementptr [15 x i8], [15 x i8]* @.str.140, i32 0, i32 0
  %144 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %136, i64 9, i8* %143, i32 %138, i32 %140, i32 %142) #7
  %145 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 8
  %146 = load i32, i32* %145, align 4
  %147 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  store i32 %146, i32* %147, align 4
  %148 = getelementptr inbounds [16 x i8], [16 x i8]* %6, i32 0, i32 0
  %149 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  %150 = load i32, i32* %149, align 4
  %151 = call i8* @inet_ntoa(i32 %150) #7, !track !51
  %152 = call i8* @strncpy(i8* %148, i8* %151, i64 15) #7, !track !52
  %153 = getelementptr inbounds [16 x i8], [16 x i8]* %6, i64 0, i64 15
  store i8 0, i8* %153, align 1
  %154 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 9
  %155 = load i32, i32* %154, align 4
  %156 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  store i32 %155, i32* %156, align 4
  %157 = getelementptr inbounds [16 x i8], [16 x i8]* %7, i32 0, i32 0
  %158 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  %159 = load i32, i32* %158, align 4
  %160 = call i8* @inet_ntoa(i32 %159) #7, !track !53
  %161 = call i8* @strncpy(i8* %157, i8* %160, i64 15) #7, !track !54
  %162 = getelementptr inbounds [16 x i8], [16 x i8]* %7, i64 0, i64 15
  store i8 0, i8* %162, align 1
  %163 = getelementptr inbounds [11 x i8], [11 x i8]* %9, i32 0, i32 0
  %164 = getelementptr inbounds [9 x i8], [9 x i8]* %10, i32 0, i32 0
  %165 = getelementptr inbounds [8 x i8], [8 x i8]* %4, i32 0, i32 0
  %166 = getelementptr inbounds [16 x i8], [16 x i8]* %6, i32 0, i32 0
  %167 = zext i16 %.116 to i32
  %168 = getelementptr inbounds [16 x i8], [16 x i8]* %7, i32 0, i32 0
  %169 = zext i16 %.118 to i32
  %170 = getelementptr inbounds %struct.pcap_pkthdr, %struct.pcap_pkthdr* %1, i32 0, i32 2
  %171 = load i32, i32* %170, align 4
  %172 = getelementptr [36 x i8], [36 x i8]* @.str.141, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %172, i8* %163, i8* %164, i8* %165, i8* %166, i32 %167, i8* %168, i32 %169, i32 %171)
  %173 = load %struct.__pmlist_t*, %struct.__pmlist_t** @attempts, align 8
  %174 = icmp ne %struct.__pmlist_t* %173, null
  br i1 %174, label %.lr.ph30.preheader, label %._crit_edge31

.lr.ph30.preheader:                               ; preds = %124
  br label %.lr.ph30

.lr.ph30:                                         ; preds = %.lr.ph30.preheader, %294
  %.02028 = phi %struct.__pmlist_t* [ %296, %294 ], [ %173, %.lr.ph30.preheader ]
  call void @unroll_loop(i32 14)
  %175 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 0
  %176 = load i8*, i8** %175, align 8
  %177 = bitcast i8* %176 to %struct.knocker*
  %178 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 1
  %179 = load i16, i16* %178, align 8
  %180 = sext i16 %179 to i32
  %181 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 0
  %182 = load %struct.opendoor*, %struct.opendoor** %181, align 8
  %183 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %182, i32 0, i32 1
  %184 = load i16, i16* %183, align 8
  %185 = zext i16 %184 to i32
  %186 = icmp sge i32 %180, %185
  br i1 %186, label %187, label %191

; <label>:187:                                    ; preds = %.lr.ph30
  %188 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 2
  %189 = getelementptr inbounds [16 x i8], [16 x i8]* %188, i32 0, i32 0
  %190 = getelementptr [40 x i8], [40 x i8]* @.str.142, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %190, i8* %189)
  br label %191

; <label>:191:                                    ; preds = %187, %.lr.ph30
  %.01 = phi i32 [ 1, %187 ], [ 0, %.lr.ph30 ]
  %192 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 1
  %193 = load i16, i16* %192, align 8
  %194 = sext i16 %193 to i32
  %195 = icmp slt i32 %194, 0
  br i1 %195, label %196, label %200

; <label>:196:                                    ; preds = %191
  %197 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 2
  %198 = getelementptr inbounds [16 x i8], [16 x i8]* %197, i32 0, i32 0
  %199 = getelementptr [36 x i8], [36 x i8]* @.str.143, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %199, i8* %198)
  br label %200

; <label>:200:                                    ; preds = %196, %191
  %.19 = phi i32 [ 1, %196 ], [ %.01, %191 ]
  %201 = icmp ne i32 %.19, 0
  br i1 %201, label %260, label %202

; <label>:202:                                    ; preds = %200
  %203 = load i64, i64* %8, align 8
  %204 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 4
  %205 = load i64, i64* %204, align 8
  %206 = sub nsw i64 %203, %205
  %207 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 0
  %208 = load %struct.opendoor*, %struct.opendoor** %207, align 8
  %209 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %208, i32 0, i32 4
  %210 = load i64, i64* %209, align 8
  %211 = icmp sge i64 %206, %210
  br i1 %211, label %212, label %260

; <label>:212:                                    ; preds = %202
  %213 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 3
  %214 = load i8*, i8** %213, align 8
  %215 = icmp ne i8* %214, null
  %216 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 2
  %217 = getelementptr inbounds [16 x i8], [16 x i8]* %216, i32 0, i32 0
  br i1 %215, label %218, label %241

; <label>:218:                                    ; preds = %212
  %219 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 3
  %220 = load i8*, i8** %219, align 8
  %221 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 0
  %222 = load %struct.opendoor*, %struct.opendoor** %221, align 8
  %223 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %222, i32 0, i32 0
  %224 = getelementptr inbounds [128 x i8], [128 x i8]* %223, i32 0, i32 0
  %225 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 1
  %226 = load i16, i16* %225, align 8
  %227 = sext i16 %226 to i32
  %228 = getelementptr [42 x i8], [42 x i8]* @.str.144, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %228, i8* %217, i8* %220, i8* %224, i32 %227)
  %229 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 2
  %230 = getelementptr inbounds [16 x i8], [16 x i8]* %229, i32 0, i32 0
  %231 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 3
  %232 = load i8*, i8** %231, align 8
  %233 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 0
  %234 = load %struct.opendoor*, %struct.opendoor** %233, align 8
  %235 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %234, i32 0, i32 0
  %236 = getelementptr inbounds [128 x i8], [128 x i8]* %235, i32 0, i32 0
  %237 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 1
  %238 = load i16, i16* %237, align 8
  %239 = sext i16 %238 to i32
  %240 = getelementptr [42 x i8], [42 x i8]* @.str.144, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %240, i8* %230, i8* %232, i8* %236, i32 %239)
  br label %260

; <label>:241:                                    ; preds = %212
  %242 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 0
  %243 = load %struct.opendoor*, %struct.opendoor** %242, align 8
  %244 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %243, i32 0, i32 0
  %245 = getelementptr inbounds [128 x i8], [128 x i8]* %244, i32 0, i32 0
  %246 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 1
  %247 = load i16, i16* %246, align 8
  %248 = sext i16 %247 to i32
  %249 = getelementptr [37 x i8], [37 x i8]* @.str.145, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %249, i8* %217, i8* %245, i32 %248)
  %250 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 2
  %251 = getelementptr inbounds [16 x i8], [16 x i8]* %250, i32 0, i32 0
  %252 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 0
  %253 = load %struct.opendoor*, %struct.opendoor** %252, align 8
  %254 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %253, i32 0, i32 0
  %255 = getelementptr inbounds [128 x i8], [128 x i8]* %254, i32 0, i32 0
  %256 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 1
  %257 = load i16, i16* %256, align 8
  %258 = sext i16 %257 to i32
  %259 = getelementptr [37 x i8], [37 x i8]* @.str.145, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %259, i8* %251, i8* %255, i32 %258)
  br label %260

; <label>:260:                                    ; preds = %218, %241, %202, %200
  %.210 = phi i32 [ %.19, %200 ], [ %.19, %202 ], [ 1, %241 ], [ 1, %218 ]
  %261 = icmp ne i32 %.210, 0
  br i1 %261, label %262, label %294

; <label>:262:                                    ; preds = %260
  %263 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 0
  %264 = load i8*, i8** %263, align 8
  %265 = bitcast i8* %264 to %struct.knocker*
  %266 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 1
  %267 = load %struct.__pmlist_t*, %struct.__pmlist_t** %266, align 8
  %268 = icmp ne %struct.__pmlist_t* %267, null
  br i1 %268, label %269, label %275

; <label>:269:                                    ; preds = %262
  %270 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  %271 = load %struct.__pmlist_t*, %struct.__pmlist_t** %270, align 8
  %272 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 1
  %273 = load %struct.__pmlist_t*, %struct.__pmlist_t** %272, align 8
  %274 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %273, i32 0, i32 2
  store %struct.__pmlist_t* %271, %struct.__pmlist_t** %274, align 8
  br label %275

; <label>:275:                                    ; preds = %269, %262
  %276 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  %277 = load %struct.__pmlist_t*, %struct.__pmlist_t** %276, align 8
  %278 = icmp ne %struct.__pmlist_t* %277, null
  br i1 %278, label %279, label %285

; <label>:279:                                    ; preds = %275
  %280 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 1
  %281 = load %struct.__pmlist_t*, %struct.__pmlist_t** %280, align 8
  %282 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  %283 = load %struct.__pmlist_t*, %struct.__pmlist_t** %282, align 8
  %284 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %283, i32 0, i32 1
  store %struct.__pmlist_t* %281, %struct.__pmlist_t** %284, align 8
  br label %285

; <label>:285:                                    ; preds = %279, %275
  %286 = load %struct.__pmlist_t*, %struct.__pmlist_t** @attempts, align 8
  %287 = icmp eq %struct.__pmlist_t* %.02028, %286
  br i1 %287, label %288, label %289

; <label>:288:                                    ; preds = %285
  store %struct.__pmlist_t* null, %struct.__pmlist_t** @attempts, align 8
  br label %289

; <label>:289:                                    ; preds = %288, %285
  %290 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  store %struct.__pmlist_t* null, %struct.__pmlist_t** %290, align 8
  %291 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 1
  store %struct.__pmlist_t* null, %struct.__pmlist_t** %291, align 8
  %292 = getelementptr inbounds %struct.knocker, %struct.knocker* %265, i32 0, i32 3
  %293 = load i8*, i8** %292, align 8
  call void @free(i8* %293) #7
  call void @list_free(%struct.__pmlist_t* %.02028)
  br label %294

; <label>:294:                                    ; preds = %260, %289
  %295 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  %296 = load %struct.__pmlist_t*, %struct.__pmlist_t** %295, align 8
  %297 = icmp ne %struct.__pmlist_t* %296, null
  br i1 %297, label %.lr.ph30, label %._crit_edge31.loopexit

._crit_edge31.loopexit:                           ; preds = %294
  br label %._crit_edge31

._crit_edge31:                                    ; preds = %._crit_edge31.loopexit, %124
  %298 = load %struct.__pmlist_t*, %struct.__pmlist_t** @attempts, align 8
  %299 = icmp ne %struct.__pmlist_t* %298, null
  br i1 %299, label %.lr.ph27.preheader, label %.loopexit

.lr.ph27.preheader:                               ; preds = %._crit_edge31
  br label %.lr.ph27

.lr.ph27:                                         ; preds = %.lr.ph27.preheader, %312
  %.12125 = phi %struct.__pmlist_t* [ %314, %312 ], [ %298, %.lr.ph27.preheader ]
  call void @unroll_loop(i32 15)
  %300 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.12125, i32 0, i32 0
  %301 = load i8*, i8** %300, align 8
  %302 = bitcast i8* %301 to %struct.knocker*
  %303 = getelementptr inbounds %struct.knocker, %struct.knocker* %302, i32 0, i32 2
  %304 = getelementptr inbounds [16 x i8], [16 x i8]* %303, i32 0, i32 0
  %305 = getelementptr inbounds [16 x i8], [16 x i8]* %6, i32 0, i32 0
  %306 = call i32 @strncmp(i8* %304, i8* %305, i64 16) #10
  %307 = icmp ne i32 %306, 0
  br i1 %307, label %312, label %308

; <label>:308:                                    ; preds = %.lr.ph27
  %.121.lcssa23 = phi %struct.__pmlist_t* [ %.12125, %.lr.ph27 ]
  %309 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.121.lcssa23, i32 0, i32 0
  %310 = load i8*, i8** %309, align 8
  %311 = bitcast i8* %310 to %struct.knocker*
  br label %.loopexit

; <label>:312:                                    ; preds = %.lr.ph27
  %313 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.12125, i32 0, i32 2
  %314 = load %struct.__pmlist_t*, %struct.__pmlist_t** %313, align 8
  %315 = icmp ne %struct.__pmlist_t* %314, null
  br i1 %315, label %.lr.ph27, label %.loopexit.loopexit

.loopexit.loopexit:                               ; preds = %312
  %.019.ph = phi %struct.knocker* [ null, %312 ]
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %._crit_edge31, %308
  %.019 = phi %struct.knocker* [ %311, %308 ], [ null, %._crit_edge31 ], [ %.019.ph, %.loopexit.loopexit ]
  %316 = icmp ne %struct.knocker* %.019, null
  br i1 %316, label %317, label %825

; <label>:317:                                    ; preds = %.loopexit
  %318 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %319 = load i8, i8* %318, align 1
  %320 = zext i8 %319 to i32
  %321 = icmp eq i32 %320, 6
  br i1 %321, label %322, label %562

; <label>:322:                                    ; preds = %317
  %323 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %324 = load %struct.opendoor*, %struct.opendoor** %323, align 8
  %325 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %324, i32 0, i32 8
  %326 = load i32, i32* %325, align 8
  %327 = icmp ne i32 %326, 0
  br i1 %327, label %328, label %362

; <label>:328:                                    ; preds = %322
  %329 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %330 = load %struct.opendoor*, %struct.opendoor** %329, align 8
  %331 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %330, i32 0, i32 8
  %332 = load i32, i32* %331, align 8
  %333 = icmp eq i32 %332, 1
  br i1 %333, label %334, label %345

; <label>:334:                                    ; preds = %328
  %335 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %336 = bitcast %union.anon.4* %335 to %struct.anon.6*
  %337 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %336, i32 0, i32 4
  %338 = load i16, i16* %337, align 4
  %339 = lshr i16 %338, 8
  %340 = and i16 %339, 1
  %341 = zext i16 %340 to i32
  %342 = icmp ne i32 %341, 1
  br i1 %342, label %343, label %345

; <label>:343:                                    ; preds = %334
  %344 = getelementptr [32 x i8], [32 x i8]* @.str.146, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %344)
  br label %345

; <label>:345:                                    ; preds = %343, %334, %328
  %.0 = phi i32 [ 0, %343 ], [ 1, %334 ], [ 1, %328 ]
  %346 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %347 = load %struct.opendoor*, %struct.opendoor** %346, align 8
  %348 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %347, i32 0, i32 8
  %349 = load i32, i32* %348, align 8
  %350 = icmp eq i32 %349, 2
  br i1 %350, label %351, label %362

; <label>:351:                                    ; preds = %345
  %352 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %353 = bitcast %union.anon.4* %352 to %struct.anon.6*
  %354 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %353, i32 0, i32 4
  %355 = load i16, i16* %354, align 4
  %356 = lshr i16 %355, 8
  %357 = and i16 %356, 1
  %358 = zext i16 %357 to i32
  %359 = icmp eq i32 %358, 1
  br i1 %359, label %360, label %362

; <label>:360:                                    ; preds = %351
  %361 = getelementptr [33 x i8], [33 x i8]* @.str.147, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %361)
  br label %362

; <label>:362:                                    ; preds = %345, %351, %360, %322
  %.2 = phi i32 [ 1, %322 ], [ 0, %360 ], [ %.0, %351 ], [ %.0, %345 ]
  %363 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %364 = load %struct.opendoor*, %struct.opendoor** %363, align 8
  %365 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %364, i32 0, i32 9
  %366 = load i32, i32* %365, align 4
  %367 = icmp ne i32 %366, 0
  br i1 %367, label %368, label %402

; <label>:368:                                    ; preds = %362
  %369 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %370 = load %struct.opendoor*, %struct.opendoor** %369, align 8
  %371 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %370, i32 0, i32 9
  %372 = load i32, i32* %371, align 4
  %373 = icmp eq i32 %372, 1
  br i1 %373, label %374, label %385

; <label>:374:                                    ; preds = %368
  %375 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %376 = bitcast %union.anon.4* %375 to %struct.anon.6*
  %377 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %376, i32 0, i32 4
  %378 = load i16, i16* %377, align 4
  %379 = lshr i16 %378, 9
  %380 = and i16 %379, 1
  %381 = zext i16 %380 to i32
  %382 = icmp ne i32 %381, 1
  br i1 %382, label %383, label %385

; <label>:383:                                    ; preds = %374
  %384 = getelementptr [32 x i8], [32 x i8]* @.str.148, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %384)
  br label %385

; <label>:385:                                    ; preds = %383, %374, %368
  %.3 = phi i32 [ 0, %383 ], [ %.2, %374 ], [ %.2, %368 ]
  %386 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %387 = load %struct.opendoor*, %struct.opendoor** %386, align 8
  %388 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %387, i32 0, i32 9
  %389 = load i32, i32* %388, align 4
  %390 = icmp eq i32 %389, 2
  br i1 %390, label %391, label %402

; <label>:391:                                    ; preds = %385
  %392 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %393 = bitcast %union.anon.4* %392 to %struct.anon.6*
  %394 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %393, i32 0, i32 4
  %395 = load i16, i16* %394, align 4
  %396 = lshr i16 %395, 9
  %397 = and i16 %396, 1
  %398 = zext i16 %397 to i32
  %399 = icmp eq i32 %398, 1
  br i1 %399, label %400, label %402

; <label>:400:                                    ; preds = %391
  %401 = getelementptr [33 x i8], [33 x i8]* @.str.149, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %401)
  br label %402

; <label>:402:                                    ; preds = %385, %391, %400, %362
  %.5 = phi i32 [ %.2, %362 ], [ 0, %400 ], [ %.3, %391 ], [ %.3, %385 ]
  %403 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %404 = load %struct.opendoor*, %struct.opendoor** %403, align 8
  %405 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %404, i32 0, i32 10
  %406 = load i32, i32* %405, align 8
  %407 = icmp ne i32 %406, 0
  br i1 %407, label %408, label %442

; <label>:408:                                    ; preds = %402
  %409 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %410 = load %struct.opendoor*, %struct.opendoor** %409, align 8
  %411 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %410, i32 0, i32 10
  %412 = load i32, i32* %411, align 8
  %413 = icmp eq i32 %412, 1
  br i1 %413, label %414, label %425

; <label>:414:                                    ; preds = %408
  %415 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %416 = bitcast %union.anon.4* %415 to %struct.anon.6*
  %417 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %416, i32 0, i32 4
  %418 = load i16, i16* %417, align 4
  %419 = lshr i16 %418, 10
  %420 = and i16 %419, 1
  %421 = zext i16 %420 to i32
  %422 = icmp ne i32 %421, 1
  br i1 %422, label %423, label %425

; <label>:423:                                    ; preds = %414
  %424 = getelementptr [32 x i8], [32 x i8]* @.str.150, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %424)
  br label %425

; <label>:425:                                    ; preds = %423, %414, %408
  %.6 = phi i32 [ 0, %423 ], [ %.5, %414 ], [ %.5, %408 ]
  %426 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %427 = load %struct.opendoor*, %struct.opendoor** %426, align 8
  %428 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %427, i32 0, i32 10
  %429 = load i32, i32* %428, align 8
  %430 = icmp eq i32 %429, 2
  br i1 %430, label %431, label %442

; <label>:431:                                    ; preds = %425
  %432 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %433 = bitcast %union.anon.4* %432 to %struct.anon.6*
  %434 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %433, i32 0, i32 4
  %435 = load i16, i16* %434, align 4
  %436 = lshr i16 %435, 10
  %437 = and i16 %436, 1
  %438 = zext i16 %437 to i32
  %439 = icmp eq i32 %438, 1
  br i1 %439, label %440, label %442

; <label>:440:                                    ; preds = %431
  %441 = getelementptr [33 x i8], [33 x i8]* @.str.151, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %441)
  br label %442

; <label>:442:                                    ; preds = %425, %431, %440, %402
  %.8 = phi i32 [ %.5, %402 ], [ 0, %440 ], [ %.6, %431 ], [ %.6, %425 ]
  %443 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %444 = load %struct.opendoor*, %struct.opendoor** %443, align 8
  %445 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %444, i32 0, i32 11
  %446 = load i32, i32* %445, align 4
  %447 = icmp ne i32 %446, 0
  br i1 %447, label %448, label %482

; <label>:448:                                    ; preds = %442
  %449 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %450 = load %struct.opendoor*, %struct.opendoor** %449, align 8
  %451 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %450, i32 0, i32 11
  %452 = load i32, i32* %451, align 4
  %453 = icmp eq i32 %452, 1
  br i1 %453, label %454, label %465

; <label>:454:                                    ; preds = %448
  %455 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %456 = bitcast %union.anon.4* %455 to %struct.anon.6*
  %457 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %456, i32 0, i32 4
  %458 = load i16, i16* %457, align 4
  %459 = lshr i16 %458, 11
  %460 = and i16 %459, 1
  %461 = zext i16 %460 to i32
  %462 = icmp ne i32 %461, 1
  br i1 %462, label %463, label %465

; <label>:463:                                    ; preds = %454
  %464 = getelementptr [32 x i8], [32 x i8]* @.str.152, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %464)
  br label %465

; <label>:465:                                    ; preds = %463, %454, %448
  %.9 = phi i32 [ 0, %463 ], [ %.8, %454 ], [ %.8, %448 ]
  %466 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %467 = load %struct.opendoor*, %struct.opendoor** %466, align 8
  %468 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %467, i32 0, i32 11
  %469 = load i32, i32* %468, align 4
  %470 = icmp eq i32 %469, 2
  br i1 %470, label %471, label %482

; <label>:471:                                    ; preds = %465
  %472 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %473 = bitcast %union.anon.4* %472 to %struct.anon.6*
  %474 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %473, i32 0, i32 4
  %475 = load i16, i16* %474, align 4
  %476 = lshr i16 %475, 11
  %477 = and i16 %476, 1
  %478 = zext i16 %477 to i32
  %479 = icmp eq i32 %478, 1
  br i1 %479, label %480, label %482

; <label>:480:                                    ; preds = %471
  %481 = getelementptr [33 x i8], [33 x i8]* @.str.153, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %481)
  br label %482

; <label>:482:                                    ; preds = %465, %471, %480, %442
  %.11 = phi i32 [ %.8, %442 ], [ 0, %480 ], [ %.9, %471 ], [ %.9, %465 ]
  %483 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %484 = load %struct.opendoor*, %struct.opendoor** %483, align 8
  %485 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %484, i32 0, i32 12
  %486 = load i32, i32* %485, align 8
  %487 = icmp ne i32 %486, 0
  br i1 %487, label %488, label %522

; <label>:488:                                    ; preds = %482
  %489 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %490 = load %struct.opendoor*, %struct.opendoor** %489, align 8
  %491 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %490, i32 0, i32 12
  %492 = load i32, i32* %491, align 8
  %493 = icmp eq i32 %492, 1
  br i1 %493, label %494, label %505

; <label>:494:                                    ; preds = %488
  %495 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %496 = bitcast %union.anon.4* %495 to %struct.anon.6*
  %497 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %496, i32 0, i32 4
  %498 = load i16, i16* %497, align 4
  %499 = lshr i16 %498, 12
  %500 = and i16 %499, 1
  %501 = zext i16 %500 to i32
  %502 = icmp ne i32 %501, 1
  br i1 %502, label %503, label %505

; <label>:503:                                    ; preds = %494
  %504 = getelementptr [32 x i8], [32 x i8]* @.str.154, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %504)
  br label %505

; <label>:505:                                    ; preds = %503, %494, %488
  %.12 = phi i32 [ 0, %503 ], [ %.11, %494 ], [ %.11, %488 ]
  %506 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %507 = load %struct.opendoor*, %struct.opendoor** %506, align 8
  %508 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %507, i32 0, i32 12
  %509 = load i32, i32* %508, align 8
  %510 = icmp eq i32 %509, 2
  br i1 %510, label %511, label %522

; <label>:511:                                    ; preds = %505
  %512 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %513 = bitcast %union.anon.4* %512 to %struct.anon.6*
  %514 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %513, i32 0, i32 4
  %515 = load i16, i16* %514, align 4
  %516 = lshr i16 %515, 12
  %517 = and i16 %516, 1
  %518 = zext i16 %517 to i32
  %519 = icmp eq i32 %518, 1
  br i1 %519, label %520, label %522

; <label>:520:                                    ; preds = %511
  %521 = getelementptr [33 x i8], [33 x i8]* @.str.155, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %521)
  br label %522

; <label>:522:                                    ; preds = %505, %511, %520, %482
  %.14 = phi i32 [ %.11, %482 ], [ 0, %520 ], [ %.12, %511 ], [ %.12, %505 ]
  %523 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %524 = load %struct.opendoor*, %struct.opendoor** %523, align 8
  %525 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %524, i32 0, i32 13
  %526 = load i32, i32* %525, align 4
  %527 = icmp ne i32 %526, 0
  br i1 %527, label %528, label %562

; <label>:528:                                    ; preds = %522
  %529 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %530 = load %struct.opendoor*, %struct.opendoor** %529, align 8
  %531 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %530, i32 0, i32 13
  %532 = load i32, i32* %531, align 4
  %533 = icmp eq i32 %532, 1
  br i1 %533, label %534, label %545

; <label>:534:                                    ; preds = %528
  %535 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %536 = bitcast %union.anon.4* %535 to %struct.anon.6*
  %537 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %536, i32 0, i32 4
  %538 = load i16, i16* %537, align 4
  %539 = lshr i16 %538, 13
  %540 = and i16 %539, 1
  %541 = zext i16 %540 to i32
  %542 = icmp ne i32 %541, 1
  br i1 %542, label %543, label %545

; <label>:543:                                    ; preds = %534
  %544 = getelementptr [32 x i8], [32 x i8]* @.str.156, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %544)
  br label %545

; <label>:545:                                    ; preds = %543, %534, %528
  %.15 = phi i32 [ 0, %543 ], [ %.14, %534 ], [ %.14, %528 ]
  %546 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %547 = load %struct.opendoor*, %struct.opendoor** %546, align 8
  %548 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %547, i32 0, i32 13
  %549 = load i32, i32* %548, align 4
  %550 = icmp eq i32 %549, 2
  br i1 %550, label %551, label %562

; <label>:551:                                    ; preds = %545
  %552 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %553 = bitcast %union.anon.4* %552 to %struct.anon.6*
  %554 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %553, i32 0, i32 4
  %555 = load i16, i16* %554, align 4
  %556 = lshr i16 %555, 13
  %557 = and i16 %556, 1
  %558 = zext i16 %557 to i32
  %559 = icmp eq i32 %558, 1
  br i1 %559, label %560, label %562

; <label>:560:                                    ; preds = %551
  %561 = getelementptr [33 x i8], [33 x i8]* @.str.157, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %561)
  br label %562

; <label>:562:                                    ; preds = %522, %560, %551, %545, %317
  %.18 = phi i32 [ 1, %317 ], [ %.14, %522 ], [ 0, %560 ], [ %.15, %551 ], [ %.15, %545 ]
  %cond = icmp eq i32 %.18, 0
  br i1 %cond, label %._crit_edge, label %563

; <label>:563:                                    ; preds = %562
  %564 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %565 = load i8, i8* %564, align 1
  %566 = zext i8 %565 to i32
  %567 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %568 = load %struct.opendoor*, %struct.opendoor** %567, align 8
  %569 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %568, i32 0, i32 3
  %570 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %571 = load i16, i16* %570, align 8
  %572 = sext i16 %571 to i64
  %573 = getelementptr inbounds [32 x i16], [32 x i16]* %569, i64 0, i64 %572
  %574 = load i16, i16* %573, align 2
  %575 = zext i16 %574 to i32
  %576 = icmp eq i32 %566, %575
  br i1 %576, label %577, label %821

; <label>:577:                                    ; preds = %563
  %578 = zext i16 %.118 to i32
  %579 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %580 = load %struct.opendoor*, %struct.opendoor** %579, align 8
  %581 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %580, i32 0, i32 2
  %582 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %583 = load i16, i16* %582, align 8
  %584 = sext i16 %583 to i64
  %585 = getelementptr inbounds [32 x i16], [32 x i16]* %581, i64 0, i64 %584
  %586 = load i16, i16* %585, align 2
  %587 = zext i16 %586 to i32
  %588 = icmp eq i32 %578, %587
  br i1 %588, label %589, label %821

; <label>:589:                                    ; preds = %577
  %590 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %591 = load i16, i16* %590, align 8
  %592 = add i16 %591, 1
  store i16 %592, i16* %590, align 8
  %593 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %594 = load i8*, i8** %593, align 8
  %595 = icmp ne i8* %594, null
  %596 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %597 = getelementptr inbounds [16 x i8], [16 x i8]* %596, i32 0, i32 0
  br i1 %595, label %598, label %621

; <label>:598:                                    ; preds = %589
  %599 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %600 = load i8*, i8** %599, align 8
  %601 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %602 = load %struct.opendoor*, %struct.opendoor** %601, align 8
  %603 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %602, i32 0, i32 0
  %604 = getelementptr inbounds [128 x i8], [128 x i8]* %603, i32 0, i32 0
  %605 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %606 = load i16, i16* %605, align 8
  %607 = sext i16 %606 to i32
  %608 = getelementptr [23 x i8], [23 x i8]* @.str.158, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %608, i8* %597, i8* %600, i8* %604, i32 %607)
  %609 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %610 = getelementptr inbounds [16 x i8], [16 x i8]* %609, i32 0, i32 0
  %611 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %612 = load i8*, i8** %611, align 8
  %613 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %614 = load %struct.opendoor*, %struct.opendoor** %613, align 8
  %615 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %614, i32 0, i32 0
  %616 = getelementptr inbounds [128 x i8], [128 x i8]* %615, i32 0, i32 0
  %617 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %618 = load i16, i16* %617, align 8
  %619 = sext i16 %618 to i32
  %620 = getelementptr [22 x i8], [22 x i8]* @.str.159, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %620, i8* %610, i8* %612, i8* %616, i32 %619)
  br label %640

; <label>:621:                                    ; preds = %589
  %622 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %623 = load %struct.opendoor*, %struct.opendoor** %622, align 8
  %624 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %623, i32 0, i32 0
  %625 = getelementptr inbounds [128 x i8], [128 x i8]* %624, i32 0, i32 0
  %626 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %627 = load i16, i16* %626, align 8
  %628 = sext i16 %627 to i32
  %629 = getelementptr [18 x i8], [18 x i8]* @.str.160, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %629, i8* %597, i8* %625, i32 %628)
  %630 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %631 = getelementptr inbounds [16 x i8], [16 x i8]* %630, i32 0, i32 0
  %632 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %633 = load %struct.opendoor*, %struct.opendoor** %632, align 8
  %634 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %633, i32 0, i32 0
  %635 = getelementptr inbounds [128 x i8], [128 x i8]* %634, i32 0, i32 0
  %636 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %637 = load i16, i16* %636, align 8
  %638 = sext i16 %637 to i32
  %639 = getelementptr [17 x i8], [17 x i8]* @.str.161, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %639, i8* %631, i8* %635, i32 %638)
  br label %640

; <label>:640:                                    ; preds = %621, %598
  %641 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %642 = load i16, i16* %641, align 8
  %643 = sext i16 %642 to i32
  %644 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %645 = load %struct.opendoor*, %struct.opendoor** %644, align 8
  %646 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %645, i32 0, i32 1
  %647 = load i16, i16* %646, align 8
  %648 = zext i16 %647 to i32
  %649 = icmp sge i32 %643, %648
  br i1 %649, label %650, label %._crit_edge

; <label>:650:                                    ; preds = %640
  %651 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %652 = load i8*, i8** %651, align 8
  %653 = icmp ne i8* %652, null
  %654 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %655 = getelementptr inbounds [16 x i8], [16 x i8]* %654, i32 0, i32 0
  br i1 %653, label %656, label %673

; <label>:656:                                    ; preds = %650
  %657 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %658 = load i8*, i8** %657, align 8
  %659 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %660 = load %struct.opendoor*, %struct.opendoor** %659, align 8
  %661 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %660, i32 0, i32 0
  %662 = getelementptr inbounds [128 x i8], [128 x i8]* %661, i32 0, i32 0
  %663 = getelementptr [26 x i8], [26 x i8]* @.str.162, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %663, i8* %655, i8* %658, i8* %662)
  %664 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %665 = getelementptr inbounds [16 x i8], [16 x i8]* %664, i32 0, i32 0
  %666 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %667 = load i8*, i8** %666, align 8
  %668 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %669 = load %struct.opendoor*, %struct.opendoor** %668, align 8
  %670 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %669, i32 0, i32 0
  %671 = getelementptr inbounds [128 x i8], [128 x i8]* %670, i32 0, i32 0
  %672 = getelementptr [25 x i8], [25 x i8]* @.str.163, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %672, i8* %665, i8* %667, i8* %671)
  br label %686

; <label>:673:                                    ; preds = %650
  %674 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %675 = load %struct.opendoor*, %struct.opendoor** %674, align 8
  %676 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %675, i32 0, i32 0
  %677 = getelementptr inbounds [128 x i8], [128 x i8]* %676, i32 0, i32 0
  %678 = getelementptr [21 x i8], [21 x i8]* @.str.164, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %678, i8* %655, i8* %677)
  %679 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %680 = getelementptr inbounds [16 x i8], [16 x i8]* %679, i32 0, i32 0
  %681 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %682 = load %struct.opendoor*, %struct.opendoor** %681, align 8
  %683 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %682, i32 0, i32 0
  %684 = getelementptr inbounds [128 x i8], [128 x i8]* %683, i32 0, i32 0
  %685 = getelementptr [20 x i8], [20 x i8]* @.str.165, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %685, i8* %680, i8* %684)
  br label %686

; <label>:686:                                    ; preds = %673, %656
  %687 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %688 = load %struct.opendoor*, %struct.opendoor** %687, align 8
  %689 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %688, i32 0, i32 5
  %690 = load i8*, i8** %689, align 8
  %691 = icmp ne i8* %690, null
  br i1 %691, label %692, label %801

; <label>:692:                                    ; preds = %686
  %693 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %694 = load %struct.opendoor*, %struct.opendoor** %693, align 8
  %695 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %694, i32 0, i32 5
  %696 = load i8*, i8** %695, align 8
  %697 = call i64 @strlen(i8* %696) #10
  %698 = icmp ne i64 %697, 0
  br i1 %698, label %699, label %801

; <label>:699:                                    ; preds = %692
  %700 = call i32 @fork() #7
  %701 = icmp eq i32 %700, 0
  br i1 %701, label %702, label %801

; <label>:702:                                    ; preds = %699
  %703 = call i32 @setsid() #7
  %704 = getelementptr inbounds [100 x i8], [100 x i8]* %11, i32 0, i32 0
  %705 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %706 = load %struct.opendoor*, %struct.opendoor** %705, align 8
  %707 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %706, i32 0, i32 5
  %708 = load i8*, i8** %707, align 8
  %709 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %710 = getelementptr inbounds [16 x i8], [16 x i8]* %709, i32 0, i32 0
  %711 = call i64 @parse_cmd(i8* %704, i64 100, i8* %708, i8* %710)
  %712 = icmp uge i64 %711, 100
  br i1 %712, label %713, label %718

; <label>:713:                                    ; preds = %702
  %714 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %715 = getelementptr [70 x i8], [70 x i8]* @.str.166, i32 0, i32 0
  %716 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %714, i8* %715)
  %717 = getelementptr [69 x i8], [69 x i8]* @.str.167, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %717)
  call void @exit(i32 0) #9
  unreachable

; <label>:718:                                    ; preds = %702
  %719 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %720 = load %struct.opendoor*, %struct.opendoor** %719, align 8
  %721 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %720, i32 0, i32 7
  %722 = load i8*, i8** %721, align 8
  %723 = icmp ne i8* %722, null
  br i1 %723, label %724, label %739

; <label>:724:                                    ; preds = %718
  %725 = getelementptr inbounds [100 x i8], [100 x i8]* %12, i32 0, i32 0
  %726 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %727 = load %struct.opendoor*, %struct.opendoor** %726, align 8
  %728 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %727, i32 0, i32 7
  %729 = load i8*, i8** %728, align 8
  %730 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %731 = getelementptr inbounds [16 x i8], [16 x i8]* %730, i32 0, i32 0
  %732 = call i64 @parse_cmd(i8* %725, i64 100, i8* %729, i8* %731)
  %733 = icmp uge i64 %732, 100
  br i1 %733, label %734, label %739

; <label>:734:                                    ; preds = %724
  %735 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %736 = getelementptr [80 x i8], [80 x i8]* @.str.168, i32 0, i32 0
  %737 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %735, i8* %736)
  %738 = getelementptr [79 x i8], [79 x i8]* @.str.169, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %738)
  call void @exit(i32 0) #9
  unreachable

; <label>:739:                                    ; preds = %724, %718
  %740 = getelementptr inbounds [100 x i8], [100 x i8]* %11, i32 0, i32 0
  %741 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %742 = load %struct.opendoor*, %struct.opendoor** %741, align 8
  %743 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %742, i32 0, i32 0
  %744 = getelementptr inbounds [128 x i8], [128 x i8]* %743, i32 0, i32 0
  %745 = call i32 @exec_cmd(i8* %740, i8* %744)
  %746 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %747 = load %struct.opendoor*, %struct.opendoor** %746, align 8
  %748 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %747, i32 0, i32 7
  %749 = load i8*, i8** %748, align 8
  %750 = icmp ne i8* %749, null
  br i1 %750, label %751, label %800

; <label>:751:                                    ; preds = %739
  %752 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %753 = load %struct.opendoor*, %struct.opendoor** %752, align 8
  %754 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %753, i32 0, i32 6
  %755 = load i64, i64* %754, align 8
  %756 = trunc i64 %755 to i32
  %757 = call i32 @sleep(i32 %756)
  %758 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %759 = load i8*, i8** %758, align 8
  %760 = icmp ne i8* %759, null
  %761 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %762 = getelementptr inbounds [16 x i8], [16 x i8]* %761, i32 0, i32 0
  br i1 %760, label %763, label %780

; <label>:763:                                    ; preds = %751
  %764 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %765 = load i8*, i8** %764, align 8
  %766 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %767 = load %struct.opendoor*, %struct.opendoor** %766, align 8
  %768 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %767, i32 0, i32 0
  %769 = getelementptr inbounds [128 x i8], [128 x i8]* %768, i32 0, i32 0
  %770 = getelementptr [30 x i8], [30 x i8]* @.str.170, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %770, i8* %762, i8* %765, i8* %769)
  %771 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %772 = getelementptr inbounds [16 x i8], [16 x i8]* %771, i32 0, i32 0
  %773 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %774 = load i8*, i8** %773, align 8
  %775 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %776 = load %struct.opendoor*, %struct.opendoor** %775, align 8
  %777 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %776, i32 0, i32 0
  %778 = getelementptr inbounds [128 x i8], [128 x i8]* %777, i32 0, i32 0
  %779 = getelementptr [29 x i8], [29 x i8]* @.str.171, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %779, i8* %772, i8* %774, i8* %778)
  br label %793

; <label>:780:                                    ; preds = %751
  %781 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %782 = load %struct.opendoor*, %struct.opendoor** %781, align 8
  %783 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %782, i32 0, i32 0
  %784 = getelementptr inbounds [128 x i8], [128 x i8]* %783, i32 0, i32 0
  %785 = getelementptr [25 x i8], [25 x i8]* @.str.172, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %785, i8* %762, i8* %784)
  %786 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %787 = getelementptr inbounds [16 x i8], [16 x i8]* %786, i32 0, i32 0
  %788 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %789 = load %struct.opendoor*, %struct.opendoor** %788, align 8
  %790 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %789, i32 0, i32 0
  %791 = getelementptr inbounds [128 x i8], [128 x i8]* %790, i32 0, i32 0
  %792 = getelementptr [24 x i8], [24 x i8]* @.str.173, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %792, i8* %787, i8* %791)
  br label %793

; <label>:793:                                    ; preds = %780, %763
  %794 = getelementptr inbounds [100 x i8], [100 x i8]* %12, i32 0, i32 0
  %795 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %796 = load %struct.opendoor*, %struct.opendoor** %795, align 8
  %797 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %796, i32 0, i32 0
  %798 = getelementptr inbounds [128 x i8], [128 x i8]* %797, i32 0, i32 0
  %799 = call i32 @exec_cmd(i8* %794, i8* %798)
  br label %800

; <label>:800:                                    ; preds = %793, %739
  call void @exit(i32 0) #9
  unreachable

; <label>:801:                                    ; preds = %699, %692, %686
  %802 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %803 = load %struct.opendoor*, %struct.opendoor** %802, align 8
  %804 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %803, i32 0, i32 14
  %805 = load %struct._IO_FILE*, %struct._IO_FILE** %804, align 8
  %806 = icmp ne %struct._IO_FILE* %805, null
  br i1 %806, label %807, label %._crit_edge

; <label>:807:                                    ; preds = %801
  %808 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %809 = load %struct.opendoor*, %struct.opendoor** %808, align 8
  %810 = call i32 @disable_used_one_time_sequence(%struct.opendoor* %809)
  %811 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %812 = load %struct.opendoor*, %struct.opendoor** %811, align 8
  %813 = call i32 @get_new_one_time_sequence(%struct.opendoor* %812)
  %814 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %815 = load %struct.opendoor*, %struct.opendoor** %814, align 8
  %816 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %815, i32 0, i32 15
  %817 = load i8*, i8** %816, align 8
  call void @free(i8* %817) #7
  %818 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %819 = load %struct.opendoor*, %struct.opendoor** %818, align 8
  %820 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %819, i32 0, i32 15
  store i8* null, i8** %820, align 8
  call void @generate_pcap_filter()
  br label %._crit_edge

; <label>:821:                                    ; preds = %577, %563
  %822 = icmp eq i32 %.18, 0
  br i1 %822, label %._crit_edge, label %823

; <label>:823:                                    ; preds = %821
  %824 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  store i16 -1, i16* %824, align 8
  br label %._crit_edge

; <label>:825:                                    ; preds = %.loopexit
  %826 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %827 = icmp ne %struct.__pmlist_t* %826, null
  br i1 %827, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %825
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %1117
  %.22224 = phi %struct.__pmlist_t* [ %1119, %1117 ], [ %826, %.lr.ph.preheader ]
  call void @unroll_loop(i32 16)
  %828 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.22224, i32 0, i32 0
  %829 = load i8*, i8** %828, align 8
  %830 = bitcast i8* %829 to %struct.opendoor*
  %831 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %832 = load i8, i8* %831, align 1
  %833 = zext i8 %832 to i32
  %834 = icmp eq i32 %833, 6
  br i1 %834, label %835, label %1039

; <label>:835:                                    ; preds = %.lr.ph
  %836 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 8
  %837 = load i32, i32* %836, align 8
  %838 = icmp ne i32 %837, 0
  br i1 %838, label %839, label %869

; <label>:839:                                    ; preds = %835
  %840 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 8
  %841 = load i32, i32* %840, align 8
  %842 = icmp eq i32 %841, 1
  br i1 %842, label %843, label %854

; <label>:843:                                    ; preds = %839
  %844 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %845 = bitcast %union.anon.4* %844 to %struct.anon.6*
  %846 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %845, i32 0, i32 4
  %847 = load i16, i16* %846, align 4
  %848 = lshr i16 %847, 8
  %849 = and i16 %848, 1
  %850 = zext i16 %849 to i32
  %851 = icmp ne i32 %850, 1
  br i1 %851, label %852, label %854

; <label>:852:                                    ; preds = %843
  %853 = getelementptr [32 x i8], [32 x i8]* @.str.146, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %853)
  br label %1117

; <label>:854:                                    ; preds = %843, %839
  %855 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 8
  %856 = load i32, i32* %855, align 8
  %857 = icmp eq i32 %856, 2
  br i1 %857, label %858, label %869

; <label>:858:                                    ; preds = %854
  %859 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %860 = bitcast %union.anon.4* %859 to %struct.anon.6*
  %861 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %860, i32 0, i32 4
  %862 = load i16, i16* %861, align 4
  %863 = lshr i16 %862, 8
  %864 = and i16 %863, 1
  %865 = zext i16 %864 to i32
  %866 = icmp eq i32 %865, 1
  br i1 %866, label %867, label %869

; <label>:867:                                    ; preds = %858
  %868 = getelementptr [33 x i8], [33 x i8]* @.str.147, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %868)
  br label %1117

; <label>:869:                                    ; preds = %854, %858, %835
  %870 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 9
  %871 = load i32, i32* %870, align 4
  %872 = icmp ne i32 %871, 0
  br i1 %872, label %873, label %903

; <label>:873:                                    ; preds = %869
  %874 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 9
  %875 = load i32, i32* %874, align 4
  %876 = icmp eq i32 %875, 1
  br i1 %876, label %877, label %888

; <label>:877:                                    ; preds = %873
  %878 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %879 = bitcast %union.anon.4* %878 to %struct.anon.6*
  %880 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %879, i32 0, i32 4
  %881 = load i16, i16* %880, align 4
  %882 = lshr i16 %881, 9
  %883 = and i16 %882, 1
  %884 = zext i16 %883 to i32
  %885 = icmp ne i32 %884, 1
  br i1 %885, label %886, label %888

; <label>:886:                                    ; preds = %877
  %887 = getelementptr [32 x i8], [32 x i8]* @.str.148, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %887)
  br label %1117

; <label>:888:                                    ; preds = %877, %873
  %889 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 9
  %890 = load i32, i32* %889, align 4
  %891 = icmp eq i32 %890, 2
  br i1 %891, label %892, label %903

; <label>:892:                                    ; preds = %888
  %893 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %894 = bitcast %union.anon.4* %893 to %struct.anon.6*
  %895 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %894, i32 0, i32 4
  %896 = load i16, i16* %895, align 4
  %897 = lshr i16 %896, 9
  %898 = and i16 %897, 1
  %899 = zext i16 %898 to i32
  %900 = icmp eq i32 %899, 1
  br i1 %900, label %901, label %903

; <label>:901:                                    ; preds = %892
  %902 = getelementptr [33 x i8], [33 x i8]* @.str.149, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %902)
  br label %1117

; <label>:903:                                    ; preds = %888, %892, %869
  %904 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 10
  %905 = load i32, i32* %904, align 8
  %906 = icmp ne i32 %905, 0
  br i1 %906, label %907, label %937

; <label>:907:                                    ; preds = %903
  %908 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 10
  %909 = load i32, i32* %908, align 8
  %910 = icmp eq i32 %909, 1
  br i1 %910, label %911, label %922

; <label>:911:                                    ; preds = %907
  %912 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %913 = bitcast %union.anon.4* %912 to %struct.anon.6*
  %914 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %913, i32 0, i32 4
  %915 = load i16, i16* %914, align 4
  %916 = lshr i16 %915, 10
  %917 = and i16 %916, 1
  %918 = zext i16 %917 to i32
  %919 = icmp ne i32 %918, 1
  br i1 %919, label %920, label %922

; <label>:920:                                    ; preds = %911
  %921 = getelementptr [32 x i8], [32 x i8]* @.str.150, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %921)
  br label %1117

; <label>:922:                                    ; preds = %911, %907
  %923 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 10
  %924 = load i32, i32* %923, align 8
  %925 = icmp eq i32 %924, 2
  br i1 %925, label %926, label %937

; <label>:926:                                    ; preds = %922
  %927 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %928 = bitcast %union.anon.4* %927 to %struct.anon.6*
  %929 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %928, i32 0, i32 4
  %930 = load i16, i16* %929, align 4
  %931 = lshr i16 %930, 10
  %932 = and i16 %931, 1
  %933 = zext i16 %932 to i32
  %934 = icmp eq i32 %933, 1
  br i1 %934, label %935, label %937

; <label>:935:                                    ; preds = %926
  %936 = getelementptr [33 x i8], [33 x i8]* @.str.151, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %936)
  br label %1117

; <label>:937:                                    ; preds = %922, %926, %903
  %938 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 11
  %939 = load i32, i32* %938, align 4
  %940 = icmp ne i32 %939, 0
  br i1 %940, label %941, label %971

; <label>:941:                                    ; preds = %937
  %942 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 11
  %943 = load i32, i32* %942, align 4
  %944 = icmp eq i32 %943, 1
  br i1 %944, label %945, label %956

; <label>:945:                                    ; preds = %941
  %946 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %947 = bitcast %union.anon.4* %946 to %struct.anon.6*
  %948 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %947, i32 0, i32 4
  %949 = load i16, i16* %948, align 4
  %950 = lshr i16 %949, 11
  %951 = and i16 %950, 1
  %952 = zext i16 %951 to i32
  %953 = icmp ne i32 %952, 1
  br i1 %953, label %954, label %956

; <label>:954:                                    ; preds = %945
  %955 = getelementptr [32 x i8], [32 x i8]* @.str.152, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %955)
  br label %1117

; <label>:956:                                    ; preds = %945, %941
  %957 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 11
  %958 = load i32, i32* %957, align 4
  %959 = icmp eq i32 %958, 2
  br i1 %959, label %960, label %971

; <label>:960:                                    ; preds = %956
  %961 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %962 = bitcast %union.anon.4* %961 to %struct.anon.6*
  %963 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %962, i32 0, i32 4
  %964 = load i16, i16* %963, align 4
  %965 = lshr i16 %964, 11
  %966 = and i16 %965, 1
  %967 = zext i16 %966 to i32
  %968 = icmp eq i32 %967, 1
  br i1 %968, label %969, label %971

; <label>:969:                                    ; preds = %960
  %970 = getelementptr [33 x i8], [33 x i8]* @.str.153, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %970)
  br label %1117

; <label>:971:                                    ; preds = %956, %960, %937
  %972 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 12
  %973 = load i32, i32* %972, align 8
  %974 = icmp ne i32 %973, 0
  br i1 %974, label %975, label %1005

; <label>:975:                                    ; preds = %971
  %976 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 12
  %977 = load i32, i32* %976, align 8
  %978 = icmp eq i32 %977, 1
  br i1 %978, label %979, label %990

; <label>:979:                                    ; preds = %975
  %980 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %981 = bitcast %union.anon.4* %980 to %struct.anon.6*
  %982 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %981, i32 0, i32 4
  %983 = load i16, i16* %982, align 4
  %984 = lshr i16 %983, 12
  %985 = and i16 %984, 1
  %986 = zext i16 %985 to i32
  %987 = icmp ne i32 %986, 1
  br i1 %987, label %988, label %990

; <label>:988:                                    ; preds = %979
  %989 = getelementptr [32 x i8], [32 x i8]* @.str.154, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %989)
  br label %1117

; <label>:990:                                    ; preds = %979, %975
  %991 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 12
  %992 = load i32, i32* %991, align 8
  %993 = icmp eq i32 %992, 2
  br i1 %993, label %994, label %1005

; <label>:994:                                    ; preds = %990
  %995 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %996 = bitcast %union.anon.4* %995 to %struct.anon.6*
  %997 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %996, i32 0, i32 4
  %998 = load i16, i16* %997, align 4
  %999 = lshr i16 %998, 12
  %1000 = and i16 %999, 1
  %1001 = zext i16 %1000 to i32
  %1002 = icmp eq i32 %1001, 1
  br i1 %1002, label %1003, label %1005

; <label>:1003:                                   ; preds = %994
  %1004 = getelementptr [33 x i8], [33 x i8]* @.str.155, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %1004)
  br label %1117

; <label>:1005:                                   ; preds = %990, %994, %971
  %1006 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 13
  %1007 = load i32, i32* %1006, align 4
  %1008 = icmp ne i32 %1007, 0
  br i1 %1008, label %1009, label %1039

; <label>:1009:                                   ; preds = %1005
  %1010 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 13
  %1011 = load i32, i32* %1010, align 4
  %1012 = icmp eq i32 %1011, 1
  br i1 %1012, label %1013, label %1024

; <label>:1013:                                   ; preds = %1009
  %1014 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %1015 = bitcast %union.anon.4* %1014 to %struct.anon.6*
  %1016 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %1015, i32 0, i32 4
  %1017 = load i16, i16* %1016, align 4
  %1018 = lshr i16 %1017, 13
  %1019 = and i16 %1018, 1
  %1020 = zext i16 %1019 to i32
  %1021 = icmp ne i32 %1020, 1
  br i1 %1021, label %1022, label %1024

; <label>:1022:                                   ; preds = %1013
  %1023 = getelementptr [32 x i8], [32 x i8]* @.str.156, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %1023)
  br label %1117

; <label>:1024:                                   ; preds = %1013, %1009
  %1025 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 13
  %1026 = load i32, i32* %1025, align 4
  %1027 = icmp eq i32 %1026, 2
  br i1 %1027, label %1028, label %1039

; <label>:1028:                                   ; preds = %1024
  %1029 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %1030 = bitcast %union.anon.4* %1029 to %struct.anon.6*
  %1031 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %1030, i32 0, i32 4
  %1032 = load i16, i16* %1031, align 4
  %1033 = lshr i16 %1032, 13
  %1034 = and i16 %1033, 1
  %1035 = zext i16 %1034 to i32
  %1036 = icmp eq i32 %1035, 1
  br i1 %1036, label %1037, label %1039

; <label>:1037:                                   ; preds = %1028
  %1038 = getelementptr [33 x i8], [33 x i8]* @.str.157, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %1038)
  br label %1117

; <label>:1039:                                   ; preds = %1005, %1028, %1024, %.lr.ph
  %1040 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %1041 = load i8, i8* %1040, align 1
  %1042 = zext i8 %1041 to i32
  %1043 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 3
  %1044 = getelementptr inbounds [32 x i16], [32 x i16]* %1043, i64 0, i64 0
  %1045 = load i16, i16* %1044, align 2
  %1046 = zext i16 %1045 to i32
  %1047 = icmp eq i32 %1042, %1046
  br i1 %1047, label %1048, label %1117

; <label>:1048:                                   ; preds = %1039
  %1049 = zext i16 %.118 to i32
  %1050 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 2
  %1051 = getelementptr inbounds [32 x i16], [32 x i16]* %1050, i64 0, i64 0
  %1052 = load i16, i16* %1051, align 2
  %1053 = zext i16 %1052 to i32
  %1054 = icmp eq i32 %1049, %1053
  br i1 %1054, label %1055, label %1117

; <label>:1055:                                   ; preds = %1048
  %1056 = call noalias i8* @malloc(i64 48) #7, !track !55
  %1057 = bitcast i8* %1056 to %struct.knocker*
  %1058 = getelementptr inbounds %struct.knocker, %struct.knocker* %1057, i32 0, i32 3
  store i8* null, i8** %1058, align 8
  %1059 = icmp eq %struct.knocker* %1057, null
  br i1 %1059, label %1060, label %1062

; <label>:1060:                                   ; preds = %1055
  %1061 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %1061)
  call void @exit(i32 1) #9
  unreachable

; <label>:1062:                                   ; preds = %1055
  %1063 = getelementptr inbounds %struct.knocker, %struct.knocker* %1057, i32 0, i32 2
  %1064 = getelementptr inbounds [16 x i8], [16 x i8]* %1063, i32 0, i32 0
  %1065 = getelementptr inbounds [16 x i8], [16 x i8]* %6, i32 0, i32 0
  %1066 = call i8* @strcpy(i8* %1064, i8* %1065) #7, !track !56
  %1067 = load i32, i32* @o_lookup, align 4
  %1068 = icmp ne i32 %1067, 0
  br i1 %1068, label %1069, label %1081

; <label>:1069:                                   ; preds = %1062
  %1070 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 8
  %1071 = load i32, i32* %1070, align 4
  %1072 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  store i32 %1071, i32* %1072, align 4
  %1073 = bitcast %struct.in_addr* %5 to i8*
  %1074 = call %struct.hostent* @gethostbyaddr(i8* %1073, i32 4, i32 2), !track !57
  %1075 = icmp ne %struct.hostent* %1074, null
  br i1 %1075, label %1076, label %1081

; <label>:1076:                                   ; preds = %1069
  %1077 = getelementptr inbounds %struct.hostent, %struct.hostent* %1074, i32 0, i32 0
  %1078 = load i8*, i8** %1077, align 8
  %1079 = call noalias i8* @strdup(i8* %1078) #7, !track !58
  %1080 = getelementptr inbounds %struct.knocker, %struct.knocker* %1057, i32 0, i32 3
  store i8* %1079, i8** %1080, align 8
  br label %1081

; <label>:1081:                                   ; preds = %1069, %1076, %1062
  %1082 = getelementptr inbounds %struct.knocker, %struct.knocker* %1057, i32 0, i32 1
  store i16 1, i16* %1082, align 8
  %1083 = load i64, i64* %8, align 8
  %1084 = getelementptr inbounds %struct.knocker, %struct.knocker* %1057, i32 0, i32 4
  store i64 %1083, i64* %1084, align 8
  %1085 = getelementptr inbounds %struct.knocker, %struct.knocker* %1057, i32 0, i32 0
  store %struct.opendoor* %830, %struct.opendoor** %1085, align 8
  %1086 = getelementptr inbounds %struct.knocker, %struct.knocker* %1057, i32 0, i32 3
  %1087 = load i8*, i8** %1086, align 8
  %1088 = icmp ne i8* %1087, null
  %1089 = getelementptr inbounds %struct.knocker, %struct.knocker* %1057, i32 0, i32 2
  %1090 = getelementptr inbounds [16 x i8], [16 x i8]* %1089, i32 0, i32 0
  br i1 %1088, label %1091, label %1104

; <label>:1091:                                   ; preds = %1081
  %1092 = getelementptr inbounds %struct.knocker, %struct.knocker* %1057, i32 0, i32 3
  %1093 = load i8*, i8** %1092, align 8
  %1094 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 0
  %1095 = getelementptr inbounds [128 x i8], [128 x i8]* %1094, i32 0, i32 0
  %1096 = getelementptr [22 x i8], [22 x i8]* @.str.174, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %1096, i8* %1090, i8* %1093, i8* %1095)
  %1097 = getelementptr inbounds %struct.knocker, %struct.knocker* %1057, i32 0, i32 2
  %1098 = getelementptr inbounds [16 x i8], [16 x i8]* %1097, i32 0, i32 0
  %1099 = getelementptr inbounds %struct.knocker, %struct.knocker* %1057, i32 0, i32 3
  %1100 = load i8*, i8** %1099, align 8
  %1101 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 0
  %1102 = getelementptr inbounds [128 x i8], [128 x i8]* %1101, i32 0, i32 0
  %1103 = getelementptr [21 x i8], [21 x i8]* @.str.175, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %1103, i8* %1098, i8* %1100, i8* %1102)
  br label %1113

; <label>:1104:                                   ; preds = %1081
  %1105 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 0
  %1106 = getelementptr inbounds [128 x i8], [128 x i8]* %1105, i32 0, i32 0
  %1107 = getelementptr [17 x i8], [17 x i8]* @.str.176, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %1107, i8* %1090, i8* %1106)
  %1108 = getelementptr inbounds %struct.knocker, %struct.knocker* %1057, i32 0, i32 2
  %1109 = getelementptr inbounds [16 x i8], [16 x i8]* %1108, i32 0, i32 0
  %1110 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %830, i32 0, i32 0
  %1111 = getelementptr inbounds [128 x i8], [128 x i8]* %1110, i32 0, i32 0
  %1112 = getelementptr [16 x i8], [16 x i8]* @.str.177, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %1112, i8* %1109, i8* %1111)
  br label %1113

; <label>:1113:                                   ; preds = %1104, %1091
  %1114 = load %struct.__pmlist_t*, %struct.__pmlist_t** @attempts, align 8
  %1115 = bitcast %struct.knocker* %1057 to i8*
  %1116 = call %struct.__pmlist_t* @list_add(%struct.__pmlist_t* %1114, i8* %1115)
  store %struct.__pmlist_t* %1116, %struct.__pmlist_t** @attempts, align 8
  br label %1117

; <label>:1117:                                   ; preds = %1039, %1048, %1113, %1037, %1022, %1003, %988, %969, %954, %935, %920, %901, %886, %867, %852
  %1118 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.22224, i32 0, i32 2
  %1119 = load %struct.__pmlist_t*, %struct.__pmlist_t** %1118, align 8
  %1120 = icmp ne %struct.__pmlist_t* %1119, null
  br i1 %1120, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %1117
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %562, %825, %801, %807, %640, %821, %823, %46, %18, %44, %55, %66
  ret void
}

declare dso_local i32 @pcap_dispatch(%struct.pcap*, i32, void (i8*, %struct.pcap_pkthdr*, i8*)*, i8*) #5

declare dso_local void @pcap_perror(%struct.pcap*, i8*) #5

; Function Attrs: nounwind readnone
declare dso_local zeroext i16 @ntohs(i16 zeroext) #6

; Function Attrs: nounwind
declare dso_local i32 @inet_aton(i8*, %struct.in_addr*) #2

; Function Attrs: nounwind
declare dso_local %struct.tm* @localtime(i64*) #2

; Function Attrs: nounwind
declare dso_local i32 @snprintf(i8*, i64, i8*, ...) #2

; Function Attrs: nounwind
declare dso_local i8* @inet_ntoa(i32) #2

; Function Attrs: nounwind
declare dso_local void @free(i8*) #2

; Function Attrs: nounwind readonly
declare dso_local i32 @strncmp(i8*, i8*, i64) #4

; Function Attrs: nounwind
declare dso_local i32 @fork() #2

; Function Attrs: nounwind
declare dso_local i32 @setsid() #2

; Function Attrs: noinline nounwind uwtable
define dso_local i64 @parse_cmd(i8*, i64, i8*, i8*) #0 {
  %5 = call i64 @strlen(i8* %2) #10
  %6 = icmp eq i64 %1, 0
  %spec.select = select i1 %6, i64 1, i64 %1
  %spec.select1 = select i1 %6, i32 0, i32 1
  %7 = getelementptr [5 x i8], [5 x i8]* @.str.128, i32 0, i32 0
  %8 = call i8* @strstr(i8* %2, i8* %7) #10, !track !59
  %9 = icmp ne i8* %8, null
  %10 = getelementptr inbounds i8, i8* %2, i64 %5
  %11 = getelementptr inbounds i8, i8* %10, i64 1
  %.05 = select i1 %9, i8* %8, i8* %11
  %12 = load i8, i8* %2, align 1
  %13 = sext i8 %12 to i32
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %.lr.ph32.preheader, label %._crit_edge33

.lr.ph32.preheader:                               ; preds = %4
  br label %.lr.ph32

.lr.ph32:                                         ; preds = %.lr.ph32.preheader, %45
  %.0130 = phi i64 [ %47, %45 ], [ 0, %.lr.ph32.preheader ]
  %.1329 = phi i64 [ %.5, %45 ], [ %spec.select, %.lr.ph32.preheader ]
  %.1628 = phi i8* [ %.38, %45 ], [ %.05, %.lr.ph32.preheader ]
  %.0927 = phi i8* [ %.413, %45 ], [ %0, %.lr.ph32.preheader ]
  %.01426 = phi i8* [ %46, %45 ], [ %2, %.lr.ph32.preheader ]
  %.01625 = phi i8* [ %.218, %45 ], [ %3, %.lr.ph32.preheader ]
  call void @unroll_loop(i32 11)
  %15 = icmp ult i8* %.01426, %.1628
  br i1 %15, label %16, label %22

; <label>:16:                                     ; preds = %.lr.ph32
  %17 = icmp ne i64 %.1329, 1
  br i1 %17, label %18, label %45

; <label>:18:                                     ; preds = %16
  %19 = load i8, i8* %.01426, align 1
  %20 = getelementptr inbounds i8, i8* %.0927, i32 1
  store i8 %19, i8* %.0927, align 1
  %21 = add i64 %.1329, -1
  br label %45

; <label>:22:                                     ; preds = %.lr.ph32
  %23 = load i8, i8* %.01625, align 1
  %24 = sext i8 %23 to i32
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %22
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %31
  %.122 = phi i64 [ %33, %31 ], [ %.0130, %.lr.ph.preheader ]
  %.321 = phi i64 [ %.4, %31 ], [ %.1329, %.lr.ph.preheader ]
  %.21120 = phi i8* [ %.312, %31 ], [ %.0927, %.lr.ph.preheader ]
  %.11719 = phi i8* [ %32, %31 ], [ %.01625, %.lr.ph.preheader ]
  call void @unroll_loop(i32 12)
  %26 = icmp ne i64 %.321, 1
  br i1 %26, label %27, label %31

; <label>:27:                                     ; preds = %.lr.ph
  %28 = load i8, i8* %.11719, align 1
  %29 = getelementptr inbounds i8, i8* %.21120, i32 1
  store i8 %28, i8* %.21120, align 1
  %30 = add i64 %.321, -1
  br label %31

; <label>:31:                                     ; preds = %27, %.lr.ph
  %.312 = phi i8* [ %29, %27 ], [ %.21120, %.lr.ph ]
  %.4 = phi i64 [ %30, %27 ], [ %.321, %.lr.ph ]
  %32 = getelementptr inbounds i8, i8* %.11719, i32 1
  %33 = add i64 %.122, 1
  %34 = load i8, i8* %32, align 1
  %35 = sext i8 %34 to i32
  %36 = icmp ne i32 %35, 0
  br i1 %36, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %31
  %.211.lcssa.ph = phi i8* [ %.312, %31 ]
  %.3.lcssa.ph = phi i64 [ %.4, %31 ]
  %.1.lcssa.ph = phi i64 [ %33, %31 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %22
  %.211.lcssa = phi i8* [ %.0927, %22 ], [ %.211.lcssa.ph, %._crit_edge.loopexit ]
  %.3.lcssa = phi i64 [ %.1329, %22 ], [ %.3.lcssa.ph, %._crit_edge.loopexit ]
  %.1.lcssa = phi i64 [ %.0130, %22 ], [ %.1.lcssa.ph, %._crit_edge.loopexit ]
  %37 = getelementptr inbounds i8, i8* %.01426, i64 4
  %38 = getelementptr [5 x i8], [5 x i8]* @.str.128, i32 0, i32 0
  %39 = call i8* @strstr(i8* %37, i8* %38) #10, !track !60
  %40 = icmp ne i8* %39, null
  %41 = getelementptr inbounds i8, i8* %37, i64 %5
  %42 = getelementptr inbounds i8, i8* %41, i64 1
  %.27 = select i1 %40, i8* %39, i8* %42
  %43 = getelementptr inbounds i8, i8* %37, i32 -1
  %44 = add i64 %.1.lcssa, -1
  br label %45

; <label>:45:                                     ; preds = %16, %18, %._crit_edge
  %.218 = phi i8* [ %3, %._crit_edge ], [ %.01625, %18 ], [ %.01625, %16 ]
  %.115 = phi i8* [ %43, %._crit_edge ], [ %.01426, %18 ], [ %.01426, %16 ]
  %.413 = phi i8* [ %.211.lcssa, %._crit_edge ], [ %20, %18 ], [ %.0927, %16 ]
  %.38 = phi i8* [ %.27, %._crit_edge ], [ %.1628, %18 ], [ %.1628, %16 ]
  %.5 = phi i64 [ %.3.lcssa, %._crit_edge ], [ %21, %18 ], [ %.1329, %16 ]
  %.2 = phi i64 [ %44, %._crit_edge ], [ %.0130, %18 ], [ %.0130, %16 ]
  %46 = getelementptr inbounds i8, i8* %.115, i32 1
  %47 = add i64 %.2, 1
  %48 = load i8, i8* %46, align 1
  %49 = sext i8 %48 to i32
  %50 = icmp ne i32 %49, 0
  br i1 %50, label %.lr.ph32, label %._crit_edge33.loopexit

._crit_edge33.loopexit:                           ; preds = %45
  %.09.lcssa.ph = phi i8* [ %.413, %45 ]
  %.01.lcssa.ph = phi i64 [ %47, %45 ]
  br label %._crit_edge33

._crit_edge33:                                    ; preds = %._crit_edge33.loopexit, %4
  %.09.lcssa = phi i8* [ %0, %4 ], [ %.09.lcssa.ph, %._crit_edge33.loopexit ]
  %.01.lcssa = phi i64 [ 0, %4 ], [ %.01.lcssa.ph, %._crit_edge33.loopexit ]
  %51 = icmp ne i32 %spec.select1, 0
  br i1 %51, label %52, label %53

; <label>:52:                                     ; preds = %._crit_edge33
  store i8 0, i8* %.09.lcssa, align 1
  br label %53

; <label>:53:                                     ; preds = %52, %._crit_edge33
  ret i64 %.01.lcssa
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @exec_cmd(i8*, i8*) #0 {
  %3 = alloca %struct.in_addr, align 4
  %4 = alloca %struct.in_addr, align 4
  %5 = getelementptr [25 x i8], [25 x i8]* @.str.129, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %5, i8* %1, i8* %0)
  %6 = getelementptr [25 x i8], [25 x i8]* @.str.129, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %6, i8* %1, i8* %0)
  %7 = call i32 @system(i8* %0)
  switch i32 %7, label %13 [
    i32 -1, label %8
    i32 0, label %28
  ]

; <label>:8:                                      ; preds = %2
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %10 = getelementptr [29 x i8], [29 x i8]* @.str.130, i32 0, i32 0
  %11 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %9, i8* %10)
  %12 = getelementptr [28 x i8], [28 x i8]* @.str.131, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %12)
  br label %28

; <label>:13:                                     ; preds = %2
  %14 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %15 = bitcast %struct.in_addr* %3 to i32*
  store i32 %7, i32* %15, align 4
  %16 = bitcast %struct.in_addr* %3 to i32*
  %17 = load i32, i32* %16, align 4
  %18 = and i32 %17, 65280
  %19 = ashr i32 %18, 8
  %20 = getelementptr [48 x i8], [48 x i8]* @.str.132, i32 0, i32 0
  %21 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %14, i8* %20, i8* %1, i32 %19)
  %22 = bitcast %struct.in_addr* %4 to i32*
  store i32 %7, i32* %22, align 4
  %23 = bitcast %struct.in_addr* %4 to i32*
  %24 = load i32, i32* %23, align 4
  %25 = and i32 %24, 65280
  %26 = ashr i32 %25, 8
  %27 = getelementptr [47 x i8], [47 x i8]* @.str.133, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %27, i8* %1, i32 %26)
  br label %28

; <label>:28:                                     ; preds = %13, %2, %8
  ret i32 %7
}

declare dso_local i32 @sleep(i32) #5

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @disable_used_one_time_sequence(%struct.opendoor*) #0 {
  %2 = call i64 @get_current_one_time_sequence_position(%struct.opendoor* %0)
  %3 = icmp sge i64 %2, 0
  br i1 %3, label %4, label %32

; <label>:4:                                      ; preds = %1
  %5 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** %5, align 8
  %7 = call i32 @fseek(%struct._IO_FILE* %6, i64 %2, i32 0)
  %8 = icmp slt i32 %7, 0
  br i1 %8, label %9, label %18

; <label>:9:                                      ; preds = %4
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %11 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 0
  %12 = getelementptr inbounds [128 x i8], [128 x i8]* %11, i32 0, i32 0
  %13 = getelementptr [81 x i8], [81 x i8]* @.str.111, i32 0, i32 0
  %14 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %10, i8* %13, i8* %12)
  %15 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 0
  %16 = getelementptr inbounds [128 x i8], [128 x i8]* %15, i32 0, i32 0
  %17 = getelementptr [81 x i8], [81 x i8]* @.str.111, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %17, i8* %16)
  call void @close_door(%struct.opendoor* %0)
  br label %32

; <label>:18:                                     ; preds = %4
  %19 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %20 = load %struct._IO_FILE*, %struct._IO_FILE** %19, align 8
  %21 = call i32 @fputc(i32 35, %struct._IO_FILE* %20)
  %22 = icmp eq i32 %21, -1
  br i1 %22, label %23, label %32

; <label>:23:                                     ; preds = %18
  %24 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %25 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 0
  %26 = getelementptr inbounds [128 x i8], [128 x i8]* %25, i32 0, i32 0
  %27 = getelementptr [81 x i8], [81 x i8]* @.str.111, i32 0, i32 0
  %28 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %24, i8* %27, i8* %26)
  %29 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 0
  %30 = getelementptr inbounds [128 x i8], [128 x i8]* %29, i32 0, i32 0
  %31 = getelementptr [81 x i8], [81 x i8]* @.str.111, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %31, i8* %30)
  call void @close_door(%struct.opendoor* %0)
  br label %32

; <label>:32:                                     ; preds = %1, %18, %23, %9
  %.0 = phi i32 [ 1, %9 ], [ 1, %23 ], [ 0, %18 ], [ 0, %1 ]
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @get_new_one_time_sequence(%struct.opendoor*) #0 {
  %2 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %3 = load %struct._IO_FILE*, %struct._IO_FILE** %2, align 8
  call void @rewind(%struct._IO_FILE* %3)
  %4 = call i64 @get_next_one_time_sequence(%struct.opendoor* %0)
  %5 = icmp slt i64 %4, 0
  br i1 %5, label %6, label %15

; <label>:6:                                      ; preds = %1
  %7 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %8 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 0
  %9 = getelementptr inbounds [128 x i8], [128 x i8]* %8, i32 0, i32 0
  %10 = getelementptr [90 x i8], [90 x i8]* @.str.109, i32 0, i32 0
  %11 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %7, i8* %10, i8* %9)
  %12 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 0
  %13 = getelementptr inbounds [128 x i8], [128 x i8]* %12, i32 0, i32 0
  %14 = getelementptr [90 x i8], [90 x i8]* @.str.109, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %14, i8* %13)
  call void @close_door(%struct.opendoor* %0)
  br label %19

; <label>:15:                                     ; preds = %1
  %16 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 0
  %17 = getelementptr inbounds [128 x i8], [128 x i8]* %16, i32 0, i32 0
  %18 = getelementptr [27 x i8], [27 x i8]* @.str.110, i32 0, i32 0
  call void (%struct.opendoor*, i8*, ...) @dprint_sequence(%struct.opendoor* %0, i8* %18, i8* %17)
  br label %19

; <label>:19:                                     ; preds = %15, %6
  %.0 = phi i32 [ 1, %6 ], [ 0, %15 ]
  ret i32 %.0
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare dso_local i8* @strcpy(i8*, i8*) #2

declare dso_local %struct.hostent* @gethostbyaddr(i8*, i32, i32) #5

; Function Attrs: nounwind
declare dso_local noalias i8* @strdup(i8*) #2

declare dso_local void @rewind(%struct._IO_FILE*) #5

; Function Attrs: noinline nounwind uwtable
define dso_local i64 @get_next_one_time_sequence(%struct.opendoor*) #0 {
  %2 = alloca [101 x i8], align 16, !track !61
  %3 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %4 = load %struct._IO_FILE*, %struct._IO_FILE** %3, align 8
  %5 = call i64 @ftell(%struct._IO_FILE* %4)
  %6 = trunc i64 %5 to i32
  %7 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %8 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** %8, align 8
  %10 = call i8* @fgets(i8* %7, i32 100, %struct._IO_FILE* %9), !track !62
  %11 = icmp ne i8* %10, null
  br i1 %11, label %.lr.ph.preheader, label %.outer._crit_edge

.lr.ph.preheader:                                 ; preds = %1
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.01.ph3 = phi i32 [ %30, %.outer ], [ %6, %.lr.ph.preheader ]
  call void @unroll_loop(i32 13)
  br label %16

; <label>:12:                                     ; preds = %34
  %13 = load %struct._IO_FILE*, %struct._IO_FILE** %8, align 8
  %14 = call i8* @fgets(i8* %7, i32 100, %struct._IO_FILE* %13), !track !63
  %15 = icmp ne i8* %14, null
  br i1 %15, label %16, label %.outer._crit_edge.loopexit

; <label>:16:                                     ; preds = %.lr.ph, %12
  call void @unroll_loop(i32 17)
  %17 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %18 = call i8* @trim(i8* %17)
  %19 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %20 = call i64 @strlen(i8* %19) #10
  %21 = icmp eq i64 %20, 0
  br i1 %21, label %.outer, label %22

; <label>:22:                                     ; preds = %16
  %23 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  %24 = load i8, i8* %23, align 16
  %25 = sext i8 %24 to i32
  %26 = icmp eq i32 %25, 35
  br i1 %26, label %.outer, label %34

.outer:                                           ; preds = %22, %16
  %27 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %28 = load %struct._IO_FILE*, %struct._IO_FILE** %27, align 8
  %29 = call i64 @ftell(%struct._IO_FILE* %28)
  %30 = trunc i64 %29 to i32
  %31 = load %struct._IO_FILE*, %struct._IO_FILE** %8, align 8
  %32 = call i8* @fgets(i8* %7, i32 100, %struct._IO_FILE* %31), !track !64
  %33 = icmp ne i8* %32, null
  br i1 %33, label %.lr.ph, label %.outer._crit_edge.loopexit1

; <label>:34:                                     ; preds = %22
  %35 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %36 = call i32 @parse_port_sequence(i8* %35, %struct.opendoor* %0)
  %37 = icmp sgt i32 %36, 0
  br i1 %37, label %12, label %38

; <label>:38:                                     ; preds = %34
  %.01.lcssa2 = phi i32 [ %.01.ph3, %34 ]
  %39 = sext i32 %.01.lcssa2 to i64
  br label %.outer._crit_edge

.outer._crit_edge.loopexit:                       ; preds = %12
  %.0.ph = phi i64 [ -1, %12 ]
  br label %.outer._crit_edge

.outer._crit_edge.loopexit1:                      ; preds = %.outer
  %.0.ph2 = phi i64 [ -1, %.outer ]
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit1, %.outer._crit_edge.loopexit, %1, %38
  %.0 = phi i64 [ %39, %38 ], [ -1, %1 ], [ %.0.ph, %.outer._crit_edge.loopexit ], [ %.0.ph2, %.outer._crit_edge.loopexit1 ]
  ret i64 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @close_door(%struct.opendoor*) #0 {
  %2 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %3 = bitcast %struct.opendoor* %0 to i8*
  %4 = call %struct.__pmlist_t* @list_remove(%struct.__pmlist_t* %2, i8* %3)
  store %struct.__pmlist_t* %4, %struct.__pmlist_t** @doors, align 8
  %5 = icmp ne %struct.opendoor* %0, null
  br i1 %5, label %6, label %37

; <label>:6:                                      ; preds = %1
  %7 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 5
  %8 = load i8*, i8** %7, align 8
  %9 = icmp ne i8* %8, null
  br i1 %9, label %10, label %13

; <label>:10:                                     ; preds = %6
  %11 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 5
  %12 = load i8*, i8** %11, align 8
  call void @free(i8* %12) #7
  br label %13

; <label>:13:                                     ; preds = %10, %6
  %14 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 7
  %15 = load i8*, i8** %14, align 8
  %16 = icmp ne i8* %15, null
  br i1 %16, label %17, label %20

; <label>:17:                                     ; preds = %13
  %18 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 7
  %19 = load i8*, i8** %18, align 8
  call void @free(i8* %19) #7
  br label %20

; <label>:20:                                     ; preds = %17, %13
  %21 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %22 = load %struct._IO_FILE*, %struct._IO_FILE** %21, align 8
  %23 = icmp ne %struct._IO_FILE* %22, null
  br i1 %23, label %24, label %28

; <label>:24:                                     ; preds = %20
  %25 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %26 = load %struct._IO_FILE*, %struct._IO_FILE** %25, align 8
  %27 = call i32 @fclose(%struct._IO_FILE* %26)
  br label %28

; <label>:28:                                     ; preds = %24, %20
  %29 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 15
  %30 = load i8*, i8** %29, align 8
  %31 = icmp ne i8* %30, null
  br i1 %31, label %32, label %35

; <label>:32:                                     ; preds = %28
  %33 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 15
  %34 = load i8*, i8** %33, align 8
  call void @free(i8* %34) #7
  br label %35

; <label>:35:                                     ; preds = %32, %28
  %36 = bitcast %struct.opendoor* %0 to i8*
  call void @free(i8* %36) #7
  br label %37

; <label>:37:                                     ; preds = %35, %1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @dprint_sequence(%struct.opendoor*, i8*, ...) #0 {
  %3 = alloca [1 x %struct.__va_list_tag], align 16
  %4 = load i32, i32* @o_debug, align 4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %6, label %53

; <label>:6:                                      ; preds = %2
  %7 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %3, i32 0, i32 0
  %8 = bitcast %struct.__va_list_tag* %7 to i8*
  call void @llvm.va_start(i8* %8)
  %9 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %3, i32 0, i32 0
  %10 = call i32 @vprintf(i8* %1, %struct.__va_list_tag* %9)
  %11 = getelementptr inbounds [1 x %struct.__va_list_tag], [1 x %struct.__va_list_tag]* %3, i32 0, i32 0
  %12 = bitcast %struct.__va_list_tag* %11 to i8*
  call void @llvm.va_end(i8* %12)
  %13 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  %14 = load i16, i16* %13, align 8
  %15 = zext i16 %14 to i32
  %16 = icmp slt i32 0, %15
  br i1 %16, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %6
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %46
  %indvars.iv = phi i64 [ %indvars.iv.next, %46 ], [ 0, %.lr.ph.preheader ]
  call void @unroll_loop(i32 18)
  %17 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 3
  %18 = getelementptr inbounds [32 x i16], [32 x i16]* %17, i64 0, i64 %indvars.iv
  %19 = load i16, i16* %18, align 2
  %20 = zext i16 %19 to i32
  %cond = icmp eq i32 %20, 17
  %21 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  %22 = load i16, i16* %21, align 8
  %23 = zext i16 %22 to i32
  %24 = sub nsw i32 %23, 1
  %25 = zext i32 %24 to i64
  %26 = icmp eq i64 %indvars.iv, %25
  %27 = zext i1 %26 to i64
  br i1 %cond, label %28, label %37

; <label>:28:                                     ; preds = %.lr.ph
  %29 = getelementptr [8 x i8], [8 x i8]* @.str.30, i32 0, i32 0
  %30 = getelementptr [8 x i8], [8 x i8]* @.str.31, i32 0, i32 0
  %31 = select i1 %26, i8* %29, i8* %30
  %32 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 2
  %33 = getelementptr inbounds [32 x i16], [32 x i16]* %32, i64 0, i64 %indvars.iv
  %34 = load i16, i16* %33, align 2
  %35 = zext i16 %34 to i32
  %36 = call i32 (i8*, ...) @printf(i8* %31, i32 %35)
  br label %46

; <label>:37:                                     ; preds = %.lr.ph
  %38 = getelementptr [8 x i8], [8 x i8]* @.str.32, i32 0, i32 0
  %39 = getelementptr [8 x i8], [8 x i8]* @.str.33, i32 0, i32 0
  %40 = select i1 %26, i8* %38, i8* %39
  %41 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 2
  %42 = getelementptr inbounds [32 x i16], [32 x i16]* %41, i64 0, i64 %indvars.iv
  %43 = load i16, i16* %42, align 2
  %44 = zext i16 %43 to i32
  %45 = call i32 (i8*, ...) @printf(i8* %40, i32 %44)
  br label %46

; <label>:46:                                     ; preds = %28, %37
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %47 = load i16, i16* %13, align 8
  %48 = zext i16 %47 to i32
  %49 = zext i32 %48 to i64
  %50 = icmp ult i64 %indvars.iv.next, %49
  br i1 %50, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %46
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %6
  %51 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %52 = call i32 @fflush(%struct._IO_FILE* %51)
  br label %53

; <label>:53:                                     ; preds = %._crit_edge, %2
  ret void
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #7

declare dso_local i32 @vprintf(i8*, %struct.__va_list_tag*) #5

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #7

declare dso_local i32 @printf(i8*, ...) #5

declare dso_local i32 @fflush(%struct._IO_FILE*) #5

declare dso_local i64 @ftell(%struct._IO_FILE*) #5

declare dso_local i8* @fgets(i8*, i32, %struct._IO_FILE*) #5

; Function Attrs: noinline nounwind uwtable
define dso_local i8* @trim(i8*) #0 {
  br label %2

; <label>:2:                                      ; preds = %2, %1
  %.0 = phi i8* [ %0, %1 ], [ %13, %2 ]
  call void @unroll_loop(i32 19)
  %3 = call i16** @__ctype_b_loc() #11
  %4 = load i16*, i16** %3, align 8
  %5 = load i8, i8* %.0, align 1
  %6 = sext i8 %5 to i32
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds i16, i16* %4, i64 %7
  %9 = load i16, i16* %8, align 2
  %10 = zext i16 %9 to i32
  %11 = and i32 %10, 8192
  %12 = icmp ne i32 %11, 0
  %13 = getelementptr inbounds i8, i8* %.0, i32 1
  br i1 %12, label %2, label %14

; <label>:14:                                     ; preds = %2
  %.0.lcssa = phi i8* [ %.0, %2 ]
  %15 = icmp ne i8* %.0.lcssa, %0
  br i1 %15, label %16, label %19

; <label>:16:                                     ; preds = %14
  %17 = call i64 @strlen(i8* %.0.lcssa) #10
  %18 = add i64 %17, 1
  call void @llvm.memmove.p0i8.p0i8.i64(i8* align 1 %0, i8* align 1 %.0.lcssa, i64 %18, i1 false), !track !65
  br label %19

; <label>:19:                                     ; preds = %16, %14
  %20 = call i64 @strlen(i8* %0) #10
  %21 = sub i64 %20, 1
  %22 = getelementptr inbounds i8, i8* %0, i64 %21
  br label %23

; <label>:23:                                     ; preds = %23, %19
  %.1 = phi i8* [ %22, %19 ], [ %34, %23 ]
  call void @unroll_loop(i32 20)
  %24 = call i16** @__ctype_b_loc() #11
  %25 = load i16*, i16** %24, align 8
  %26 = load i8, i8* %.1, align 1
  %27 = sext i8 %26 to i32
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds i16, i16* %25, i64 %28
  %30 = load i16, i16* %29, align 2
  %31 = zext i16 %30 to i32
  %32 = and i32 %31, 8192
  %33 = icmp ne i32 %32, 0
  %34 = getelementptr inbounds i8, i8* %.1, i32 -1
  br i1 %33, label %23, label %35

; <label>:35:                                     ; preds = %23
  %.1.lcssa = phi i8* [ %.1, %23 ]
  %36 = getelementptr inbounds i8, i8* %.1.lcssa, i32 1
  store i8 0, i8* %36, align 1
  ret i8* %0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @parse_port_sequence(i8*, %struct.opendoor*) #0 {
  %3 = alloca i8*, align 8, !track !66
  %4 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  %5 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  store i16 0, i16* %5, align 8
  %6 = getelementptr [2 x i8], [2 x i8]* @.str.86, i32 0, i32 0
  %7 = call i8* @strsep(i8** %3, i8* %6) #7
  store i8* %7, i8** %4, align 8
  %8 = icmp ne i8* %7, null
  br i1 %8, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %79
  call void @unroll_loop(i32 21)
  %9 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %10 = load i16, i16* %9, align 8
  %11 = zext i16 %10 to i32
  %12 = icmp sge i32 %11, 32
  br i1 %12, label %13, label %22

; <label>:13:                                     ; preds = %.lr.ph
  %14 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %15 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 0
  %16 = getelementptr inbounds [128 x i8], [128 x i8]* %15, i32 0, i32 0
  %17 = getelementptr [54 x i8], [54 x i8]* @.str.102, i32 0, i32 0
  %18 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %14, i8* %17, i8* %16)
  %19 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 0
  %20 = getelementptr inbounds [128 x i8], [128 x i8]* %19, i32 0, i32 0
  %21 = getelementptr [53 x i8], [53 x i8]* @.str.103, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %21, i8* %20)
  br label %._crit_edge

; <label>:22:                                     ; preds = %.lr.ph
  %23 = getelementptr [2 x i8], [2 x i8]* @.str.104, i32 0, i32 0
  %24 = call i8* @strsep(i8** %4, i8* %23) #7
  %25 = call i32 @atoi(i8* %24) #10
  %26 = trunc i32 %25 to i16
  %27 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 2
  %28 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %29 = load i16, i16* %28, align 8
  %30 = add i16 %29, 1
  store i16 %30, i16* %28, align 8
  %31 = zext i16 %29 to i64
  %32 = getelementptr inbounds [32 x i16], [32 x i16]* %27, i64 0, i64 %31
  store i16 %26, i16* %32, align 2
  %33 = getelementptr [2 x i8], [2 x i8]* @.str.104, i32 0, i32 0
  %34 = call i8* @strsep(i8** %4, i8* %33) #7
  %35 = icmp ne i8* %34, null
  br i1 %35, label %36, label %71

; <label>:36:                                     ; preds = %22
  %37 = call i8* @trim(i8* %34)
  %38 = call i8* @strtoupper(i8* %37)
  %39 = getelementptr [4 x i8], [4 x i8]* @.str.105, i32 0, i32 0
  %40 = call i32 @strcmp(i8* %38, i8* %39) #10
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %50, label %42

; <label>:42:                                     ; preds = %36
  %43 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 3
  %44 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %45 = load i16, i16* %44, align 8
  %46 = zext i16 %45 to i32
  %47 = sub nsw i32 %46, 1
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [32 x i16], [32 x i16]* %43, i64 0, i64 %48
  store i16 6, i16* %49, align 2
  br label %79

; <label>:50:                                     ; preds = %36
  %51 = getelementptr [4 x i8], [4 x i8]* @.str.106, i32 0, i32 0
  %52 = call i32 @strcmp(i8* %38, i8* %51) #10
  %53 = icmp ne i32 %52, 0
  br i1 %53, label %62, label %54

; <label>:54:                                     ; preds = %50
  %55 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 3
  %56 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %57 = load i16, i16* %56, align 8
  %58 = zext i16 %57 to i32
  %59 = sub nsw i32 %58, 1
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds [32 x i16], [32 x i16]* %55, i64 0, i64 %60
  store i16 17, i16* %61, align 2
  br label %79

; <label>:62:                                     ; preds = %50
  %63 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %64 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 0
  %65 = getelementptr inbounds [128 x i8], [128 x i8]* %64, i32 0, i32 0
  %66 = getelementptr [56 x i8], [56 x i8]* @.str.107, i32 0, i32 0
  %67 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %63, i8* %66, i8* %65)
  %68 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 0
  %69 = getelementptr inbounds [128 x i8], [128 x i8]* %68, i32 0, i32 0
  %70 = getelementptr [55 x i8], [55 x i8]* @.str.108, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %70, i8* %69)
  br label %._crit_edge

; <label>:71:                                     ; preds = %22
  %72 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 3
  %73 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %74 = load i16, i16* %73, align 8
  %75 = zext i16 %74 to i32
  %76 = sub nsw i32 %75, 1
  %77 = sext i32 %76 to i64
  %78 = getelementptr inbounds [32 x i16], [32 x i16]* %72, i64 0, i64 %77
  store i16 6, i16* %78, align 2
  br label %79

; <label>:79:                                     ; preds = %42, %54, %71
  %80 = getelementptr [2 x i8], [2 x i8]* @.str.86, i32 0, i32 0
  %81 = call i8* @strsep(i8** %3, i8* %80) #7
  store i8* %81, i8** %4, align 8
  %82 = icmp ne i8* %81, null
  br i1 %82, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %79
  %.0.ph = phi i32 [ 0, %79 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2, %62, %13
  %.0 = phi i32 [ 1, %13 ], [ 1, %62 ], [ 0, %2 ], [ %.0.ph, %._crit_edge.loopexit ]
  ret i32 %.0
}

; Function Attrs: nounwind
declare dso_local i8* @strsep(i8**, i8*) #2

; Function Attrs: nounwind readonly
declare dso_local i32 @atoi(i8*) #4

; Function Attrs: noinline nounwind uwtable
define dso_local i8* @strtoupper(i8*) #0 {
  %2 = load i8, i8* %0, align 1
  %3 = icmp ne i8 %2, 0
  br i1 %3, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %1
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.01 = phi i8* [ %8, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  call void @unroll_loop(i32 22)
  %4 = load i8, i8* %.01, align 1
  %5 = sext i8 %4 to i32
  %6 = call i32 @toupper(i32 %5) #10
  %7 = trunc i32 %6 to i8
  store i8 %7, i8* %.01, align 1
  %8 = getelementptr inbounds i8, i8* %.01, i32 1
  %9 = load i8, i8* %8, align 1
  %10 = icmp ne i8 %9, 0
  br i1 %10, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %1
  ret i8* %0
}

; Function Attrs: nounwind readonly
declare dso_local i32 @strcmp(i8*, i8*) #4

; Function Attrs: nounwind readonly
declare dso_local i32 @toupper(i32) #4

; Function Attrs: nounwind readnone
declare dso_local i16** @__ctype_b_loc() #6

; Function Attrs: argmemonly nounwind
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i1) #1

; Function Attrs: noinline nounwind uwtable
define dso_local i64 @get_current_one_time_sequence_position(%struct.opendoor*) #0 {
  %2 = alloca %struct.opendoor, align 8, !track !67
  %3 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %4 = load %struct._IO_FILE*, %struct._IO_FILE** %3, align 8
  call void @rewind(%struct._IO_FILE* %4)
  %5 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** %5, align 8
  %7 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %2, i32 0, i32 14
  store %struct._IO_FILE* %6, %struct._IO_FILE** %7, align 8
  %8 = call i64 @get_next_one_time_sequence(%struct.opendoor* %2)
  %9 = icmp sge i64 %8, 0
  br i1 %9, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %1
  %10 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 3
  %11 = getelementptr inbounds [32 x i16], [32 x i16]* %10, i32 0, i32 0
  %12 = bitcast i16* %11 to i8*
  %13 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %2, i32 0, i32 3
  %14 = getelementptr inbounds [32 x i16], [32 x i16]* %13, i32 0, i32 0
  %15 = bitcast i16* %14 to i8*
  %16 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %41
  %.013 = phi i64 [ %42, %41 ], [ %8, %.lr.ph.preheader ]
  call void @unroll_loop(i32 23)
  %17 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  %18 = load i16, i16* %17, align 8
  %19 = zext i16 %18 to i32
  %20 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %2, i32 0, i32 1
  %21 = load i16, i16* %20, align 8
  %22 = zext i16 %21 to i32
  %23 = icmp eq i32 %19, %22
  br i1 %23, label %24, label %41

; <label>:24:                                     ; preds = %.lr.ph
  %25 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 2
  %26 = getelementptr inbounds [32 x i16], [32 x i16]* %25, i32 0, i32 0
  %27 = bitcast i16* %26 to i8*
  %28 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %2, i32 0, i32 2
  %29 = getelementptr inbounds [32 x i16], [32 x i16]* %28, i32 0, i32 0
  %30 = bitcast i16* %29 to i8*
  %31 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  %32 = load i16, i16* %31, align 8
  %33 = zext i16 %32 to i64
  %34 = call i32 @memcmp(i8* %27, i8* %30, i64 %33) #10
  %35 = icmp eq i32 %34, 0
  br i1 %35, label %36, label %41

; <label>:36:                                     ; preds = %24
  %37 = load i16, i16* %16, align 8
  %38 = zext i16 %37 to i64
  %39 = call i32 @memcmp(i8* %12, i8* %15, i64 %38) #10
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %._crit_edge.loopexit, label %41

; <label>:41:                                     ; preds = %24, %36, %.lr.ph
  %42 = call i64 @get_next_one_time_sequence(%struct.opendoor* %2)
  %43 = icmp sge i64 %42, 0
  br i1 %43, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %36, %41
  %.0.ph = phi i64 [ -1, %41 ], [ %.013, %36 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %1
  %.0 = phi i64 [ -1, %1 ], [ %.0.ph, %._crit_edge.loopexit ]
  ret i64 %.0
}

declare dso_local i32 @fseek(%struct._IO_FILE*, i64, i32) #5

declare dso_local i32 @fputc(i32, %struct._IO_FILE*) #5

; Function Attrs: nounwind readonly
declare dso_local i32 @memcmp(i8*, i8*, i64) #4

declare dso_local i32 @system(i8*) #5

; Function Attrs: nounwind readonly
declare dso_local i8* @strstr(i8*, i8*) #4

declare dso_local i32 @wait(%struct.in_addr*) #5

; Function Attrs: nounwind
declare dso_local i32 @vsnprintf(i8*, i64, i8*, %struct.__va_list_tag*) #2

declare dso_local void @syslog(i32, i8*, ...) #5

; Function Attrs: nounwind
declare dso_local i64 @time(i64*) #2

; Function Attrs: noinline nounwind uwtable
define dso_local i64 @realloc_strcat(i8**, i8*, i64) #0 {
  %4 = icmp eq i64 %2, 0
  br i1 %4, label %23, label %5

; <label>:5:                                      ; preds = %3
  %6 = load i8*, i8** %0, align 8
  %7 = call i64 @strlen(i8* %6) #10
  %8 = call i64 @strlen(i8* %1) #10
  %9 = add i64 %7, %8
  %10 = add i64 %9, 1
  %11 = icmp ugt i64 %10, %2
  br i1 %11, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %5
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.012 = phi i64 [ %12, %.lr.ph ], [ %2, %.lr.ph.preheader ]
  call void @unroll_loop(i32 24)
  %12 = mul i64 %.012, 2
  %13 = icmp ugt i64 %10, %12
  br i1 %13, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.01.lcssa.ph = phi i64 [ %12, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %5
  %.01.lcssa = phi i64 [ %2, %5 ], [ %.01.lcssa.ph, %._crit_edge.loopexit ]
  %14 = icmp ne i64 %.01.lcssa, %2
  br i1 %14, label %15, label %20

; <label>:15:                                     ; preds = %._crit_edge
  %16 = load i8*, i8** %0, align 8
  %17 = call i8* @realloc(i8* %16, i64 %.01.lcssa) #7, !track !68
  store i8* %17, i8** %0, align 8
  %18 = load i8*, i8** %0, align 8
  %19 = icmp eq i8* %18, null
  br i1 %19, label %23, label %20

; <label>:20:                                     ; preds = %15, %._crit_edge
  %21 = load i8*, i8** %0, align 8
  %22 = call i8* @strcat(i8* %21, i8* %1) #7, !track !69
  br label %23

; <label>:23:                                     ; preds = %15, %3, %20
  %.0 = phi i64 [ %.01.lcssa, %20 ], [ 0, %3 ], [ 0, %15 ]
  ret i64 %.0
}

declare dso_local i32 @pcap_compile(%struct.pcap*, %struct.bpf_program*, i8*, i32, i32) #5

declare dso_local i32 @pcap_setfilter(%struct.pcap*, %struct.bpf_program*) #5

declare dso_local void @pcap_freecode(%struct.bpf_program*) #5

; Function Attrs: nounwind
declare dso_local i8* @realloc(i8*, i64) #2

; Function Attrs: nounwind
declare dso_local i8* @strcat(i8*, i8*) #2

; Function Attrs: nounwind
declare dso_local i32 @socket(i32, i32, i32) #2

; Function Attrs: nounwind
declare dso_local i32 @ioctl(i32, i64, ...) #2

declare dso_local i32 @close(i32) #5

declare dso_local void @pcap_close(%struct.pcap*) #5

; Function Attrs: nounwind
declare dso_local i32 @unlink(i8*) #2

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.__pmlist_t* @list_new() #8 {
  %1 = call noalias i8* @malloc(i64 24) #7, !track !70
  %2 = bitcast i8* %1 to %struct.__pmlist_t*
  %3 = icmp eq %struct.__pmlist_t* %2, null
  br i1 %3, label %8, label %4

; <label>:4:                                      ; preds = %0
  %5 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %2, i32 0, i32 0
  store i8* null, i8** %5, align 8
  %6 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %2, i32 0, i32 1
  store %struct.__pmlist_t* null, %struct.__pmlist_t** %6, align 8
  %7 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %2, i32 0, i32 2
  store %struct.__pmlist_t* null, %struct.__pmlist_t** %7, align 8
  br label %8

; <label>:8:                                      ; preds = %0, %4
  %.0 = phi %struct.__pmlist_t* [ %2, %4 ], [ null, %0 ]
  ret %struct.__pmlist_t* %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @list_free(%struct.__pmlist_t*) #0 {
  %2 = icmp eq %struct.__pmlist_t* %0, null
  br i1 %2, label %20, label %3

; <label>:3:                                      ; preds = %1
  %4 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %0, i32 0, i32 0
  %5 = load i8*, i8** %4, align 8
  %6 = icmp ne i8* %5, null
  br i1 %6, label %7, label %11

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %0, i32 0, i32 0
  %9 = load i8*, i8** %8, align 8
  call void @free(i8* %9) #7
  %10 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %0, i32 0, i32 0
  store i8* null, i8** %10, align 8
  br label %11

; <label>:11:                                     ; preds = %7, %3
  %12 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %0, i32 0, i32 2
  %13 = load %struct.__pmlist_t*, %struct.__pmlist_t** %12, align 8
  %14 = icmp ne %struct.__pmlist_t* %13, null
  br i1 %14, label %15, label %18

; <label>:15:                                     ; preds = %11
  %16 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %0, i32 0, i32 2
  %17 = load %struct.__pmlist_t*, %struct.__pmlist_t** %16, align 8
  call void @list_free(%struct.__pmlist_t* %17)
  br label %18

; <label>:18:                                     ; preds = %15, %11
  %19 = bitcast %struct.__pmlist_t* %0 to i8*
  call void @free(i8* %19) #7
  br label %20

; <label>:20:                                     ; preds = %1, %18
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.__pmlist_t* @list_add(%struct.__pmlist_t*, i8*) #8 {
  %3 = icmp eq %struct.__pmlist_t* %0, null
  br i1 %3, label %4, label %6

; <label>:4:                                      ; preds = %2
  %5 = call %struct.__pmlist_t* @list_new()
  br label %6

; <label>:6:                                      ; preds = %4, %2
  %.02 = phi %struct.__pmlist_t* [ %5, %4 ], [ %0, %2 ]
  %7 = call %struct.__pmlist_t* @list_last(%struct.__pmlist_t* %.02)
  %8 = icmp eq %struct.__pmlist_t* %7, %.02
  br i1 %8, label %9, label %13

; <label>:9:                                      ; preds = %6
  %10 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %7, i32 0, i32 0
  %11 = load i8*, i8** %10, align 8
  %12 = icmp eq i8* %11, null
  br i1 %12, label %25, label %13

; <label>:13:                                     ; preds = %9, %6
  %14 = call %struct.__pmlist_t* @list_new()
  %15 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %7, i32 0, i32 2
  store %struct.__pmlist_t* %14, %struct.__pmlist_t** %15, align 8
  %16 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %7, i32 0, i32 2
  %17 = load %struct.__pmlist_t*, %struct.__pmlist_t** %16, align 8
  %18 = icmp eq %struct.__pmlist_t* %17, null
  br i1 %18, label %27, label %19

; <label>:19:                                     ; preds = %13
  %20 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %7, i32 0, i32 2
  %21 = load %struct.__pmlist_t*, %struct.__pmlist_t** %20, align 8
  %22 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %21, i32 0, i32 1
  store %struct.__pmlist_t* %7, %struct.__pmlist_t** %22, align 8
  %23 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %7, i32 0, i32 2
  %24 = load %struct.__pmlist_t*, %struct.__pmlist_t** %23, align 8
  br label %25

; <label>:25:                                     ; preds = %9, %19
  %.01 = phi %struct.__pmlist_t* [ %24, %19 ], [ %7, %9 ]
  %26 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.01, i32 0, i32 0
  store i8* %1, i8** %26, align 8
  br label %27

; <label>:27:                                     ; preds = %13, %25
  %.0 = phi %struct.__pmlist_t* [ %.02, %25 ], [ null, %13 ]
  ret %struct.__pmlist_t* %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.__pmlist_t* @list_last(%struct.__pmlist_t*) #8 {
  call void @unroll_loop(i32 25)
  %2 = icmp ne %struct.__pmlist_t* %0, null
  br i1 %2, label %.lr.ph, label %.critedge

.lr.ph:                                           ; preds = %1
  br label %3

; <label>:3:                                      ; preds = %.lr.ph, %7
  %.01 = phi %struct.__pmlist_t* [ %0, %.lr.ph ], [ %9, %7 ]
  %4 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.01, i32 0, i32 2
  %5 = load %struct.__pmlist_t*, %struct.__pmlist_t** %4, align 8
  %6 = icmp ne %struct.__pmlist_t* %5, null
  br i1 %6, label %7, label %..critedge_crit_edge2

; <label>:7:                                      ; preds = %3
  %8 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.01, i32 0, i32 2
  %9 = load %struct.__pmlist_t*, %struct.__pmlist_t** %8, align 8
  call void @unroll_loop(i32 25)
  %10 = icmp ne %struct.__pmlist_t* %9, null
  br i1 %10, label %3, label %..critedge_crit_edge

..critedge_crit_edge:                             ; preds = %7
  %split = phi %struct.__pmlist_t* [ %9, %7 ]
  br label %.critedge

..critedge_crit_edge2:                            ; preds = %3
  %split3 = phi %struct.__pmlist_t* [ %.01, %3 ]
  br label %.critedge

.critedge:                                        ; preds = %..critedge_crit_edge2, %..critedge_crit_edge, %1
  %.0.lcssa = phi %struct.__pmlist_t* [ %split3, %..critedge_crit_edge2 ], [ %split, %..critedge_crit_edge ], [ %0, %1 ]
  ret %struct.__pmlist_t* %.0.lcssa
}

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.__pmlist_t* @list_remove(%struct.__pmlist_t*, i8*) #8 {
  %3 = icmp ne %struct.__pmlist_t* %0, null
  br i1 %3, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %32
  %.03 = phi %struct.__pmlist_t* [ %34, %32 ], [ %0, %.lr.ph.preheader ]
  %.012 = phi %struct.__pmlist_t* [ %.2, %32 ], [ %0, %.lr.ph.preheader ]
  call void @unroll_loop(i32 26)
  %4 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 0
  %5 = load i8*, i8** %4, align 8
  %6 = icmp eq i8* %5, %1
  br i1 %6, label %7, label %32

; <label>:7:                                      ; preds = %.lr.ph
  %8 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 1
  %9 = load %struct.__pmlist_t*, %struct.__pmlist_t** %8, align 8
  %10 = icmp ne %struct.__pmlist_t* %9, null
  br i1 %10, label %11, label %17

; <label>:11:                                     ; preds = %7
  %12 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 2
  %13 = load %struct.__pmlist_t*, %struct.__pmlist_t** %12, align 8
  %14 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 1
  %15 = load %struct.__pmlist_t*, %struct.__pmlist_t** %14, align 8
  %16 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %15, i32 0, i32 2
  store %struct.__pmlist_t* %13, %struct.__pmlist_t** %16, align 8
  br label %17

; <label>:17:                                     ; preds = %11, %7
  %18 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 2
  %19 = load %struct.__pmlist_t*, %struct.__pmlist_t** %18, align 8
  %20 = icmp ne %struct.__pmlist_t* %19, null
  br i1 %20, label %21, label %27

; <label>:21:                                     ; preds = %17
  %22 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 1
  %23 = load %struct.__pmlist_t*, %struct.__pmlist_t** %22, align 8
  %24 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 2
  %25 = load %struct.__pmlist_t*, %struct.__pmlist_t** %24, align 8
  %26 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %25, i32 0, i32 1
  store %struct.__pmlist_t* %23, %struct.__pmlist_t** %26, align 8
  br label %27

; <label>:27:                                     ; preds = %21, %17
  %28 = icmp eq %struct.__pmlist_t* %.03, %.012
  br i1 %28, label %29, label %32

; <label>:29:                                     ; preds = %27
  %30 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 2
  %31 = load %struct.__pmlist_t*, %struct.__pmlist_t** %30, align 8
  br label %32

; <label>:32:                                     ; preds = %.lr.ph, %29, %27
  %.2 = phi %struct.__pmlist_t* [ %.012, %.lr.ph ], [ %31, %29 ], [ %.012, %27 ]
  %33 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 2
  %34 = load %struct.__pmlist_t*, %struct.__pmlist_t** %33, align 8
  %35 = icmp ne %struct.__pmlist_t* %34, null
  br i1 %35, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %32
  %.01.lcssa.ph = phi %struct.__pmlist_t* [ %.2, %32 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.01.lcssa = phi %struct.__pmlist_t* [ %0, %2 ], [ %.01.lcssa.ph, %._crit_edge.loopexit ]
  ret %struct.__pmlist_t* %.01.lcssa
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @list_count(%struct.__pmlist_t*) #0 {
  %2 = icmp ne %struct.__pmlist_t* %0, null
  br i1 %2, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %1
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.03 = phi %struct.__pmlist_t* [ %4, %.lr.ph ], [ %0, %.lr.ph.preheader ]
  %.012 = phi i32 [ %5, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %3 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 2
  %4 = load %struct.__pmlist_t*, %struct.__pmlist_t** %3, align 8
  %5 = add nuw nsw i32 %.012, 1
  %6 = icmp ne %struct.__pmlist_t* %4, null
  br i1 %6, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.01.lcssa.ph = phi i32 [ %5, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %1
  %.01.lcssa = phi i32 [ 0, %1 ], [ %.01.lcssa.ph, %._crit_edge.loopexit ]
  ret i32 %.01.lcssa
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @list_isin(%struct.__pmlist_t*, i8*) #0 {
  %3 = icmp ne %struct.__pmlist_t* %0, null
  br i1 %3, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %7
  %.012 = phi %struct.__pmlist_t* [ %9, %7 ], [ %0, %.lr.ph.preheader ]
  %4 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.012, i32 0, i32 0
  %5 = load i8*, i8** %4, align 8
  %6 = icmp eq i8* %5, %1
  br i1 %6, label %._crit_edge.loopexit, label %7

; <label>:7:                                      ; preds = %.lr.ph
  %8 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.012, i32 0, i32 2
  %9 = load %struct.__pmlist_t*, %struct.__pmlist_t** %8, align 8
  %10 = icmp ne %struct.__pmlist_t* %9, null
  br i1 %10, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph, %7
  %.0.ph = phi i32 [ 0, %7 ], [ 1, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0 = phi i32 [ 0, %2 ], [ %.0.ph, %._crit_edge.loopexit ]
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @is_in(i8*, %struct.__pmlist_t*) #0 {
  %3 = icmp ne %struct.__pmlist_t* %1, null
  br i1 %3, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %12
  %.012 = phi %struct.__pmlist_t* [ %14, %12 ], [ %1, %.lr.ph.preheader ]
  %4 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.012, i32 0, i32 0
  %5 = load i8*, i8** %4, align 8
  %6 = icmp ne i8* %5, null
  br i1 %6, label %7, label %12

; <label>:7:                                      ; preds = %.lr.ph
  %8 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.012, i32 0, i32 0
  %9 = load i8*, i8** %8, align 8
  %10 = call i32 @strcmp(i8* %9, i8* %0) #10
  %11 = icmp ne i32 %10, 0
  br i1 %11, label %12, label %._crit_edge.loopexit

; <label>:12:                                     ; preds = %.lr.ph, %7
  %13 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.012, i32 0, i32 2
  %14 = load %struct.__pmlist_t*, %struct.__pmlist_t** %13, align 8
  %15 = icmp ne %struct.__pmlist_t* %14, null
  br i1 %15, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %7, %12
  %.0.ph = phi i32 [ 0, %12 ], [ 1, %7 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2
  %.0 = phi i32 [ 0, %2 ], [ %.0.ph, %._crit_edge.loopexit ]
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.__pmlist_t* @list_merge(%struct.__pmlist_t*, %struct.__pmlist_t*) #0 {
  %3 = icmp eq %struct.__pmlist_t* %1, null
  br i1 %3, label %._crit_edge, label %4

; <label>:4:                                      ; preds = %2
  %5 = icmp eq %struct.__pmlist_t* %0, null
  br i1 %5, label %6, label %8

; <label>:6:                                      ; preds = %4
  %7 = call %struct.__pmlist_t* @list_new()
  br label %8

; <label>:8:                                      ; preds = %6, %4
  %.01 = phi %struct.__pmlist_t* [ %7, %6 ], [ %0, %4 ]
  %9 = icmp ne %struct.__pmlist_t* %1, null
  br i1 %9, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %8
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %18
  %.14 = phi %struct.__pmlist_t* [ %.2, %18 ], [ %.01, %.lr.ph.preheader ]
  %.023 = phi %struct.__pmlist_t* [ %20, %18 ], [ %1, %.lr.ph.preheader ]
  call void @unroll_loop(i32 27)
  %10 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.023, i32 0, i32 0
  %11 = load i8*, i8** %10, align 8
  %12 = icmp ne i8* %11, null
  br i1 %12, label %13, label %18

; <label>:13:                                     ; preds = %.lr.ph
  %14 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.023, i32 0, i32 0
  %15 = load i8*, i8** %14, align 8
  %16 = call %struct.__pmlist_t* @list_add(%struct.__pmlist_t* %.14, i8* %15)
  %17 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.023, i32 0, i32 0
  store i8* null, i8** %17, align 8
  br label %18

; <label>:18:                                     ; preds = %.lr.ph, %13
  %.2 = phi %struct.__pmlist_t* [ %16, %13 ], [ %.14, %.lr.ph ]
  %19 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.023, i32 0, i32 2
  %20 = load %struct.__pmlist_t*, %struct.__pmlist_t** %19, align 8
  %21 = icmp ne %struct.__pmlist_t* %20, null
  br i1 %21, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %18
  %.0.ph = phi %struct.__pmlist_t* [ %.2, %18 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %8, %2
  %.0 = phi %struct.__pmlist_t* [ %0, %2 ], [ %.01, %8 ], [ %.0.ph, %._crit_edge.loopexit ]
  ret %struct.__pmlist_t* %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @list_strcmp(i8*, i8*) #0 {
  %3 = bitcast i8* %0 to i8**
  %4 = bitcast i8* %1 to i8**
  %5 = load i8*, i8** %3, align 8
  %6 = load i8*, i8** %4, align 8
  %7 = call i32 @strcmp(i8* %5, i8* %6) #10
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.__pmlist_t* @list_sort(%struct.__pmlist_t*) #0 {
  %2 = icmp eq %struct.__pmlist_t* %0, null
  br i1 %2, label %26, label %.lr.ph9

.lr.ph9:                                          ; preds = %1
  %3 = call i32 @list_count(%struct.__pmlist_t* %0)
  %4 = zext i32 %3 to i64
  %5 = mul i64 %4, 8
  %6 = call noalias i8* @malloc(i64 %5) #7
  %7 = bitcast i8* %6 to i8**
  br label %8

; <label>:8:                                      ; preds = %.lr.ph9, %8
  %indvars.iv11 = phi i64 [ 0, %.lr.ph9 ], [ %indvars.iv.next12, %8 ]
  %.026 = phi %struct.__pmlist_t* [ %0, %.lr.ph9 ], [ %13, %8 ]
  %9 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.026, i32 0, i32 0
  %10 = load i8*, i8** %9, align 8
  %indvars.iv.next12 = add nuw i64 %indvars.iv11, 1
  %11 = getelementptr inbounds i8*, i8** %7, i64 %indvars.iv11
  store i8* %10, i8** %11, align 8
  %12 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.026, i32 0, i32 2
  %13 = load %struct.__pmlist_t*, %struct.__pmlist_t** %12, align 8
  %14 = icmp ne %struct.__pmlist_t* %13, null
  br i1 %14, label %8, label %._crit_edge10

._crit_edge10:                                    ; preds = %8
  %15 = bitcast i8** %7 to i8*
  %16 = zext i32 %3 to i64
  call void @qsort(i8* %15, i64 %16, i64 8, i32 (i8*, i8*)* @list_strcmp)
  %17 = icmp ult i32 0, %3
  br i1 %17, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %._crit_edge10
  %18 = zext i32 %3 to i64
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %.134 = phi %struct.__pmlist_t* [ %22, %.lr.ph ], [ null, %.lr.ph.preheader ]
  call void @unroll_loop(i32 28)
  %19 = getelementptr inbounds i8*, i8** %7, i64 %indvars.iv
  %20 = load i8*, i8** %19, align 8
  %21 = call noalias i8* @strdup(i8* %20) #7, !track !71
  %22 = call %struct.__pmlist_t* @list_add(%struct.__pmlist_t* %.134, i8* %21)
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond1 = icmp ne i64 %indvars.iv.next, %18
  br i1 %exitcond1, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.13.lcssa.ph = phi %struct.__pmlist_t* [ %22, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %._crit_edge10
  %.13.lcssa = phi %struct.__pmlist_t* [ null, %._crit_edge10 ], [ %.13.lcssa.ph, %._crit_edge.loopexit ]
  %23 = icmp ne i8** %7, null
  br i1 %23, label %24, label %26

; <label>:24:                                     ; preds = %._crit_edge
  %25 = bitcast i8** %7 to i8*
  call void @free(i8* %25) #7
  br label %26

; <label>:26:                                     ; preds = %._crit_edge, %24, %1
  %.0 = phi %struct.__pmlist_t* [ null, %1 ], [ %.13.lcssa, %24 ], [ %.13.lcssa, %._crit_edge ]
  ret %struct.__pmlist_t* %.0
}

declare dso_local void @qsort(i8*, i64, i64, i32 (i8*, i8*)*) #5

; Function Attrs: noinline nounwind uwtable
define dso_local void @list_display(i8*, %struct.__pmlist_t*) #0 {
  %3 = getelementptr [8 x i8], [8 x i8]* @.str.178, i32 0, i32 0
  %4 = call i8* @getenv(i8* %3) #7
  %5 = icmp ne i8* %4, null
  br i1 %5, label %6, label %8

; <label>:6:                                      ; preds = %2
  %7 = call i32 @atoi(i8* %4) #10
  br label %8

; <label>:8:                                      ; preds = %6, %2
  %.03 = phi i32 [ %7, %6 ], [ 80, %2 ]
  %9 = call i64 @strlen(i8* %0) #10
  %10 = trunc i64 %9 to i32
  %11 = getelementptr [4 x i8], [4 x i8]* @.str.1.179, i32 0, i32 0
  %12 = call i32 (i8*, ...) @printf(i8* %11, i8* %0)
  %13 = icmp ne %struct.__pmlist_t* %1, null
  br i1 %13, label %.lr.ph8, label %41

.lr.ph8:                                          ; preds = %8
  %14 = add i32 %10, 1
  br label %15

; <label>:15:                                     ; preds = %.lr.ph8, %._crit_edge
  %.016 = phi %struct.__pmlist_t* [ %1, %.lr.ph8 ], [ %37, %._crit_edge ]
  %.025 = phi i32 [ %10, %.lr.ph8 ], [ %35, %._crit_edge ]
  %16 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.016, i32 0, i32 0
  %17 = load i8*, i8** %16, align 8
  %18 = call i64 @strlen(i8* %17) #10
  %19 = add i64 %18, 1
  %20 = trunc i64 %19 to i32
  %21 = add nsw i32 %20, %.025
  %22 = icmp sge i32 %21, %.03
  br i1 %22, label %23, label %._crit_edge

; <label>:23:                                     ; preds = %15
  %24 = getelementptr [2 x i8], [2 x i8]* @.str.2.180, i32 0, i32 0
  %25 = call i32 (i8*, ...) @printf(i8* %24)
  %26 = add nsw i32 %10, 1
  %27 = icmp slt i32 0, %26
  br i1 %27, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %23
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %.04 = phi i32 [ %30, %.lr.ph ], [ 0, %.lr.ph.preheader ]
  %28 = getelementptr [2 x i8], [2 x i8]* @.str.3.181, i32 0, i32 0
  %29 = call i32 (i8*, ...) @printf(i8* %28)
  %30 = add nuw nsw i32 %.04, 1
  %exitcond = icmp ne i32 %30, %14
  br i1 %exitcond, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.1.ph = phi i32 [ %10, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %23, %15
  %.1 = phi i32 [ %.025, %15 ], [ %10, %23 ], [ %.1.ph, %._crit_edge.loopexit ]
  %31 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.016, i32 0, i32 0
  %32 = load i8*, i8** %31, align 8
  %33 = getelementptr [4 x i8], [4 x i8]* @.str.1.179, i32 0, i32 0
  %34 = call i32 (i8*, ...) @printf(i8* %33, i8* %32)
  %35 = add nsw i32 %.1, %20
  %36 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.016, i32 0, i32 2
  %37 = load %struct.__pmlist_t*, %struct.__pmlist_t** %36, align 8
  %38 = icmp ne %struct.__pmlist_t* %37, null
  br i1 %38, label %15, label %._crit_edge9

._crit_edge9:                                     ; preds = %._crit_edge
  %39 = getelementptr [2 x i8], [2 x i8]* @.str.2.180, i32 0, i32 0
  %40 = call i32 (i8*, ...) @printf(i8* %39)
  br label %44

; <label>:41:                                     ; preds = %8
  %42 = getelementptr [6 x i8], [6 x i8]* @.str.4.182, i32 0, i32 0
  %43 = call i32 (i8*, ...) @printf(i8* %42)
  br label %44

; <label>:44:                                     ; preds = %41, %._crit_edge9
  ret void
}

; Function Attrs: nounwind
declare dso_local i8* @getenv(i8*) #2

declare void @unroll_loop(i32)

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind }
attributes #8 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "track_func"="true" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { noreturn nounwind }
attributes #10 = { nounwind readonly }
attributes #11 = { nounwind readnone }

!llvm.ident = !{!10, !10}
!llvm.module.flags = !{!11}

!0 = !{i64 1}
!1 = !{i64 4}
!2 = !{i64 6}
!3 = !{i64 9}
!4 = !{i64 38}
!5 = !{i64 37}
!6 = !{i64 36}
!7 = !{i64 34}
!8 = !{i64 35}
!9 = !{i64 0}
!10 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!11 = !{i32 1, !"wchar_size", i32 4}
!12 = !{i64 33}
!13 = !{!"1"}
!14 = !{i64 42}
!15 = !{i64 27}
!16 = !{i64 26}
!17 = !{i64 25}
!18 = !{i64 24}
!19 = !{i64 2}
!20 = !{i64 3}
!21 = !{i64 21}
!22 = !{i64 20}
!23 = !{i64 32}
!24 = !{i64 19}
!25 = !{i64 28}
!26 = !{i64 7}
!27 = !{i64 55}
!28 = !{i64 66}
!29 = !{i64 65}
!30 = !{i64 64}
!31 = !{i64 8}
!32 = !{i64 11}
!33 = !{i64 29}
!34 = !{i64 13}
!35 = !{i64 60}
!36 = !{i64 30}
!37 = !{i64 17}
!38 = !{i64 59}
!39 = !{i64 58}
!40 = !{i64 57}
!41 = !{i64 5}
!42 = !{i64 68}
!43 = !{i64 54}
!44 = !{i64 53}
!45 = !{i64 52}
!46 = !{i64 51}
!47 = !{i64 50}
!48 = !{i64 10}
!49 = !{i64 47}
!50 = !{i64 46}
!51 = !{i64 45}
!52 = !{i64 44}
!53 = !{i64 43}
!54 = !{i64 49}
!55 = !{i64 12}
!56 = !{i64 63}
!57 = !{i64 16}
!58 = !{i64 14}
!59 = !{i64 56}
!60 = !{i64 61}
!61 = !{i64 15}
!62 = !{i64 62}
!63 = !{i64 67}
!64 = !{i64 48}
!65 = !{i64 22}
!66 = !{i64 23}
!67 = !{i64 18}
!68 = !{i64 31}
!69 = !{i64 39}
!70 = !{i64 40}
!71 = !{i64 41}
