; ModuleID = './work_dir/knockd_ls.bc'
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
@3 = constant [10 x i8] c"dst host \00"
@4 = constant [7 x i8] c" and (\00"
@5 = constant [2 x i8] c")\00"

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main_old(i32, i8**) #0 {
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
  %28 = icmp ne i32 105, 0
  br i1 true, label %.lr.ph.preheader, label %.loopexit

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %44
  %29 = phi i32 [ %45, %44 ], [ 105, %.lr.ph.preheader ]
  %30 = icmp slt i32 %29, 0
  br i1 %30, label %.loopexit.loopexit, label %31

; <label>:31:                                     ; preds = %.lr.ph
  switch i32 %29, label %43 [
    i32 0, label %44
    i32 118, label %32
    i32 68, label %33
    i32 100, label %34
    i32 108, label %35
    i32 105, label %36
    i32 99, label %39
    i32 86, label %42
  ]

; <label>:32:                                     ; preds = %31
  store i32 1, i32* @o_verbose, align 4
  br label %44

; <label>:33:                                     ; preds = %31
  store i32 1, i32* @o_debug, align 4
  br label %44

; <label>:34:                                     ; preds = %31
  store i32 1, i32* @o_daemon, align 4
  br label %44

; <label>:35:                                     ; preds = %31
  store i32 1, i32* @o_lookup, align 4
  br label %44

; <label>:36:                                     ; preds = %31
  %37 = load i8*, i8** @optarg, align 8
  %38 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %37, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %44

; <label>:39:                                     ; preds = %31
  %40 = load i8*, i8** @optarg, align 8
  %41 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %40, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %44

; <label>:42:                                     ; preds = %31
  call void @ver()
  br label %43

; <label>:43:                                     ; preds = %42, %31
  call void @usage()
  br label %44

; <label>:44:                                     ; preds = %31, %43, %39, %36, %35, %34, %33, %32
  %45 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %46 = icmp ne i32 %45, 0
  br i1 %46, label %.lr.ph, label %.loopexit.loopexit

.loopexit.loopexit:                               ; preds = %.lr.ph, %44
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %2
  %47 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i32 0, i32 0
  %48 = call i32 @parseconfig(i8* %47)
  %49 = icmp ne i32 %48, 0
  br i1 %49, label %50, label %51

; <label>:50:                                     ; preds = %.loopexit
  call void @exit(i32 1) #9
  unreachable

; <label>:51:                                     ; preds = %.loopexit
  %52 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %53 = call i64 @strlen(i8* %52) #10
  %54 = icmp eq i64 %53, 0
  br i1 %54, label %55, label %59

; <label>:55:                                     ; preds = %51
  %56 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %57 = getelementptr [5 x i8], [5 x i8]* @.str.9, i32 0, i32 0
  %58 = call i8* @strncpy(i8* %56, i8* %57, i64 32) #7, !track !16
  br label %59

; <label>:59:                                     ; preds = %55, %51
  %60 = load i32, i32* @o_usesyslog, align 4
  %61 = icmp ne i32 %60, 0
  br i1 %61, label %62, label %64

; <label>:62:                                     ; preds = %59
  %63 = getelementptr [7 x i8], [7 x i8]* @.str.10, i32 0, i32 0
  call void @openlog(i8* %63, i32 0, i32 8)
  br label %64

; <label>:64:                                     ; preds = %62, %59
  %65 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  %66 = call i64 @strlen(i8* %65) #10
  %67 = icmp ne i64 %66, 0
  br i1 %67, label %68, label %76

; <label>:68:                                     ; preds = %64
  %69 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  %70 = getelementptr [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %71 = call %struct._IO_FILE* @fopen(i8* %69, i8* %70), !track !17
  store %struct._IO_FILE* %71, %struct._IO_FILE** @logfd, align 8
  %72 = load %struct._IO_FILE*, %struct._IO_FILE** @logfd, align 8
  %73 = icmp eq %struct._IO_FILE* %72, null
  br i1 %73, label %74, label %76

; <label>:74:                                     ; preds = %68
  %75 = getelementptr [29 x i8], [29 x i8]* @.str.12, i32 0, i32 0
  call void @perror(i8* %75)
  br label %76

; <label>:76:                                     ; preds = %68, %74, %64
  %77 = getelementptr inbounds [256 x i8], [256 x i8]* %22, i32 0, i32 0
  %78 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %79 = call %struct.pcap* @pcap_open_live(i8* %78, i32 65535, i32 0, i32 0, i8* %77)
  store %struct.pcap* %79, %struct.pcap** @cap, align 8
  %80 = getelementptr inbounds [256 x i8], [256 x i8]* %22, i32 0, i32 0
  %81 = call i64 @strlen(i8* %80) #10
  %82 = icmp ne i64 %81, 0
  br i1 %82, label %83, label %89

; <label>:83:                                     ; preds = %76
  %84 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %85 = getelementptr inbounds [256 x i8], [256 x i8]* %22, i32 0, i32 0
  %86 = getelementptr [23 x i8], [23 x i8]* @.str.13, i32 0, i32 0
  %87 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %88 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %84, i8* %86, i8* %87, i8* %85)
  br label %89

; <label>:89:                                     ; preds = %83, %76
  %90 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %91 = icmp eq %struct.pcap* %90, null
  br i1 %91, label %92, label %93

; <label>:92:                                     ; preds = %89
  call void @exit(i32 1) #9
  unreachable

; <label>:93:                                     ; preds = %89
  %94 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %95 = call i32 @pcap_datalink(%struct.pcap* %94)
  store i32 %95, i32* @lltype, align 4
  %96 = load i32, i32* @lltype, align 4
  switch i32 %96, label %103 [
    i32 1, label %97
    i32 113, label %99
    i32 12, label %101
  ]

; <label>:97:                                     ; preds = %93
  %98 = getelementptr [29 x i8], [29 x i8]* @.str.14, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %98)
  br label %108

; <label>:99:                                     ; preds = %93
  %100 = getelementptr [55 x i8], [55 x i8]* @.str.15, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %100)
  br label %108

; <label>:101:                                    ; preds = %93
  %102 = getelementptr [42 x i8], [42 x i8]* @.str.16, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %102)
  br label %108

; <label>:103:                                    ; preds = %93
  %104 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %105 = load i32, i32* @lltype, align 4
  %106 = getelementptr [40 x i8], [40 x i8]* @.str.17, i32 0, i32 0
  %107 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %104, i8* %106, i32 %105)
  call void @cleanup(i32 1)
  br label %108

; <label>:108:                                    ; preds = %103, %101, %99, %97
  %109 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %110 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %111 = call i8* @get_ip(i8* %109, i8* %110, i32 32)
  %112 = icmp eq i8* %111, null
  br i1 %112, label %113, label %118

; <label>:113:                                    ; preds = %108
  %114 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %115 = getelementptr [33 x i8], [33 x i8]* @.str.18, i32 0, i32 0
  %116 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %117 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %114, i8* %115, i8* %116)
  call void @cleanup(i32 1)
  br label %121

; <label>:118:                                    ; preds = %108
  %119 = getelementptr [14 x i8], [14 x i8]* @.str.19, i32 0, i32 0
  %120 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %119, i8* %120)
  br label %121

; <label>:121:                                    ; preds = %118, %113
  call void @generate_pcap_filter()
  %122 = load i32, i32* @o_daemon, align 4
  %123 = icmp ne i32 %122, 0
  br i1 %123, label %124, label %150

; <label>:124:                                    ; preds = %121
  %125 = call i32 @daemon(i32 0, i32 0) #7
  %126 = icmp slt i32 %125, 0
  br i1 %126, label %127, label %129

; <label>:127:                                    ; preds = %124
  %128 = getelementptr [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  call void @perror(i8* %128)
  call void @cleanup(i32 1)
  br label %129

; <label>:129:                                    ; preds = %127, %124
  %130 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  %131 = getelementptr [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %132 = call %struct._IO_FILE* @fopen(i8* %130, i8* %131), !track !18
  %133 = icmp ne %struct._IO_FILE* %132, null
  br i1 %133, label %134, label %139

; <label>:134:                                    ; preds = %129
  %135 = call i32 @getpid() #7
  %136 = getelementptr [4 x i8], [4 x i8]* @.str.21, i32 0, i32 0
  %137 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %132, i8* %136, i32 %135)
  %138 = call i32 @fclose(%struct._IO_FILE* %132)
  br label %150

; <label>:139:                                    ; preds = %129
  %140 = call i32* @__errno_location() #11
  %141 = load i32, i32* %140, align 4
  %142 = call i8* @strerror(i32 %141) #7
  %143 = getelementptr [34 x i8], [34 x i8]* @.str.22, i32 0, i32 0
  %144 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %143, i8* %144, i8* %142)
  %145 = call i32* @__errno_location() #11
  %146 = load i32, i32* %145, align 4
  %147 = call i8* @strerror(i32 %146) #7
  %148 = getelementptr [33 x i8], [33 x i8]* @.str.23, i32 0, i32 0
  %149 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %148, i8* %149, i8* %147)
  br label %150

; <label>:150:                                    ; preds = %134, %139, %121
  %151 = call void (i32)* @signal(i32 2, void (i32)* @cleanup) #7
  %152 = call void (i32)* @signal(i32 15, void (i32)* @cleanup) #7
  %153 = call void (i32)* @signal(i32 17, void (i32)* @child_exit) #7
  %154 = call void (i32)* @signal(i32 1, void (i32)* @read_cfg) #7
  %155 = getelementptr [20 x i8], [20 x i8]* @.str.24, i32 0, i32 0
  %156 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %155, i8* %156)
  %157 = getelementptr [29 x i8], [29 x i8]* @.str.25, i32 0, i32 0
  %158 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %157, i8* %158)
  br label %159

; <label>:159:                                    ; preds = %150, %159
  %160 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %161 = call i32 @pcap_dispatch(%struct.pcap* %160, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %162 = icmp sge i32 %161, 0
  br i1 %162, label %159, label %163

; <label>:163:                                    ; preds = %159
  %.0.lcssa = phi i32 [ %161, %159 ]
  %164 = getelementptr [35 x i8], [35 x i8]* @.str.26, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %164, i32 %.0.lcssa)
  %165 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %166 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %165, i8* %166)
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
  %14 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %15 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %16 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  %17 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  %18 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %19 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %20 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %21 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %22 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %23 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %24 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %25 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %26 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %27 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %28 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %29 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  br label %.lr.ph43

.lr.ph43:                                         ; preds = %.lr.ph43.preheader, %.outer
  %.02.ph49 = phi i32 [ %.lcssa40, %.outer ], [ 0, %.lr.ph43.preheader ]
  %.03.ph48 = phi %struct.opendoor* [ %.2, %.outer ], [ null, %.lr.ph43.preheader ]
  %30 = add i32 %.02.ph49, 1
  br label %31

; <label>:31:                                     ; preds = %.lr.ph43, %39
  %lsr.iv = phi i32 [ %30, %.lr.ph43 ], [ %lsr.iv.next, %39 ]
  %32 = call i8* @trim(i8* %14)
  %33 = call i64 @strlen(i8* %15) #10
  %34 = icmp eq i64 %33, 0
  br i1 %34, label %39, label %35

; <label>:35:                                     ; preds = %31
  %36 = load i8, i8* %16, align 16
  %37 = sext i8 %36 to i32
  %38 = icmp eq i32 %37, 35
  br i1 %38, label %39, label %42

; <label>:39:                                     ; preds = %35, %31
  %40 = call i8* @fgets(i8* %11, i32 100, %struct._IO_FILE* %7), !track !24
  %41 = icmp ne i8* %40, null
  %lsr.iv.next = add i32 %lsr.iv, 1
  br i1 %41, label %31, label %.outer._crit_edge.loopexit

; <label>:42:                                     ; preds = %35
  %.lcssa40 = phi i32 [ %lsr.iv, %35 ]
  %43 = load i8, i8* %17, align 16
  %44 = sext i8 %43 to i32
  %45 = icmp eq i32 %44, 91
  br i1 %45, label %46, label %92

; <label>:46:                                     ; preds = %42
  %47 = call i64 @strlen(i8* %18) #10
  %48 = sub i64 %47, 1
  %49 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 %48
  %50 = load i8, i8* %49, align 1
  %51 = sext i8 %50 to i32
  %52 = icmp eq i32 %51, 93
  br i1 %52, label %53, label %92

; <label>:53:                                     ; preds = %46
  store i8* %20, i8** %3, align 8
  %54 = load i8*, i8** %3, align 8
  %55 = getelementptr inbounds i8, i8* %54, i32 1
  store i8* %55, i8** %3, align 8
  %56 = load i8*, i8** %3, align 8
  %57 = call i8* @strncpy(i8* %21, i8* %56, i64 256) #7, !track !25
  %58 = call i64 @strlen(i8* %22) #10
  %59 = sub i64 %58, 1
  %60 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i64 0, i64 %59
  store i8 0, i8* %60, align 1
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.53, i64 0, i64 0), i8* %23)
  %61 = call i64 @strlen(i8* %24) #10
  %62 = icmp ne i64 %61, 0
  br i1 %62, label %67, label %63

; <label>:63:                                     ; preds = %53
  %.lcssa29 = phi i32 [ %.lcssa40, %53 ]
  %64 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %65 = getelementptr [35 x i8], [35 x i8]* @.str.54, i32 0, i32 0
  %66 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %64, i8* %65, i32 %.lcssa29)
  br label %._crit_edge

; <label>:67:                                     ; preds = %53
  %68 = call i32 @strcmp(i8* %26, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.55, i64 0, i64 0)) #10
  %69 = icmp ne i32 %68, 0
  br i1 %69, label %70, label %.outer

; <label>:70:                                     ; preds = %67
  %71 = call noalias i8* @malloc(i64 336) #7, !track !26
  %72 = bitcast i8* %71 to %struct.opendoor*
  %73 = icmp eq %struct.opendoor* %72, null
  br i1 %73, label %74, label %76

; <label>:74:                                     ; preds = %70
  %75 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %75)
  call void @exit(i32 1) #9
  unreachable

; <label>:76:                                     ; preds = %70
  %77 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 0
  %78 = getelementptr inbounds [128 x i8], [128 x i8]* %77, i32 0, i32 0
  %79 = call i8* @strncpy(i8* %78, i8* %28, i64 127) #7, !track !27
  %80 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 0
  %81 = getelementptr inbounds [128 x i8], [128 x i8]* %80, i64 0, i64 127
  store i8 0, i8* %81, align 1
  %82 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 1
  store i16 0, i16* %82, align 8
  %83 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 4
  store i64 25, i64* %83, align 8
  %84 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 5
  store i8* null, i8** %84, align 8
  %85 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 6
  store i64 10, i64* %85, align 8
  %86 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 7
  store i8* null, i8** %86, align 8
  %87 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 14
  store %struct._IO_FILE* null, %struct._IO_FILE** %87, align 8
  %88 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 15
  store i8* null, i8** %88, align 8
  %89 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %90 = bitcast %struct.opendoor* %72 to i8*
  %91 = call %struct.__pmlist_t* @list_add(%struct.__pmlist_t* %89, i8* %90)
  store %struct.__pmlist_t* %91, %struct.__pmlist_t** @doors, align 8
  br label %.outer

; <label>:92:                                     ; preds = %46, %42
  %93 = call i64 @strlen(i8* %19) #10
  %94 = icmp ne i64 %93, 0
  br i1 %94, label %99, label %95

; <label>:95:                                     ; preds = %92
  %.lcssa17 = phi i32 [ %.lcssa40, %92 ]
  %96 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %97 = getelementptr [58 x i8], [58 x i8]* @.str.57, i32 0, i32 0
  %98 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %96, i8* %97, i32 %.lcssa17)
  br label %._crit_edge

; <label>:99:                                     ; preds = %92
  store i8* %25, i8** %3, align 8
  %100 = call i8* @strsep(i8** %3, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.58, i64 0, i64 0)) #7
  %101 = icmp eq i8* %100, null
  br i1 %101, label %102, label %106

; <label>:102:                                    ; preds = %99
  %.lcssa18 = phi i32 [ %.lcssa40, %99 ]
  %103 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %104 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %105 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %103, i8* %104, i32 %.lcssa18)
  br label %._crit_edge

; <label>:106:                                    ; preds = %99
  %107 = call i8* @trim(i8* %100)
  %108 = call i8* @strtoupper(i8* %100)
  %109 = load i8*, i8** %3, align 8
  %110 = icmp eq i8* %109, null
  br i1 %110, label %111, label %119

; <label>:111:                                    ; preds = %106
  %112 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.60, i64 0, i64 0)) #10
  %113 = icmp ne i32 %112, 0
  br i1 %113, label %115, label %114

; <label>:114:                                    ; preds = %111
  store i32 1, i32* @o_usesyslog, align 4
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.61, i64 0, i64 0))
  br label %.outer

; <label>:115:                                    ; preds = %111
  %.lcssa28 = phi i32 [ %.lcssa40, %111 ]
  %116 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %117 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %118 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %116, i8* %117, i32 %.lcssa28)
  br label %._crit_edge

; <label>:119:                                    ; preds = %106
  %120 = load i8*, i8** %3, align 8
  %121 = call i8* @trim(i8* %120)
  %122 = call i32 @strcmp(i8* %27, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.55, i64 0, i64 0)) #10
  %123 = icmp ne i32 %122, 0
  br i1 %123, label %149, label %124

; <label>:124:                                    ; preds = %119
  %125 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.62, i64 0, i64 0)) #10
  %126 = icmp ne i32 %125, 0
  br i1 %126, label %130, label %127

; <label>:127:                                    ; preds = %124
  %128 = load i8*, i8** %3, align 8
  %129 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_logfile, i64 0, i64 0), i8* %128, i64 99) #7, !track !28
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_logfile, i64 0, i64 99), align 1
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.63, i64 0, i64 0), i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_logfile, i64 0, i64 0))
  br label %._crit_edge47

; <label>:130:                                    ; preds = %124
  %131 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.64, i64 0, i64 0)) #10
  %132 = icmp ne i32 %131, 0
  br i1 %132, label %136, label %133

; <label>:133:                                    ; preds = %130
  %134 = load i8*, i8** %3, align 8
  %135 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_pidfile, i64 0, i64 0), i8* %134, i64 99) #7, !track !29
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_pidfile, i64 0, i64 99), align 1
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.65, i64 0, i64 0), i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_pidfile, i64 0, i64 0))
  br label %._crit_edge47

; <label>:136:                                    ; preds = %130
  %137 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.66, i64 0, i64 0)) #10
  %138 = icmp ne i32 %137, 0
  br i1 %138, label %145, label %139

; <label>:139:                                    ; preds = %136
  %140 = call i64 @strlen(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0)) #10
  %141 = icmp eq i64 %140, 0
  br i1 %141, label %142, label %._crit_edge47

; <label>:142:                                    ; preds = %139
  %143 = load i8*, i8** %3, align 8
  %144 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %143, i64 31) #7, !track !30
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.67, i64 0, i64 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0))
  br label %._crit_edge47

; <label>:145:                                    ; preds = %136
  %.lcssa19 = phi i32 [ %.lcssa40, %136 ]
  %146 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %147 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %148 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %146, i8* %147, i32 %.lcssa19)
  br label %._crit_edge

; <label>:149:                                    ; preds = %119
  %150 = icmp eq %struct.opendoor* %.03.ph48, null
  br i1 %150, label %151, label %155

; <label>:151:                                    ; preds = %149
  %.lcssa20 = phi i32 [ %.lcssa40, %149 ]
  %.lcssa8 = phi i8* [ %108, %149 ]
  %152 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %153 = getelementptr [62 x i8], [62 x i8]* @.str.68, i32 0, i32 0
  %154 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %152, i8* %153, i32 %.lcssa20, i8* %.lcssa8)
  br label %._crit_edge

; <label>:155:                                    ; preds = %149
  %156 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.69, i64 0, i64 0)) #10
  %157 = icmp ne i32 %156, 0
  br i1 %157, label %165, label %158

; <label>:158:                                    ; preds = %155
  %159 = load i8*, i8** %3, align 8
  %160 = call i32 @parse_port_sequence(i8* %159, %struct.opendoor* %.03.ph48)
  %161 = icmp sgt i32 %160, 0
  br i1 %161, label %._crit_edge.loopexit1, label %162

; <label>:162:                                    ; preds = %158
  %163 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %164 = getelementptr inbounds [128 x i8], [128 x i8]* %163, i32 0, i32 0
  call void (%struct.opendoor*, i8*, ...) @dprint_sequence(%struct.opendoor* %.03.ph48, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.70, i64 0, i64 0), i8* %164)
  br label %._crit_edge47

; <label>:165:                                    ; preds = %155
  %166 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.71, i64 0, i64 0)) #10
  %167 = icmp ne i32 %166, 0
  br i1 %167, label %187, label %168

; <label>:168:                                    ; preds = %165
  %169 = load i8*, i8** %3, align 8
  %170 = call %struct._IO_FILE* @fopen(i8* %169, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.72, i64 0, i64 0)), !track !31
  %171 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 14
  store %struct._IO_FILE* %170, %struct._IO_FILE** %171, align 8
  %172 = icmp eq %struct._IO_FILE* %170, null
  br i1 %172, label %173, label %175

; <label>:173:                                    ; preds = %168
  %174 = load i8*, i8** %3, align 8
  call void @perror(i8* %174)
  br label %._crit_edge

; <label>:175:                                    ; preds = %168
  %176 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %177 = getelementptr inbounds [128 x i8], [128 x i8]* %176, i32 0, i32 0
  %178 = load i8*, i8** %3, align 8
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.73, i64 0, i64 0), i8* %177, i8* %178)
  %179 = call i32 @get_new_one_time_sequence(%struct.opendoor* %.03.ph48)
  %180 = icmp eq i32 %179, 0
  br i1 %180, label %181, label %184

; <label>:181:                                    ; preds = %175
  %182 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %183 = getelementptr inbounds [128 x i8], [128 x i8]* %182, i32 0, i32 0
  call void (%struct.opendoor*, i8*, ...) @dprint_sequence(%struct.opendoor* %.03.ph48, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.70, i64 0, i64 0), i8* %183)
  br label %._crit_edge47

; <label>:184:                                    ; preds = %175
  %185 = load i8*, i8** %3, align 8
  %186 = getelementptr [66 x i8], [66 x i8]* @.str.74, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %186, i8* %185)
  br label %._crit_edge

; <label>:187:                                    ; preds = %165
  %188 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.75, i64 0, i64 0)) #10
  %189 = icmp ne i32 %188, 0
  br i1 %189, label %190, label %193

; <label>:190:                                    ; preds = %187
  %191 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.76, i64 0, i64 0)) #10
  %192 = icmp ne i32 %191, 0
  br i1 %192, label %202, label %193

; <label>:193:                                    ; preds = %190, %187
  %194 = load i8*, i8** %3, align 8
  %195 = call i32 @atoi(i8* %194) #10
  %196 = sext i32 %195 to i64
  %197 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 4
  store i64 %196, i64* %197, align 8
  %198 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %199 = getelementptr inbounds [128 x i8], [128 x i8]* %198, i32 0, i32 0
  %200 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 4
  %201 = load i64, i64* %200, align 8
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.77, i64 0, i64 0), i8* %199, i64 %201)
  br label %._crit_edge47

; <label>:202:                                    ; preds = %190
  %203 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.78, i64 0, i64 0)) #10
  %204 = icmp ne i32 %203, 0
  br i1 %204, label %205, label %208

; <label>:205:                                    ; preds = %202
  %206 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.79, i64 0, i64 0)) #10
  %207 = icmp ne i32 %206, 0
  br i1 %207, label %229, label %208

; <label>:208:                                    ; preds = %205, %202
  %209 = load i8*, i8** %3, align 8
  %210 = call i64 @strlen(i8* %209) #10
  %211 = add i64 %210, 1
  %212 = mul i64 1, %211
  %213 = call noalias i8* @malloc(i64 %212) #7, !track !32
  %214 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  store i8* %213, i8** %214, align 8
  %215 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  %216 = load i8*, i8** %215, align 8
  %217 = icmp eq i8* %216, null
  br i1 %217, label %218, label %220

; <label>:218:                                    ; preds = %208
  %219 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %219)
  call void @exit(i32 1) #9
  unreachable

; <label>:220:                                    ; preds = %208
  %221 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  %222 = load i8*, i8** %221, align 8
  %223 = load i8*, i8** %3, align 8
  %224 = call i8* @strcpy(i8* %222, i8* %223) #7, !track !33
  %225 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %226 = getelementptr inbounds [128 x i8], [128 x i8]* %225, i32 0, i32 0
  %227 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  %228 = load i8*, i8** %227, align 8
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.80, i64 0, i64 0), i8* %226, i8* %228)
  br label %._crit_edge47

; <label>:229:                                    ; preds = %205
  %230 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.81, i64 0, i64 0)) #10
  %231 = icmp ne i32 %230, 0
  br i1 %231, label %241, label %232

; <label>:232:                                    ; preds = %229
  %233 = load i8*, i8** %3, align 8
  %234 = call i32 @atoi(i8* %233) #10
  %235 = sext i32 %234 to i64
  %236 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 6
  store i64 %235, i64* %236, align 8
  %237 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %238 = getelementptr inbounds [128 x i8], [128 x i8]* %237, i32 0, i32 0
  %239 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 6
  %240 = load i64, i64* %239, align 8
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.82, i64 0, i64 0), i8* %238, i64 %240)
  br label %._crit_edge47

; <label>:241:                                    ; preds = %229
  %242 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.83, i64 0, i64 0)) #10
  %243 = icmp ne i32 %242, 0
  br i1 %243, label %265, label %244

; <label>:244:                                    ; preds = %241
  %245 = load i8*, i8** %3, align 8
  %246 = call i64 @strlen(i8* %245) #10
  %247 = add i64 %246, 1
  %248 = mul i64 1, %247
  %249 = call noalias i8* @malloc(i64 %248) #7, !track !34
  %250 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  store i8* %249, i8** %250, align 8
  %251 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  %252 = load i8*, i8** %251, align 8
  %253 = icmp eq i8* %252, null
  br i1 %253, label %254, label %256

; <label>:254:                                    ; preds = %244
  %255 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %255)
  call void @exit(i32 1) #9
  unreachable

; <label>:256:                                    ; preds = %244
  %257 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  %258 = load i8*, i8** %257, align 8
  %259 = load i8*, i8** %3, align 8
  %260 = call i8* @strcpy(i8* %258, i8* %259) #7, !track !35
  %261 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %262 = getelementptr inbounds [128 x i8], [128 x i8]* %261, i32 0, i32 0
  %263 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  %264 = load i8*, i8** %263, align 8
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.84, i64 0, i64 0), i8* %262, i8* %264)
  br label %._crit_edge47

; <label>:265:                                    ; preds = %241
  %266 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.85, i64 0, i64 0)) #10
  %267 = icmp ne i32 %266, 0
  br i1 %267, label %340, label %268

; <label>:268:                                    ; preds = %265
  %269 = load i8*, i8** %3, align 8
  %270 = call i8* @strtoupper(i8* %269)
  %271 = call i8* @strsep(i8** %3, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.86, i64 0, i64 0)) #7
  %272 = icmp ne i8* %271, null
  br i1 %272, label %.lr.ph46.preheader, label %._crit_edge47

.lr.ph46.preheader:                               ; preds = %268
  %273 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 8
  %274 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 8
  %275 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 9
  %276 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 9
  %277 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 10
  %278 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 10
  %279 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 11
  %280 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 11
  %281 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 12
  %282 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 12
  %283 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 13
  %284 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 13
  br label %.lr.ph46

.lr.ph46:                                         ; preds = %.lr.ph46.preheader, %337
  %285 = phi i8* [ %338, %337 ], [ %271, %.lr.ph46.preheader ]
  %286 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.87, i64 0, i64 0)) #10
  %287 = icmp ne i32 %286, 0
  br i1 %287, label %289, label %288

; <label>:288:                                    ; preds = %.lr.ph46
  store i32 1, i32* %273, align 8
  br label %337

; <label>:289:                                    ; preds = %.lr.ph46
  %290 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.88, i64 0, i64 0)) #10
  %291 = icmp ne i32 %290, 0
  br i1 %291, label %293, label %292

; <label>:292:                                    ; preds = %289
  store i32 2, i32* %274, align 8
  br label %337

; <label>:293:                                    ; preds = %289
  %294 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.89, i64 0, i64 0)) #10
  %295 = icmp ne i32 %294, 0
  br i1 %295, label %297, label %296

; <label>:296:                                    ; preds = %293
  store i32 1, i32* %275, align 4
  br label %337

; <label>:297:                                    ; preds = %293
  %298 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.90, i64 0, i64 0)) #10
  %299 = icmp ne i32 %298, 0
  br i1 %299, label %301, label %300

; <label>:300:                                    ; preds = %297
  store i32 2, i32* %276, align 4
  br label %337

; <label>:301:                                    ; preds = %297
  %302 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.91, i64 0, i64 0)) #10
  %303 = icmp ne i32 %302, 0
  br i1 %303, label %305, label %304

; <label>:304:                                    ; preds = %301
  store i32 1, i32* %277, align 8
  br label %337

; <label>:305:                                    ; preds = %301
  %306 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.92, i64 0, i64 0)) #10
  %307 = icmp ne i32 %306, 0
  br i1 %307, label %309, label %308

; <label>:308:                                    ; preds = %305
  store i32 2, i32* %278, align 8
  br label %337

; <label>:309:                                    ; preds = %305
  %310 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.93, i64 0, i64 0)) #10
  %311 = icmp ne i32 %310, 0
  br i1 %311, label %313, label %312

; <label>:312:                                    ; preds = %309
  store i32 1, i32* %279, align 4
  br label %337

; <label>:313:                                    ; preds = %309
  %314 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.94, i64 0, i64 0)) #10
  %315 = icmp ne i32 %314, 0
  br i1 %315, label %317, label %316

; <label>:316:                                    ; preds = %313
  store i32 2, i32* %280, align 4
  br label %337

; <label>:317:                                    ; preds = %313
  %318 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.95, i64 0, i64 0)) #10
  %319 = icmp ne i32 %318, 0
  br i1 %319, label %321, label %320

; <label>:320:                                    ; preds = %317
  store i32 1, i32* %281, align 8
  br label %337

; <label>:321:                                    ; preds = %317
  %322 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.96, i64 0, i64 0)) #10
  %323 = icmp ne i32 %322, 0
  br i1 %323, label %325, label %324

; <label>:324:                                    ; preds = %321
  store i32 2, i32* %282, align 8
  br label %337

; <label>:325:                                    ; preds = %321
  %326 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.97, i64 0, i64 0)) #10
  %327 = icmp ne i32 %326, 0
  br i1 %327, label %329, label %328

; <label>:328:                                    ; preds = %325
  store i32 1, i32* %283, align 4
  br label %337

; <label>:329:                                    ; preds = %325
  %330 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.98, i64 0, i64 0)) #10
  %331 = icmp ne i32 %330, 0
  br i1 %331, label %333, label %332

; <label>:332:                                    ; preds = %329
  store i32 2, i32* %284, align 4
  br label %337

; <label>:333:                                    ; preds = %329
  %.lcssa27 = phi i32 [ %.lcssa40, %329 ]
  %.lcssa5 = phi i8* [ %285, %329 ]
  %334 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %335 = getelementptr [41 x i8], [41 x i8]* @.str.99, i32 0, i32 0
  %336 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %334, i8* %335, i32 %.lcssa27, i8* %.lcssa5)
  br label %._crit_edge

; <label>:337:                                    ; preds = %292, %300, %308, %316, %324, %332, %328, %320, %312, %304, %296, %288
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.100, i64 0, i64 0), i8* %285)
  %338 = call i8* @strsep(i8** %3, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.86, i64 0, i64 0)) #7
  %339 = icmp ne i8* %338, null
  br i1 %339, label %.lr.ph46, label %._crit_edge47.loopexit

; <label>:340:                                    ; preds = %265
  %.lcssa26 = phi i32 [ %.lcssa40, %265 ]
  %341 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %342 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %343 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %341, i8* %342, i32 %.lcssa26)
  br label %._crit_edge

._crit_edge47.loopexit:                           ; preds = %337
  br label %._crit_edge47

._crit_edge47:                                    ; preds = %._crit_edge47.loopexit, %162, %193, %232, %268, %256, %220, %181, %127, %142, %139, %133
  %.0333 = phi %struct.opendoor* [ %.03.ph48, %133 ], [ %.03.ph48, %139 ], [ %.03.ph48, %142 ], [ %.03.ph48, %127 ], [ %.03.ph48, %162 ], [ %.03.ph48, %181 ], [ %.03.ph48, %193 ], [ %.03.ph48, %220 ], [ %.03.ph48, %232 ], [ %.03.ph48, %256 ], [ %.03.ph48, %268 ], [ %.03.ph48, %._crit_edge47.loopexit ]
  store i8 0, i8* %29, align 16
  br label %.outer

.outer:                                           ; preds = %114, %._crit_edge47, %67, %76
  %.2 = phi %struct.opendoor* [ %72, %76 ], [ %.03.ph48, %67 ], [ %.0333, %._crit_edge47 ], [ %.03.ph48, %114 ]
  %344 = call i8* @fgets(i8* %11, i32 100, %struct._IO_FILE* %7), !track !36
  %345 = icmp ne i8* %344, null
  br i1 %345, label %.lr.ph43, label %.outer._crit_edge.loopexit3

.outer._crit_edge.loopexit:                       ; preds = %39
  br label %.outer._crit_edge

.outer._crit_edge.loopexit3:                      ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit3, %.outer._crit_edge.loopexit, %10
  %346 = call i32 @fclose(%struct._IO_FILE* %7)
  %347 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %348 = icmp ne %struct.__pmlist_t* %347, null
  br i1 %348, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %.outer._crit_edge
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %363
  %.0141 = phi %struct.__pmlist_t* [ %365, %363 ], [ %347, %.lr.ph.preheader ]
  %349 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.0141, i32 0, i32 0
  %350 = load i8*, i8** %349, align 8
  %351 = bitcast i8* %350 to %struct.opendoor*
  %352 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %351, i32 0, i32 1
  %353 = load i16, i16* %352, align 8
  %354 = zext i16 %353 to i32
  %355 = icmp eq i32 %354, 0
  br i1 %355, label %356, label %363

; <label>:356:                                    ; preds = %.lr.ph
  %.lcssa4 = phi i8* [ %350, %.lr.ph ]
  %357 = bitcast i8* %.lcssa4 to %struct.opendoor*
  %358 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %359 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %357, i32 0, i32 0
  %360 = getelementptr inbounds [128 x i8], [128 x i8]* %359, i32 0, i32 0
  %361 = getelementptr [49 x i8], [49 x i8]* @.str.101, i32 0, i32 0
  %362 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %358, i8* %361, i8* %360)
  br label %._crit_edge

; <label>:363:                                    ; preds = %.lr.ph
  %364 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.0141, i32 0, i32 2
  %365 = load %struct.__pmlist_t*, %struct.__pmlist_t** %364, align 8
  %366 = icmp ne %struct.__pmlist_t* %365, null
  br i1 %366, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %363
  %.0.ph = phi i32 [ 0, %363 ]
  br label %._crit_edge

._crit_edge.loopexit1:                            ; preds = %158
  %.0.ph2 = phi i32 [ %160, %158 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit1, %._crit_edge.loopexit, %.outer._crit_edge, %356, %340, %333, %184, %173, %151, %145, %115, %102, %95, %63, %9
  %.0 = phi i32 [ 1, %9 ], [ 1, %63 ], [ 1, %102 ], [ 1, %115 ], [ 1, %151 ], [ 1, %340 ], [ 1, %333 ], [ 1, %173 ], [ 1, %184 ], [ 1, %145 ], [ 1, %95 ], [ 1, %356 ], [ 0, %.outer._crit_edge ], [ %.0.ph, %._crit_edge.loopexit ], [ %.0.ph2, %._crit_edge.loopexit1 ]
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
  %6 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %7 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %8 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %9 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  br label %.lr.ph51

.lr.ph51:                                         ; preds = %.lr.ph51.preheader, %215
  %.049 = phi %struct.__pmlist_t* [ %217, %215 ], [ %4, %.lr.ph51.preheader ]
  %.0148 = phi i64 [ %.30, %215 ], [ 0, %.lr.ph51.preheader ]
  %.02347 = phi i16 [ %.124, %215 ], [ 0, %.lr.ph51.preheader ]
  %10 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.049, i32 0, i32 0
  %11 = load i8*, i8** %10, align 8
  %12 = bitcast i8* %11 to %struct.opendoor*
  %13 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 15
  %14 = load i8*, i8** %13, align 8
  %15 = icmp ne i8* %14, null
  br i1 %15, label %215, label %16

; <label>:16:                                     ; preds = %.lr.ph51
  %17 = load i8*, i8** %1, align 8
  %18 = icmp eq i8* %17, null
  br i1 %18, label %19, label %27

; <label>:19:                                     ; preds = %16
  %20 = call noalias i8* @malloc(i64 200) #7, !track !43
  store i8* %20, i8** %1, align 8
  %21 = load i8*, i8** %1, align 8
  %22 = icmp eq i8* %21, null
  br i1 %22, label %23, label %24

; <label>:23:                                     ; preds = %19
  call void @perror(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.56, i64 0, i64 0))
  call void @cleanup(i32 1)
  br label %24

; <label>:24:                                     ; preds = %23, %19
  %25 = load i8*, i8** %1, align 8
  %26 = getelementptr inbounds i8, i8* %25, i64 0
  store i8 0, i8* %26, align 1
  br label %27

; <label>:27:                                     ; preds = %24, %16
  %.12 = phi i64 [ 200, %24 ], [ %.0148, %16 ]
  %28 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 1
  %29 = load i16, i16* %28, align 8
  %30 = zext i16 %29 to i32
  %31 = icmp ult i32 0, %30
  br i1 %31, label %.lr.ph32.preheader, label %._crit_edge33

.lr.ph32.preheader:                               ; preds = %27
  %scevgep = getelementptr i8, i8* %11, i64 194
  br label %.lr.ph32

.lr.ph32:                                         ; preds = %.lr.ph32.preheader, %48
  %indvars.iv = phi i64 [ %indvars.iv.next, %48 ], [ 0, %.lr.ph32.preheader ]
  %.230 = phi i64 [ %.4, %48 ], [ %.12, %.lr.ph32.preheader ]
  %.0429 = phi i16 [ %.211, %48 ], [ 0, %.lr.ph32.preheader ]
  %.01528 = phi i16 [ %.217, %48 ], [ 0, %.lr.ph32.preheader ]
  %32 = shl i64 %indvars.iv, 1
  %scevgep1 = getelementptr i8, i8* %scevgep, i64 %32
  %scevgep12 = bitcast i8* %scevgep1 to i16*
  %33 = load i16, i16* %scevgep12, align 2
  %34 = zext i16 %33 to i32
  %35 = icmp eq i32 %34, 6
  br i1 %35, label %36, label %48

; <label>:36:                                     ; preds = %.lr.ph32
  %37 = icmp ne i16 %.0429, 0
  br i1 %37, label %40, label %38

; <label>:38:                                     ; preds = %36
  %39 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.112, i64 0, i64 0), i64 %.230)
  br label %42

; <label>:40:                                     ; preds = %36
  %41 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.113, i64 0, i64 0), i64 %.230)
  br label %42

; <label>:42:                                     ; preds = %40, %38
  %.116 = phi i16 [ %.01528, %40 ], [ 1, %38 ]
  %.110 = phi i16 [ %.0429, %40 ], [ 1, %38 ]
  %.3 = phi i64 [ %41, %40 ], [ %39, %38 ]
  %43 = shl i64 %indvars.iv, 1
  %scevgep3 = getelementptr i8, i8* %scevgep, i64 %43
  %scevgep34 = bitcast i8* %scevgep3 to i16*
  %scevgep5 = getelementptr i16, i16* %scevgep34, i64 -32
  %44 = load i16, i16* %scevgep5, align 2
  %45 = zext i16 %44 to i32
  %46 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %6, i64 10, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.114, i64 0, i64 0), i32 %45) #7
  %47 = call i64 @realloc_strcat(i8** %1, i8* %7, i64 %.3)
  br label %48

; <label>:48:                                     ; preds = %.lr.ph32, %42
  %.217 = phi i16 [ %.116, %42 ], [ %.01528, %.lr.ph32 ]
  %.211 = phi i16 [ %.110, %42 ], [ %.0429, %.lr.ph32 ]
  %.4 = phi i64 [ %47, %42 ], [ %.230, %.lr.ph32 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %49 = load i16, i16* %28, align 8
  %50 = zext i16 %49 to i32
  %51 = zext i32 %50 to i64
  %52 = icmp ult i64 %indvars.iv.next, %51
  br i1 %52, label %.lr.ph32, label %._crit_edge33.loopexit

._crit_edge33.loopexit:                           ; preds = %48
  %.015.lcssa.ph = phi i16 [ %.217, %48 ]
  %.2.lcssa.ph = phi i64 [ %.4, %48 ]
  br label %._crit_edge33

._crit_edge33:                                    ; preds = %._crit_edge33.loopexit, %27
  %.015.lcssa = phi i16 [ 0, %27 ], [ %.015.lcssa.ph, %._crit_edge33.loopexit ]
  %.2.lcssa = phi i64 [ %.12, %27 ], [ %.2.lcssa.ph, %._crit_edge33.loopexit ]
  %53 = icmp ne i16 %.015.lcssa, 0
  br i1 %53, label %54, label %56

; <label>:54:                                     ; preds = %._crit_edge33
  %55 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.115, i64 0, i64 0), i64 %.2.lcssa)
  br label %56

; <label>:56:                                     ; preds = %54, %._crit_edge33
  %.5 = phi i64 [ %55, %54 ], [ %.2.lcssa, %._crit_edge33 ]
  %57 = icmp ne i16 %.015.lcssa, 0
  br i1 %57, label %58, label %162

; <label>:58:                                     ; preds = %56
  %59 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 8
  %60 = load i32, i32* %59, align 8
  %61 = icmp ne i32 %60, 0
  br i1 %61, label %62, label %75

; <label>:62:                                     ; preds = %58
  %63 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.116, i64 0, i64 0), i64 %.5)
  %64 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 8
  %65 = load i32, i32* %64, align 8
  %66 = icmp eq i32 %65, 1
  br i1 %66, label %67, label %69

; <label>:67:                                     ; preds = %62
  %68 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.117, i64 0, i64 0), i64 %63)
  br label %69

; <label>:69:                                     ; preds = %67, %62
  %.6 = phi i64 [ %68, %67 ], [ %63, %62 ]
  %70 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 8
  %71 = load i32, i32* %70, align 8
  %72 = icmp eq i32 %71, 2
  br i1 %72, label %73, label %75

; <label>:73:                                     ; preds = %69
  %74 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.118, i64 0, i64 0), i64 %.6)
  br label %75

; <label>:75:                                     ; preds = %69, %73, %58
  %.8 = phi i64 [ %.5, %58 ], [ %74, %73 ], [ %.6, %69 ]
  %76 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 9
  %77 = load i32, i32* %76, align 4
  %78 = icmp ne i32 %77, 0
  br i1 %78, label %79, label %92

; <label>:79:                                     ; preds = %75
  %80 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.119, i64 0, i64 0), i64 %.8)
  %81 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 9
  %82 = load i32, i32* %81, align 4
  %83 = icmp eq i32 %82, 1
  br i1 %83, label %84, label %86

; <label>:84:                                     ; preds = %79
  %85 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.117, i64 0, i64 0), i64 %80)
  br label %86

; <label>:86:                                     ; preds = %84, %79
  %.9 = phi i64 [ %85, %84 ], [ %80, %79 ]
  %87 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 9
  %88 = load i32, i32* %87, align 4
  %89 = icmp eq i32 %88, 2
  br i1 %89, label %90, label %92

; <label>:90:                                     ; preds = %86
  %91 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.118, i64 0, i64 0), i64 %.9)
  br label %92

; <label>:92:                                     ; preds = %86, %90, %75
  %.11 = phi i64 [ %.8, %75 ], [ %91, %90 ], [ %.9, %86 ]
  %93 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 10
  %94 = load i32, i32* %93, align 8
  %95 = icmp ne i32 %94, 0
  br i1 %95, label %96, label %109

; <label>:96:                                     ; preds = %92
  %97 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.120, i64 0, i64 0), i64 %.11)
  %98 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 10
  %99 = load i32, i32* %98, align 8
  %100 = icmp eq i32 %99, 1
  br i1 %100, label %101, label %103

; <label>:101:                                    ; preds = %96
  %102 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.117, i64 0, i64 0), i64 %97)
  br label %103

; <label>:103:                                    ; preds = %101, %96
  %.123 = phi i64 [ %102, %101 ], [ %97, %96 ]
  %104 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 10
  %105 = load i32, i32* %104, align 8
  %106 = icmp eq i32 %105, 2
  br i1 %106, label %107, label %109

; <label>:107:                                    ; preds = %103
  %108 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.118, i64 0, i64 0), i64 %.123)
  br label %109

; <label>:109:                                    ; preds = %103, %107, %92
  %.14 = phi i64 [ %.11, %92 ], [ %108, %107 ], [ %.123, %103 ]
  %110 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 11
  %111 = load i32, i32* %110, align 4
  %112 = icmp ne i32 %111, 0
  br i1 %112, label %113, label %126

; <label>:113:                                    ; preds = %109
  %114 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.121, i64 0, i64 0), i64 %.14)
  %115 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 11
  %116 = load i32, i32* %115, align 4
  %117 = icmp eq i32 %116, 1
  br i1 %117, label %118, label %120

; <label>:118:                                    ; preds = %113
  %119 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.117, i64 0, i64 0), i64 %114)
  br label %120

; <label>:120:                                    ; preds = %118, %113
  %.15 = phi i64 [ %119, %118 ], [ %114, %113 ]
  %121 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 11
  %122 = load i32, i32* %121, align 4
  %123 = icmp eq i32 %122, 2
  br i1 %123, label %124, label %126

; <label>:124:                                    ; preds = %120
  %125 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.118, i64 0, i64 0), i64 %.15)
  br label %126

; <label>:126:                                    ; preds = %120, %124, %109
  %.17 = phi i64 [ %.14, %109 ], [ %125, %124 ], [ %.15, %120 ]
  %127 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 12
  %128 = load i32, i32* %127, align 8
  %129 = icmp ne i32 %128, 0
  br i1 %129, label %130, label %143

; <label>:130:                                    ; preds = %126
  %131 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.122, i64 0, i64 0), i64 %.17)
  %132 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 12
  %133 = load i32, i32* %132, align 8
  %134 = icmp eq i32 %133, 1
  br i1 %134, label %135, label %137

; <label>:135:                                    ; preds = %130
  %136 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.117, i64 0, i64 0), i64 %131)
  br label %137

; <label>:137:                                    ; preds = %135, %130
  %.18 = phi i64 [ %136, %135 ], [ %131, %130 ]
  %138 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 12
  %139 = load i32, i32* %138, align 8
  %140 = icmp eq i32 %139, 2
  br i1 %140, label %141, label %143

; <label>:141:                                    ; preds = %137
  %142 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.118, i64 0, i64 0), i64 %.18)
  br label %143

; <label>:143:                                    ; preds = %137, %141, %126
  %.20 = phi i64 [ %.17, %126 ], [ %142, %141 ], [ %.18, %137 ]
  %144 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 13
  %145 = load i32, i32* %144, align 4
  %146 = icmp ne i32 %145, 0
  br i1 %146, label %147, label %160

; <label>:147:                                    ; preds = %143
  %148 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.123, i64 0, i64 0), i64 %.20)
  %149 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 13
  %150 = load i32, i32* %149, align 4
  %151 = icmp eq i32 %150, 1
  br i1 %151, label %152, label %154

; <label>:152:                                    ; preds = %147
  %153 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.117, i64 0, i64 0), i64 %148)
  br label %154

; <label>:154:                                    ; preds = %152, %147
  %.21 = phi i64 [ %153, %152 ], [ %148, %147 ]
  %155 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 13
  %156 = load i32, i32* %155, align 4
  %157 = icmp eq i32 %156, 2
  br i1 %157, label %158, label %160

; <label>:158:                                    ; preds = %154
  %159 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.118, i64 0, i64 0), i64 %.21)
  br label %160

; <label>:160:                                    ; preds = %154, %158, %143
  %.23 = phi i64 [ %.20, %143 ], [ %159, %158 ], [ %.21, %154 ]
  %161 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.115, i64 0, i64 0), i64 %.23)
  br label %162

; <label>:162:                                    ; preds = %160, %56
  %.24 = phi i64 [ %161, %160 ], [ %.5, %56 ]
  %163 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 1
  %164 = load i16, i16* %163, align 8
  %165 = zext i16 %164 to i32
  %166 = icmp ult i32 0, %165
  br i1 %166, label %.lr.ph41.preheader, label %._crit_edge42

.lr.ph41.preheader:                               ; preds = %162
  %167 = icmp ne i16 %.015.lcssa, 0
  %scevgep6 = getelementptr i8, i8* %11, i64 194
  br label %.lr.ph41

.lr.ph41:                                         ; preds = %.lr.ph41.preheader, %187
  %indvars.iv45 = phi i64 [ %indvars.iv.next46, %187 ], [ 0, %.lr.ph41.preheader ]
  %.2539 = phi i64 [ %.28, %187 ], [ %.24, %.lr.ph41.preheader ]
  %.31238 = phi i16 [ %.514, %187 ], [ 0, %.lr.ph41.preheader ]
  %.01837 = phi i16 [ %.220, %187 ], [ 0, %.lr.ph41.preheader ]
  %168 = shl i64 %indvars.iv45, 1
  %scevgep7 = getelementptr i8, i8* %scevgep6, i64 %168
  %scevgep78 = bitcast i8* %scevgep7 to i16*
  %169 = load i16, i16* %scevgep78, align 2
  %170 = zext i16 %169 to i32
  %171 = icmp eq i32 %170, 17
  br i1 %171, label %172, label %187

; <label>:172:                                    ; preds = %.lr.ph41
  %173 = icmp ne i16 %.31238, 0
  br i1 %173, label %179, label %174

; <label>:174:                                    ; preds = %172
  br i1 %167, label %175, label %177

; <label>:175:                                    ; preds = %174
  %176 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.113, i64 0, i64 0), i64 %.2539)
  br label %177

; <label>:177:                                    ; preds = %175, %174
  %.26 = phi i64 [ %176, %175 ], [ %.2539, %174 ]
  %178 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.124, i64 0, i64 0), i64 %.26)
  br label %181

; <label>:179:                                    ; preds = %172
  %180 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.113, i64 0, i64 0), i64 %.2539)
  br label %181

; <label>:181:                                    ; preds = %179, %177
  %.119 = phi i16 [ %.01837, %179 ], [ 1, %177 ]
  %.413 = phi i16 [ %.31238, %179 ], [ 1, %177 ]
  %.27 = phi i64 [ %180, %179 ], [ %178, %177 ]
  %182 = shl i64 %indvars.iv45, 1
  %scevgep9 = getelementptr i8, i8* %scevgep6, i64 %182
  %scevgep910 = bitcast i8* %scevgep9 to i16*
  %scevgep11 = getelementptr i16, i16* %scevgep910, i64 -32
  %183 = load i16, i16* %scevgep11, align 2
  %184 = zext i16 %183 to i32
  %185 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %8, i64 10, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.114, i64 0, i64 0), i32 %184) #7
  %186 = call i64 @realloc_strcat(i8** %1, i8* %9, i64 %.27)
  br label %187

; <label>:187:                                    ; preds = %.lr.ph41, %181
  %.220 = phi i16 [ %.119, %181 ], [ %.01837, %.lr.ph41 ]
  %.514 = phi i16 [ %.413, %181 ], [ %.31238, %.lr.ph41 ]
  %.28 = phi i64 [ %186, %181 ], [ %.2539, %.lr.ph41 ]
  %indvars.iv.next46 = add nuw nsw i64 %indvars.iv45, 1
  %188 = load i16, i16* %163, align 8
  %189 = zext i16 %188 to i32
  %190 = zext i32 %189 to i64
  %191 = icmp ult i64 %indvars.iv.next46, %190
  br i1 %191, label %.lr.ph41, label %._crit_edge42.loopexit

._crit_edge42.loopexit:                           ; preds = %187
  %.018.lcssa.ph = phi i16 [ %.220, %187 ]
  %.25.lcssa.ph = phi i64 [ %.28, %187 ]
  br label %._crit_edge42

._crit_edge42:                                    ; preds = %._crit_edge42.loopexit, %162
  %.018.lcssa = phi i16 [ 0, %162 ], [ %.018.lcssa.ph, %._crit_edge42.loopexit ]
  %.25.lcssa = phi i64 [ %.24, %162 ], [ %.25.lcssa.ph, %._crit_edge42.loopexit ]
  %192 = icmp ne i16 %.018.lcssa, 0
  br i1 %192, label %193, label %195

; <label>:193:                                    ; preds = %._crit_edge42
  %194 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.115, i64 0, i64 0), i64 %.25.lcssa)
  br label %195

; <label>:195:                                    ; preds = %193, %._crit_edge42
  %.29 = phi i64 [ %194, %193 ], [ %.25.lcssa, %._crit_edge42 ]
  %196 = icmp eq i64 %.29, 0
  br i1 %196, label %197, label %198

; <label>:197:                                    ; preds = %195
  call void @perror(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.125, i64 0, i64 0))
  call void @cleanup(i32 1)
  br label %198

; <label>:198:                                    ; preds = %197, %195
  %199 = load i8*, i8** %1, align 8
  %200 = call i64 @strlen(i8* %199) #10
  %201 = add i64 %200, 1
  %202 = call noalias i8* @malloc(i64 %201) #7, !track !44
  %203 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 15
  store i8* %202, i8** %203, align 8
  %204 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 15
  %205 = load i8*, i8** %204, align 8
  %206 = icmp eq i8* %205, null
  br i1 %206, label %207, label %208

; <label>:207:                                    ; preds = %198
  call void @perror(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.56, i64 0, i64 0))
  call void @cleanup(i32 1)
  br label %208

; <label>:208:                                    ; preds = %207, %198
  %209 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 15
  %210 = load i8*, i8** %209, align 8
  %211 = load i8*, i8** %1, align 8
  %212 = call i8* @strcpy(i8* %210, i8* %211) #7, !track !45
  %213 = load i8*, i8** %1, align 8
  %214 = getelementptr inbounds i8, i8* %213, i64 0
  store i8 0, i8* %214, align 1
  br label %215

; <label>:215:                                    ; preds = %.lr.ph51, %208
  %.124 = phi i16 [ 1, %208 ], [ %.02347, %.lr.ph51 ]
  %.30 = phi i64 [ %.29, %208 ], [ %.0148, %.lr.ph51 ]
  %216 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.049, i32 0, i32 2
  %217 = load %struct.__pmlist_t*, %struct.__pmlist_t** %216, align 8
  %218 = icmp ne %struct.__pmlist_t* %217, null
  br i1 %218, label %.lr.ph51, label %._crit_edge52.loopexit

._crit_edge52.loopexit:                           ; preds = %215
  %.023.lcssa.ph = phi i16 [ %.124, %215 ]
  %.01.lcssa.ph = phi i64 [ %.30, %215 ]
  br label %._crit_edge52

._crit_edge52:                                    ; preds = %._crit_edge52.loopexit, %0
  %.023.lcssa = phi i16 [ 0, %0 ], [ %.023.lcssa.ph, %._crit_edge52.loopexit ]
  %.01.lcssa = phi i64 [ 0, %0 ], [ %.01.lcssa.ph, %._crit_edge52.loopexit ]
  %219 = icmp ne i16 %.023.lcssa, 0
  br i1 %219, label %220, label %266

; <label>:220:                                    ; preds = %._crit_edge52
  %221 = getelementptr [10 x i8], [10 x i8]* @.str.126, i32 0, i32 0
  %222 = call i64 @realloc_strcat(i8** %1, i8* %221, i64 %.01.lcssa)
  %223 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %224 = call i64 @realloc_strcat(i8** %1, i8* %223, i64 %222)
  %225 = getelementptr [7 x i8], [7 x i8]* @.str.127, i32 0, i32 0
  %226 = call i64 @realloc_strcat(i8** %1, i8* %225, i64 %224)
  %227 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %228 = icmp ne %struct.__pmlist_t* %227, null
  br i1 %228, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %220
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %240
  %.126 = phi %struct.__pmlist_t* [ %242, %240 ], [ %227, %.lr.ph.preheader ]
  %.3125 = phi i64 [ %.32, %240 ], [ %226, %.lr.ph.preheader ]
  %229 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.126, i32 0, i32 0
  %230 = load i8*, i8** %229, align 8
  %231 = bitcast i8* %230 to %struct.opendoor*
  %232 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %231, i32 0, i32 15
  %233 = load i8*, i8** %232, align 8
  %234 = call i64 @realloc_strcat(i8** %1, i8* %233, i64 %.3125)
  %235 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.126, i32 0, i32 2
  %236 = load %struct.__pmlist_t*, %struct.__pmlist_t** %235, align 8
  %237 = icmp ne %struct.__pmlist_t* %236, null
  br i1 %237, label %238, label %240

; <label>:238:                                    ; preds = %.lr.ph
  %239 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.113, i64 0, i64 0), i64 %234)
  br label %240

; <label>:240:                                    ; preds = %.lr.ph, %238
  %.32 = phi i64 [ %239, %238 ], [ %234, %.lr.ph ]
  %241 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.126, i32 0, i32 2
  %242 = load %struct.__pmlist_t*, %struct.__pmlist_t** %241, align 8
  %243 = icmp ne %struct.__pmlist_t* %242, null
  br i1 %243, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %240
  %.31.lcssa.ph = phi i64 [ %.32, %240 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %220
  %.31.lcssa = phi i64 [ %226, %220 ], [ %.31.lcssa.ph, %._crit_edge.loopexit ]
  %244 = getelementptr [2 x i8], [2 x i8]* @.str.115, i32 0, i32 0
  %245 = call i64 @realloc_strcat(i8** %1, i8* %244, i64 %.31.lcssa)
  %246 = icmp eq i64 %245, 0
  br i1 %246, label %247, label %249

; <label>:247:                                    ; preds = %._crit_edge
  %248 = getelementptr [8 x i8], [8 x i8]* @.str.125, i32 0, i32 0
  call void @perror(i8* %248)
  call void @cleanup(i32 1)
  br label %249

; <label>:249:                                    ; preds = %247, %._crit_edge
  %250 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %251 = load i8*, i8** %1, align 8
  %252 = call i32 @pcap_compile(%struct.pcap* %250, %struct.bpf_program* %3, i8* %251, i32 1, i32 0)
  %253 = icmp slt i32 %252, 0
  br i1 %253, label %254, label %257

; <label>:254:                                    ; preds = %249
  %255 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %256 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %255, i8* %256)
  call void @cleanup(i32 1)
  br label %257

; <label>:257:                                    ; preds = %254, %249
  %258 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %259 = call i32 @pcap_setfilter(%struct.pcap* %258, %struct.bpf_program* %3)
  %260 = icmp slt i32 %259, 0
  br i1 %260, label %261, label %264

; <label>:261:                                    ; preds = %257
  %262 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %263 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %262, i8* %263)
  call void @cleanup(i32 1)
  br label %264

; <label>:264:                                    ; preds = %261, %257
  call void @pcap_freecode(%struct.bpf_program* %3)
  %265 = load i8*, i8** %1, align 8
  call void @free(i8* %265) #7
  br label %266

; <label>:266:                                    ; preds = %264, %._crit_edge52
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

.lr.ph30:                                         ; preds = %.lr.ph30.preheader, %288
  %.02028 = phi %struct.__pmlist_t* [ %290, %288 ], [ %173, %.lr.ph30.preheader ]
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
  br i1 %186, label %187, label %190

; <label>:187:                                    ; preds = %.lr.ph30
  %188 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 2
  %189 = getelementptr inbounds [16 x i8], [16 x i8]* %188, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.142, i64 0, i64 0), i8* %189)
  br label %190

; <label>:190:                                    ; preds = %187, %.lr.ph30
  %.01 = phi i32 [ 1, %187 ], [ 0, %.lr.ph30 ]
  %191 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 1
  %192 = load i16, i16* %191, align 8
  %193 = sext i16 %192 to i32
  %194 = icmp slt i32 %193, 0
  br i1 %194, label %195, label %198

; <label>:195:                                    ; preds = %190
  %196 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 2
  %197 = getelementptr inbounds [16 x i8], [16 x i8]* %196, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.143, i64 0, i64 0), i8* %197)
  br label %198

; <label>:198:                                    ; preds = %195, %190
  %.19 = phi i32 [ 1, %195 ], [ %.01, %190 ]
  %199 = icmp ne i32 %.19, 0
  br i1 %199, label %254, label %200

; <label>:200:                                    ; preds = %198
  %201 = load i64, i64* %8, align 8
  %202 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 4
  %203 = load i64, i64* %202, align 8
  %204 = sub nsw i64 %201, %203
  %205 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 0
  %206 = load %struct.opendoor*, %struct.opendoor** %205, align 8
  %207 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %206, i32 0, i32 4
  %208 = load i64, i64* %207, align 8
  %209 = icmp sge i64 %204, %208
  br i1 %209, label %210, label %254

; <label>:210:                                    ; preds = %200
  %211 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 3
  %212 = load i8*, i8** %211, align 8
  %213 = icmp ne i8* %212, null
  %214 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 2
  %215 = getelementptr inbounds [16 x i8], [16 x i8]* %214, i32 0, i32 0
  br i1 %213, label %216, label %237

; <label>:216:                                    ; preds = %210
  %217 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 3
  %218 = load i8*, i8** %217, align 8
  %219 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 0
  %220 = load %struct.opendoor*, %struct.opendoor** %219, align 8
  %221 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %220, i32 0, i32 0
  %222 = getelementptr inbounds [128 x i8], [128 x i8]* %221, i32 0, i32 0
  %223 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 1
  %224 = load i16, i16* %223, align 8
  %225 = sext i16 %224 to i32
  call void (i8*, ...) @vprint(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.144, i64 0, i64 0), i8* %215, i8* %218, i8* %222, i32 %225)
  %226 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 2
  %227 = getelementptr inbounds [16 x i8], [16 x i8]* %226, i32 0, i32 0
  %228 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 3
  %229 = load i8*, i8** %228, align 8
  %230 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 0
  %231 = load %struct.opendoor*, %struct.opendoor** %230, align 8
  %232 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %231, i32 0, i32 0
  %233 = getelementptr inbounds [128 x i8], [128 x i8]* %232, i32 0, i32 0
  %234 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 1
  %235 = load i16, i16* %234, align 8
  %236 = sext i16 %235 to i32
  call void (i8*, ...) @logprint(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.144, i64 0, i64 0), i8* %227, i8* %229, i8* %233, i32 %236)
  br label %254

; <label>:237:                                    ; preds = %210
  %238 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 0
  %239 = load %struct.opendoor*, %struct.opendoor** %238, align 8
  %240 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %239, i32 0, i32 0
  %241 = getelementptr inbounds [128 x i8], [128 x i8]* %240, i32 0, i32 0
  %242 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 1
  %243 = load i16, i16* %242, align 8
  %244 = sext i16 %243 to i32
  call void (i8*, ...) @vprint(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.145, i64 0, i64 0), i8* %215, i8* %241, i32 %244)
  %245 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 2
  %246 = getelementptr inbounds [16 x i8], [16 x i8]* %245, i32 0, i32 0
  %247 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 0
  %248 = load %struct.opendoor*, %struct.opendoor** %247, align 8
  %249 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %248, i32 0, i32 0
  %250 = getelementptr inbounds [128 x i8], [128 x i8]* %249, i32 0, i32 0
  %251 = getelementptr inbounds %struct.knocker, %struct.knocker* %177, i32 0, i32 1
  %252 = load i16, i16* %251, align 8
  %253 = sext i16 %252 to i32
  call void (i8*, ...) @logprint(i8* getelementptr inbounds ([37 x i8], [37 x i8]* @.str.145, i64 0, i64 0), i8* %246, i8* %250, i32 %253)
  br label %254

; <label>:254:                                    ; preds = %216, %237, %200, %198
  %.210 = phi i32 [ %.19, %198 ], [ %.19, %200 ], [ 1, %237 ], [ 1, %216 ]
  %255 = icmp ne i32 %.210, 0
  br i1 %255, label %256, label %288

; <label>:256:                                    ; preds = %254
  %257 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 0
  %258 = load i8*, i8** %257, align 8
  %259 = bitcast i8* %258 to %struct.knocker*
  %260 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 1
  %261 = load %struct.__pmlist_t*, %struct.__pmlist_t** %260, align 8
  %262 = icmp ne %struct.__pmlist_t* %261, null
  br i1 %262, label %263, label %269

; <label>:263:                                    ; preds = %256
  %264 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  %265 = load %struct.__pmlist_t*, %struct.__pmlist_t** %264, align 8
  %266 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 1
  %267 = load %struct.__pmlist_t*, %struct.__pmlist_t** %266, align 8
  %268 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %267, i32 0, i32 2
  store %struct.__pmlist_t* %265, %struct.__pmlist_t** %268, align 8
  br label %269

; <label>:269:                                    ; preds = %263, %256
  %270 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  %271 = load %struct.__pmlist_t*, %struct.__pmlist_t** %270, align 8
  %272 = icmp ne %struct.__pmlist_t* %271, null
  br i1 %272, label %273, label %279

; <label>:273:                                    ; preds = %269
  %274 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 1
  %275 = load %struct.__pmlist_t*, %struct.__pmlist_t** %274, align 8
  %276 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  %277 = load %struct.__pmlist_t*, %struct.__pmlist_t** %276, align 8
  %278 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %277, i32 0, i32 1
  store %struct.__pmlist_t* %275, %struct.__pmlist_t** %278, align 8
  br label %279

; <label>:279:                                    ; preds = %273, %269
  %280 = load %struct.__pmlist_t*, %struct.__pmlist_t** @attempts, align 8
  %281 = icmp eq %struct.__pmlist_t* %.02028, %280
  br i1 %281, label %282, label %283

; <label>:282:                                    ; preds = %279
  store %struct.__pmlist_t* null, %struct.__pmlist_t** @attempts, align 8
  br label %283

; <label>:283:                                    ; preds = %282, %279
  %284 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  store %struct.__pmlist_t* null, %struct.__pmlist_t** %284, align 8
  %285 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 1
  store %struct.__pmlist_t* null, %struct.__pmlist_t** %285, align 8
  %286 = getelementptr inbounds %struct.knocker, %struct.knocker* %259, i32 0, i32 3
  %287 = load i8*, i8** %286, align 8
  call void @free(i8* %287) #7
  call void @list_free(%struct.__pmlist_t* %.02028)
  br label %288

; <label>:288:                                    ; preds = %254, %283
  %289 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  %290 = load %struct.__pmlist_t*, %struct.__pmlist_t** %289, align 8
  %291 = icmp ne %struct.__pmlist_t* %290, null
  br i1 %291, label %.lr.ph30, label %._crit_edge31.loopexit

._crit_edge31.loopexit:                           ; preds = %288
  br label %._crit_edge31

._crit_edge31:                                    ; preds = %._crit_edge31.loopexit, %124
  %292 = load %struct.__pmlist_t*, %struct.__pmlist_t** @attempts, align 8
  %293 = icmp ne %struct.__pmlist_t* %292, null
  br i1 %293, label %.lr.ph27.preheader, label %.loopexit

.lr.ph27.preheader:                               ; preds = %._crit_edge31
  %294 = getelementptr inbounds [16 x i8], [16 x i8]* %6, i32 0, i32 0
  br label %.lr.ph27

.lr.ph27:                                         ; preds = %.lr.ph27.preheader, %306
  %.12125 = phi %struct.__pmlist_t* [ %308, %306 ], [ %292, %.lr.ph27.preheader ]
  %295 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.12125, i32 0, i32 0
  %296 = load i8*, i8** %295, align 8
  %297 = bitcast i8* %296 to %struct.knocker*
  %298 = getelementptr inbounds %struct.knocker, %struct.knocker* %297, i32 0, i32 2
  %299 = getelementptr inbounds [16 x i8], [16 x i8]* %298, i32 0, i32 0
  %300 = call i32 @strncmp(i8* %299, i8* %294, i64 16) #10
  %301 = icmp ne i32 %300, 0
  br i1 %301, label %306, label %302

; <label>:302:                                    ; preds = %.lr.ph27
  %.121.lcssa23 = phi %struct.__pmlist_t* [ %.12125, %.lr.ph27 ]
  %303 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.121.lcssa23, i32 0, i32 0
  %304 = load i8*, i8** %303, align 8
  %305 = bitcast i8* %304 to %struct.knocker*
  br label %.loopexit

; <label>:306:                                    ; preds = %.lr.ph27
  %307 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.12125, i32 0, i32 2
  %308 = load %struct.__pmlist_t*, %struct.__pmlist_t** %307, align 8
  %309 = icmp ne %struct.__pmlist_t* %308, null
  br i1 %309, label %.lr.ph27, label %.loopexit.loopexit

.loopexit.loopexit:                               ; preds = %306
  %.019.ph = phi %struct.knocker* [ null, %306 ]
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %._crit_edge31, %302
  %.019 = phi %struct.knocker* [ %305, %302 ], [ null, %._crit_edge31 ], [ %.019.ph, %.loopexit.loopexit ]
  %310 = icmp ne %struct.knocker* %.019, null
  br i1 %310, label %311, label %819

; <label>:311:                                    ; preds = %.loopexit
  %312 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %313 = load i8, i8* %312, align 1
  %314 = zext i8 %313 to i32
  %315 = icmp eq i32 %314, 6
  br i1 %315, label %316, label %556

; <label>:316:                                    ; preds = %311
  %317 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %318 = load %struct.opendoor*, %struct.opendoor** %317, align 8
  %319 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %318, i32 0, i32 8
  %320 = load i32, i32* %319, align 8
  %321 = icmp ne i32 %320, 0
  br i1 %321, label %322, label %356

; <label>:322:                                    ; preds = %316
  %323 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %324 = load %struct.opendoor*, %struct.opendoor** %323, align 8
  %325 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %324, i32 0, i32 8
  %326 = load i32, i32* %325, align 8
  %327 = icmp eq i32 %326, 1
  br i1 %327, label %328, label %339

; <label>:328:                                    ; preds = %322
  %329 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %330 = bitcast %union.anon.4* %329 to %struct.anon.6*
  %331 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %330, i32 0, i32 4
  %332 = load i16, i16* %331, align 4
  %333 = lshr i16 %332, 8
  %334 = and i16 %333, 1
  %335 = zext i16 %334 to i32
  %336 = icmp ne i32 %335, 1
  br i1 %336, label %337, label %339

; <label>:337:                                    ; preds = %328
  %338 = getelementptr [32 x i8], [32 x i8]* @.str.146, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %338)
  br label %339

; <label>:339:                                    ; preds = %337, %328, %322
  %.0 = phi i32 [ 0, %337 ], [ 1, %328 ], [ 1, %322 ]
  %340 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %341 = load %struct.opendoor*, %struct.opendoor** %340, align 8
  %342 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %341, i32 0, i32 8
  %343 = load i32, i32* %342, align 8
  %344 = icmp eq i32 %343, 2
  br i1 %344, label %345, label %356

; <label>:345:                                    ; preds = %339
  %346 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %347 = bitcast %union.anon.4* %346 to %struct.anon.6*
  %348 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %347, i32 0, i32 4
  %349 = load i16, i16* %348, align 4
  %350 = lshr i16 %349, 8
  %351 = and i16 %350, 1
  %352 = zext i16 %351 to i32
  %353 = icmp eq i32 %352, 1
  br i1 %353, label %354, label %356

; <label>:354:                                    ; preds = %345
  %355 = getelementptr [33 x i8], [33 x i8]* @.str.147, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %355)
  br label %356

; <label>:356:                                    ; preds = %339, %345, %354, %316
  %.2 = phi i32 [ 1, %316 ], [ 0, %354 ], [ %.0, %345 ], [ %.0, %339 ]
  %357 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %358 = load %struct.opendoor*, %struct.opendoor** %357, align 8
  %359 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %358, i32 0, i32 9
  %360 = load i32, i32* %359, align 4
  %361 = icmp ne i32 %360, 0
  br i1 %361, label %362, label %396

; <label>:362:                                    ; preds = %356
  %363 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %364 = load %struct.opendoor*, %struct.opendoor** %363, align 8
  %365 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %364, i32 0, i32 9
  %366 = load i32, i32* %365, align 4
  %367 = icmp eq i32 %366, 1
  br i1 %367, label %368, label %379

; <label>:368:                                    ; preds = %362
  %369 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %370 = bitcast %union.anon.4* %369 to %struct.anon.6*
  %371 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %370, i32 0, i32 4
  %372 = load i16, i16* %371, align 4
  %373 = lshr i16 %372, 9
  %374 = and i16 %373, 1
  %375 = zext i16 %374 to i32
  %376 = icmp ne i32 %375, 1
  br i1 %376, label %377, label %379

; <label>:377:                                    ; preds = %368
  %378 = getelementptr [32 x i8], [32 x i8]* @.str.148, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %378)
  br label %379

; <label>:379:                                    ; preds = %377, %368, %362
  %.3 = phi i32 [ 0, %377 ], [ %.2, %368 ], [ %.2, %362 ]
  %380 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %381 = load %struct.opendoor*, %struct.opendoor** %380, align 8
  %382 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %381, i32 0, i32 9
  %383 = load i32, i32* %382, align 4
  %384 = icmp eq i32 %383, 2
  br i1 %384, label %385, label %396

; <label>:385:                                    ; preds = %379
  %386 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %387 = bitcast %union.anon.4* %386 to %struct.anon.6*
  %388 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %387, i32 0, i32 4
  %389 = load i16, i16* %388, align 4
  %390 = lshr i16 %389, 9
  %391 = and i16 %390, 1
  %392 = zext i16 %391 to i32
  %393 = icmp eq i32 %392, 1
  br i1 %393, label %394, label %396

; <label>:394:                                    ; preds = %385
  %395 = getelementptr [33 x i8], [33 x i8]* @.str.149, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %395)
  br label %396

; <label>:396:                                    ; preds = %379, %385, %394, %356
  %.5 = phi i32 [ %.2, %356 ], [ 0, %394 ], [ %.3, %385 ], [ %.3, %379 ]
  %397 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %398 = load %struct.opendoor*, %struct.opendoor** %397, align 8
  %399 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %398, i32 0, i32 10
  %400 = load i32, i32* %399, align 8
  %401 = icmp ne i32 %400, 0
  br i1 %401, label %402, label %436

; <label>:402:                                    ; preds = %396
  %403 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %404 = load %struct.opendoor*, %struct.opendoor** %403, align 8
  %405 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %404, i32 0, i32 10
  %406 = load i32, i32* %405, align 8
  %407 = icmp eq i32 %406, 1
  br i1 %407, label %408, label %419

; <label>:408:                                    ; preds = %402
  %409 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %410 = bitcast %union.anon.4* %409 to %struct.anon.6*
  %411 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %410, i32 0, i32 4
  %412 = load i16, i16* %411, align 4
  %413 = lshr i16 %412, 10
  %414 = and i16 %413, 1
  %415 = zext i16 %414 to i32
  %416 = icmp ne i32 %415, 1
  br i1 %416, label %417, label %419

; <label>:417:                                    ; preds = %408
  %418 = getelementptr [32 x i8], [32 x i8]* @.str.150, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %418)
  br label %419

; <label>:419:                                    ; preds = %417, %408, %402
  %.6 = phi i32 [ 0, %417 ], [ %.5, %408 ], [ %.5, %402 ]
  %420 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %421 = load %struct.opendoor*, %struct.opendoor** %420, align 8
  %422 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %421, i32 0, i32 10
  %423 = load i32, i32* %422, align 8
  %424 = icmp eq i32 %423, 2
  br i1 %424, label %425, label %436

; <label>:425:                                    ; preds = %419
  %426 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %427 = bitcast %union.anon.4* %426 to %struct.anon.6*
  %428 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %427, i32 0, i32 4
  %429 = load i16, i16* %428, align 4
  %430 = lshr i16 %429, 10
  %431 = and i16 %430, 1
  %432 = zext i16 %431 to i32
  %433 = icmp eq i32 %432, 1
  br i1 %433, label %434, label %436

; <label>:434:                                    ; preds = %425
  %435 = getelementptr [33 x i8], [33 x i8]* @.str.151, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %435)
  br label %436

; <label>:436:                                    ; preds = %419, %425, %434, %396
  %.8 = phi i32 [ %.5, %396 ], [ 0, %434 ], [ %.6, %425 ], [ %.6, %419 ]
  %437 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %438 = load %struct.opendoor*, %struct.opendoor** %437, align 8
  %439 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %438, i32 0, i32 11
  %440 = load i32, i32* %439, align 4
  %441 = icmp ne i32 %440, 0
  br i1 %441, label %442, label %476

; <label>:442:                                    ; preds = %436
  %443 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %444 = load %struct.opendoor*, %struct.opendoor** %443, align 8
  %445 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %444, i32 0, i32 11
  %446 = load i32, i32* %445, align 4
  %447 = icmp eq i32 %446, 1
  br i1 %447, label %448, label %459

; <label>:448:                                    ; preds = %442
  %449 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %450 = bitcast %union.anon.4* %449 to %struct.anon.6*
  %451 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %450, i32 0, i32 4
  %452 = load i16, i16* %451, align 4
  %453 = lshr i16 %452, 11
  %454 = and i16 %453, 1
  %455 = zext i16 %454 to i32
  %456 = icmp ne i32 %455, 1
  br i1 %456, label %457, label %459

; <label>:457:                                    ; preds = %448
  %458 = getelementptr [32 x i8], [32 x i8]* @.str.152, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %458)
  br label %459

; <label>:459:                                    ; preds = %457, %448, %442
  %.9 = phi i32 [ 0, %457 ], [ %.8, %448 ], [ %.8, %442 ]
  %460 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %461 = load %struct.opendoor*, %struct.opendoor** %460, align 8
  %462 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %461, i32 0, i32 11
  %463 = load i32, i32* %462, align 4
  %464 = icmp eq i32 %463, 2
  br i1 %464, label %465, label %476

; <label>:465:                                    ; preds = %459
  %466 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %467 = bitcast %union.anon.4* %466 to %struct.anon.6*
  %468 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %467, i32 0, i32 4
  %469 = load i16, i16* %468, align 4
  %470 = lshr i16 %469, 11
  %471 = and i16 %470, 1
  %472 = zext i16 %471 to i32
  %473 = icmp eq i32 %472, 1
  br i1 %473, label %474, label %476

; <label>:474:                                    ; preds = %465
  %475 = getelementptr [33 x i8], [33 x i8]* @.str.153, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %475)
  br label %476

; <label>:476:                                    ; preds = %459, %465, %474, %436
  %.11 = phi i32 [ %.8, %436 ], [ 0, %474 ], [ %.9, %465 ], [ %.9, %459 ]
  %477 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %478 = load %struct.opendoor*, %struct.opendoor** %477, align 8
  %479 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %478, i32 0, i32 12
  %480 = load i32, i32* %479, align 8
  %481 = icmp ne i32 %480, 0
  br i1 %481, label %482, label %516

; <label>:482:                                    ; preds = %476
  %483 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %484 = load %struct.opendoor*, %struct.opendoor** %483, align 8
  %485 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %484, i32 0, i32 12
  %486 = load i32, i32* %485, align 8
  %487 = icmp eq i32 %486, 1
  br i1 %487, label %488, label %499

; <label>:488:                                    ; preds = %482
  %489 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %490 = bitcast %union.anon.4* %489 to %struct.anon.6*
  %491 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %490, i32 0, i32 4
  %492 = load i16, i16* %491, align 4
  %493 = lshr i16 %492, 12
  %494 = and i16 %493, 1
  %495 = zext i16 %494 to i32
  %496 = icmp ne i32 %495, 1
  br i1 %496, label %497, label %499

; <label>:497:                                    ; preds = %488
  %498 = getelementptr [32 x i8], [32 x i8]* @.str.154, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %498)
  br label %499

; <label>:499:                                    ; preds = %497, %488, %482
  %.12 = phi i32 [ 0, %497 ], [ %.11, %488 ], [ %.11, %482 ]
  %500 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %501 = load %struct.opendoor*, %struct.opendoor** %500, align 8
  %502 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %501, i32 0, i32 12
  %503 = load i32, i32* %502, align 8
  %504 = icmp eq i32 %503, 2
  br i1 %504, label %505, label %516

; <label>:505:                                    ; preds = %499
  %506 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %507 = bitcast %union.anon.4* %506 to %struct.anon.6*
  %508 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %507, i32 0, i32 4
  %509 = load i16, i16* %508, align 4
  %510 = lshr i16 %509, 12
  %511 = and i16 %510, 1
  %512 = zext i16 %511 to i32
  %513 = icmp eq i32 %512, 1
  br i1 %513, label %514, label %516

; <label>:514:                                    ; preds = %505
  %515 = getelementptr [33 x i8], [33 x i8]* @.str.155, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %515)
  br label %516

; <label>:516:                                    ; preds = %499, %505, %514, %476
  %.14 = phi i32 [ %.11, %476 ], [ 0, %514 ], [ %.12, %505 ], [ %.12, %499 ]
  %517 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %518 = load %struct.opendoor*, %struct.opendoor** %517, align 8
  %519 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %518, i32 0, i32 13
  %520 = load i32, i32* %519, align 4
  %521 = icmp ne i32 %520, 0
  br i1 %521, label %522, label %556

; <label>:522:                                    ; preds = %516
  %523 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %524 = load %struct.opendoor*, %struct.opendoor** %523, align 8
  %525 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %524, i32 0, i32 13
  %526 = load i32, i32* %525, align 4
  %527 = icmp eq i32 %526, 1
  br i1 %527, label %528, label %539

; <label>:528:                                    ; preds = %522
  %529 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %530 = bitcast %union.anon.4* %529 to %struct.anon.6*
  %531 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %530, i32 0, i32 4
  %532 = load i16, i16* %531, align 4
  %533 = lshr i16 %532, 13
  %534 = and i16 %533, 1
  %535 = zext i16 %534 to i32
  %536 = icmp ne i32 %535, 1
  br i1 %536, label %537, label %539

; <label>:537:                                    ; preds = %528
  %538 = getelementptr [32 x i8], [32 x i8]* @.str.156, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %538)
  br label %539

; <label>:539:                                    ; preds = %537, %528, %522
  %.15 = phi i32 [ 0, %537 ], [ %.14, %528 ], [ %.14, %522 ]
  %540 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %541 = load %struct.opendoor*, %struct.opendoor** %540, align 8
  %542 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %541, i32 0, i32 13
  %543 = load i32, i32* %542, align 4
  %544 = icmp eq i32 %543, 2
  br i1 %544, label %545, label %556

; <label>:545:                                    ; preds = %539
  %546 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %547 = bitcast %union.anon.4* %546 to %struct.anon.6*
  %548 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %547, i32 0, i32 4
  %549 = load i16, i16* %548, align 4
  %550 = lshr i16 %549, 13
  %551 = and i16 %550, 1
  %552 = zext i16 %551 to i32
  %553 = icmp eq i32 %552, 1
  br i1 %553, label %554, label %556

; <label>:554:                                    ; preds = %545
  %555 = getelementptr [33 x i8], [33 x i8]* @.str.157, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %555)
  br label %556

; <label>:556:                                    ; preds = %516, %554, %545, %539, %311
  %.18 = phi i32 [ 1, %311 ], [ %.14, %516 ], [ 0, %554 ], [ %.15, %545 ], [ %.15, %539 ]
  %cond = icmp eq i32 %.18, 0
  br i1 %cond, label %._crit_edge, label %557

; <label>:557:                                    ; preds = %556
  %558 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %559 = load i8, i8* %558, align 1
  %560 = zext i8 %559 to i32
  %561 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %562 = load %struct.opendoor*, %struct.opendoor** %561, align 8
  %563 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %562, i32 0, i32 3
  %564 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %565 = load i16, i16* %564, align 8
  %566 = sext i16 %565 to i64
  %567 = getelementptr inbounds [32 x i16], [32 x i16]* %563, i64 0, i64 %566
  %568 = load i16, i16* %567, align 2
  %569 = zext i16 %568 to i32
  %570 = icmp eq i32 %560, %569
  br i1 %570, label %571, label %815

; <label>:571:                                    ; preds = %557
  %572 = zext i16 %.118 to i32
  %573 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %574 = load %struct.opendoor*, %struct.opendoor** %573, align 8
  %575 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %574, i32 0, i32 2
  %576 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %577 = load i16, i16* %576, align 8
  %578 = sext i16 %577 to i64
  %579 = getelementptr inbounds [32 x i16], [32 x i16]* %575, i64 0, i64 %578
  %580 = load i16, i16* %579, align 2
  %581 = zext i16 %580 to i32
  %582 = icmp eq i32 %572, %581
  br i1 %582, label %583, label %815

; <label>:583:                                    ; preds = %571
  %584 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %585 = load i16, i16* %584, align 8
  %586 = add i16 %585, 1
  store i16 %586, i16* %584, align 8
  %587 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %588 = load i8*, i8** %587, align 8
  %589 = icmp ne i8* %588, null
  %590 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %591 = getelementptr inbounds [16 x i8], [16 x i8]* %590, i32 0, i32 0
  br i1 %589, label %592, label %615

; <label>:592:                                    ; preds = %583
  %593 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %594 = load i8*, i8** %593, align 8
  %595 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %596 = load %struct.opendoor*, %struct.opendoor** %595, align 8
  %597 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %596, i32 0, i32 0
  %598 = getelementptr inbounds [128 x i8], [128 x i8]* %597, i32 0, i32 0
  %599 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %600 = load i16, i16* %599, align 8
  %601 = sext i16 %600 to i32
  %602 = getelementptr [23 x i8], [23 x i8]* @.str.158, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %602, i8* %591, i8* %594, i8* %598, i32 %601)
  %603 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %604 = getelementptr inbounds [16 x i8], [16 x i8]* %603, i32 0, i32 0
  %605 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %606 = load i8*, i8** %605, align 8
  %607 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %608 = load %struct.opendoor*, %struct.opendoor** %607, align 8
  %609 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %608, i32 0, i32 0
  %610 = getelementptr inbounds [128 x i8], [128 x i8]* %609, i32 0, i32 0
  %611 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %612 = load i16, i16* %611, align 8
  %613 = sext i16 %612 to i32
  %614 = getelementptr [22 x i8], [22 x i8]* @.str.159, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %614, i8* %604, i8* %606, i8* %610, i32 %613)
  br label %634

; <label>:615:                                    ; preds = %583
  %616 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %617 = load %struct.opendoor*, %struct.opendoor** %616, align 8
  %618 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %617, i32 0, i32 0
  %619 = getelementptr inbounds [128 x i8], [128 x i8]* %618, i32 0, i32 0
  %620 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %621 = load i16, i16* %620, align 8
  %622 = sext i16 %621 to i32
  %623 = getelementptr [18 x i8], [18 x i8]* @.str.160, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %623, i8* %591, i8* %619, i32 %622)
  %624 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %625 = getelementptr inbounds [16 x i8], [16 x i8]* %624, i32 0, i32 0
  %626 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %627 = load %struct.opendoor*, %struct.opendoor** %626, align 8
  %628 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %627, i32 0, i32 0
  %629 = getelementptr inbounds [128 x i8], [128 x i8]* %628, i32 0, i32 0
  %630 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %631 = load i16, i16* %630, align 8
  %632 = sext i16 %631 to i32
  %633 = getelementptr [17 x i8], [17 x i8]* @.str.161, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %633, i8* %625, i8* %629, i32 %632)
  br label %634

; <label>:634:                                    ; preds = %615, %592
  %635 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %636 = load i16, i16* %635, align 8
  %637 = sext i16 %636 to i32
  %638 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %639 = load %struct.opendoor*, %struct.opendoor** %638, align 8
  %640 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %639, i32 0, i32 1
  %641 = load i16, i16* %640, align 8
  %642 = zext i16 %641 to i32
  %643 = icmp sge i32 %637, %642
  br i1 %643, label %644, label %._crit_edge

; <label>:644:                                    ; preds = %634
  %645 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %646 = load i8*, i8** %645, align 8
  %647 = icmp ne i8* %646, null
  %648 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %649 = getelementptr inbounds [16 x i8], [16 x i8]* %648, i32 0, i32 0
  br i1 %647, label %650, label %667

; <label>:650:                                    ; preds = %644
  %651 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %652 = load i8*, i8** %651, align 8
  %653 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %654 = load %struct.opendoor*, %struct.opendoor** %653, align 8
  %655 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %654, i32 0, i32 0
  %656 = getelementptr inbounds [128 x i8], [128 x i8]* %655, i32 0, i32 0
  %657 = getelementptr [26 x i8], [26 x i8]* @.str.162, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %657, i8* %649, i8* %652, i8* %656)
  %658 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %659 = getelementptr inbounds [16 x i8], [16 x i8]* %658, i32 0, i32 0
  %660 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %661 = load i8*, i8** %660, align 8
  %662 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %663 = load %struct.opendoor*, %struct.opendoor** %662, align 8
  %664 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %663, i32 0, i32 0
  %665 = getelementptr inbounds [128 x i8], [128 x i8]* %664, i32 0, i32 0
  %666 = getelementptr [25 x i8], [25 x i8]* @.str.163, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %666, i8* %659, i8* %661, i8* %665)
  br label %680

; <label>:667:                                    ; preds = %644
  %668 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %669 = load %struct.opendoor*, %struct.opendoor** %668, align 8
  %670 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %669, i32 0, i32 0
  %671 = getelementptr inbounds [128 x i8], [128 x i8]* %670, i32 0, i32 0
  %672 = getelementptr [21 x i8], [21 x i8]* @.str.164, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %672, i8* %649, i8* %671)
  %673 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %674 = getelementptr inbounds [16 x i8], [16 x i8]* %673, i32 0, i32 0
  %675 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %676 = load %struct.opendoor*, %struct.opendoor** %675, align 8
  %677 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %676, i32 0, i32 0
  %678 = getelementptr inbounds [128 x i8], [128 x i8]* %677, i32 0, i32 0
  %679 = getelementptr [20 x i8], [20 x i8]* @.str.165, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %679, i8* %674, i8* %678)
  br label %680

; <label>:680:                                    ; preds = %667, %650
  %681 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %682 = load %struct.opendoor*, %struct.opendoor** %681, align 8
  %683 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %682, i32 0, i32 5
  %684 = load i8*, i8** %683, align 8
  %685 = icmp ne i8* %684, null
  br i1 %685, label %686, label %795

; <label>:686:                                    ; preds = %680
  %687 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %688 = load %struct.opendoor*, %struct.opendoor** %687, align 8
  %689 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %688, i32 0, i32 5
  %690 = load i8*, i8** %689, align 8
  %691 = call i64 @strlen(i8* %690) #10
  %692 = icmp ne i64 %691, 0
  br i1 %692, label %693, label %795

; <label>:693:                                    ; preds = %686
  %694 = call i32 @fork() #7
  %695 = icmp eq i32 %694, 0
  br i1 %695, label %696, label %795

; <label>:696:                                    ; preds = %693
  %697 = call i32 @setsid() #7
  %698 = getelementptr inbounds [100 x i8], [100 x i8]* %11, i32 0, i32 0
  %699 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %700 = load %struct.opendoor*, %struct.opendoor** %699, align 8
  %701 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %700, i32 0, i32 5
  %702 = load i8*, i8** %701, align 8
  %703 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %704 = getelementptr inbounds [16 x i8], [16 x i8]* %703, i32 0, i32 0
  %705 = call i64 @parse_cmd(i8* %698, i64 100, i8* %702, i8* %704)
  %706 = icmp uge i64 %705, 100
  br i1 %706, label %707, label %712

; <label>:707:                                    ; preds = %696
  %708 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %709 = getelementptr [70 x i8], [70 x i8]* @.str.166, i32 0, i32 0
  %710 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %708, i8* %709)
  %711 = getelementptr [69 x i8], [69 x i8]* @.str.167, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %711)
  call void @exit(i32 0) #9
  unreachable

; <label>:712:                                    ; preds = %696
  %713 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %714 = load %struct.opendoor*, %struct.opendoor** %713, align 8
  %715 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %714, i32 0, i32 7
  %716 = load i8*, i8** %715, align 8
  %717 = icmp ne i8* %716, null
  br i1 %717, label %718, label %733

; <label>:718:                                    ; preds = %712
  %719 = getelementptr inbounds [100 x i8], [100 x i8]* %12, i32 0, i32 0
  %720 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %721 = load %struct.opendoor*, %struct.opendoor** %720, align 8
  %722 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %721, i32 0, i32 7
  %723 = load i8*, i8** %722, align 8
  %724 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %725 = getelementptr inbounds [16 x i8], [16 x i8]* %724, i32 0, i32 0
  %726 = call i64 @parse_cmd(i8* %719, i64 100, i8* %723, i8* %725)
  %727 = icmp uge i64 %726, 100
  br i1 %727, label %728, label %733

; <label>:728:                                    ; preds = %718
  %729 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %730 = getelementptr [80 x i8], [80 x i8]* @.str.168, i32 0, i32 0
  %731 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %729, i8* %730)
  %732 = getelementptr [79 x i8], [79 x i8]* @.str.169, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %732)
  call void @exit(i32 0) #9
  unreachable

; <label>:733:                                    ; preds = %718, %712
  %734 = getelementptr inbounds [100 x i8], [100 x i8]* %11, i32 0, i32 0
  %735 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %736 = load %struct.opendoor*, %struct.opendoor** %735, align 8
  %737 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %736, i32 0, i32 0
  %738 = getelementptr inbounds [128 x i8], [128 x i8]* %737, i32 0, i32 0
  %739 = call i32 @exec_cmd(i8* %734, i8* %738)
  %740 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %741 = load %struct.opendoor*, %struct.opendoor** %740, align 8
  %742 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %741, i32 0, i32 7
  %743 = load i8*, i8** %742, align 8
  %744 = icmp ne i8* %743, null
  br i1 %744, label %745, label %794

; <label>:745:                                    ; preds = %733
  %746 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %747 = load %struct.opendoor*, %struct.opendoor** %746, align 8
  %748 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %747, i32 0, i32 6
  %749 = load i64, i64* %748, align 8
  %750 = trunc i64 %749 to i32
  %751 = call i32 @sleep(i32 %750)
  %752 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %753 = load i8*, i8** %752, align 8
  %754 = icmp ne i8* %753, null
  %755 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %756 = getelementptr inbounds [16 x i8], [16 x i8]* %755, i32 0, i32 0
  br i1 %754, label %757, label %774

; <label>:757:                                    ; preds = %745
  %758 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %759 = load i8*, i8** %758, align 8
  %760 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %761 = load %struct.opendoor*, %struct.opendoor** %760, align 8
  %762 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %761, i32 0, i32 0
  %763 = getelementptr inbounds [128 x i8], [128 x i8]* %762, i32 0, i32 0
  %764 = getelementptr [30 x i8], [30 x i8]* @.str.170, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %764, i8* %756, i8* %759, i8* %763)
  %765 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %766 = getelementptr inbounds [16 x i8], [16 x i8]* %765, i32 0, i32 0
  %767 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %768 = load i8*, i8** %767, align 8
  %769 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %770 = load %struct.opendoor*, %struct.opendoor** %769, align 8
  %771 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %770, i32 0, i32 0
  %772 = getelementptr inbounds [128 x i8], [128 x i8]* %771, i32 0, i32 0
  %773 = getelementptr [29 x i8], [29 x i8]* @.str.171, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %773, i8* %766, i8* %768, i8* %772)
  br label %787

; <label>:774:                                    ; preds = %745
  %775 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %776 = load %struct.opendoor*, %struct.opendoor** %775, align 8
  %777 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %776, i32 0, i32 0
  %778 = getelementptr inbounds [128 x i8], [128 x i8]* %777, i32 0, i32 0
  %779 = getelementptr [25 x i8], [25 x i8]* @.str.172, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %779, i8* %756, i8* %778)
  %780 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %781 = getelementptr inbounds [16 x i8], [16 x i8]* %780, i32 0, i32 0
  %782 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %783 = load %struct.opendoor*, %struct.opendoor** %782, align 8
  %784 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %783, i32 0, i32 0
  %785 = getelementptr inbounds [128 x i8], [128 x i8]* %784, i32 0, i32 0
  %786 = getelementptr [24 x i8], [24 x i8]* @.str.173, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %786, i8* %781, i8* %785)
  br label %787

; <label>:787:                                    ; preds = %774, %757
  %788 = getelementptr inbounds [100 x i8], [100 x i8]* %12, i32 0, i32 0
  %789 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %790 = load %struct.opendoor*, %struct.opendoor** %789, align 8
  %791 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %790, i32 0, i32 0
  %792 = getelementptr inbounds [128 x i8], [128 x i8]* %791, i32 0, i32 0
  %793 = call i32 @exec_cmd(i8* %788, i8* %792)
  br label %794

; <label>:794:                                    ; preds = %787, %733
  call void @exit(i32 0) #9
  unreachable

; <label>:795:                                    ; preds = %693, %686, %680
  %796 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %797 = load %struct.opendoor*, %struct.opendoor** %796, align 8
  %798 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %797, i32 0, i32 14
  %799 = load %struct._IO_FILE*, %struct._IO_FILE** %798, align 8
  %800 = icmp ne %struct._IO_FILE* %799, null
  br i1 %800, label %801, label %._crit_edge

; <label>:801:                                    ; preds = %795
  %802 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %803 = load %struct.opendoor*, %struct.opendoor** %802, align 8
  %804 = call i32 @disable_used_one_time_sequence(%struct.opendoor* %803)
  %805 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %806 = load %struct.opendoor*, %struct.opendoor** %805, align 8
  %807 = call i32 @get_new_one_time_sequence(%struct.opendoor* %806)
  %808 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %809 = load %struct.opendoor*, %struct.opendoor** %808, align 8
  %810 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %809, i32 0, i32 15
  %811 = load i8*, i8** %810, align 8
  call void @free(i8* %811) #7
  %812 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %813 = load %struct.opendoor*, %struct.opendoor** %812, align 8
  %814 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %813, i32 0, i32 15
  store i8* null, i8** %814, align 8
  call void @generate_pcap_filter()
  br label %._crit_edge

; <label>:815:                                    ; preds = %571, %557
  %816 = icmp eq i32 %.18, 0
  br i1 %816, label %._crit_edge, label %817

; <label>:817:                                    ; preds = %815
  %818 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  store i16 -1, i16* %818, align 8
  br label %._crit_edge

; <label>:819:                                    ; preds = %.loopexit
  %820 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %821 = icmp ne %struct.__pmlist_t* %820, null
  br i1 %821, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %819
  %822 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %823 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %824 = zext i16 %.118 to i32
  %825 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %826 = bitcast %union.anon.4* %825 to %struct.anon.6*
  %827 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %826, i32 0, i32 4
  %828 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %829 = bitcast %union.anon.4* %828 to %struct.anon.6*
  %830 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %829, i32 0, i32 4
  %831 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %832 = bitcast %union.anon.4* %831 to %struct.anon.6*
  %833 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %832, i32 0, i32 4
  %834 = getelementptr inbounds [16 x i8], [16 x i8]* %6, i32 0, i32 0
  %835 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %836 = bitcast %union.anon.4* %835 to %struct.anon.6*
  %837 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %836, i32 0, i32 4
  %838 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %839 = bitcast %union.anon.4* %838 to %struct.anon.6*
  %840 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %839, i32 0, i32 4
  %841 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 8
  %842 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  %843 = bitcast %struct.in_addr* %5 to i8*
  %844 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %845 = bitcast %union.anon.4* %844 to %struct.anon.6*
  %846 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %845, i32 0, i32 4
  %847 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %848 = bitcast %union.anon.4* %847 to %struct.anon.6*
  %849 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %848, i32 0, i32 4
  %850 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %851 = bitcast %union.anon.4* %850 to %struct.anon.6*
  %852 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %851, i32 0, i32 4
  %853 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %854 = bitcast %union.anon.4* %853 to %struct.anon.6*
  %855 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %854, i32 0, i32 4
  %856 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %857 = bitcast %union.anon.4* %856 to %struct.anon.6*
  %858 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %857, i32 0, i32 4
  %859 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %860 = bitcast %union.anon.4* %859 to %struct.anon.6*
  %861 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %860, i32 0, i32 4
  %862 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %863 = bitcast %union.anon.4* %862 to %struct.anon.6*
  %864 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %863, i32 0, i32 4
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %1095
  %.22224 = phi %struct.__pmlist_t* [ %1097, %1095 ], [ %820, %.lr.ph.preheader ]
  %865 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.22224, i32 0, i32 0
  %866 = load i8*, i8** %865, align 8
  %867 = bitcast i8* %866 to %struct.opendoor*
  %868 = load i8, i8* %822, align 1
  %869 = zext i8 %868 to i32
  %870 = icmp eq i32 %869, 6
  br i1 %870, label %871, label %1027

; <label>:871:                                    ; preds = %.lr.ph
  %872 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 8
  %873 = load i32, i32* %872, align 8
  %874 = icmp ne i32 %873, 0
  br i1 %874, label %875, label %897

; <label>:875:                                    ; preds = %871
  %876 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 8
  %877 = load i32, i32* %876, align 8
  %878 = icmp eq i32 %877, 1
  br i1 %878, label %879, label %886

; <label>:879:                                    ; preds = %875
  %880 = load i16, i16* %827, align 4
  %881 = lshr i16 %880, 8
  %882 = and i16 %881, 1
  %883 = zext i16 %882 to i32
  %884 = icmp ne i32 %883, 1
  br i1 %884, label %885, label %886

; <label>:885:                                    ; preds = %879
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.146, i64 0, i64 0))
  br label %1095

; <label>:886:                                    ; preds = %879, %875
  %887 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 8
  %888 = load i32, i32* %887, align 8
  %889 = icmp eq i32 %888, 2
  br i1 %889, label %890, label %897

; <label>:890:                                    ; preds = %886
  %891 = load i16, i16* %830, align 4
  %892 = lshr i16 %891, 8
  %893 = and i16 %892, 1
  %894 = zext i16 %893 to i32
  %895 = icmp eq i32 %894, 1
  br i1 %895, label %896, label %897

; <label>:896:                                    ; preds = %890
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.147, i64 0, i64 0))
  br label %1095

; <label>:897:                                    ; preds = %886, %890, %871
  %898 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 9
  %899 = load i32, i32* %898, align 4
  %900 = icmp ne i32 %899, 0
  br i1 %900, label %901, label %923

; <label>:901:                                    ; preds = %897
  %902 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 9
  %903 = load i32, i32* %902, align 4
  %904 = icmp eq i32 %903, 1
  br i1 %904, label %905, label %912

; <label>:905:                                    ; preds = %901
  %906 = load i16, i16* %833, align 4
  %907 = lshr i16 %906, 9
  %908 = and i16 %907, 1
  %909 = zext i16 %908 to i32
  %910 = icmp ne i32 %909, 1
  br i1 %910, label %911, label %912

; <label>:911:                                    ; preds = %905
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.148, i64 0, i64 0))
  br label %1095

; <label>:912:                                    ; preds = %905, %901
  %913 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 9
  %914 = load i32, i32* %913, align 4
  %915 = icmp eq i32 %914, 2
  br i1 %915, label %916, label %923

; <label>:916:                                    ; preds = %912
  %917 = load i16, i16* %837, align 4
  %918 = lshr i16 %917, 9
  %919 = and i16 %918, 1
  %920 = zext i16 %919 to i32
  %921 = icmp eq i32 %920, 1
  br i1 %921, label %922, label %923

; <label>:922:                                    ; preds = %916
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.149, i64 0, i64 0))
  br label %1095

; <label>:923:                                    ; preds = %912, %916, %897
  %924 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 10
  %925 = load i32, i32* %924, align 8
  %926 = icmp ne i32 %925, 0
  br i1 %926, label %927, label %949

; <label>:927:                                    ; preds = %923
  %928 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 10
  %929 = load i32, i32* %928, align 8
  %930 = icmp eq i32 %929, 1
  br i1 %930, label %931, label %938

; <label>:931:                                    ; preds = %927
  %932 = load i16, i16* %840, align 4
  %933 = lshr i16 %932, 10
  %934 = and i16 %933, 1
  %935 = zext i16 %934 to i32
  %936 = icmp ne i32 %935, 1
  br i1 %936, label %937, label %938

; <label>:937:                                    ; preds = %931
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.150, i64 0, i64 0))
  br label %1095

; <label>:938:                                    ; preds = %931, %927
  %939 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 10
  %940 = load i32, i32* %939, align 8
  %941 = icmp eq i32 %940, 2
  br i1 %941, label %942, label %949

; <label>:942:                                    ; preds = %938
  %943 = load i16, i16* %846, align 4
  %944 = lshr i16 %943, 10
  %945 = and i16 %944, 1
  %946 = zext i16 %945 to i32
  %947 = icmp eq i32 %946, 1
  br i1 %947, label %948, label %949

; <label>:948:                                    ; preds = %942
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.151, i64 0, i64 0))
  br label %1095

; <label>:949:                                    ; preds = %938, %942, %923
  %950 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 11
  %951 = load i32, i32* %950, align 4
  %952 = icmp ne i32 %951, 0
  br i1 %952, label %953, label %975

; <label>:953:                                    ; preds = %949
  %954 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 11
  %955 = load i32, i32* %954, align 4
  %956 = icmp eq i32 %955, 1
  br i1 %956, label %957, label %964

; <label>:957:                                    ; preds = %953
  %958 = load i16, i16* %849, align 4
  %959 = lshr i16 %958, 11
  %960 = and i16 %959, 1
  %961 = zext i16 %960 to i32
  %962 = icmp ne i32 %961, 1
  br i1 %962, label %963, label %964

; <label>:963:                                    ; preds = %957
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.152, i64 0, i64 0))
  br label %1095

; <label>:964:                                    ; preds = %957, %953
  %965 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 11
  %966 = load i32, i32* %965, align 4
  %967 = icmp eq i32 %966, 2
  br i1 %967, label %968, label %975

; <label>:968:                                    ; preds = %964
  %969 = load i16, i16* %852, align 4
  %970 = lshr i16 %969, 11
  %971 = and i16 %970, 1
  %972 = zext i16 %971 to i32
  %973 = icmp eq i32 %972, 1
  br i1 %973, label %974, label %975

; <label>:974:                                    ; preds = %968
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.153, i64 0, i64 0))
  br label %1095

; <label>:975:                                    ; preds = %964, %968, %949
  %976 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 12
  %977 = load i32, i32* %976, align 8
  %978 = icmp ne i32 %977, 0
  br i1 %978, label %979, label %1001

; <label>:979:                                    ; preds = %975
  %980 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 12
  %981 = load i32, i32* %980, align 8
  %982 = icmp eq i32 %981, 1
  br i1 %982, label %983, label %990

; <label>:983:                                    ; preds = %979
  %984 = load i16, i16* %855, align 4
  %985 = lshr i16 %984, 12
  %986 = and i16 %985, 1
  %987 = zext i16 %986 to i32
  %988 = icmp ne i32 %987, 1
  br i1 %988, label %989, label %990

; <label>:989:                                    ; preds = %983
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.154, i64 0, i64 0))
  br label %1095

; <label>:990:                                    ; preds = %983, %979
  %991 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 12
  %992 = load i32, i32* %991, align 8
  %993 = icmp eq i32 %992, 2
  br i1 %993, label %994, label %1001

; <label>:994:                                    ; preds = %990
  %995 = load i16, i16* %858, align 4
  %996 = lshr i16 %995, 12
  %997 = and i16 %996, 1
  %998 = zext i16 %997 to i32
  %999 = icmp eq i32 %998, 1
  br i1 %999, label %1000, label %1001

; <label>:1000:                                   ; preds = %994
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.155, i64 0, i64 0))
  br label %1095

; <label>:1001:                                   ; preds = %990, %994, %975
  %1002 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 13
  %1003 = load i32, i32* %1002, align 4
  %1004 = icmp ne i32 %1003, 0
  br i1 %1004, label %1005, label %1027

; <label>:1005:                                   ; preds = %1001
  %1006 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 13
  %1007 = load i32, i32* %1006, align 4
  %1008 = icmp eq i32 %1007, 1
  br i1 %1008, label %1009, label %1016

; <label>:1009:                                   ; preds = %1005
  %1010 = load i16, i16* %861, align 4
  %1011 = lshr i16 %1010, 13
  %1012 = and i16 %1011, 1
  %1013 = zext i16 %1012 to i32
  %1014 = icmp ne i32 %1013, 1
  br i1 %1014, label %1015, label %1016

; <label>:1015:                                   ; preds = %1009
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.156, i64 0, i64 0))
  br label %1095

; <label>:1016:                                   ; preds = %1009, %1005
  %1017 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 13
  %1018 = load i32, i32* %1017, align 4
  %1019 = icmp eq i32 %1018, 2
  br i1 %1019, label %1020, label %1027

; <label>:1020:                                   ; preds = %1016
  %1021 = load i16, i16* %864, align 4
  %1022 = lshr i16 %1021, 13
  %1023 = and i16 %1022, 1
  %1024 = zext i16 %1023 to i32
  %1025 = icmp eq i32 %1024, 1
  br i1 %1025, label %1026, label %1027

; <label>:1026:                                   ; preds = %1020
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([33 x i8], [33 x i8]* @.str.157, i64 0, i64 0))
  br label %1095

; <label>:1027:                                   ; preds = %1001, %1020, %1016, %.lr.ph
  %1028 = load i8, i8* %823, align 1
  %1029 = zext i8 %1028 to i32
  %1030 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 3
  %1031 = getelementptr inbounds [32 x i16], [32 x i16]* %1030, i64 0, i64 0
  %1032 = load i16, i16* %1031, align 2
  %1033 = zext i16 %1032 to i32
  %1034 = icmp eq i32 %1029, %1033
  br i1 %1034, label %1035, label %1095

; <label>:1035:                                   ; preds = %1027
  %1036 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 2
  %1037 = getelementptr inbounds [32 x i16], [32 x i16]* %1036, i64 0, i64 0
  %1038 = load i16, i16* %1037, align 2
  %1039 = zext i16 %1038 to i32
  %1040 = icmp eq i32 %824, %1039
  br i1 %1040, label %1041, label %1095

; <label>:1041:                                   ; preds = %1035
  %1042 = call noalias i8* @malloc(i64 48) #7, !track !55
  %1043 = bitcast i8* %1042 to %struct.knocker*
  %1044 = getelementptr inbounds %struct.knocker, %struct.knocker* %1043, i32 0, i32 3
  store i8* null, i8** %1044, align 8
  %1045 = icmp eq %struct.knocker* %1043, null
  br i1 %1045, label %1046, label %1048

; <label>:1046:                                   ; preds = %1041
  %1047 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %1047)
  call void @exit(i32 1) #9
  unreachable

; <label>:1048:                                   ; preds = %1041
  %1049 = getelementptr inbounds %struct.knocker, %struct.knocker* %1043, i32 0, i32 2
  %1050 = getelementptr inbounds [16 x i8], [16 x i8]* %1049, i32 0, i32 0
  %1051 = call i8* @strcpy(i8* %1050, i8* %834) #7, !track !56
  %1052 = load i32, i32* @o_lookup, align 4
  %1053 = icmp ne i32 %1052, 0
  br i1 %1053, label %1054, label %1063

; <label>:1054:                                   ; preds = %1048
  %1055 = load i32, i32* %841, align 4
  store i32 %1055, i32* %842, align 4
  %1056 = call %struct.hostent* @gethostbyaddr(i8* %843, i32 4, i32 2), !track !57
  %1057 = icmp ne %struct.hostent* %1056, null
  br i1 %1057, label %1058, label %1063

; <label>:1058:                                   ; preds = %1054
  %1059 = getelementptr inbounds %struct.hostent, %struct.hostent* %1056, i32 0, i32 0
  %1060 = load i8*, i8** %1059, align 8
  %1061 = call noalias i8* @strdup(i8* %1060) #7, !track !58
  %1062 = getelementptr inbounds %struct.knocker, %struct.knocker* %1043, i32 0, i32 3
  store i8* %1061, i8** %1062, align 8
  br label %1063

; <label>:1063:                                   ; preds = %1054, %1058, %1048
  %1064 = getelementptr inbounds %struct.knocker, %struct.knocker* %1043, i32 0, i32 1
  store i16 1, i16* %1064, align 8
  %1065 = load i64, i64* %8, align 8
  %1066 = getelementptr inbounds %struct.knocker, %struct.knocker* %1043, i32 0, i32 4
  store i64 %1065, i64* %1066, align 8
  %1067 = getelementptr inbounds %struct.knocker, %struct.knocker* %1043, i32 0, i32 0
  store %struct.opendoor* %867, %struct.opendoor** %1067, align 8
  %1068 = getelementptr inbounds %struct.knocker, %struct.knocker* %1043, i32 0, i32 3
  %1069 = load i8*, i8** %1068, align 8
  %1070 = icmp ne i8* %1069, null
  %1071 = getelementptr inbounds %struct.knocker, %struct.knocker* %1043, i32 0, i32 2
  %1072 = getelementptr inbounds [16 x i8], [16 x i8]* %1071, i32 0, i32 0
  br i1 %1070, label %1073, label %1084

; <label>:1073:                                   ; preds = %1063
  %1074 = getelementptr inbounds %struct.knocker, %struct.knocker* %1043, i32 0, i32 3
  %1075 = load i8*, i8** %1074, align 8
  %1076 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 0
  %1077 = getelementptr inbounds [128 x i8], [128 x i8]* %1076, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.174, i64 0, i64 0), i8* %1072, i8* %1075, i8* %1077)
  %1078 = getelementptr inbounds %struct.knocker, %struct.knocker* %1043, i32 0, i32 2
  %1079 = getelementptr inbounds [16 x i8], [16 x i8]* %1078, i32 0, i32 0
  %1080 = getelementptr inbounds %struct.knocker, %struct.knocker* %1043, i32 0, i32 3
  %1081 = load i8*, i8** %1080, align 8
  %1082 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 0
  %1083 = getelementptr inbounds [128 x i8], [128 x i8]* %1082, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.175, i64 0, i64 0), i8* %1079, i8* %1081, i8* %1083)
  br label %1091

; <label>:1084:                                   ; preds = %1063
  %1085 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 0
  %1086 = getelementptr inbounds [128 x i8], [128 x i8]* %1085, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.176, i64 0, i64 0), i8* %1072, i8* %1086)
  %1087 = getelementptr inbounds %struct.knocker, %struct.knocker* %1043, i32 0, i32 2
  %1088 = getelementptr inbounds [16 x i8], [16 x i8]* %1087, i32 0, i32 0
  %1089 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %867, i32 0, i32 0
  %1090 = getelementptr inbounds [128 x i8], [128 x i8]* %1089, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.177, i64 0, i64 0), i8* %1088, i8* %1090)
  br label %1091

; <label>:1091:                                   ; preds = %1084, %1073
  %1092 = load %struct.__pmlist_t*, %struct.__pmlist_t** @attempts, align 8
  %1093 = bitcast %struct.knocker* %1043 to i8*
  %1094 = call %struct.__pmlist_t* @list_add(%struct.__pmlist_t* %1092, i8* %1093)
  store %struct.__pmlist_t* %1094, %struct.__pmlist_t** @attempts, align 8
  br label %1095

; <label>:1095:                                   ; preds = %1027, %1035, %1091, %1026, %1015, %1000, %989, %974, %963, %948, %937, %922, %911, %896, %885
  %1096 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.22224, i32 0, i32 2
  %1097 = load %struct.__pmlist_t*, %struct.__pmlist_t** %1096, align 8
  %1098 = icmp ne %struct.__pmlist_t* %1097, null
  br i1 %1098, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %1095
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %556, %819, %795, %801, %634, %815, %817, %46, %18, %44, %55, %66
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

.lr.ph32:                                         ; preds = %.lr.ph32.preheader, %43
  %.0130 = phi i64 [ %45, %43 ], [ 0, %.lr.ph32.preheader ]
  %.1329 = phi i64 [ %.5, %43 ], [ %spec.select, %.lr.ph32.preheader ]
  %.1628 = phi i8* [ %.38, %43 ], [ %.05, %.lr.ph32.preheader ]
  %.0927 = phi i8* [ %.413, %43 ], [ %0, %.lr.ph32.preheader ]
  %.01426 = phi i8* [ %44, %43 ], [ %2, %.lr.ph32.preheader ]
  %.01625 = phi i8* [ %.218, %43 ], [ %3, %.lr.ph32.preheader ]
  %15 = icmp ult i8* %.01426, %.1628
  br i1 %15, label %16, label %22

; <label>:16:                                     ; preds = %.lr.ph32
  %17 = icmp ne i64 %.1329, 1
  br i1 %17, label %18, label %43

; <label>:18:                                     ; preds = %16
  %19 = load i8, i8* %.01426, align 1
  %20 = getelementptr inbounds i8, i8* %.0927, i32 1
  store i8 %19, i8* %.0927, align 1
  %21 = add i64 %.1329, -1
  br label %43

; <label>:22:                                     ; preds = %.lr.ph32
  %23 = load i8, i8* %.01625, align 1
  %24 = sext i8 %23 to i32
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %22
  %scevgep = getelementptr i8, i8* %.01625, i64 1
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %31
  %lsr.iv = phi i8* [ %scevgep, %.lr.ph.preheader ], [ %scevgep1, %31 ]
  %.122 = phi i64 [ %32, %31 ], [ %.0130, %.lr.ph.preheader ]
  %.321 = phi i64 [ %.4, %31 ], [ %.1329, %.lr.ph.preheader ]
  %.21120 = phi i8* [ %.312, %31 ], [ %.0927, %.lr.ph.preheader ]
  %scevgep2 = getelementptr i8, i8* %lsr.iv, i64 -1
  %26 = icmp ne i64 %.321, 1
  br i1 %26, label %27, label %31

; <label>:27:                                     ; preds = %.lr.ph
  %28 = load i8, i8* %scevgep2, align 1
  %29 = getelementptr inbounds i8, i8* %.21120, i32 1
  store i8 %28, i8* %.21120, align 1
  %30 = add i64 %.321, -1
  br label %31

; <label>:31:                                     ; preds = %27, %.lr.ph
  %.312 = phi i8* [ %29, %27 ], [ %.21120, %.lr.ph ]
  %.4 = phi i64 [ %30, %27 ], [ %.321, %.lr.ph ]
  %32 = add i64 %.122, 1
  %33 = load i8, i8* %lsr.iv, align 1
  %34 = sext i8 %33 to i32
  %35 = icmp ne i32 %34, 0
  %scevgep1 = getelementptr i8, i8* %lsr.iv, i64 1
  br i1 %35, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %31
  %.211.lcssa.ph = phi i8* [ %.312, %31 ]
  %.3.lcssa.ph = phi i64 [ %.4, %31 ]
  %.1.lcssa.ph = phi i64 [ %32, %31 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %22
  %.211.lcssa = phi i8* [ %.0927, %22 ], [ %.211.lcssa.ph, %._crit_edge.loopexit ]
  %.3.lcssa = phi i64 [ %.1329, %22 ], [ %.3.lcssa.ph, %._crit_edge.loopexit ]
  %.1.lcssa = phi i64 [ %.0130, %22 ], [ %.1.lcssa.ph, %._crit_edge.loopexit ]
  %36 = getelementptr inbounds i8, i8* %.01426, i64 4
  %37 = call i8* @strstr(i8* %36, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.128, i64 0, i64 0)) #10, !track !60
  %38 = icmp ne i8* %37, null
  %39 = getelementptr inbounds i8, i8* %36, i64 %5
  %40 = getelementptr inbounds i8, i8* %39, i64 1
  %.27 = select i1 %38, i8* %37, i8* %40
  %41 = getelementptr inbounds i8, i8* %36, i32 -1
  %42 = add i64 %.1.lcssa, -1
  br label %43

; <label>:43:                                     ; preds = %16, %18, %._crit_edge
  %.218 = phi i8* [ %3, %._crit_edge ], [ %.01625, %18 ], [ %.01625, %16 ]
  %.115 = phi i8* [ %41, %._crit_edge ], [ %.01426, %18 ], [ %.01426, %16 ]
  %.413 = phi i8* [ %.211.lcssa, %._crit_edge ], [ %20, %18 ], [ %.0927, %16 ]
  %.38 = phi i8* [ %.27, %._crit_edge ], [ %.1628, %18 ], [ %.1628, %16 ]
  %.5 = phi i64 [ %.3.lcssa, %._crit_edge ], [ %21, %18 ], [ %.1329, %16 ]
  %.2 = phi i64 [ %42, %._crit_edge ], [ %.0130, %18 ], [ %.0130, %16 ]
  %44 = getelementptr inbounds i8, i8* %.115, i32 1
  %45 = add i64 %.2, 1
  %46 = load i8, i8* %44, align 1
  %47 = sext i8 %46 to i32
  %48 = icmp ne i32 %47, 0
  br i1 %48, label %.lr.ph32, label %._crit_edge33.loopexit

._crit_edge33.loopexit:                           ; preds = %43
  %.09.lcssa.ph = phi i8* [ %.413, %43 ]
  %.01.lcssa.ph = phi i64 [ %45, %43 ]
  br label %._crit_edge33

._crit_edge33:                                    ; preds = %._crit_edge33.loopexit, %4
  %.09.lcssa = phi i8* [ %0, %4 ], [ %.09.lcssa.ph, %._crit_edge33.loopexit ]
  %.01.lcssa = phi i64 [ 0, %4 ], [ %.01.lcssa.ph, %._crit_edge33.loopexit ]
  %49 = icmp ne i32 %spec.select1, 0
  br i1 %49, label %50, label %51

; <label>:50:                                     ; preds = %._crit_edge33
  store i8 0, i8* %.09.lcssa, align 1
  br label %51

; <label>:51:                                     ; preds = %50, %._crit_edge33
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
  %12 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %13 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %14 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  %15 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %16 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.outer
  %.01.ph3 = phi i32 [ %31, %.outer ], [ %6, %.lr.ph.preheader ]
  br label %21

; <label>:17:                                     ; preds = %35
  %18 = load %struct._IO_FILE*, %struct._IO_FILE** %8, align 8
  %19 = call i8* @fgets(i8* %7, i32 100, %struct._IO_FILE* %18), !track !63
  %20 = icmp ne i8* %19, null
  br i1 %20, label %21, label %.outer._crit_edge.loopexit

; <label>:21:                                     ; preds = %.lr.ph, %17
  %22 = call i8* @trim(i8* %12)
  %23 = call i64 @strlen(i8* %13) #10
  %24 = icmp eq i64 %23, 0
  br i1 %24, label %.outer, label %25

; <label>:25:                                     ; preds = %21
  %26 = load i8, i8* %14, align 16
  %27 = sext i8 %26 to i32
  %28 = icmp eq i32 %27, 35
  br i1 %28, label %.outer, label %35

.outer:                                           ; preds = %25, %21
  %29 = load %struct._IO_FILE*, %struct._IO_FILE** %16, align 8
  %30 = call i64 @ftell(%struct._IO_FILE* %29)
  %31 = trunc i64 %30 to i32
  %32 = load %struct._IO_FILE*, %struct._IO_FILE** %8, align 8
  %33 = call i8* @fgets(i8* %7, i32 100, %struct._IO_FILE* %32), !track !64
  %34 = icmp ne i8* %33, null
  br i1 %34, label %.lr.ph, label %.outer._crit_edge.loopexit1

; <label>:35:                                     ; preds = %25
  %36 = call i32 @parse_port_sequence(i8* %15, %struct.opendoor* %0)
  %37 = icmp sgt i32 %36, 0
  br i1 %37, label %17, label %38

; <label>:38:                                     ; preds = %35
  %.01.lcssa2 = phi i32 [ %.01.ph3, %35 ]
  %39 = sext i32 %.01.lcssa2 to i64
  br label %.outer._crit_edge

.outer._crit_edge.loopexit:                       ; preds = %17
  %.0.ph = phi i64 [ -1, %17 ]
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
  br i1 %5, label %6, label %42

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
  %17 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  %scevgep = getelementptr %struct.opendoor, %struct.opendoor* %0, i64 0, i32 2, i64 0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %35
  %indvars.iv = phi i64 [ %indvars.iv.next, %35 ], [ 0, %.lr.ph.preheader ]
  %scevgep1 = getelementptr i16, i16* %scevgep, i64 %indvars.iv
  %scevgep2 = getelementptr i16, i16* %scevgep1, i64 32
  %18 = load i16, i16* %scevgep2, align 2
  %19 = zext i16 %18 to i32
  %cond = icmp eq i32 %19, 17
  %20 = load i16, i16* %17, align 8
  %21 = zext i16 %20 to i32
  %22 = sub nsw i32 %21, 1
  %23 = zext i32 %22 to i64
  %24 = icmp eq i64 %indvars.iv, %23
  br i1 %cond, label %25, label %30

; <label>:25:                                     ; preds = %.lr.ph
  %26 = select i1 %24, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.30, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.31, i64 0, i64 0)
  %scevgep4 = getelementptr i16, i16* %scevgep, i64 %indvars.iv
  %27 = load i16, i16* %scevgep4, align 2
  %28 = zext i16 %27 to i32
  %29 = call i32 (i8*, ...) @printf(i8* %26, i32 %28)
  br label %35

; <label>:30:                                     ; preds = %.lr.ph
  %31 = select i1 %24, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.32, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.33, i64 0, i64 0)
  %scevgep3 = getelementptr i16, i16* %scevgep, i64 %indvars.iv
  %32 = load i16, i16* %scevgep3, align 2
  %33 = zext i16 %32 to i32
  %34 = call i32 (i8*, ...) @printf(i8* %31, i32 %33)
  br label %35

; <label>:35:                                     ; preds = %25, %30
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %36 = load i16, i16* %13, align 8
  %37 = zext i16 %36 to i32
  %38 = zext i32 %37 to i64
  %39 = icmp ult i64 %indvars.iv.next, %38
  br i1 %39, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %35
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %6
  %40 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %41 = call i32 @fflush(%struct._IO_FILE* %40)
  br label %42

; <label>:42:                                     ; preds = %._crit_edge, %2
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
  %scevgep3 = getelementptr i8, i8* %0, i64 -1
  br label %2

; <label>:2:                                      ; preds = %2, %1
  %lsr.iv4 = phi i8* [ %scevgep5, %2 ], [ %scevgep3, %1 ]
  %scevgep6 = getelementptr i8, i8* %lsr.iv4, i64 1
  %3 = call i16** @__ctype_b_loc() #11
  %4 = load i16*, i16** %3, align 8
  %5 = load i8, i8* %scevgep6, align 1
  %6 = sext i8 %5 to i32
  %7 = sext i32 %6 to i64
  %8 = getelementptr inbounds i16, i16* %4, i64 %7
  %9 = load i16, i16* %8, align 2
  %10 = zext i16 %9 to i32
  %11 = and i32 %10, 8192
  %12 = icmp ne i32 %11, 0
  %scevgep5 = getelementptr i8, i8* %lsr.iv4, i64 1
  br i1 %12, label %2, label %13

; <label>:13:                                     ; preds = %2
  %.0.lcssa = phi i8* [ %scevgep5, %2 ]
  %14 = icmp ne i8* %.0.lcssa, %0
  br i1 %14, label %15, label %18

; <label>:15:                                     ; preds = %13
  %16 = call i64 @strlen(i8* %.0.lcssa) #10
  %17 = add i64 %16, 1
  call void @llvm.memmove.p0i8.p0i8.i64(i8* align 1 %0, i8* align 1 %.0.lcssa, i64 %17, i1 false), !track !65
  br label %18

; <label>:18:                                     ; preds = %15, %13
  %19 = call i64 @strlen(i8* %0) #10
  %scevgep = getelementptr i8, i8* %0, i64 %19
  br label %20

; <label>:20:                                     ; preds = %20, %18
  %lsr.iv = phi i8* [ %scevgep1, %20 ], [ %scevgep, %18 ]
  %scevgep2 = getelementptr i8, i8* %lsr.iv, i64 -1
  %21 = call i16** @__ctype_b_loc() #11
  %22 = load i16*, i16** %21, align 8
  %23 = load i8, i8* %scevgep2, align 1
  %24 = sext i8 %23 to i32
  %25 = sext i32 %24 to i64
  %26 = getelementptr inbounds i16, i16* %22, i64 %25
  %27 = load i16, i16* %26, align 2
  %28 = zext i16 %27 to i32
  %29 = and i32 %28, 8192
  %30 = icmp ne i32 %29, 0
  %scevgep1 = getelementptr i8, i8* %lsr.iv, i64 -1
  br i1 %30, label %20, label %31

; <label>:31:                                     ; preds = %20
  %.1.lcssa = phi i8* [ %scevgep1, %20 ]
  %32 = getelementptr inbounds i8, i8* %.1.lcssa, i32 1
  store i8 0, i8* %32, align 1
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
  %9 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %10 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 2
  %11 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %12 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 3
  %13 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %14 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 3
  %15 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %16 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 3
  %17 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %75
  %18 = load i16, i16* %9, align 8
  %19 = zext i16 %18 to i32
  %20 = icmp sge i32 %19, 32
  br i1 %20, label %21, label %30

; <label>:21:                                     ; preds = %.lr.ph
  %22 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %23 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 0
  %24 = getelementptr inbounds [128 x i8], [128 x i8]* %23, i32 0, i32 0
  %25 = getelementptr [54 x i8], [54 x i8]* @.str.102, i32 0, i32 0
  %26 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %22, i8* %25, i8* %24)
  %27 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 0
  %28 = getelementptr inbounds [128 x i8], [128 x i8]* %27, i32 0, i32 0
  %29 = getelementptr [53 x i8], [53 x i8]* @.str.103, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %29, i8* %28)
  br label %._crit_edge

; <label>:30:                                     ; preds = %.lr.ph
  %31 = call i8* @strsep(i8** %4, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.104, i64 0, i64 0)) #7
  %32 = call i32 @atoi(i8* %31) #10
  %33 = trunc i32 %32 to i16
  %34 = load i16, i16* %11, align 8
  %35 = add i16 %34, 1
  store i16 %35, i16* %11, align 8
  %36 = zext i16 %34 to i64
  %37 = getelementptr inbounds [32 x i16], [32 x i16]* %10, i64 0, i64 %36
  store i16 %33, i16* %37, align 2
  %38 = call i8* @strsep(i8** %4, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.104, i64 0, i64 0)) #7
  %39 = icmp ne i8* %38, null
  br i1 %39, label %40, label %69

; <label>:40:                                     ; preds = %30
  %41 = call i8* @trim(i8* %38)
  %42 = call i8* @strtoupper(i8* %41)
  %43 = call i32 @strcmp(i8* %42, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.105, i64 0, i64 0)) #10
  %44 = icmp ne i32 %43, 0
  br i1 %44, label %51, label %45

; <label>:45:                                     ; preds = %40
  %46 = load i16, i16* %15, align 8
  %47 = zext i16 %46 to i32
  %48 = sub nsw i32 %47, 1
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [32 x i16], [32 x i16]* %14, i64 0, i64 %49
  store i16 6, i16* %50, align 2
  br label %75

; <label>:51:                                     ; preds = %40
  %52 = call i32 @strcmp(i8* %42, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.106, i64 0, i64 0)) #10
  %53 = icmp ne i32 %52, 0
  br i1 %53, label %60, label %54

; <label>:54:                                     ; preds = %51
  %55 = load i16, i16* %17, align 8
  %56 = zext i16 %55 to i32
  %57 = sub nsw i32 %56, 1
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds [32 x i16], [32 x i16]* %16, i64 0, i64 %58
  store i16 17, i16* %59, align 2
  br label %75

; <label>:60:                                     ; preds = %51
  %61 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %62 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 0
  %63 = getelementptr inbounds [128 x i8], [128 x i8]* %62, i32 0, i32 0
  %64 = getelementptr [56 x i8], [56 x i8]* @.str.107, i32 0, i32 0
  %65 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %61, i8* %64, i8* %63)
  %66 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 0
  %67 = getelementptr inbounds [128 x i8], [128 x i8]* %66, i32 0, i32 0
  %68 = getelementptr [55 x i8], [55 x i8]* @.str.108, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %68, i8* %67)
  br label %._crit_edge

; <label>:69:                                     ; preds = %30
  %70 = load i16, i16* %13, align 8
  %71 = zext i16 %70 to i32
  %72 = sub nsw i32 %71, 1
  %73 = sext i32 %72 to i64
  %74 = getelementptr inbounds [32 x i16], [32 x i16]* %12, i64 0, i64 %73
  store i16 6, i16* %74, align 2
  br label %75

; <label>:75:                                     ; preds = %45, %54, %69
  %76 = call i8* @strsep(i8** %3, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.86, i64 0, i64 0)) #7
  store i8* %76, i8** %4, align 8
  %77 = icmp ne i8* %76, null
  br i1 %77, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %75
  %.0.ph = phi i32 [ 0, %75 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %2, %60, %21
  %.0 = phi i32 [ 1, %21 ], [ 1, %60 ], [ 0, %2 ], [ %.0.ph, %._crit_edge.loopexit ]
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
  %4 = load i8, i8* %.01, align 1
  %5 = sext i8 %4 to i32
  %6 = call i32 @toupper(i32 %5) #10
  %7 = trunc i32 %6 to i8
  store i8 %7, i8* %.01, align 1
  %8 = getelementptr inbounds i8, i8* %.01, i32 1
  %scevgep = getelementptr i8, i8* %.01, i64 1
  %9 = load i8, i8* %scevgep, align 1
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
  %17 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  %18 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %2, i32 0, i32 1
  %19 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 2
  %20 = getelementptr inbounds [32 x i16], [32 x i16]* %19, i32 0, i32 0
  %21 = bitcast i16* %20 to i8*
  %22 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %2, i32 0, i32 2
  %23 = getelementptr inbounds [32 x i16], [32 x i16]* %22, i32 0, i32 0
  %24 = bitcast i16* %23 to i8*
  %25 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %41
  %.013 = phi i64 [ %42, %41 ], [ %8, %.lr.ph.preheader ]
  %26 = load i16, i16* %17, align 8
  %27 = zext i16 %26 to i32
  %28 = load i16, i16* %18, align 8
  %29 = zext i16 %28 to i32
  %30 = icmp eq i32 %27, %29
  br i1 %30, label %31, label %41

; <label>:31:                                     ; preds = %.lr.ph
  %32 = load i16, i16* %25, align 8
  %33 = zext i16 %32 to i64
  %34 = call i32 @memcmp(i8* %21, i8* %24, i64 %33) #10
  %35 = icmp eq i32 %34, 0
  br i1 %35, label %36, label %41

; <label>:36:                                     ; preds = %31
  %37 = load i16, i16* %16, align 8
  %38 = zext i16 %37 to i64
  %39 = call i32 @memcmp(i8* %12, i8* %15, i64 %38) #10
  %40 = icmp eq i32 %39, 0
  br i1 %40, label %._crit_edge.loopexit, label %41

; <label>:41:                                     ; preds = %31, %36, %.lr.ph
  %42 = call i64 @get_next_one_time_sequence(%struct.opendoor* %2)
  %43 = icmp sge i64 %42, 0
  br i1 %43, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %36, %41
  %.0.ph = phi i64 [ %.013, %36 ], [ -1, %41 ]
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
  %2 = icmp ne %struct.__pmlist_t* %0, null
  br i1 %2, label %.lr.ph.preheader, label %.critedge

.lr.ph.preheader:                                 ; preds = %1
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %6
  %.01 = phi %struct.__pmlist_t* [ %8, %6 ], [ %0, %.lr.ph.preheader ]
  %3 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.01, i32 0, i32 2
  %4 = load %struct.__pmlist_t*, %struct.__pmlist_t** %3, align 8
  %5 = icmp ne %struct.__pmlist_t* %4, null
  br i1 %5, label %6, label %.critedge.loopexit

; <label>:6:                                      ; preds = %.lr.ph
  %7 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.01, i32 0, i32 2
  %8 = load %struct.__pmlist_t*, %struct.__pmlist_t** %7, align 8
  %9 = icmp ne %struct.__pmlist_t* %8, null
  br i1 %9, label %.lr.ph, label %.critedge.loopexit

.critedge.loopexit:                               ; preds = %6, %.lr.ph
  %.0.lcssa.ph = phi %struct.__pmlist_t* [ %.01, %.lr.ph ], [ %8, %6 ]
  br label %.critedge

.critedge:                                        ; preds = %.critedge.loopexit, %1
  %.0.lcssa = phi %struct.__pmlist_t* [ %0, %1 ], [ %.0.lcssa.ph, %.critedge.loopexit ]
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
  %.0.ph = phi i32 [ 1, %.lr.ph ], [ 0, %7 ]
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
  %.0.ph = phi i32 [ 1, %7 ], [ 0, %12 ]
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
  br i1 %2, label %25, label %.lr.ph9

.lr.ph9:                                          ; preds = %1
  %3 = call i32 @list_count(%struct.__pmlist_t* %0)
  %4 = zext i32 %3 to i64
  %5 = mul i64 %4, 8
  %6 = call noalias i8* @malloc(i64 %5) #7
  %7 = bitcast i8* %6 to i8**
  br label %8

; <label>:8:                                      ; preds = %.lr.ph9, %8
  %lsr.iv2 = phi i8* [ %6, %.lr.ph9 ], [ %scevgep3, %8 ]
  %.026 = phi %struct.__pmlist_t* [ %0, %.lr.ph9 ], [ %12, %8 ]
  %lsr.iv24 = bitcast i8* %lsr.iv2 to i8**
  %9 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.026, i32 0, i32 0
  %10 = load i8*, i8** %9, align 8
  store i8* %10, i8** %lsr.iv24, align 8
  %11 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.026, i32 0, i32 2
  %12 = load %struct.__pmlist_t*, %struct.__pmlist_t** %11, align 8
  %13 = icmp ne %struct.__pmlist_t* %12, null
  %scevgep3 = getelementptr i8, i8* %lsr.iv2, i64 8
  br i1 %13, label %8, label %._crit_edge10

._crit_edge10:                                    ; preds = %8
  %14 = bitcast i8** %7 to i8*
  %15 = zext i32 %3 to i64
  call void @qsort(i8* %14, i64 %15, i64 8, i32 (i8*, i8*)* @list_strcmp)
  %16 = icmp ult i32 0, %3
  br i1 %16, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %._crit_edge10
  %17 = zext i32 %3 to i64
  %18 = shl i64 %17, 3
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %lsr.iv = phi i64 [ 0, %.lr.ph.preheader ], [ %lsr.iv.next, %.lr.ph ]
  %.134 = phi %struct.__pmlist_t* [ %21, %.lr.ph ], [ null, %.lr.ph.preheader ]
  %scevgep = getelementptr i8, i8* %6, i64 %lsr.iv
  %scevgep1 = bitcast i8* %scevgep to i8**
  %19 = load i8*, i8** %scevgep1, align 8
  %20 = call noalias i8* @strdup(i8* %19) #7, !track !71
  %21 = call %struct.__pmlist_t* @list_add(%struct.__pmlist_t* %.134, i8* %20)
  %lsr.iv.next = add nuw nsw i64 %lsr.iv, 8
  %exitcond1 = icmp ne i64 %18, %lsr.iv.next
  br i1 %exitcond1, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.13.lcssa.ph = phi %struct.__pmlist_t* [ %21, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %._crit_edge10
  %.13.lcssa = phi %struct.__pmlist_t* [ null, %._crit_edge10 ], [ %.13.lcssa.ph, %._crit_edge.loopexit ]
  %22 = icmp ne i8** %7, null
  br i1 %22, label %23, label %25

; <label>:23:                                     ; preds = %._crit_edge
  %24 = bitcast i8** %7 to i8*
  call void @free(i8* %24) #7
  br label %25

; <label>:25:                                     ; preds = %._crit_edge, %23, %1
  %.0 = phi %struct.__pmlist_t* [ null, %1 ], [ %.13.lcssa, %23 ], [ %.13.lcssa, %._crit_edge ]
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
  br i1 %13, label %.lr.ph8, label %37

.lr.ph8:                                          ; preds = %8
  %14 = add i32 %10, 1
  %15 = add nsw i32 %10, 1
  %16 = icmp slt i32 0, %15
  br label %17

; <label>:17:                                     ; preds = %.lr.ph8, %._crit_edge
  %.016 = phi %struct.__pmlist_t* [ %1, %.lr.ph8 ], [ %33, %._crit_edge ]
  %.025 = phi i32 [ %10, %.lr.ph8 ], [ %31, %._crit_edge ]
  %18 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.016, i32 0, i32 0
  %19 = load i8*, i8** %18, align 8
  %20 = call i64 @strlen(i8* %19) #10
  %21 = add i64 %20, 1
  %22 = trunc i64 %21 to i32
  %23 = add nsw i32 %22, %.025
  %24 = icmp sge i32 %23, %.03
  br i1 %24, label %25, label %._crit_edge

; <label>:25:                                     ; preds = %17
  %26 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2.180, i64 0, i64 0))
  br i1 %16, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %25
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %.lr.ph
  %lsr.iv = phi i32 [ %14, %.lr.ph.preheader ], [ %lsr.iv.next, %.lr.ph ]
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3.181, i64 0, i64 0))
  %lsr.iv.next = add i32 %lsr.iv, -1
  %exitcond = icmp ne i32 %lsr.iv.next, 0
  br i1 %exitcond, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.1.ph = phi i32 [ %10, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %25, %17
  %.1 = phi i32 [ %.025, %17 ], [ %10, %25 ], [ %.1.ph, %._crit_edge.loopexit ]
  %28 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.016, i32 0, i32 0
  %29 = load i8*, i8** %28, align 8
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1.179, i64 0, i64 0), i8* %29)
  %31 = add nsw i32 %.1, %22
  %32 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.016, i32 0, i32 2
  %33 = load %struct.__pmlist_t*, %struct.__pmlist_t** %32, align 8
  %34 = icmp ne %struct.__pmlist_t* %33, null
  br i1 %34, label %17, label %._crit_edge9

._crit_edge9:                                     ; preds = %._crit_edge
  %35 = getelementptr [2 x i8], [2 x i8]* @.str.2.180, i32 0, i32 0
  %36 = call i32 (i8*, ...) @printf(i8* %35)
  br label %40

; <label>:37:                                     ; preds = %8
  %38 = getelementptr [6 x i8], [6 x i8]* @.str.4.182, i32 0, i32 0
  %39 = call i32 (i8*, ...) @printf(i8* %38)
  br label %40

; <label>:40:                                     ; preds = %37, %._crit_edge9
  ret void
}

; Function Attrs: nounwind
declare dso_local i8* @getenv(i8*) #2

declare void @unroll_loop(i32)

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i1) #1

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
  %28 = icmp ne i32 105, 0
  br i1 true, label %.lr.ph.preheader, label %.loopexit

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader
  br i1 false, label %.loopexit.loopexit, label %29

; <label>:29:                                     ; preds = %.lr.ph
  switch i32 105, label %41 [
    i32 0, label %42
    i32 118, label %30
    i32 68, label %31
    i32 100, label %32
    i32 108, label %33
    i32 105, label %34
    i32 99, label %37
    i32 86, label %40
  ]

; <label>:30:                                     ; preds = %29
  store i32 1, i32* @o_verbose, align 4
  br label %42

; <label>:31:                                     ; preds = %29
  store i32 1, i32* @o_debug, align 4
  br label %42

; <label>:32:                                     ; preds = %29
  store i32 1, i32* @o_daemon, align 4
  br label %42

; <label>:33:                                     ; preds = %29
  store i32 1, i32* @o_lookup, align 4
  br label %42

; <label>:34:                                     ; preds = %29
  %35 = load i8*, i8** @optarg, align 8
  %36 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %35, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %42

; <label>:37:                                     ; preds = %29
  %38 = load i8*, i8** @optarg, align 8
  %39 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %38, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %42

; <label>:40:                                     ; preds = %29
  call void @ver()
  br label %41

; <label>:41:                                     ; preds = %40, %29
  call void @usage()
  br label %42

; <label>:42:                                     ; preds = %41, %37, %34, %33, %32, %31, %30, %29
  %43 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %44 = icmp ne i32 -1, 0
  br i1 true, label %.lr.ph.1, label %.loopexit.loopexit

.loopexit.loopexit:                               ; preds = %485, %.lr.ph.19, %468, %.lr.ph.18, %451, %.lr.ph.17, %434, %.lr.ph.16, %417, %.lr.ph.15, %400, %.lr.ph.14, %383, %.lr.ph.13, %366, %.lr.ph.12, %349, %.lr.ph.11, %332, %.lr.ph.10, %315, %.lr.ph.9, %298, %.lr.ph.8, %281, %.lr.ph.7, %264, %.lr.ph.6, %247, %.lr.ph.5, %230, %.lr.ph.4, %213, %.lr.ph.3, %196, %.lr.ph.2, %179, %.lr.ph.1, %42, %.lr.ph
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %2
  %45 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i32 0, i32 0
  %46 = call i32 @parseconfig_clone(i8* %45)
  %47 = icmp ne i32 %46, 0
  br i1 %47, label %48, label %49

; <label>:48:                                     ; preds = %.loopexit
  call void @exit(i32 1) #9
  unreachable

; <label>:49:                                     ; preds = %.loopexit
  %50 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %51 = call i64 @strlen(i8* %50) #10
  %52 = icmp eq i64 %51, 0
  br i1 %52, label %53, label %57

; <label>:53:                                     ; preds = %49
  %54 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %55 = getelementptr [5 x i8], [5 x i8]* @.str.9, i32 0, i32 0
  %56 = call i8* @strncpy(i8* %54, i8* %55, i64 32) #7, !track !16
  br label %57

; <label>:57:                                     ; preds = %53, %49
  %58 = load i32, i32* @o_usesyslog, align 4
  %59 = icmp ne i32 %58, 0
  br i1 %59, label %60, label %62

; <label>:60:                                     ; preds = %57
  %61 = getelementptr [7 x i8], [7 x i8]* @.str.10, i32 0, i32 0
  call void @openlog(i8* %61, i32 0, i32 8)
  br label %62

; <label>:62:                                     ; preds = %60, %57
  %63 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  %64 = call i64 @strlen(i8* %63) #10
  %65 = icmp ne i64 %64, 0
  br i1 %65, label %66, label %74

; <label>:66:                                     ; preds = %62
  %67 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  %68 = getelementptr [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %69 = call %struct._IO_FILE* @fopen(i8* %67, i8* %68), !track !17
  store %struct._IO_FILE* %69, %struct._IO_FILE** @logfd, align 8
  %70 = load %struct._IO_FILE*, %struct._IO_FILE** @logfd, align 8
  %71 = icmp eq %struct._IO_FILE* %70, null
  br i1 %71, label %72, label %74

; <label>:72:                                     ; preds = %66
  %73 = getelementptr [29 x i8], [29 x i8]* @.str.12, i32 0, i32 0
  call void @perror(i8* %73)
  br label %74

; <label>:74:                                     ; preds = %72, %66, %62
  %75 = getelementptr inbounds [256 x i8], [256 x i8]* %22, i32 0, i32 0
  %76 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %77 = call %struct.pcap* @pcap_open_live(i8* %76, i32 65535, i32 0, i32 0, i8* %75)
  store %struct.pcap* %77, %struct.pcap** @cap, align 8
  %78 = getelementptr inbounds [256 x i8], [256 x i8]* %22, i32 0, i32 0
  %79 = call i64 @strlen(i8* %78) #10
  %80 = icmp ne i64 %79, 0
  br i1 %80, label %81, label %87

; <label>:81:                                     ; preds = %74
  %82 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %83 = getelementptr inbounds [256 x i8], [256 x i8]* %22, i32 0, i32 0
  %84 = getelementptr [23 x i8], [23 x i8]* @.str.13, i32 0, i32 0
  %85 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %86 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %82, i8* %84, i8* %85, i8* %83)
  br label %87

; <label>:87:                                     ; preds = %81, %74
  %88 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %89 = icmp eq %struct.pcap* %88, null
  br i1 %89, label %90, label %91

; <label>:90:                                     ; preds = %87
  call void @exit(i32 1) #9
  unreachable

; <label>:91:                                     ; preds = %87
  %92 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %93 = call i32 @pcap_datalink(%struct.pcap* %92)
  store i32 %93, i32* @lltype, align 4
  %94 = load i32, i32* @lltype, align 4
  switch i32 %94, label %101 [
    i32 1, label %95
    i32 113, label %97
    i32 12, label %99
  ]

; <label>:95:                                     ; preds = %91
  %96 = getelementptr [29 x i8], [29 x i8]* @.str.14, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %96)
  br label %106

; <label>:97:                                     ; preds = %91
  %98 = getelementptr [55 x i8], [55 x i8]* @.str.15, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %98)
  br label %106

; <label>:99:                                     ; preds = %91
  %100 = getelementptr [42 x i8], [42 x i8]* @.str.16, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %100)
  br label %106

; <label>:101:                                    ; preds = %91
  %102 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %103 = load i32, i32* @lltype, align 4
  %104 = getelementptr [40 x i8], [40 x i8]* @.str.17, i32 0, i32 0
  %105 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %102, i8* %104, i32 %103)
  call void @cleanup(i32 1)
  br label %106

; <label>:106:                                    ; preds = %101, %99, %97, %95
  %107 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %108 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %109 = call i8* @get_ip_clone(i8* %107, i8* %108, i32 32)
  %110 = icmp eq i8* %109, null
  br i1 %110, label %111, label %116

; <label>:111:                                    ; preds = %106
  %112 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %113 = getelementptr [33 x i8], [33 x i8]* @.str.18, i32 0, i32 0
  %114 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %115 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %112, i8* %113, i8* %114)
  call void @cleanup(i32 1)
  br label %119

; <label>:116:                                    ; preds = %106
  %117 = getelementptr [14 x i8], [14 x i8]* @.str.19, i32 0, i32 0
  %118 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  call void (i8*, ...) @dprint_clone(i8* %117, i8* %118)
  br label %119

; <label>:119:                                    ; preds = %116, %111
  call void @generate_pcap_filter_clone()
  %120 = load i32, i32* @o_daemon, align 4
  %121 = icmp ne i32 %120, 0
  br i1 %121, label %122, label %148

; <label>:122:                                    ; preds = %119
  %123 = call i32 @daemon(i32 0, i32 0) #7
  %124 = icmp slt i32 %123, 0
  br i1 %124, label %125, label %127

; <label>:125:                                    ; preds = %122
  %126 = getelementptr [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  call void @perror(i8* %126)
  call void @cleanup(i32 1)
  br label %127

; <label>:127:                                    ; preds = %125, %122
  %128 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  %129 = getelementptr [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %130 = call %struct._IO_FILE* @fopen(i8* %128, i8* %129), !track !18
  %131 = icmp ne %struct._IO_FILE* %130, null
  br i1 %131, label %132, label %137

; <label>:132:                                    ; preds = %127
  %133 = call i32 @getpid() #7
  %134 = getelementptr [4 x i8], [4 x i8]* @.str.21, i32 0, i32 0
  %135 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %130, i8* %134, i32 %133)
  %136 = call i32 @fclose(%struct._IO_FILE* %130)
  br label %148

; <label>:137:                                    ; preds = %127
  %138 = call i32* @__errno_location() #11
  %139 = load i32, i32* %138, align 4
  %140 = call i8* @strerror(i32 %139) #7
  %141 = getelementptr [34 x i8], [34 x i8]* @.str.22, i32 0, i32 0
  %142 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  call void (i8*, ...) @dprint_clone.14(i8* %141, i8* %142, i8* %140)
  %143 = call i32* @__errno_location() #11
  %144 = load i32, i32* %143, align 4
  %145 = call i8* @strerror(i32 %144) #7
  %146 = getelementptr [33 x i8], [33 x i8]* @.str.23, i32 0, i32 0
  %147 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  call void (i8*, ...) @logprint_clone(i8* %146, i8* %147, i8* %145)
  br label %148

; <label>:148:                                    ; preds = %137, %132, %119
  %149 = call void (i32)* @signal(i32 2, void (i32)* @cleanup) #7
  %150 = call void (i32)* @signal(i32 15, void (i32)* @cleanup) #7
  %151 = call void (i32)* @signal(i32 17, void (i32)* @child_exit) #7
  %152 = call void (i32)* @signal(i32 1, void (i32)* @read_cfg) #7
  %153 = getelementptr [20 x i8], [20 x i8]* @.str.24, i32 0, i32 0
  %154 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  call void (i8*, ...) @vprint_clone(i8* %153, i8* %154)
  %155 = getelementptr [29 x i8], [29 x i8]* @.str.25, i32 0, i32 0
  %156 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  call void (i8*, ...) @logprint_clone.18(i8* %155, i8* %156)
  br label %157

; <label>:157:                                    ; preds = %157, %148
  %158 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %159 = call i32 @pcap_dispatch(%struct.pcap* %158, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %160 = icmp sge i32 %159, 0
  br i1 %160, label %157, label %161

; <label>:161:                                    ; preds = %157
  %.0.lcssa = phi i32 [ %159, %157 ]
  %162 = getelementptr [35 x i8], [35 x i8]* @.str.26, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %162, i32 %.0.lcssa)
  %163 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %164 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %163, i8* %164)
  call void @cleanup(i32 0)
  call void @exit(i32 0) #9
  unreachable

.lr.ph.1:                                         ; preds = %42
  %165 = icmp slt i32 -1, 0
  br i1 true, label %.loopexit.loopexit, label %166

; <label>:166:                                    ; preds = %.lr.ph.1
  switch i32 -1, label %178 [
    i32 0, label %179
    i32 118, label %177
    i32 68, label %176
    i32 100, label %175
    i32 108, label %174
    i32 105, label %171
    i32 99, label %168
    i32 86, label %167
  ]

; <label>:167:                                    ; preds = %166
  call void @ver()
  br label %178

; <label>:168:                                    ; preds = %166
  %169 = load i8*, i8** @optarg, align 8
  %170 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %169, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %179

; <label>:171:                                    ; preds = %166
  %172 = load i8*, i8** @optarg, align 8
  %173 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %172, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %179

; <label>:174:                                    ; preds = %166
  store i32 1, i32* @o_lookup, align 4
  br label %179

; <label>:175:                                    ; preds = %166
  store i32 1, i32* @o_daemon, align 4
  br label %179

; <label>:176:                                    ; preds = %166
  store i32 1, i32* @o_debug, align 4
  br label %179

; <label>:177:                                    ; preds = %166
  store i32 1, i32* @o_verbose, align 4
  br label %179

; <label>:178:                                    ; preds = %167, %166
  call void @usage()
  br label %179

; <label>:179:                                    ; preds = %178, %177, %176, %175, %174, %171, %168, %166
  %180 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %181 = icmp ne i32 %180, 0
  br i1 %181, label %.lr.ph.2, label %.loopexit.loopexit

.lr.ph.2:                                         ; preds = %179
  %182 = icmp slt i32 %180, 0
  br i1 %182, label %.loopexit.loopexit, label %183

; <label>:183:                                    ; preds = %.lr.ph.2
  switch i32 %180, label %195 [
    i32 0, label %196
    i32 118, label %194
    i32 68, label %193
    i32 100, label %192
    i32 108, label %191
    i32 105, label %188
    i32 99, label %185
    i32 86, label %184
  ]

; <label>:184:                                    ; preds = %183
  call void @ver()
  br label %195

; <label>:185:                                    ; preds = %183
  %186 = load i8*, i8** @optarg, align 8
  %187 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %186, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %196

; <label>:188:                                    ; preds = %183
  %189 = load i8*, i8** @optarg, align 8
  %190 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %189, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %196

; <label>:191:                                    ; preds = %183
  store i32 1, i32* @o_lookup, align 4
  br label %196

; <label>:192:                                    ; preds = %183
  store i32 1, i32* @o_daemon, align 4
  br label %196

; <label>:193:                                    ; preds = %183
  store i32 1, i32* @o_debug, align 4
  br label %196

; <label>:194:                                    ; preds = %183
  store i32 1, i32* @o_verbose, align 4
  br label %196

; <label>:195:                                    ; preds = %184, %183
  call void @usage()
  br label %196

; <label>:196:                                    ; preds = %195, %194, %193, %192, %191, %188, %185, %183
  %197 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %198 = icmp ne i32 %197, 0
  br i1 %198, label %.lr.ph.3, label %.loopexit.loopexit

.lr.ph.3:                                         ; preds = %196
  %199 = icmp slt i32 %197, 0
  br i1 %199, label %.loopexit.loopexit, label %200

; <label>:200:                                    ; preds = %.lr.ph.3
  switch i32 %197, label %212 [
    i32 0, label %213
    i32 118, label %211
    i32 68, label %210
    i32 100, label %209
    i32 108, label %208
    i32 105, label %205
    i32 99, label %202
    i32 86, label %201
  ]

; <label>:201:                                    ; preds = %200
  call void @ver()
  br label %212

; <label>:202:                                    ; preds = %200
  %203 = load i8*, i8** @optarg, align 8
  %204 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %203, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %213

; <label>:205:                                    ; preds = %200
  %206 = load i8*, i8** @optarg, align 8
  %207 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %206, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %213

; <label>:208:                                    ; preds = %200
  store i32 1, i32* @o_lookup, align 4
  br label %213

; <label>:209:                                    ; preds = %200
  store i32 1, i32* @o_daemon, align 4
  br label %213

; <label>:210:                                    ; preds = %200
  store i32 1, i32* @o_debug, align 4
  br label %213

; <label>:211:                                    ; preds = %200
  store i32 1, i32* @o_verbose, align 4
  br label %213

; <label>:212:                                    ; preds = %201, %200
  call void @usage()
  br label %213

; <label>:213:                                    ; preds = %212, %211, %210, %209, %208, %205, %202, %200
  %214 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %215 = icmp ne i32 %214, 0
  br i1 %215, label %.lr.ph.4, label %.loopexit.loopexit

.lr.ph.4:                                         ; preds = %213
  %216 = icmp slt i32 %214, 0
  br i1 %216, label %.loopexit.loopexit, label %217

; <label>:217:                                    ; preds = %.lr.ph.4
  switch i32 %214, label %229 [
    i32 0, label %230
    i32 118, label %228
    i32 68, label %227
    i32 100, label %226
    i32 108, label %225
    i32 105, label %222
    i32 99, label %219
    i32 86, label %218
  ]

; <label>:218:                                    ; preds = %217
  call void @ver()
  br label %229

; <label>:219:                                    ; preds = %217
  %220 = load i8*, i8** @optarg, align 8
  %221 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %220, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %230

; <label>:222:                                    ; preds = %217
  %223 = load i8*, i8** @optarg, align 8
  %224 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %223, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %230

; <label>:225:                                    ; preds = %217
  store i32 1, i32* @o_lookup, align 4
  br label %230

; <label>:226:                                    ; preds = %217
  store i32 1, i32* @o_daemon, align 4
  br label %230

; <label>:227:                                    ; preds = %217
  store i32 1, i32* @o_debug, align 4
  br label %230

; <label>:228:                                    ; preds = %217
  store i32 1, i32* @o_verbose, align 4
  br label %230

; <label>:229:                                    ; preds = %218, %217
  call void @usage()
  br label %230

; <label>:230:                                    ; preds = %229, %228, %227, %226, %225, %222, %219, %217
  %231 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %232 = icmp ne i32 %231, 0
  br i1 %232, label %.lr.ph.5, label %.loopexit.loopexit

.lr.ph.5:                                         ; preds = %230
  %233 = icmp slt i32 %231, 0
  br i1 %233, label %.loopexit.loopexit, label %234

; <label>:234:                                    ; preds = %.lr.ph.5
  switch i32 %231, label %246 [
    i32 0, label %247
    i32 118, label %245
    i32 68, label %244
    i32 100, label %243
    i32 108, label %242
    i32 105, label %239
    i32 99, label %236
    i32 86, label %235
  ]

; <label>:235:                                    ; preds = %234
  call void @ver()
  br label %246

; <label>:236:                                    ; preds = %234
  %237 = load i8*, i8** @optarg, align 8
  %238 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %237, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %247

; <label>:239:                                    ; preds = %234
  %240 = load i8*, i8** @optarg, align 8
  %241 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %240, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %247

; <label>:242:                                    ; preds = %234
  store i32 1, i32* @o_lookup, align 4
  br label %247

; <label>:243:                                    ; preds = %234
  store i32 1, i32* @o_daemon, align 4
  br label %247

; <label>:244:                                    ; preds = %234
  store i32 1, i32* @o_debug, align 4
  br label %247

; <label>:245:                                    ; preds = %234
  store i32 1, i32* @o_verbose, align 4
  br label %247

; <label>:246:                                    ; preds = %235, %234
  call void @usage()
  br label %247

; <label>:247:                                    ; preds = %246, %245, %244, %243, %242, %239, %236, %234
  %248 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %249 = icmp ne i32 %248, 0
  br i1 %249, label %.lr.ph.6, label %.loopexit.loopexit

.lr.ph.6:                                         ; preds = %247
  %250 = icmp slt i32 %248, 0
  br i1 %250, label %.loopexit.loopexit, label %251

; <label>:251:                                    ; preds = %.lr.ph.6
  switch i32 %248, label %263 [
    i32 0, label %264
    i32 118, label %262
    i32 68, label %261
    i32 100, label %260
    i32 108, label %259
    i32 105, label %256
    i32 99, label %253
    i32 86, label %252
  ]

; <label>:252:                                    ; preds = %251
  call void @ver()
  br label %263

; <label>:253:                                    ; preds = %251
  %254 = load i8*, i8** @optarg, align 8
  %255 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %254, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %264

; <label>:256:                                    ; preds = %251
  %257 = load i8*, i8** @optarg, align 8
  %258 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %257, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %264

; <label>:259:                                    ; preds = %251
  store i32 1, i32* @o_lookup, align 4
  br label %264

; <label>:260:                                    ; preds = %251
  store i32 1, i32* @o_daemon, align 4
  br label %264

; <label>:261:                                    ; preds = %251
  store i32 1, i32* @o_debug, align 4
  br label %264

; <label>:262:                                    ; preds = %251
  store i32 1, i32* @o_verbose, align 4
  br label %264

; <label>:263:                                    ; preds = %252, %251
  call void @usage()
  br label %264

; <label>:264:                                    ; preds = %263, %262, %261, %260, %259, %256, %253, %251
  %265 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %266 = icmp ne i32 %265, 0
  br i1 %266, label %.lr.ph.7, label %.loopexit.loopexit

.lr.ph.7:                                         ; preds = %264
  %267 = icmp slt i32 %265, 0
  br i1 %267, label %.loopexit.loopexit, label %268

; <label>:268:                                    ; preds = %.lr.ph.7
  switch i32 %265, label %280 [
    i32 0, label %281
    i32 118, label %279
    i32 68, label %278
    i32 100, label %277
    i32 108, label %276
    i32 105, label %273
    i32 99, label %270
    i32 86, label %269
  ]

; <label>:269:                                    ; preds = %268
  call void @ver()
  br label %280

; <label>:270:                                    ; preds = %268
  %271 = load i8*, i8** @optarg, align 8
  %272 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %271, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %281

; <label>:273:                                    ; preds = %268
  %274 = load i8*, i8** @optarg, align 8
  %275 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %274, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %281

; <label>:276:                                    ; preds = %268
  store i32 1, i32* @o_lookup, align 4
  br label %281

; <label>:277:                                    ; preds = %268
  store i32 1, i32* @o_daemon, align 4
  br label %281

; <label>:278:                                    ; preds = %268
  store i32 1, i32* @o_debug, align 4
  br label %281

; <label>:279:                                    ; preds = %268
  store i32 1, i32* @o_verbose, align 4
  br label %281

; <label>:280:                                    ; preds = %269, %268
  call void @usage()
  br label %281

; <label>:281:                                    ; preds = %280, %279, %278, %277, %276, %273, %270, %268
  %282 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %283 = icmp ne i32 %282, 0
  br i1 %283, label %.lr.ph.8, label %.loopexit.loopexit

.lr.ph.8:                                         ; preds = %281
  %284 = icmp slt i32 %282, 0
  br i1 %284, label %.loopexit.loopexit, label %285

; <label>:285:                                    ; preds = %.lr.ph.8
  switch i32 %282, label %297 [
    i32 0, label %298
    i32 118, label %296
    i32 68, label %295
    i32 100, label %294
    i32 108, label %293
    i32 105, label %290
    i32 99, label %287
    i32 86, label %286
  ]

; <label>:286:                                    ; preds = %285
  call void @ver()
  br label %297

; <label>:287:                                    ; preds = %285
  %288 = load i8*, i8** @optarg, align 8
  %289 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %288, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %298

; <label>:290:                                    ; preds = %285
  %291 = load i8*, i8** @optarg, align 8
  %292 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %291, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %298

; <label>:293:                                    ; preds = %285
  store i32 1, i32* @o_lookup, align 4
  br label %298

; <label>:294:                                    ; preds = %285
  store i32 1, i32* @o_daemon, align 4
  br label %298

; <label>:295:                                    ; preds = %285
  store i32 1, i32* @o_debug, align 4
  br label %298

; <label>:296:                                    ; preds = %285
  store i32 1, i32* @o_verbose, align 4
  br label %298

; <label>:297:                                    ; preds = %286, %285
  call void @usage()
  br label %298

; <label>:298:                                    ; preds = %297, %296, %295, %294, %293, %290, %287, %285
  %299 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %300 = icmp ne i32 %299, 0
  br i1 %300, label %.lr.ph.9, label %.loopexit.loopexit

.lr.ph.9:                                         ; preds = %298
  %301 = icmp slt i32 %299, 0
  br i1 %301, label %.loopexit.loopexit, label %302

; <label>:302:                                    ; preds = %.lr.ph.9
  switch i32 %299, label %314 [
    i32 0, label %315
    i32 118, label %313
    i32 68, label %312
    i32 100, label %311
    i32 108, label %310
    i32 105, label %307
    i32 99, label %304
    i32 86, label %303
  ]

; <label>:303:                                    ; preds = %302
  call void @ver()
  br label %314

; <label>:304:                                    ; preds = %302
  %305 = load i8*, i8** @optarg, align 8
  %306 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %305, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %315

; <label>:307:                                    ; preds = %302
  %308 = load i8*, i8** @optarg, align 8
  %309 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %308, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %315

; <label>:310:                                    ; preds = %302
  store i32 1, i32* @o_lookup, align 4
  br label %315

; <label>:311:                                    ; preds = %302
  store i32 1, i32* @o_daemon, align 4
  br label %315

; <label>:312:                                    ; preds = %302
  store i32 1, i32* @o_debug, align 4
  br label %315

; <label>:313:                                    ; preds = %302
  store i32 1, i32* @o_verbose, align 4
  br label %315

; <label>:314:                                    ; preds = %303, %302
  call void @usage()
  br label %315

; <label>:315:                                    ; preds = %314, %313, %312, %311, %310, %307, %304, %302
  %316 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %317 = icmp ne i32 %316, 0
  br i1 %317, label %.lr.ph.10, label %.loopexit.loopexit

.lr.ph.10:                                        ; preds = %315
  %318 = icmp slt i32 %316, 0
  br i1 %318, label %.loopexit.loopexit, label %319

; <label>:319:                                    ; preds = %.lr.ph.10
  switch i32 %316, label %331 [
    i32 0, label %332
    i32 118, label %330
    i32 68, label %329
    i32 100, label %328
    i32 108, label %327
    i32 105, label %324
    i32 99, label %321
    i32 86, label %320
  ]

; <label>:320:                                    ; preds = %319
  call void @ver()
  br label %331

; <label>:321:                                    ; preds = %319
  %322 = load i8*, i8** @optarg, align 8
  %323 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %322, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %332

; <label>:324:                                    ; preds = %319
  %325 = load i8*, i8** @optarg, align 8
  %326 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %325, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %332

; <label>:327:                                    ; preds = %319
  store i32 1, i32* @o_lookup, align 4
  br label %332

; <label>:328:                                    ; preds = %319
  store i32 1, i32* @o_daemon, align 4
  br label %332

; <label>:329:                                    ; preds = %319
  store i32 1, i32* @o_debug, align 4
  br label %332

; <label>:330:                                    ; preds = %319
  store i32 1, i32* @o_verbose, align 4
  br label %332

; <label>:331:                                    ; preds = %320, %319
  call void @usage()
  br label %332

; <label>:332:                                    ; preds = %331, %330, %329, %328, %327, %324, %321, %319
  %333 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %334 = icmp ne i32 %333, 0
  br i1 %334, label %.lr.ph.11, label %.loopexit.loopexit

.lr.ph.11:                                        ; preds = %332
  %335 = icmp slt i32 %333, 0
  br i1 %335, label %.loopexit.loopexit, label %336

; <label>:336:                                    ; preds = %.lr.ph.11
  switch i32 %333, label %348 [
    i32 0, label %349
    i32 118, label %347
    i32 68, label %346
    i32 100, label %345
    i32 108, label %344
    i32 105, label %341
    i32 99, label %338
    i32 86, label %337
  ]

; <label>:337:                                    ; preds = %336
  call void @ver()
  br label %348

; <label>:338:                                    ; preds = %336
  %339 = load i8*, i8** @optarg, align 8
  %340 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %339, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %349

; <label>:341:                                    ; preds = %336
  %342 = load i8*, i8** @optarg, align 8
  %343 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %342, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %349

; <label>:344:                                    ; preds = %336
  store i32 1, i32* @o_lookup, align 4
  br label %349

; <label>:345:                                    ; preds = %336
  store i32 1, i32* @o_daemon, align 4
  br label %349

; <label>:346:                                    ; preds = %336
  store i32 1, i32* @o_debug, align 4
  br label %349

; <label>:347:                                    ; preds = %336
  store i32 1, i32* @o_verbose, align 4
  br label %349

; <label>:348:                                    ; preds = %337, %336
  call void @usage()
  br label %349

; <label>:349:                                    ; preds = %348, %347, %346, %345, %344, %341, %338, %336
  %350 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %351 = icmp ne i32 %350, 0
  br i1 %351, label %.lr.ph.12, label %.loopexit.loopexit

.lr.ph.12:                                        ; preds = %349
  %352 = icmp slt i32 %350, 0
  br i1 %352, label %.loopexit.loopexit, label %353

; <label>:353:                                    ; preds = %.lr.ph.12
  switch i32 %350, label %365 [
    i32 0, label %366
    i32 118, label %364
    i32 68, label %363
    i32 100, label %362
    i32 108, label %361
    i32 105, label %358
    i32 99, label %355
    i32 86, label %354
  ]

; <label>:354:                                    ; preds = %353
  call void @ver()
  br label %365

; <label>:355:                                    ; preds = %353
  %356 = load i8*, i8** @optarg, align 8
  %357 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %356, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %366

; <label>:358:                                    ; preds = %353
  %359 = load i8*, i8** @optarg, align 8
  %360 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %359, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %366

; <label>:361:                                    ; preds = %353
  store i32 1, i32* @o_lookup, align 4
  br label %366

; <label>:362:                                    ; preds = %353
  store i32 1, i32* @o_daemon, align 4
  br label %366

; <label>:363:                                    ; preds = %353
  store i32 1, i32* @o_debug, align 4
  br label %366

; <label>:364:                                    ; preds = %353
  store i32 1, i32* @o_verbose, align 4
  br label %366

; <label>:365:                                    ; preds = %354, %353
  call void @usage()
  br label %366

; <label>:366:                                    ; preds = %365, %364, %363, %362, %361, %358, %355, %353
  %367 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %368 = icmp ne i32 %367, 0
  br i1 %368, label %.lr.ph.13, label %.loopexit.loopexit

.lr.ph.13:                                        ; preds = %366
  %369 = icmp slt i32 %367, 0
  br i1 %369, label %.loopexit.loopexit, label %370

; <label>:370:                                    ; preds = %.lr.ph.13
  switch i32 %367, label %382 [
    i32 0, label %383
    i32 118, label %381
    i32 68, label %380
    i32 100, label %379
    i32 108, label %378
    i32 105, label %375
    i32 99, label %372
    i32 86, label %371
  ]

; <label>:371:                                    ; preds = %370
  call void @ver()
  br label %382

; <label>:372:                                    ; preds = %370
  %373 = load i8*, i8** @optarg, align 8
  %374 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %373, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %383

; <label>:375:                                    ; preds = %370
  %376 = load i8*, i8** @optarg, align 8
  %377 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %376, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %383

; <label>:378:                                    ; preds = %370
  store i32 1, i32* @o_lookup, align 4
  br label %383

; <label>:379:                                    ; preds = %370
  store i32 1, i32* @o_daemon, align 4
  br label %383

; <label>:380:                                    ; preds = %370
  store i32 1, i32* @o_debug, align 4
  br label %383

; <label>:381:                                    ; preds = %370
  store i32 1, i32* @o_verbose, align 4
  br label %383

; <label>:382:                                    ; preds = %371, %370
  call void @usage()
  br label %383

; <label>:383:                                    ; preds = %382, %381, %380, %379, %378, %375, %372, %370
  %384 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %385 = icmp ne i32 %384, 0
  br i1 %385, label %.lr.ph.14, label %.loopexit.loopexit

.lr.ph.14:                                        ; preds = %383
  %386 = icmp slt i32 %384, 0
  br i1 %386, label %.loopexit.loopexit, label %387

; <label>:387:                                    ; preds = %.lr.ph.14
  switch i32 %384, label %399 [
    i32 0, label %400
    i32 118, label %398
    i32 68, label %397
    i32 100, label %396
    i32 108, label %395
    i32 105, label %392
    i32 99, label %389
    i32 86, label %388
  ]

; <label>:388:                                    ; preds = %387
  call void @ver()
  br label %399

; <label>:389:                                    ; preds = %387
  %390 = load i8*, i8** @optarg, align 8
  %391 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %390, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %400

; <label>:392:                                    ; preds = %387
  %393 = load i8*, i8** @optarg, align 8
  %394 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %393, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %400

; <label>:395:                                    ; preds = %387
  store i32 1, i32* @o_lookup, align 4
  br label %400

; <label>:396:                                    ; preds = %387
  store i32 1, i32* @o_daemon, align 4
  br label %400

; <label>:397:                                    ; preds = %387
  store i32 1, i32* @o_debug, align 4
  br label %400

; <label>:398:                                    ; preds = %387
  store i32 1, i32* @o_verbose, align 4
  br label %400

; <label>:399:                                    ; preds = %388, %387
  call void @usage()
  br label %400

; <label>:400:                                    ; preds = %399, %398, %397, %396, %395, %392, %389, %387
  %401 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %402 = icmp ne i32 %401, 0
  br i1 %402, label %.lr.ph.15, label %.loopexit.loopexit

.lr.ph.15:                                        ; preds = %400
  %403 = icmp slt i32 %401, 0
  br i1 %403, label %.loopexit.loopexit, label %404

; <label>:404:                                    ; preds = %.lr.ph.15
  switch i32 %401, label %416 [
    i32 0, label %417
    i32 118, label %415
    i32 68, label %414
    i32 100, label %413
    i32 108, label %412
    i32 105, label %409
    i32 99, label %406
    i32 86, label %405
  ]

; <label>:405:                                    ; preds = %404
  call void @ver()
  br label %416

; <label>:406:                                    ; preds = %404
  %407 = load i8*, i8** @optarg, align 8
  %408 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %407, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %417

; <label>:409:                                    ; preds = %404
  %410 = load i8*, i8** @optarg, align 8
  %411 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %410, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %417

; <label>:412:                                    ; preds = %404
  store i32 1, i32* @o_lookup, align 4
  br label %417

; <label>:413:                                    ; preds = %404
  store i32 1, i32* @o_daemon, align 4
  br label %417

; <label>:414:                                    ; preds = %404
  store i32 1, i32* @o_debug, align 4
  br label %417

; <label>:415:                                    ; preds = %404
  store i32 1, i32* @o_verbose, align 4
  br label %417

; <label>:416:                                    ; preds = %405, %404
  call void @usage()
  br label %417

; <label>:417:                                    ; preds = %416, %415, %414, %413, %412, %409, %406, %404
  %418 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %419 = icmp ne i32 %418, 0
  br i1 %419, label %.lr.ph.16, label %.loopexit.loopexit

.lr.ph.16:                                        ; preds = %417
  %420 = icmp slt i32 %418, 0
  br i1 %420, label %.loopexit.loopexit, label %421

; <label>:421:                                    ; preds = %.lr.ph.16
  switch i32 %418, label %433 [
    i32 0, label %434
    i32 118, label %432
    i32 68, label %431
    i32 100, label %430
    i32 108, label %429
    i32 105, label %426
    i32 99, label %423
    i32 86, label %422
  ]

; <label>:422:                                    ; preds = %421
  call void @ver()
  br label %433

; <label>:423:                                    ; preds = %421
  %424 = load i8*, i8** @optarg, align 8
  %425 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %424, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %434

; <label>:426:                                    ; preds = %421
  %427 = load i8*, i8** @optarg, align 8
  %428 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %427, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %434

; <label>:429:                                    ; preds = %421
  store i32 1, i32* @o_lookup, align 4
  br label %434

; <label>:430:                                    ; preds = %421
  store i32 1, i32* @o_daemon, align 4
  br label %434

; <label>:431:                                    ; preds = %421
  store i32 1, i32* @o_debug, align 4
  br label %434

; <label>:432:                                    ; preds = %421
  store i32 1, i32* @o_verbose, align 4
  br label %434

; <label>:433:                                    ; preds = %422, %421
  call void @usage()
  br label %434

; <label>:434:                                    ; preds = %433, %432, %431, %430, %429, %426, %423, %421
  %435 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %436 = icmp ne i32 %435, 0
  br i1 %436, label %.lr.ph.17, label %.loopexit.loopexit

.lr.ph.17:                                        ; preds = %434
  %437 = icmp slt i32 %435, 0
  br i1 %437, label %.loopexit.loopexit, label %438

; <label>:438:                                    ; preds = %.lr.ph.17
  switch i32 %435, label %450 [
    i32 0, label %451
    i32 118, label %449
    i32 68, label %448
    i32 100, label %447
    i32 108, label %446
    i32 105, label %443
    i32 99, label %440
    i32 86, label %439
  ]

; <label>:439:                                    ; preds = %438
  call void @ver()
  br label %450

; <label>:440:                                    ; preds = %438
  %441 = load i8*, i8** @optarg, align 8
  %442 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %441, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %451

; <label>:443:                                    ; preds = %438
  %444 = load i8*, i8** @optarg, align 8
  %445 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %444, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %451

; <label>:446:                                    ; preds = %438
  store i32 1, i32* @o_lookup, align 4
  br label %451

; <label>:447:                                    ; preds = %438
  store i32 1, i32* @o_daemon, align 4
  br label %451

; <label>:448:                                    ; preds = %438
  store i32 1, i32* @o_debug, align 4
  br label %451

; <label>:449:                                    ; preds = %438
  store i32 1, i32* @o_verbose, align 4
  br label %451

; <label>:450:                                    ; preds = %439, %438
  call void @usage()
  br label %451

; <label>:451:                                    ; preds = %450, %449, %448, %447, %446, %443, %440, %438
  %452 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %453 = icmp ne i32 %452, 0
  br i1 %453, label %.lr.ph.18, label %.loopexit.loopexit

.lr.ph.18:                                        ; preds = %451
  %454 = icmp slt i32 %452, 0
  br i1 %454, label %.loopexit.loopexit, label %455

; <label>:455:                                    ; preds = %.lr.ph.18
  switch i32 %452, label %467 [
    i32 0, label %468
    i32 118, label %466
    i32 68, label %465
    i32 100, label %464
    i32 108, label %463
    i32 105, label %460
    i32 99, label %457
    i32 86, label %456
  ]

; <label>:456:                                    ; preds = %455
  call void @ver()
  br label %467

; <label>:457:                                    ; preds = %455
  %458 = load i8*, i8** @optarg, align 8
  %459 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %458, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %468

; <label>:460:                                    ; preds = %455
  %461 = load i8*, i8** @optarg, align 8
  %462 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %461, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %468

; <label>:463:                                    ; preds = %455
  store i32 1, i32* @o_lookup, align 4
  br label %468

; <label>:464:                                    ; preds = %455
  store i32 1, i32* @o_daemon, align 4
  br label %468

; <label>:465:                                    ; preds = %455
  store i32 1, i32* @o_debug, align 4
  br label %468

; <label>:466:                                    ; preds = %455
  store i32 1, i32* @o_verbose, align 4
  br label %468

; <label>:467:                                    ; preds = %456, %455
  call void @usage()
  br label %468

; <label>:468:                                    ; preds = %467, %466, %465, %464, %463, %460, %457, %455
  %469 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %470 = icmp ne i32 %469, 0
  br i1 %470, label %.lr.ph.19, label %.loopexit.loopexit

.lr.ph.19:                                        ; preds = %468
  %471 = icmp slt i32 %469, 0
  br i1 %471, label %.loopexit.loopexit, label %472

; <label>:472:                                    ; preds = %.lr.ph.19
  switch i32 %469, label %484 [
    i32 0, label %485
    i32 118, label %483
    i32 68, label %482
    i32 100, label %481
    i32 108, label %480
    i32 105, label %477
    i32 99, label %474
    i32 86, label %473
  ]

; <label>:473:                                    ; preds = %472
  call void @ver()
  br label %484

; <label>:474:                                    ; preds = %472
  %475 = load i8*, i8** @optarg, align 8
  %476 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %475, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %485

; <label>:477:                                    ; preds = %472
  %478 = load i8*, i8** @optarg, align 8
  %479 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %478, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %485

; <label>:480:                                    ; preds = %472
  store i32 1, i32* @o_lookup, align 4
  br label %485

; <label>:481:                                    ; preds = %472
  store i32 1, i32* @o_daemon, align 4
  br label %485

; <label>:482:                                    ; preds = %472
  store i32 1, i32* @o_debug, align 4
  br label %485

; <label>:483:                                    ; preds = %472
  store i32 1, i32* @o_verbose, align 4
  br label %485

; <label>:484:                                    ; preds = %473, %472
  call void @usage()
  br label %485

; <label>:485:                                    ; preds = %484, %483, %482, %481, %480, %477, %474, %472
  %486 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  br label %.loopexit.loopexit
}

declare void @__loop_termination_test___0()

declare void @__loop_iteration_test___0()

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @parseconfig_clone(i8*) #0 {
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
  %14 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %15 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %16 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  %17 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  %18 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %19 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %20 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %21 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %22 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %23 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %24 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %25 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %26 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %27 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %28 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %29 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  br label %.lr.ph43

.lr.ph43:                                         ; preds = %.outer, %.lr.ph43.preheader
  %.02.ph49 = phi i32 [ %.lcssa40, %.outer ], [ 0, %.lr.ph43.preheader ]
  %.03.ph48 = phi %struct.opendoor* [ %.2, %.outer ], [ null, %.lr.ph43.preheader ]
  %30 = add i32 %.02.ph49, 1
  br label %31

; <label>:31:                                     ; preds = %39, %.lr.ph43
  %lsr.iv = phi i32 [ %30, %.lr.ph43 ], [ %lsr.iv.next, %39 ]
  %32 = call i8* @trim(i8* %14)
  %33 = call i64 @strlen(i8* %15) #10
  %34 = icmp eq i64 %33, 0
  br i1 %34, label %39, label %35

; <label>:35:                                     ; preds = %31
  %36 = load i8, i8* %16, align 16
  %37 = sext i8 %36 to i32
  %38 = icmp eq i32 %37, 35
  br i1 %38, label %39, label %42

; <label>:39:                                     ; preds = %35, %31
  %40 = call i8* @fgets(i8* %11, i32 100, %struct._IO_FILE* %7), !track !24
  %41 = icmp ne i8* %40, null
  %lsr.iv.next = add i32 %lsr.iv, 1
  br i1 %41, label %31, label %.outer._crit_edge.loopexit

; <label>:42:                                     ; preds = %35
  %.lcssa40 = phi i32 [ %lsr.iv, %35 ]
  %43 = load i8, i8* %17, align 16
  %44 = sext i8 %43 to i32
  %45 = icmp eq i32 %44, 91
  br i1 %45, label %46, label %92

; <label>:46:                                     ; preds = %42
  %47 = call i64 @strlen(i8* %18) #10
  %48 = sub i64 %47, 1
  %49 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 %48
  %50 = load i8, i8* %49, align 1
  %51 = sext i8 %50 to i32
  %52 = icmp eq i32 %51, 93
  br i1 %52, label %53, label %92

; <label>:53:                                     ; preds = %46
  store i8* %20, i8** %3, align 8
  %54 = load i8*, i8** %3, align 8
  %55 = getelementptr inbounds i8, i8* %54, i32 1
  store i8* %55, i8** %3, align 8
  %56 = load i8*, i8** %3, align 8
  %57 = call i8* @strncpy(i8* %21, i8* %56, i64 256) #7, !track !25
  %58 = call i64 @strlen(i8* %22) #10
  %59 = sub i64 %58, 1
  %60 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i64 0, i64 %59
  store i8 0, i8* %60, align 1
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.53, i64 0, i64 0), i8* %23)
  %61 = call i64 @strlen(i8* %24) #10
  %62 = icmp ne i64 %61, 0
  br i1 %62, label %67, label %63

; <label>:63:                                     ; preds = %53
  %.lcssa29 = phi i32 [ %.lcssa40, %53 ]
  %64 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %65 = getelementptr [35 x i8], [35 x i8]* @.str.54, i32 0, i32 0
  %66 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %64, i8* %65, i32 %.lcssa29)
  br label %._crit_edge

; <label>:67:                                     ; preds = %53
  %68 = call i32 @strcmp(i8* %26, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.55, i64 0, i64 0)) #10
  %69 = icmp ne i32 %68, 0
  br i1 %69, label %70, label %.outer

; <label>:70:                                     ; preds = %67
  %71 = call noalias i8* @malloc(i64 336) #7, !track !26
  %72 = bitcast i8* %71 to %struct.opendoor*
  %73 = icmp eq %struct.opendoor* %72, null
  br i1 %73, label %74, label %76

; <label>:74:                                     ; preds = %70
  %75 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %75)
  call void @exit(i32 1) #9
  unreachable

; <label>:76:                                     ; preds = %70
  %77 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 0
  %78 = getelementptr inbounds [128 x i8], [128 x i8]* %77, i32 0, i32 0
  %79 = call i8* @strncpy(i8* %78, i8* %28, i64 127) #7, !track !27
  %80 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 0
  %81 = getelementptr inbounds [128 x i8], [128 x i8]* %80, i64 0, i64 127
  store i8 0, i8* %81, align 1
  %82 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 1
  store i16 0, i16* %82, align 8
  %83 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 4
  store i64 25, i64* %83, align 8
  %84 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 5
  store i8* null, i8** %84, align 8
  %85 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 6
  store i64 10, i64* %85, align 8
  %86 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 7
  store i8* null, i8** %86, align 8
  %87 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 14
  store %struct._IO_FILE* null, %struct._IO_FILE** %87, align 8
  %88 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %72, i32 0, i32 15
  store i8* null, i8** %88, align 8
  %89 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %90 = bitcast %struct.opendoor* %72 to i8*
  %91 = call %struct.__pmlist_t* @list_add(%struct.__pmlist_t* %89, i8* %90)
  store %struct.__pmlist_t* %91, %struct.__pmlist_t** @doors, align 8
  br label %.outer

; <label>:92:                                     ; preds = %46, %42
  %93 = call i64 @strlen(i8* %19) #10
  %94 = icmp ne i64 %93, 0
  br i1 %94, label %99, label %95

; <label>:95:                                     ; preds = %92
  %.lcssa17 = phi i32 [ %.lcssa40, %92 ]
  %96 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %97 = getelementptr [58 x i8], [58 x i8]* @.str.57, i32 0, i32 0
  %98 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %96, i8* %97, i32 %.lcssa17)
  br label %._crit_edge

; <label>:99:                                     ; preds = %92
  store i8* %25, i8** %3, align 8
  %100 = call i8* @strsep(i8** %3, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.58, i64 0, i64 0)) #7
  %101 = icmp eq i8* %100, null
  br i1 %101, label %102, label %106

; <label>:102:                                    ; preds = %99
  %.lcssa18 = phi i32 [ %.lcssa40, %99 ]
  %103 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %104 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %105 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %103, i8* %104, i32 %.lcssa18)
  br label %._crit_edge

; <label>:106:                                    ; preds = %99
  %107 = call i8* @trim(i8* %100)
  %108 = call i8* @strtoupper(i8* %100)
  %109 = load i8*, i8** %3, align 8
  %110 = icmp eq i8* %109, null
  br i1 %110, label %111, label %119

; <label>:111:                                    ; preds = %106
  %112 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.60, i64 0, i64 0)) #10
  %113 = icmp ne i32 %112, 0
  br i1 %113, label %115, label %114

; <label>:114:                                    ; preds = %111
  store i32 1, i32* @o_usesyslog, align 4
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.61, i64 0, i64 0))
  br label %.outer

; <label>:115:                                    ; preds = %111
  %.lcssa28 = phi i32 [ %.lcssa40, %111 ]
  %116 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %117 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %118 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %116, i8* %117, i32 %.lcssa28)
  br label %._crit_edge

; <label>:119:                                    ; preds = %106
  %120 = load i8*, i8** %3, align 8
  %121 = call i8* @trim(i8* %120)
  %122 = call i32 @strcmp(i8* %27, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.55, i64 0, i64 0)) #10
  %123 = icmp ne i32 %122, 0
  br i1 %123, label %149, label %124

; <label>:124:                                    ; preds = %119
  %125 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.62, i64 0, i64 0)) #10
  %126 = icmp ne i32 %125, 0
  br i1 %126, label %130, label %127

; <label>:127:                                    ; preds = %124
  %128 = load i8*, i8** %3, align 8
  %129 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_logfile, i64 0, i64 0), i8* %128, i64 99) #7, !track !28
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_logfile, i64 0, i64 99), align 1
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.63, i64 0, i64 0), i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_logfile, i64 0, i64 0))
  br label %._crit_edge47

; <label>:130:                                    ; preds = %124
  %131 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.64, i64 0, i64 0)) #10
  %132 = icmp ne i32 %131, 0
  br i1 %132, label %136, label %133

; <label>:133:                                    ; preds = %130
  %134 = load i8*, i8** %3, align 8
  %135 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_pidfile, i64 0, i64 0), i8* %134, i64 99) #7, !track !29
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_pidfile, i64 0, i64 99), align 1
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.65, i64 0, i64 0), i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_pidfile, i64 0, i64 0))
  br label %._crit_edge47

; <label>:136:                                    ; preds = %130
  %137 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.66, i64 0, i64 0)) #10
  %138 = icmp ne i32 %137, 0
  br i1 %138, label %145, label %139

; <label>:139:                                    ; preds = %136
  %140 = call i64 @strlen(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0)) #10
  %141 = icmp eq i64 %140, 0
  br i1 %141, label %142, label %._crit_edge47

; <label>:142:                                    ; preds = %139
  %143 = load i8*, i8** %3, align 8
  %144 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %143, i64 31) #7, !track !30
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.67, i64 0, i64 0), i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0))
  br label %._crit_edge47

; <label>:145:                                    ; preds = %136
  %.lcssa19 = phi i32 [ %.lcssa40, %136 ]
  %146 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %147 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %148 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %146, i8* %147, i32 %.lcssa19)
  br label %._crit_edge

; <label>:149:                                    ; preds = %119
  %150 = icmp eq %struct.opendoor* %.03.ph48, null
  br i1 %150, label %151, label %155

; <label>:151:                                    ; preds = %149
  %.lcssa20 = phi i32 [ %.lcssa40, %149 ]
  %.lcssa8 = phi i8* [ %108, %149 ]
  %152 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %153 = getelementptr [62 x i8], [62 x i8]* @.str.68, i32 0, i32 0
  %154 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %152, i8* %153, i32 %.lcssa20, i8* %.lcssa8)
  br label %._crit_edge

; <label>:155:                                    ; preds = %149
  %156 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.69, i64 0, i64 0)) #10
  %157 = icmp ne i32 %156, 0
  br i1 %157, label %165, label %158

; <label>:158:                                    ; preds = %155
  %159 = load i8*, i8** %3, align 8
  %160 = call i32 @parse_port_sequence(i8* %159, %struct.opendoor* %.03.ph48)
  %161 = icmp sgt i32 %160, 0
  br i1 %161, label %._crit_edge.loopexit1, label %162

; <label>:162:                                    ; preds = %158
  %163 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %164 = getelementptr inbounds [128 x i8], [128 x i8]* %163, i32 0, i32 0
  call void (%struct.opendoor*, i8*, ...) @dprint_sequence(%struct.opendoor* %.03.ph48, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.70, i64 0, i64 0), i8* %164)
  br label %._crit_edge47

; <label>:165:                                    ; preds = %155
  %166 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.71, i64 0, i64 0)) #10
  %167 = icmp ne i32 %166, 0
  br i1 %167, label %187, label %168

; <label>:168:                                    ; preds = %165
  %169 = load i8*, i8** %3, align 8
  %170 = call %struct._IO_FILE* @fopen(i8* %169, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.72, i64 0, i64 0)), !track !31
  %171 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 14
  store %struct._IO_FILE* %170, %struct._IO_FILE** %171, align 8
  %172 = icmp eq %struct._IO_FILE* %170, null
  br i1 %172, label %173, label %175

; <label>:173:                                    ; preds = %168
  %174 = load i8*, i8** %3, align 8
  call void @perror(i8* %174)
  br label %._crit_edge

; <label>:175:                                    ; preds = %168
  %176 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %177 = getelementptr inbounds [128 x i8], [128 x i8]* %176, i32 0, i32 0
  %178 = load i8*, i8** %3, align 8
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str.73, i64 0, i64 0), i8* %177, i8* %178)
  %179 = call i32 @get_new_one_time_sequence(%struct.opendoor* %.03.ph48)
  %180 = icmp eq i32 %179, 0
  br i1 %180, label %181, label %184

; <label>:181:                                    ; preds = %175
  %182 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %183 = getelementptr inbounds [128 x i8], [128 x i8]* %182, i32 0, i32 0
  call void (%struct.opendoor*, i8*, ...) @dprint_sequence(%struct.opendoor* %.03.ph48, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.70, i64 0, i64 0), i8* %183)
  br label %._crit_edge47

; <label>:184:                                    ; preds = %175
  %185 = load i8*, i8** %3, align 8
  %186 = getelementptr [66 x i8], [66 x i8]* @.str.74, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %186, i8* %185)
  br label %._crit_edge

; <label>:187:                                    ; preds = %165
  %188 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.75, i64 0, i64 0)) #10
  %189 = icmp ne i32 %188, 0
  br i1 %189, label %190, label %193

; <label>:190:                                    ; preds = %187
  %191 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.76, i64 0, i64 0)) #10
  %192 = icmp ne i32 %191, 0
  br i1 %192, label %202, label %193

; <label>:193:                                    ; preds = %190, %187
  %194 = load i8*, i8** %3, align 8
  %195 = call i32 @atoi(i8* %194) #10
  %196 = sext i32 %195 to i64
  %197 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 4
  store i64 %196, i64* %197, align 8
  %198 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %199 = getelementptr inbounds [128 x i8], [128 x i8]* %198, i32 0, i32 0
  %200 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 4
  %201 = load i64, i64* %200, align 8
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.77, i64 0, i64 0), i8* %199, i64 %201)
  br label %._crit_edge47

; <label>:202:                                    ; preds = %190
  %203 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.78, i64 0, i64 0)) #10
  %204 = icmp ne i32 %203, 0
  br i1 %204, label %205, label %208

; <label>:205:                                    ; preds = %202
  %206 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.79, i64 0, i64 0)) #10
  %207 = icmp ne i32 %206, 0
  br i1 %207, label %229, label %208

; <label>:208:                                    ; preds = %205, %202
  %209 = load i8*, i8** %3, align 8
  %210 = call i64 @strlen(i8* %209) #10
  %211 = add i64 %210, 1
  %212 = mul i64 1, %211
  %213 = call noalias i8* @malloc(i64 %212) #7, !track !32
  %214 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  store i8* %213, i8** %214, align 8
  %215 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  %216 = load i8*, i8** %215, align 8
  %217 = icmp eq i8* %216, null
  br i1 %217, label %218, label %220

; <label>:218:                                    ; preds = %208
  %219 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %219)
  call void @exit(i32 1) #9
  unreachable

; <label>:220:                                    ; preds = %208
  %221 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  %222 = load i8*, i8** %221, align 8
  %223 = load i8*, i8** %3, align 8
  %224 = call i8* @strcpy(i8* %222, i8* %223) #7, !track !33
  %225 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %226 = getelementptr inbounds [128 x i8], [128 x i8]* %225, i32 0, i32 0
  %227 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  %228 = load i8*, i8** %227, align 8
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.80, i64 0, i64 0), i8* %226, i8* %228)
  br label %._crit_edge47

; <label>:229:                                    ; preds = %205
  %230 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.81, i64 0, i64 0)) #10
  %231 = icmp ne i32 %230, 0
  br i1 %231, label %241, label %232

; <label>:232:                                    ; preds = %229
  %233 = load i8*, i8** %3, align 8
  %234 = call i32 @atoi(i8* %233) #10
  %235 = sext i32 %234 to i64
  %236 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 6
  store i64 %235, i64* %236, align 8
  %237 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %238 = getelementptr inbounds [128 x i8], [128 x i8]* %237, i32 0, i32 0
  %239 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 6
  %240 = load i64, i64* %239, align 8
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([29 x i8], [29 x i8]* @.str.82, i64 0, i64 0), i8* %238, i64 %240)
  br label %._crit_edge47

; <label>:241:                                    ; preds = %229
  %242 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.83, i64 0, i64 0)) #10
  %243 = icmp ne i32 %242, 0
  br i1 %243, label %265, label %244

; <label>:244:                                    ; preds = %241
  %245 = load i8*, i8** %3, align 8
  %246 = call i64 @strlen(i8* %245) #10
  %247 = add i64 %246, 1
  %248 = mul i64 1, %247
  %249 = call noalias i8* @malloc(i64 %248) #7, !track !34
  %250 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  store i8* %249, i8** %250, align 8
  %251 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  %252 = load i8*, i8** %251, align 8
  %253 = icmp eq i8* %252, null
  br i1 %253, label %254, label %256

; <label>:254:                                    ; preds = %244
  %255 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %255)
  call void @exit(i32 1) #9
  unreachable

; <label>:256:                                    ; preds = %244
  %257 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  %258 = load i8*, i8** %257, align 8
  %259 = load i8*, i8** %3, align 8
  %260 = call i8* @strcpy(i8* %258, i8* %259) #7, !track !35
  %261 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %262 = getelementptr inbounds [128 x i8], [128 x i8]* %261, i32 0, i32 0
  %263 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  %264 = load i8*, i8** %263, align 8
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.84, i64 0, i64 0), i8* %262, i8* %264)
  br label %._crit_edge47

; <label>:265:                                    ; preds = %241
  %266 = call i32 @strcmp(i8* %108, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.85, i64 0, i64 0)) #10
  %267 = icmp ne i32 %266, 0
  br i1 %267, label %340, label %268

; <label>:268:                                    ; preds = %265
  %269 = load i8*, i8** %3, align 8
  %270 = call i8* @strtoupper(i8* %269)
  %271 = call i8* @strsep(i8** %3, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.86, i64 0, i64 0)) #7
  %272 = icmp ne i8* %271, null
  br i1 %272, label %.lr.ph46.preheader, label %._crit_edge47

.lr.ph46.preheader:                               ; preds = %268
  %273 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 8
  %274 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 8
  %275 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 9
  %276 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 9
  %277 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 10
  %278 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 10
  %279 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 11
  %280 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 11
  %281 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 12
  %282 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 12
  %283 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 13
  %284 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 13
  br label %.lr.ph46

.lr.ph46:                                         ; preds = %337, %.lr.ph46.preheader
  %285 = phi i8* [ %338, %337 ], [ %271, %.lr.ph46.preheader ]
  %286 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.87, i64 0, i64 0)) #10
  %287 = icmp ne i32 %286, 0
  br i1 %287, label %289, label %288

; <label>:288:                                    ; preds = %.lr.ph46
  store i32 1, i32* %273, align 8
  br label %337

; <label>:289:                                    ; preds = %.lr.ph46
  %290 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.88, i64 0, i64 0)) #10
  %291 = icmp ne i32 %290, 0
  br i1 %291, label %293, label %292

; <label>:292:                                    ; preds = %289
  store i32 2, i32* %274, align 8
  br label %337

; <label>:293:                                    ; preds = %289
  %294 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.89, i64 0, i64 0)) #10
  %295 = icmp ne i32 %294, 0
  br i1 %295, label %297, label %296

; <label>:296:                                    ; preds = %293
  store i32 1, i32* %275, align 4
  br label %337

; <label>:297:                                    ; preds = %293
  %298 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.90, i64 0, i64 0)) #10
  %299 = icmp ne i32 %298, 0
  br i1 %299, label %301, label %300

; <label>:300:                                    ; preds = %297
  store i32 2, i32* %276, align 4
  br label %337

; <label>:301:                                    ; preds = %297
  %302 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.91, i64 0, i64 0)) #10
  %303 = icmp ne i32 %302, 0
  br i1 %303, label %305, label %304

; <label>:304:                                    ; preds = %301
  store i32 1, i32* %277, align 8
  br label %337

; <label>:305:                                    ; preds = %301
  %306 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.92, i64 0, i64 0)) #10
  %307 = icmp ne i32 %306, 0
  br i1 %307, label %309, label %308

; <label>:308:                                    ; preds = %305
  store i32 2, i32* %278, align 8
  br label %337

; <label>:309:                                    ; preds = %305
  %310 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.93, i64 0, i64 0)) #10
  %311 = icmp ne i32 %310, 0
  br i1 %311, label %313, label %312

; <label>:312:                                    ; preds = %309
  store i32 1, i32* %279, align 4
  br label %337

; <label>:313:                                    ; preds = %309
  %314 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.94, i64 0, i64 0)) #10
  %315 = icmp ne i32 %314, 0
  br i1 %315, label %317, label %316

; <label>:316:                                    ; preds = %313
  store i32 2, i32* %280, align 4
  br label %337

; <label>:317:                                    ; preds = %313
  %318 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.95, i64 0, i64 0)) #10
  %319 = icmp ne i32 %318, 0
  br i1 %319, label %321, label %320

; <label>:320:                                    ; preds = %317
  store i32 1, i32* %281, align 8
  br label %337

; <label>:321:                                    ; preds = %317
  %322 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.96, i64 0, i64 0)) #10
  %323 = icmp ne i32 %322, 0
  br i1 %323, label %325, label %324

; <label>:324:                                    ; preds = %321
  store i32 2, i32* %282, align 8
  br label %337

; <label>:325:                                    ; preds = %321
  %326 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.97, i64 0, i64 0)) #10
  %327 = icmp ne i32 %326, 0
  br i1 %327, label %329, label %328

; <label>:328:                                    ; preds = %325
  store i32 1, i32* %283, align 4
  br label %337

; <label>:329:                                    ; preds = %325
  %330 = call i32 @strcmp(i8* %285, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.98, i64 0, i64 0)) #10
  %331 = icmp ne i32 %330, 0
  br i1 %331, label %333, label %332

; <label>:332:                                    ; preds = %329
  store i32 2, i32* %284, align 4
  br label %337

; <label>:333:                                    ; preds = %329
  %.lcssa27 = phi i32 [ %.lcssa40, %329 ]
  %.lcssa5 = phi i8* [ %285, %329 ]
  %334 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %335 = getelementptr [41 x i8], [41 x i8]* @.str.99, i32 0, i32 0
  %336 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %334, i8* %335, i32 %.lcssa27, i8* %.lcssa5)
  br label %._crit_edge

; <label>:337:                                    ; preds = %332, %328, %324, %320, %316, %312, %308, %304, %300, %296, %292, %288
  call void (i8*, ...) @dprint(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.100, i64 0, i64 0), i8* %285)
  %338 = call i8* @strsep(i8** %3, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.86, i64 0, i64 0)) #7
  %339 = icmp ne i8* %338, null
  br i1 %339, label %.lr.ph46, label %._crit_edge47.loopexit

; <label>:340:                                    ; preds = %265
  %.lcssa26 = phi i32 [ %.lcssa40, %265 ]
  %341 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %342 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %343 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %341, i8* %342, i32 %.lcssa26)
  br label %._crit_edge

._crit_edge47.loopexit:                           ; preds = %337
  br label %._crit_edge47

._crit_edge47:                                    ; preds = %._crit_edge47.loopexit, %268, %256, %232, %220, %193, %181, %162, %142, %139, %133, %127
  %.0333 = phi %struct.opendoor* [ %.03.ph48, %133 ], [ %.03.ph48, %139 ], [ %.03.ph48, %142 ], [ %.03.ph48, %127 ], [ %.03.ph48, %162 ], [ %.03.ph48, %181 ], [ %.03.ph48, %193 ], [ %.03.ph48, %220 ], [ %.03.ph48, %232 ], [ %.03.ph48, %256 ], [ %.03.ph48, %268 ], [ %.03.ph48, %._crit_edge47.loopexit ]
  store i8 0, i8* %29, align 16
  br label %.outer

.outer:                                           ; preds = %._crit_edge47, %114, %76, %67
  %.2 = phi %struct.opendoor* [ %72, %76 ], [ %.03.ph48, %67 ], [ %.0333, %._crit_edge47 ], [ %.03.ph48, %114 ]
  %344 = call i8* @fgets(i8* %11, i32 100, %struct._IO_FILE* %7), !track !36
  %345 = icmp ne i8* %344, null
  br i1 %345, label %.lr.ph43, label %.outer._crit_edge.loopexit3

.outer._crit_edge.loopexit:                       ; preds = %39
  br label %.outer._crit_edge

.outer._crit_edge.loopexit3:                      ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer._crit_edge.loopexit3, %.outer._crit_edge.loopexit, %10
  %346 = call i32 @fclose(%struct._IO_FILE* %7)
  %347 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %348 = icmp ne %struct.__pmlist_t* %347, null
  br i1 %348, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %.outer._crit_edge
  br label %.lr.ph

.lr.ph:                                           ; preds = %363, %.lr.ph.preheader
  %.0141 = phi %struct.__pmlist_t* [ %365, %363 ], [ %347, %.lr.ph.preheader ]
  %349 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.0141, i32 0, i32 0
  %350 = load i8*, i8** %349, align 8
  %351 = bitcast i8* %350 to %struct.opendoor*
  %352 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %351, i32 0, i32 1
  %353 = load i16, i16* %352, align 8
  %354 = zext i16 %353 to i32
  %355 = icmp eq i32 %354, 0
  br i1 %355, label %356, label %363

; <label>:356:                                    ; preds = %.lr.ph
  %.lcssa4 = phi i8* [ %350, %.lr.ph ]
  %357 = bitcast i8* %.lcssa4 to %struct.opendoor*
  %358 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %359 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %357, i32 0, i32 0
  %360 = getelementptr inbounds [128 x i8], [128 x i8]* %359, i32 0, i32 0
  %361 = getelementptr [49 x i8], [49 x i8]* @.str.101, i32 0, i32 0
  %362 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %358, i8* %361, i8* %360)
  br label %._crit_edge

; <label>:363:                                    ; preds = %.lr.ph
  %364 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.0141, i32 0, i32 2
  %365 = load %struct.__pmlist_t*, %struct.__pmlist_t** %364, align 8
  %366 = icmp ne %struct.__pmlist_t* %365, null
  br i1 %366, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %363
  %.0.ph = phi i32 [ 0, %363 ]
  br label %._crit_edge

._crit_edge.loopexit1:                            ; preds = %158
  %.0.ph2 = phi i32 [ %160, %158 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit1, %._crit_edge.loopexit, %356, %.outer._crit_edge, %340, %333, %184, %173, %151, %145, %115, %102, %95, %63, %9
  %.0 = phi i32 [ 1, %9 ], [ 1, %63 ], [ 1, %102 ], [ 1, %115 ], [ 1, %151 ], [ 1, %340 ], [ 1, %333 ], [ 1, %173 ], [ 1, %184 ], [ 1, %145 ], [ 1, %95 ], [ 1, %356 ], [ 0, %.outer._crit_edge ], [ 0, %._crit_edge.loopexit ], [ %.0.ph2, %._crit_edge.loopexit1 ]
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i8* @get_ip_clone(i8*, i8*, i32) #0 {
  %4 = alloca %struct.ifreq, align 8, !track !37
  %5 = icmp sle i32 32, 0
  %6 = icmp eq i64 403, 0
  %7 = icmp eq i8* %1, null
  %or.cond = or i1 false, false
  br i1 false, label %40, label %8

; <label>:8:                                      ; preds = %3
  %9 = getelementptr inbounds i8, i8* %1, i64 0
  store i8 0, i8* %9, align 1
  %10 = call i32 @socket(i32 2, i32 2, i32 0) #7
  %11 = icmp slt i32 %10, 0
  br i1 %11, label %40, label %12

; <label>:12:                                     ; preds = %8
  %13 = getelementptr inbounds %struct.ifreq, %struct.ifreq* %4, i32 0, i32 0
  %14 = bitcast %union.anon* %13 to [16 x i8]*
  %15 = bitcast [16 x i8]* %14 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %15, i8 0, i64 16, i1 false)
  %16 = getelementptr inbounds %struct.ifreq, %struct.ifreq* %4, i32 0, i32 0
  %17 = bitcast %union.anon* %16 to [16 x i8]*
  %18 = getelementptr inbounds [16 x i8], [16 x i8]* %17, i32 0, i32 0
  %19 = call i8* @strncpy(i8* %18, i8* %0, i64 15) #7, !track !38
  %20 = getelementptr inbounds %struct.ifreq, %struct.ifreq* %4, i32 0, i32 0
  %21 = bitcast %union.anon* %20 to [16 x i8]*
  %22 = getelementptr inbounds [16 x i8], [16 x i8]* %21, i64 0, i64 15
  store i8 0, i8* %22, align 1
  %23 = call i32 (i32, i64, ...) @ioctl(i32 %10, i64 35093, %struct.ifreq* %4) #7
  %24 = icmp ne i32 %23, 0
  %25 = call i32 @close(i32 %10)
  br i1 %24, label %40, label %26

; <label>:26:                                     ; preds = %12
  %27 = getelementptr inbounds %struct.ifreq, %struct.ifreq* %4, i32 0, i32 1
  %28 = bitcast %union.anon.1* %27 to %struct.sockaddr*
  %29 = bitcast %struct.sockaddr* %28 to %struct.sockaddr_in*
  %30 = getelementptr inbounds %struct.sockaddr_in, %struct.sockaddr_in* %29, i32 0, i32 2
  %31 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %30, i32 0, i32 0
  %32 = load i32, i32* %31, align 4
  %33 = call i8* @inet_ntoa(i32 %32) #7, !track !39
  %34 = sub nsw i32 32, 1
  %35 = sext i32 31 to i64
  %36 = call i8* @strncpy(i8* %1, i8* %33, i64 31) #7, !track !40
  %37 = sub nsw i32 32, 1
  %38 = sext i32 31 to i64
  %39 = getelementptr inbounds i8, i8* %1, i64 31
  store i8 0, i8* %39, align 1
  br label %40

; <label>:40:                                     ; preds = %26, %12, %8, %3
  %.0 = phi i8* [ %1, %26 ], [ null, %3 ], [ null, %8 ], [ null, %12 ]
  ret i8* %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @dprint_clone(i8*, ...) #0 {
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
define dso_local void @generate_pcap_filter_clone() #0 {
  %1 = alloca i8*, align 8, !track !41
  %2 = alloca [10 x i8], align 1
  %3 = alloca %struct.bpf_program, align 8, !track !42
  store i8* null, i8** %1, align 8
  %4 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %5 = icmp ne %struct.__pmlist_t* %4, null
  br i1 %5, label %.lr.ph51.preheader, label %._crit_edge52

.lr.ph51.preheader:                               ; preds = %0
  %6 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %7 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %8 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %9 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  br label %.lr.ph51

.lr.ph51:                                         ; preds = %215, %.lr.ph51.preheader
  %.049 = phi %struct.__pmlist_t* [ %217, %215 ], [ %4, %.lr.ph51.preheader ]
  %.0148 = phi i64 [ %.30, %215 ], [ 0, %.lr.ph51.preheader ]
  %.02347 = phi i16 [ %.124, %215 ], [ 0, %.lr.ph51.preheader ]
  %10 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.049, i32 0, i32 0
  %11 = load i8*, i8** %10, align 8
  %12 = bitcast i8* %11 to %struct.opendoor*
  %13 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 15
  %14 = load i8*, i8** %13, align 8
  %15 = icmp ne i8* %14, null
  br i1 %15, label %215, label %16

; <label>:16:                                     ; preds = %.lr.ph51
  %17 = load i8*, i8** %1, align 8
  %18 = icmp eq i8* %17, null
  br i1 %18, label %19, label %27

; <label>:19:                                     ; preds = %16
  %20 = call noalias i8* @malloc(i64 200) #7, !track !43
  store i8* %20, i8** %1, align 8
  %21 = load i8*, i8** %1, align 8
  %22 = icmp eq i8* %21, null
  br i1 %22, label %23, label %24

; <label>:23:                                     ; preds = %19
  call void @perror(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.56, i64 0, i64 0))
  call void @cleanup(i32 1)
  br label %24

; <label>:24:                                     ; preds = %23, %19
  %25 = load i8*, i8** %1, align 8
  %26 = getelementptr inbounds i8, i8* %25, i64 0
  store i8 0, i8* %26, align 1
  br label %27

; <label>:27:                                     ; preds = %24, %16
  %.12 = phi i64 [ 200, %24 ], [ %.0148, %16 ]
  %28 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 1
  %29 = load i16, i16* %28, align 8
  %30 = zext i16 %29 to i32
  %31 = icmp ult i32 0, %30
  br i1 %31, label %.lr.ph32.preheader, label %._crit_edge33

.lr.ph32.preheader:                               ; preds = %27
  %scevgep = getelementptr i8, i8* %11, i64 194
  br label %.lr.ph32

.lr.ph32:                                         ; preds = %48, %.lr.ph32.preheader
  %indvars.iv = phi i64 [ %indvars.iv.next, %48 ], [ 0, %.lr.ph32.preheader ]
  %.230 = phi i64 [ %.4, %48 ], [ %.12, %.lr.ph32.preheader ]
  %.0429 = phi i16 [ %.211, %48 ], [ 0, %.lr.ph32.preheader ]
  %.01528 = phi i16 [ %.217, %48 ], [ 0, %.lr.ph32.preheader ]
  %32 = shl i64 %indvars.iv, 1
  %scevgep1 = getelementptr i8, i8* %scevgep, i64 %32
  %scevgep12 = bitcast i8* %scevgep1 to i16*
  %33 = load i16, i16* %scevgep12, align 2
  %34 = zext i16 %33 to i32
  %35 = icmp eq i32 %34, 6
  br i1 %35, label %36, label %48

; <label>:36:                                     ; preds = %.lr.ph32
  %37 = icmp ne i16 %.0429, 0
  br i1 %37, label %40, label %38

; <label>:38:                                     ; preds = %36
  %39 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.112, i64 0, i64 0), i64 %.230)
  br label %42

; <label>:40:                                     ; preds = %36
  %41 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.113, i64 0, i64 0), i64 %.230)
  br label %42

; <label>:42:                                     ; preds = %40, %38
  %.116 = phi i16 [ %.01528, %40 ], [ 1, %38 ]
  %.110 = phi i16 [ %.0429, %40 ], [ 1, %38 ]
  %.3 = phi i64 [ %41, %40 ], [ %39, %38 ]
  %43 = shl i64 %indvars.iv, 1
  %scevgep3 = getelementptr i8, i8* %scevgep, i64 %43
  %scevgep34 = bitcast i8* %scevgep3 to i16*
  %scevgep5 = getelementptr i16, i16* %scevgep34, i64 -32
  %44 = load i16, i16* %scevgep5, align 2
  %45 = zext i16 %44 to i32
  %46 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %6, i64 10, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.114, i64 0, i64 0), i32 %45) #7
  %47 = call i64 @realloc_strcat(i8** %1, i8* %7, i64 %.3)
  br label %48

; <label>:48:                                     ; preds = %42, %.lr.ph32
  %.217 = phi i16 [ %.116, %42 ], [ %.01528, %.lr.ph32 ]
  %.211 = phi i16 [ %.110, %42 ], [ %.0429, %.lr.ph32 ]
  %.4 = phi i64 [ %47, %42 ], [ %.230, %.lr.ph32 ]
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %49 = load i16, i16* %28, align 8
  %50 = zext i16 %49 to i32
  %51 = zext i32 %50 to i64
  %52 = icmp ult i64 %indvars.iv.next, %51
  br i1 %52, label %.lr.ph32, label %._crit_edge33.loopexit

._crit_edge33.loopexit:                           ; preds = %48
  %.015.lcssa.ph = phi i16 [ %.217, %48 ]
  %.2.lcssa.ph = phi i64 [ %.4, %48 ]
  br label %._crit_edge33

._crit_edge33:                                    ; preds = %._crit_edge33.loopexit, %27
  %.015.lcssa = phi i16 [ 0, %27 ], [ %.015.lcssa.ph, %._crit_edge33.loopexit ]
  %.2.lcssa = phi i64 [ %.12, %27 ], [ %.2.lcssa.ph, %._crit_edge33.loopexit ]
  %53 = icmp ne i16 %.015.lcssa, 0
  br i1 %53, label %54, label %56

; <label>:54:                                     ; preds = %._crit_edge33
  %55 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.115, i64 0, i64 0), i64 %.2.lcssa)
  br label %56

; <label>:56:                                     ; preds = %54, %._crit_edge33
  %.5 = phi i64 [ %55, %54 ], [ %.2.lcssa, %._crit_edge33 ]
  %57 = icmp ne i16 %.015.lcssa, 0
  br i1 %57, label %58, label %162

; <label>:58:                                     ; preds = %56
  %59 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 8
  %60 = load i32, i32* %59, align 8
  %61 = icmp ne i32 %60, 0
  br i1 %61, label %62, label %75

; <label>:62:                                     ; preds = %58
  %63 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.116, i64 0, i64 0), i64 %.5)
  %64 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 8
  %65 = load i32, i32* %64, align 8
  %66 = icmp eq i32 %65, 1
  br i1 %66, label %67, label %69

; <label>:67:                                     ; preds = %62
  %68 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.117, i64 0, i64 0), i64 %63)
  br label %69

; <label>:69:                                     ; preds = %67, %62
  %.6 = phi i64 [ %68, %67 ], [ %63, %62 ]
  %70 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 8
  %71 = load i32, i32* %70, align 8
  %72 = icmp eq i32 %71, 2
  br i1 %72, label %73, label %75

; <label>:73:                                     ; preds = %69
  %74 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.118, i64 0, i64 0), i64 %.6)
  br label %75

; <label>:75:                                     ; preds = %73, %69, %58
  %.8 = phi i64 [ %.5, %58 ], [ %74, %73 ], [ %.6, %69 ]
  %76 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 9
  %77 = load i32, i32* %76, align 4
  %78 = icmp ne i32 %77, 0
  br i1 %78, label %79, label %92

; <label>:79:                                     ; preds = %75
  %80 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.119, i64 0, i64 0), i64 %.8)
  %81 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 9
  %82 = load i32, i32* %81, align 4
  %83 = icmp eq i32 %82, 1
  br i1 %83, label %84, label %86

; <label>:84:                                     ; preds = %79
  %85 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.117, i64 0, i64 0), i64 %80)
  br label %86

; <label>:86:                                     ; preds = %84, %79
  %.9 = phi i64 [ %85, %84 ], [ %80, %79 ]
  %87 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 9
  %88 = load i32, i32* %87, align 4
  %89 = icmp eq i32 %88, 2
  br i1 %89, label %90, label %92

; <label>:90:                                     ; preds = %86
  %91 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.118, i64 0, i64 0), i64 %.9)
  br label %92

; <label>:92:                                     ; preds = %90, %86, %75
  %.11 = phi i64 [ %.8, %75 ], [ %91, %90 ], [ %.9, %86 ]
  %93 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 10
  %94 = load i32, i32* %93, align 8
  %95 = icmp ne i32 %94, 0
  br i1 %95, label %96, label %109

; <label>:96:                                     ; preds = %92
  %97 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.120, i64 0, i64 0), i64 %.11)
  %98 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 10
  %99 = load i32, i32* %98, align 8
  %100 = icmp eq i32 %99, 1
  br i1 %100, label %101, label %103

; <label>:101:                                    ; preds = %96
  %102 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.117, i64 0, i64 0), i64 %97)
  br label %103

; <label>:103:                                    ; preds = %101, %96
  %.123 = phi i64 [ %102, %101 ], [ %97, %96 ]
  %104 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 10
  %105 = load i32, i32* %104, align 8
  %106 = icmp eq i32 %105, 2
  br i1 %106, label %107, label %109

; <label>:107:                                    ; preds = %103
  %108 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.118, i64 0, i64 0), i64 %.123)
  br label %109

; <label>:109:                                    ; preds = %107, %103, %92
  %.14 = phi i64 [ %.11, %92 ], [ %108, %107 ], [ %.123, %103 ]
  %110 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 11
  %111 = load i32, i32* %110, align 4
  %112 = icmp ne i32 %111, 0
  br i1 %112, label %113, label %126

; <label>:113:                                    ; preds = %109
  %114 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.121, i64 0, i64 0), i64 %.14)
  %115 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 11
  %116 = load i32, i32* %115, align 4
  %117 = icmp eq i32 %116, 1
  br i1 %117, label %118, label %120

; <label>:118:                                    ; preds = %113
  %119 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.117, i64 0, i64 0), i64 %114)
  br label %120

; <label>:120:                                    ; preds = %118, %113
  %.15 = phi i64 [ %119, %118 ], [ %114, %113 ]
  %121 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 11
  %122 = load i32, i32* %121, align 4
  %123 = icmp eq i32 %122, 2
  br i1 %123, label %124, label %126

; <label>:124:                                    ; preds = %120
  %125 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.118, i64 0, i64 0), i64 %.15)
  br label %126

; <label>:126:                                    ; preds = %124, %120, %109
  %.17 = phi i64 [ %.14, %109 ], [ %125, %124 ], [ %.15, %120 ]
  %127 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 12
  %128 = load i32, i32* %127, align 8
  %129 = icmp ne i32 %128, 0
  br i1 %129, label %130, label %143

; <label>:130:                                    ; preds = %126
  %131 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.122, i64 0, i64 0), i64 %.17)
  %132 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 12
  %133 = load i32, i32* %132, align 8
  %134 = icmp eq i32 %133, 1
  br i1 %134, label %135, label %137

; <label>:135:                                    ; preds = %130
  %136 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.117, i64 0, i64 0), i64 %131)
  br label %137

; <label>:137:                                    ; preds = %135, %130
  %.18 = phi i64 [ %136, %135 ], [ %131, %130 ]
  %138 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 12
  %139 = load i32, i32* %138, align 8
  %140 = icmp eq i32 %139, 2
  br i1 %140, label %141, label %143

; <label>:141:                                    ; preds = %137
  %142 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.118, i64 0, i64 0), i64 %.18)
  br label %143

; <label>:143:                                    ; preds = %141, %137, %126
  %.20 = phi i64 [ %.17, %126 ], [ %142, %141 ], [ %.18, %137 ]
  %144 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 13
  %145 = load i32, i32* %144, align 4
  %146 = icmp ne i32 %145, 0
  br i1 %146, label %147, label %160

; <label>:147:                                    ; preds = %143
  %148 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.123, i64 0, i64 0), i64 %.20)
  %149 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 13
  %150 = load i32, i32* %149, align 4
  %151 = icmp eq i32 %150, 1
  br i1 %151, label %152, label %154

; <label>:152:                                    ; preds = %147
  %153 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.117, i64 0, i64 0), i64 %148)
  br label %154

; <label>:154:                                    ; preds = %152, %147
  %.21 = phi i64 [ %153, %152 ], [ %148, %147 ]
  %155 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 13
  %156 = load i32, i32* %155, align 4
  %157 = icmp eq i32 %156, 2
  br i1 %157, label %158, label %160

; <label>:158:                                    ; preds = %154
  %159 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.118, i64 0, i64 0), i64 %.21)
  br label %160

; <label>:160:                                    ; preds = %158, %154, %143
  %.23 = phi i64 [ %.20, %143 ], [ %159, %158 ], [ %.21, %154 ]
  %161 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.115, i64 0, i64 0), i64 %.23)
  br label %162

; <label>:162:                                    ; preds = %160, %56
  %.24 = phi i64 [ %161, %160 ], [ %.5, %56 ]
  %163 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 1
  %164 = load i16, i16* %163, align 8
  %165 = zext i16 %164 to i32
  %166 = icmp ult i32 0, %165
  br i1 %166, label %.lr.ph41.preheader, label %._crit_edge42

.lr.ph41.preheader:                               ; preds = %162
  %167 = icmp ne i16 %.015.lcssa, 0
  %scevgep6 = getelementptr i8, i8* %11, i64 194
  br label %.lr.ph41

.lr.ph41:                                         ; preds = %187, %.lr.ph41.preheader
  %indvars.iv45 = phi i64 [ %indvars.iv.next46, %187 ], [ 0, %.lr.ph41.preheader ]
  %.2539 = phi i64 [ %.28, %187 ], [ %.24, %.lr.ph41.preheader ]
  %.31238 = phi i16 [ %.514, %187 ], [ 0, %.lr.ph41.preheader ]
  %.01837 = phi i16 [ %.220, %187 ], [ 0, %.lr.ph41.preheader ]
  %168 = shl i64 %indvars.iv45, 1
  %scevgep7 = getelementptr i8, i8* %scevgep6, i64 %168
  %scevgep78 = bitcast i8* %scevgep7 to i16*
  %169 = load i16, i16* %scevgep78, align 2
  %170 = zext i16 %169 to i32
  %171 = icmp eq i32 %170, 17
  br i1 %171, label %172, label %187

; <label>:172:                                    ; preds = %.lr.ph41
  %173 = icmp ne i16 %.31238, 0
  br i1 %173, label %179, label %174

; <label>:174:                                    ; preds = %172
  br i1 %167, label %175, label %177

; <label>:175:                                    ; preds = %174
  %176 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.113, i64 0, i64 0), i64 %.2539)
  br label %177

; <label>:177:                                    ; preds = %175, %174
  %.26 = phi i64 [ %176, %175 ], [ %.2539, %174 ]
  %178 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.124, i64 0, i64 0), i64 %.26)
  br label %181

; <label>:179:                                    ; preds = %172
  %180 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.113, i64 0, i64 0), i64 %.2539)
  br label %181

; <label>:181:                                    ; preds = %179, %177
  %.119 = phi i16 [ %.01837, %179 ], [ 1, %177 ]
  %.413 = phi i16 [ %.31238, %179 ], [ 1, %177 ]
  %.27 = phi i64 [ %180, %179 ], [ %178, %177 ]
  %182 = shl i64 %indvars.iv45, 1
  %scevgep9 = getelementptr i8, i8* %scevgep6, i64 %182
  %scevgep910 = bitcast i8* %scevgep9 to i16*
  %scevgep11 = getelementptr i16, i16* %scevgep910, i64 -32
  %183 = load i16, i16* %scevgep11, align 2
  %184 = zext i16 %183 to i32
  %185 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %8, i64 10, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.114, i64 0, i64 0), i32 %184) #7
  %186 = call i64 @realloc_strcat(i8** %1, i8* %9, i64 %.27)
  br label %187

; <label>:187:                                    ; preds = %181, %.lr.ph41
  %.220 = phi i16 [ %.119, %181 ], [ %.01837, %.lr.ph41 ]
  %.514 = phi i16 [ %.413, %181 ], [ %.31238, %.lr.ph41 ]
  %.28 = phi i64 [ %186, %181 ], [ %.2539, %.lr.ph41 ]
  %indvars.iv.next46 = add nuw nsw i64 %indvars.iv45, 1
  %188 = load i16, i16* %163, align 8
  %189 = zext i16 %188 to i32
  %190 = zext i32 %189 to i64
  %191 = icmp ult i64 %indvars.iv.next46, %190
  br i1 %191, label %.lr.ph41, label %._crit_edge42.loopexit

._crit_edge42.loopexit:                           ; preds = %187
  %.018.lcssa.ph = phi i16 [ %.220, %187 ]
  %.25.lcssa.ph = phi i64 [ %.28, %187 ]
  br label %._crit_edge42

._crit_edge42:                                    ; preds = %._crit_edge42.loopexit, %162
  %.018.lcssa = phi i16 [ 0, %162 ], [ %.018.lcssa.ph, %._crit_edge42.loopexit ]
  %.25.lcssa = phi i64 [ %.24, %162 ], [ %.25.lcssa.ph, %._crit_edge42.loopexit ]
  %192 = icmp ne i16 %.018.lcssa, 0
  br i1 %192, label %193, label %195

; <label>:193:                                    ; preds = %._crit_edge42
  %194 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.115, i64 0, i64 0), i64 %.25.lcssa)
  br label %195

; <label>:195:                                    ; preds = %193, %._crit_edge42
  %.29 = phi i64 [ %194, %193 ], [ %.25.lcssa, %._crit_edge42 ]
  %196 = icmp eq i64 %.29, 0
  br i1 %196, label %197, label %198

; <label>:197:                                    ; preds = %195
  call void @perror(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.125, i64 0, i64 0))
  call void @cleanup(i32 1)
  br label %198

; <label>:198:                                    ; preds = %197, %195
  %199 = load i8*, i8** %1, align 8
  %200 = call i64 @strlen(i8* %199) #10
  %201 = add i64 %200, 1
  %202 = call noalias i8* @malloc(i64 %201) #7, !track !44
  %203 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 15
  store i8* %202, i8** %203, align 8
  %204 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 15
  %205 = load i8*, i8** %204, align 8
  %206 = icmp eq i8* %205, null
  br i1 %206, label %207, label %208

; <label>:207:                                    ; preds = %198
  call void @perror(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.56, i64 0, i64 0))
  call void @cleanup(i32 1)
  br label %208

; <label>:208:                                    ; preds = %207, %198
  %209 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %12, i32 0, i32 15
  %210 = load i8*, i8** %209, align 8
  %211 = load i8*, i8** %1, align 8
  %212 = call i8* @strcpy(i8* %210, i8* %211) #7, !track !45
  %213 = load i8*, i8** %1, align 8
  %214 = getelementptr inbounds i8, i8* %213, i64 0
  store i8 0, i8* %214, align 1
  br label %215

; <label>:215:                                    ; preds = %208, %.lr.ph51
  %.124 = phi i16 [ 1, %208 ], [ %.02347, %.lr.ph51 ]
  %.30 = phi i64 [ %.29, %208 ], [ %.0148, %.lr.ph51 ]
  %216 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.049, i32 0, i32 2
  %217 = load %struct.__pmlist_t*, %struct.__pmlist_t** %216, align 8
  %218 = icmp ne %struct.__pmlist_t* %217, null
  br i1 %218, label %.lr.ph51, label %._crit_edge52.loopexit

._crit_edge52.loopexit:                           ; preds = %215
  %.023.lcssa.ph = phi i16 [ %.124, %215 ]
  %.01.lcssa.ph = phi i64 [ %.30, %215 ]
  br label %._crit_edge52

._crit_edge52:                                    ; preds = %._crit_edge52.loopexit, %0
  %.023.lcssa = phi i16 [ 0, %0 ], [ %.023.lcssa.ph, %._crit_edge52.loopexit ]
  %.01.lcssa = phi i64 [ 0, %0 ], [ %.01.lcssa.ph, %._crit_edge52.loopexit ]
  %219 = icmp ne i16 %.023.lcssa, 0
  br i1 %219, label %220, label %266

; <label>:220:                                    ; preds = %._crit_edge52
  %221 = getelementptr [10 x i8], [10 x i8]* @.str.126, i32 0, i32 0
  %222 = call i64 @realloc_strcat_clone(i8** %1, i8* %221, i64 %.01.lcssa)
  %223 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %224 = call i64 @realloc_strcat_clone.8(i8** %1, i8* %223, i64 %222)
  %225 = getelementptr [7 x i8], [7 x i8]* @.str.127, i32 0, i32 0
  %226 = call i64 @realloc_strcat_clone.10(i8** %1, i8* %225, i64 %224)
  %227 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %228 = icmp ne %struct.__pmlist_t* %227, null
  br i1 %228, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %220
  br label %.lr.ph

.lr.ph:                                           ; preds = %240, %.lr.ph.preheader
  %.126 = phi %struct.__pmlist_t* [ %242, %240 ], [ %227, %.lr.ph.preheader ]
  %.3125 = phi i64 [ %.32, %240 ], [ %226, %.lr.ph.preheader ]
  %229 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.126, i32 0, i32 0
  %230 = load i8*, i8** %229, align 8
  %231 = bitcast i8* %230 to %struct.opendoor*
  %232 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %231, i32 0, i32 15
  %233 = load i8*, i8** %232, align 8
  %234 = call i64 @realloc_strcat(i8** %1, i8* %233, i64 %.3125)
  %235 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.126, i32 0, i32 2
  %236 = load %struct.__pmlist_t*, %struct.__pmlist_t** %235, align 8
  %237 = icmp ne %struct.__pmlist_t* %236, null
  br i1 %237, label %238, label %240

; <label>:238:                                    ; preds = %.lr.ph
  %239 = call i64 @realloc_strcat(i8** %1, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.113, i64 0, i64 0), i64 %234)
  br label %240

; <label>:240:                                    ; preds = %238, %.lr.ph
  %.32 = phi i64 [ %239, %238 ], [ %234, %.lr.ph ]
  %241 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.126, i32 0, i32 2
  %242 = load %struct.__pmlist_t*, %struct.__pmlist_t** %241, align 8
  %243 = icmp ne %struct.__pmlist_t* %242, null
  br i1 %243, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %240
  %.31.lcssa.ph = phi i64 [ %.32, %240 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %220
  %.31.lcssa = phi i64 [ %226, %220 ], [ %.31.lcssa.ph, %._crit_edge.loopexit ]
  %244 = getelementptr [2 x i8], [2 x i8]* @.str.115, i32 0, i32 0
  %245 = call i64 @realloc_strcat_clone.12(i8** %1, i8* %244, i64 %.31.lcssa)
  %246 = icmp eq i64 %245, 0
  br i1 %246, label %247, label %249

; <label>:247:                                    ; preds = %._crit_edge
  %248 = getelementptr [8 x i8], [8 x i8]* @.str.125, i32 0, i32 0
  call void @perror(i8* %248)
  call void @cleanup(i32 1)
  br label %249

; <label>:249:                                    ; preds = %247, %._crit_edge
  %250 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %251 = load i8*, i8** %1, align 8
  %252 = call i32 @pcap_compile(%struct.pcap* %250, %struct.bpf_program* %3, i8* %251, i32 1, i32 0)
  %253 = icmp slt i32 %252, 0
  br i1 %253, label %254, label %257

; <label>:254:                                    ; preds = %249
  %255 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %256 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %255, i8* %256)
  call void @cleanup(i32 1)
  br label %257

; <label>:257:                                    ; preds = %254, %249
  %258 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %259 = call i32 @pcap_setfilter(%struct.pcap* %258, %struct.bpf_program* %3)
  %260 = icmp slt i32 %259, 0
  br i1 %260, label %261, label %264

; <label>:261:                                    ; preds = %257
  %262 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %263 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %262, i8* %263)
  call void @cleanup(i32 1)
  br label %264

; <label>:264:                                    ; preds = %261, %257
  call void @pcap_freecode(%struct.bpf_program* %3)
  %265 = load i8*, i8** %1, align 8
  call void @free(i8* %265) #7
  br label %266

; <label>:266:                                    ; preds = %264, %._crit_edge52
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i64 @realloc_strcat_clone(i8**, i8*, i64) #0 {
  %4 = icmp eq i64 %2, 0
  br i1 %4, label %24, label %5

; <label>:5:                                      ; preds = %3
  %6 = load i8*, i8** %0, align 8
  %7 = call i64 @strlen(i8* %6) #10
  %8 = getelementptr [10 x i8], [10 x i8]* @3, i64 0, i64 0
  %9 = call i64 @strlen(i8* %8) #10
  %10 = add i64 %7, 9
  %11 = add i64 %10, 1
  %12 = icmp ugt i64 %11, %2
  br i1 %12, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %5
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %.lr.ph.preheader
  %.012 = phi i64 [ %13, %.lr.ph ], [ %2, %.lr.ph.preheader ]
  %13 = mul i64 %.012, 2
  %14 = icmp ugt i64 %11, %13
  br i1 %14, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.01.lcssa.ph = phi i64 [ %13, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %5
  %.01.lcssa = phi i64 [ %2, %5 ], [ %.01.lcssa.ph, %._crit_edge.loopexit ]
  %15 = icmp ne i64 %.01.lcssa, %2
  br i1 %15, label %16, label %21

; <label>:16:                                     ; preds = %._crit_edge
  %17 = load i8*, i8** %0, align 8
  %18 = call i8* @realloc(i8* %17, i64 %.01.lcssa) #7, !track !68
  store i8* %18, i8** %0, align 8
  %19 = load i8*, i8** %0, align 8
  %20 = icmp eq i8* %19, null
  br i1 %20, label %24, label %21

; <label>:21:                                     ; preds = %16, %._crit_edge
  %22 = load i8*, i8** %0, align 8
  %23 = call i8* @strcat(i8* %22, i8* %1) #7, !track !69
  br label %24

; <label>:24:                                     ; preds = %21, %16, %3
  %.0 = phi i64 [ %.01.lcssa, %21 ], [ 0, %3 ], [ 0, %16 ]
  ret i64 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i64 @realloc_strcat_clone.8(i8**, i8*, i64) #0 {
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

.lr.ph:                                           ; preds = %.lr.ph, %.lr.ph.preheader
  %.012 = phi i64 [ %12, %.lr.ph ], [ %2, %.lr.ph.preheader ]
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

; <label>:23:                                     ; preds = %20, %15, %3
  %.0 = phi i64 [ %.01.lcssa, %20 ], [ 0, %3 ], [ 0, %15 ]
  ret i64 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i64 @realloc_strcat_clone.10(i8**, i8*, i64) #0 {
  %4 = icmp eq i64 %2, 0
  br i1 %4, label %24, label %5

; <label>:5:                                      ; preds = %3
  %6 = load i8*, i8** %0, align 8
  %7 = call i64 @strlen(i8* %6) #10
  %8 = getelementptr [7 x i8], [7 x i8]* @4, i64 0, i64 0
  %9 = call i64 @strlen(i8* %8) #10
  %10 = add i64 %7, 6
  %11 = add i64 %10, 1
  %12 = icmp ugt i64 %11, %2
  br i1 %12, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %5
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %.lr.ph.preheader
  %.012 = phi i64 [ %13, %.lr.ph ], [ %2, %.lr.ph.preheader ]
  %13 = mul i64 %.012, 2
  %14 = icmp ugt i64 %11, %13
  br i1 %14, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.01.lcssa.ph = phi i64 [ %13, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %5
  %.01.lcssa = phi i64 [ %2, %5 ], [ %.01.lcssa.ph, %._crit_edge.loopexit ]
  %15 = icmp ne i64 %.01.lcssa, %2
  br i1 %15, label %16, label %21

; <label>:16:                                     ; preds = %._crit_edge
  %17 = load i8*, i8** %0, align 8
  %18 = call i8* @realloc(i8* %17, i64 %.01.lcssa) #7, !track !68
  store i8* %18, i8** %0, align 8
  %19 = load i8*, i8** %0, align 8
  %20 = icmp eq i8* %19, null
  br i1 %20, label %24, label %21

; <label>:21:                                     ; preds = %16, %._crit_edge
  %22 = load i8*, i8** %0, align 8
  %23 = call i8* @strcat(i8* %22, i8* %1) #7, !track !69
  br label %24

; <label>:24:                                     ; preds = %21, %16, %3
  %.0 = phi i64 [ %.01.lcssa, %21 ], [ 0, %3 ], [ 0, %16 ]
  ret i64 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i64 @realloc_strcat_clone.12(i8**, i8*, i64) #0 {
  %4 = icmp eq i64 %2, 0
  br i1 %4, label %24, label %5

; <label>:5:                                      ; preds = %3
  %6 = load i8*, i8** %0, align 8
  %7 = call i64 @strlen(i8* %6) #10
  %8 = getelementptr [2 x i8], [2 x i8]* @5, i64 0, i64 0
  %9 = call i64 @strlen(i8* %8) #10
  %10 = add i64 %7, 1
  %11 = add i64 %10, 1
  %12 = icmp ugt i64 %11, %2
  br i1 %12, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %5
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %.lr.ph.preheader
  %.012 = phi i64 [ %13, %.lr.ph ], [ %2, %.lr.ph.preheader ]
  %13 = mul i64 %.012, 2
  %14 = icmp ugt i64 %11, %13
  br i1 %14, label %.lr.ph, label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %.lr.ph
  %.01.lcssa.ph = phi i64 [ %13, %.lr.ph ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %5
  %.01.lcssa = phi i64 [ %2, %5 ], [ %.01.lcssa.ph, %._crit_edge.loopexit ]
  %15 = icmp ne i64 %.01.lcssa, %2
  br i1 %15, label %16, label %21

; <label>:16:                                     ; preds = %._crit_edge
  %17 = load i8*, i8** %0, align 8
  %18 = call i8* @realloc(i8* %17, i64 %.01.lcssa) #7, !track !68
  store i8* %18, i8** %0, align 8
  %19 = load i8*, i8** %0, align 8
  %20 = icmp eq i8* %19, null
  br i1 %20, label %24, label %21

; <label>:21:                                     ; preds = %16, %._crit_edge
  %22 = load i8*, i8** %0, align 8
  %23 = call i8* @strcat(i8* %22, i8* %1) #7, !track !69
  br label %24

; <label>:24:                                     ; preds = %21, %16, %3
  %.0 = phi i64 [ %.01.lcssa, %21 ], [ 0, %3 ], [ 0, %16 ]
  ret i64 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @dprint_clone.14(i8*, ...) #0 {
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
define dso_local void @logprint_clone(i8*, ...) #0 {
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

; Function Attrs: noinline nounwind uwtable
define dso_local void @vprint_clone(i8*, ...) #0 {
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
define dso_local void @logprint_clone.18(i8*, ...) #0 {
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

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main_clone(i32, i8**) #0 {
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
  %28 = icmp ne i32 105, 0
  br i1 true, label %.lr.ph.preheader, label %.loopexit

.lr.ph.preheader:                                 ; preds = %2
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader
  br i1 false, label %.loopexit.loopexit, label %29

; <label>:29:                                     ; preds = %.lr.ph
  switch i32 105, label %41 [
    i32 0, label %42
    i32 118, label %30
    i32 68, label %31
    i32 100, label %32
    i32 108, label %33
    i32 105, label %34
    i32 99, label %37
    i32 86, label %40
  ]

; <label>:30:                                     ; preds = %29
  store i32 1, i32* @o_verbose, align 4
  br label %42

; <label>:31:                                     ; preds = %29
  store i32 1, i32* @o_debug, align 4
  br label %42

; <label>:32:                                     ; preds = %29
  store i32 1, i32* @o_daemon, align 4
  br label %42

; <label>:33:                                     ; preds = %29
  store i32 1, i32* @o_lookup, align 4
  br label %42

; <label>:34:                                     ; preds = %29
  %35 = load i8*, i8** @optarg, align 8
  %36 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %35, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %42

; <label>:37:                                     ; preds = %29
  %38 = load i8*, i8** @optarg, align 8
  %39 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %38, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %42

; <label>:40:                                     ; preds = %29
  call void @ver()
  br label %41

; <label>:41:                                     ; preds = %40, %29
  call void @usage()
  br label %42

; <label>:42:                                     ; preds = %41, %37, %34, %33, %32, %31, %30, %29
  %43 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %44 = icmp ne i32 -1, 0
  br i1 true, label %.lr.ph.1, label %.loopexit.loopexit

.loopexit.loopexit:                               ; preds = %485, %.lr.ph.19, %468, %.lr.ph.18, %451, %.lr.ph.17, %434, %.lr.ph.16, %417, %.lr.ph.15, %400, %.lr.ph.14, %383, %.lr.ph.13, %366, %.lr.ph.12, %349, %.lr.ph.11, %332, %.lr.ph.10, %315, %.lr.ph.9, %298, %.lr.ph.8, %281, %.lr.ph.7, %264, %.lr.ph.6, %247, %.lr.ph.5, %230, %.lr.ph.4, %213, %.lr.ph.3, %196, %.lr.ph.2, %179, %.lr.ph.1, %42, %.lr.ph
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %2
  %45 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i32 0, i32 0
  %46 = call i32 @parseconfig_clone(i8* %45)
  %47 = icmp ne i32 %46, 0
  br i1 %47, label %48, label %49

; <label>:48:                                     ; preds = %.loopexit
  call void @exit(i32 1) #9
  unreachable

; <label>:49:                                     ; preds = %.loopexit
  %50 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %51 = call i64 @strlen(i8* %50) #10
  %52 = icmp eq i64 %51, 0
  br i1 %52, label %53, label %57

; <label>:53:                                     ; preds = %49
  %54 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %55 = getelementptr [5 x i8], [5 x i8]* @.str.9, i32 0, i32 0
  %56 = call i8* @strncpy(i8* %54, i8* %55, i64 32) #7, !track !16
  br label %57

; <label>:57:                                     ; preds = %53, %49
  %58 = load i32, i32* @o_usesyslog, align 4
  %59 = icmp ne i32 %58, 0
  br i1 %59, label %60, label %62

; <label>:60:                                     ; preds = %57
  %61 = getelementptr [7 x i8], [7 x i8]* @.str.10, i32 0, i32 0
  call void @openlog(i8* %61, i32 0, i32 8)
  br label %62

; <label>:62:                                     ; preds = %60, %57
  %63 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  %64 = call i64 @strlen(i8* %63) #10
  %65 = icmp ne i64 %64, 0
  br i1 %65, label %66, label %74

; <label>:66:                                     ; preds = %62
  %67 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  %68 = getelementptr [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %69 = call %struct._IO_FILE* @fopen(i8* %67, i8* %68), !track !17
  store %struct._IO_FILE* %69, %struct._IO_FILE** @logfd, align 8
  %70 = load %struct._IO_FILE*, %struct._IO_FILE** @logfd, align 8
  %71 = icmp eq %struct._IO_FILE* %70, null
  br i1 %71, label %72, label %74

; <label>:72:                                     ; preds = %66
  %73 = getelementptr [29 x i8], [29 x i8]* @.str.12, i32 0, i32 0
  call void @perror(i8* %73)
  br label %74

; <label>:74:                                     ; preds = %72, %66, %62
  %75 = getelementptr inbounds [256 x i8], [256 x i8]* %22, i32 0, i32 0
  %76 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %77 = call %struct.pcap* @pcap_open_live(i8* %76, i32 65535, i32 0, i32 0, i8* %75)
  store %struct.pcap* %77, %struct.pcap** @cap, align 8
  %78 = getelementptr inbounds [256 x i8], [256 x i8]* %22, i32 0, i32 0
  %79 = call i64 @strlen(i8* %78) #10
  %80 = icmp ne i64 %79, 0
  br i1 %80, label %81, label %87

; <label>:81:                                     ; preds = %74
  %82 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %83 = getelementptr inbounds [256 x i8], [256 x i8]* %22, i32 0, i32 0
  %84 = getelementptr [23 x i8], [23 x i8]* @.str.13, i32 0, i32 0
  %85 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %86 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %82, i8* %84, i8* %85, i8* %83)
  br label %87

; <label>:87:                                     ; preds = %81, %74
  %88 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %89 = icmp eq %struct.pcap* %88, null
  br i1 %89, label %90, label %91

; <label>:90:                                     ; preds = %87
  call void @exit(i32 1) #9
  unreachable

; <label>:91:                                     ; preds = %87
  %92 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %93 = call i32 @pcap_datalink(%struct.pcap* %92)
  store i32 %93, i32* @lltype, align 4
  %94 = load i32, i32* @lltype, align 4
  switch i32 %94, label %101 [
    i32 1, label %95
    i32 113, label %97
    i32 12, label %99
  ]

; <label>:95:                                     ; preds = %91
  %96 = getelementptr [29 x i8], [29 x i8]* @.str.14, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %96)
  br label %106

; <label>:97:                                     ; preds = %91
  %98 = getelementptr [55 x i8], [55 x i8]* @.str.15, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %98)
  br label %106

; <label>:99:                                     ; preds = %91
  %100 = getelementptr [42 x i8], [42 x i8]* @.str.16, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %100)
  br label %106

; <label>:101:                                    ; preds = %91
  %102 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %103 = load i32, i32* @lltype, align 4
  %104 = getelementptr [40 x i8], [40 x i8]* @.str.17, i32 0, i32 0
  %105 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %102, i8* %104, i32 %103)
  call void @cleanup(i32 1)
  br label %106

; <label>:106:                                    ; preds = %101, %99, %97, %95
  %107 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %108 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %109 = call i8* @get_ip_clone(i8* %107, i8* %108, i32 32)
  %110 = icmp eq i8* %109, null
  br i1 %110, label %111, label %116

; <label>:111:                                    ; preds = %106
  %112 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %113 = getelementptr [33 x i8], [33 x i8]* @.str.18, i32 0, i32 0
  %114 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %115 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %112, i8* %113, i8* %114)
  call void @cleanup(i32 1)
  br label %119

; <label>:116:                                    ; preds = %106
  %117 = getelementptr [14 x i8], [14 x i8]* @.str.19, i32 0, i32 0
  %118 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  call void (i8*, ...) @dprint_clone(i8* %117, i8* %118)
  br label %119

; <label>:119:                                    ; preds = %116, %111
  call void @generate_pcap_filter_clone()
  %120 = load i32, i32* @o_daemon, align 4
  %121 = icmp ne i32 %120, 0
  br i1 %121, label %122, label %148

; <label>:122:                                    ; preds = %119
  %123 = call i32 @daemon(i32 0, i32 0) #7
  %124 = icmp slt i32 %123, 0
  br i1 %124, label %125, label %127

; <label>:125:                                    ; preds = %122
  %126 = getelementptr [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  call void @perror(i8* %126)
  call void @cleanup(i32 1)
  br label %127

; <label>:127:                                    ; preds = %125, %122
  %128 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  %129 = getelementptr [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %130 = call %struct._IO_FILE* @fopen(i8* %128, i8* %129), !track !18
  %131 = icmp ne %struct._IO_FILE* %130, null
  br i1 %131, label %132, label %137

; <label>:132:                                    ; preds = %127
  %133 = call i32 @getpid() #7
  %134 = getelementptr [4 x i8], [4 x i8]* @.str.21, i32 0, i32 0
  %135 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %130, i8* %134, i32 %133)
  %136 = call i32 @fclose(%struct._IO_FILE* %130)
  br label %148

; <label>:137:                                    ; preds = %127
  %138 = call i32* @__errno_location() #11
  %139 = load i32, i32* %138, align 4
  %140 = call i8* @strerror(i32 %139) #7
  %141 = getelementptr [34 x i8], [34 x i8]* @.str.22, i32 0, i32 0
  %142 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  call void (i8*, ...) @dprint_clone.14(i8* %141, i8* %142, i8* %140)
  %143 = call i32* @__errno_location() #11
  %144 = load i32, i32* %143, align 4
  %145 = call i8* @strerror(i32 %144) #7
  %146 = getelementptr [33 x i8], [33 x i8]* @.str.23, i32 0, i32 0
  %147 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  call void (i8*, ...) @logprint_clone(i8* %146, i8* %147, i8* %145)
  br label %148

; <label>:148:                                    ; preds = %137, %132, %119
  %149 = call void (i32)* @signal(i32 2, void (i32)* @cleanup) #7
  %150 = call void (i32)* @signal(i32 15, void (i32)* @cleanup) #7
  %151 = call void (i32)* @signal(i32 17, void (i32)* @child_exit) #7
  %152 = call void (i32)* @signal(i32 1, void (i32)* @read_cfg) #7
  %153 = getelementptr [20 x i8], [20 x i8]* @.str.24, i32 0, i32 0
  %154 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  call void (i8*, ...) @vprint_clone(i8* %153, i8* %154)
  %155 = getelementptr [29 x i8], [29 x i8]* @.str.25, i32 0, i32 0
  %156 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  call void (i8*, ...) @logprint_clone.18(i8* %155, i8* %156)
  br label %157

; <label>:157:                                    ; preds = %148
  %158 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %159 = call i32 @pcap_dispatch(%struct.pcap* %158, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %160 = icmp sge i32 %159, 0
  br i1 %160, label %487, label %161

; <label>:161:                                    ; preds = %559, %555, %551, %547, %543, %539, %535, %531, %527, %523, %519, %515, %511, %507, %503, %499, %495, %491, %487, %157
  %.0.lcssa = phi i32 [ %159, %157 ], [ %489, %487 ], [ %493, %491 ], [ %497, %495 ], [ %501, %499 ], [ %505, %503 ], [ %509, %507 ], [ %513, %511 ], [ %517, %515 ], [ %521, %519 ], [ %525, %523 ], [ %529, %527 ], [ %533, %531 ], [ %537, %535 ], [ %541, %539 ], [ %545, %543 ], [ %549, %547 ], [ %553, %551 ], [ %557, %555 ], [ %561, %559 ]
  %162 = getelementptr [35 x i8], [35 x i8]* @.str.26, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %162, i32 %.0.lcssa)
  %163 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %164 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %163, i8* %164)
  call void @cleanup(i32 0)
  call void @exit(i32 0) #9
  unreachable

.lr.ph.1:                                         ; preds = %42
  %165 = icmp slt i32 -1, 0
  br i1 true, label %.loopexit.loopexit, label %166

; <label>:166:                                    ; preds = %.lr.ph.1
  switch i32 -1, label %178 [
    i32 0, label %179
    i32 118, label %177
    i32 68, label %176
    i32 100, label %175
    i32 108, label %174
    i32 105, label %171
    i32 99, label %168
    i32 86, label %167
  ]

; <label>:167:                                    ; preds = %166
  call void @ver()
  br label %178

; <label>:168:                                    ; preds = %166
  %169 = load i8*, i8** @optarg, align 8
  %170 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %169, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %179

; <label>:171:                                    ; preds = %166
  %172 = load i8*, i8** @optarg, align 8
  %173 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %172, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %179

; <label>:174:                                    ; preds = %166
  store i32 1, i32* @o_lookup, align 4
  br label %179

; <label>:175:                                    ; preds = %166
  store i32 1, i32* @o_daemon, align 4
  br label %179

; <label>:176:                                    ; preds = %166
  store i32 1, i32* @o_debug, align 4
  br label %179

; <label>:177:                                    ; preds = %166
  store i32 1, i32* @o_verbose, align 4
  br label %179

; <label>:178:                                    ; preds = %167, %166
  call void @usage()
  br label %179

; <label>:179:                                    ; preds = %178, %177, %176, %175, %174, %171, %168, %166
  %180 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %181 = icmp ne i32 %180, 0
  br i1 %181, label %.lr.ph.2, label %.loopexit.loopexit

.lr.ph.2:                                         ; preds = %179
  %182 = icmp slt i32 %180, 0
  br i1 %182, label %.loopexit.loopexit, label %183

; <label>:183:                                    ; preds = %.lr.ph.2
  switch i32 %180, label %195 [
    i32 0, label %196
    i32 118, label %194
    i32 68, label %193
    i32 100, label %192
    i32 108, label %191
    i32 105, label %188
    i32 99, label %185
    i32 86, label %184
  ]

; <label>:184:                                    ; preds = %183
  call void @ver()
  br label %195

; <label>:185:                                    ; preds = %183
  %186 = load i8*, i8** @optarg, align 8
  %187 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %186, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %196

; <label>:188:                                    ; preds = %183
  %189 = load i8*, i8** @optarg, align 8
  %190 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %189, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %196

; <label>:191:                                    ; preds = %183
  store i32 1, i32* @o_lookup, align 4
  br label %196

; <label>:192:                                    ; preds = %183
  store i32 1, i32* @o_daemon, align 4
  br label %196

; <label>:193:                                    ; preds = %183
  store i32 1, i32* @o_debug, align 4
  br label %196

; <label>:194:                                    ; preds = %183
  store i32 1, i32* @o_verbose, align 4
  br label %196

; <label>:195:                                    ; preds = %184, %183
  call void @usage()
  br label %196

; <label>:196:                                    ; preds = %195, %194, %193, %192, %191, %188, %185, %183
  %197 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %198 = icmp ne i32 %197, 0
  br i1 %198, label %.lr.ph.3, label %.loopexit.loopexit

.lr.ph.3:                                         ; preds = %196
  %199 = icmp slt i32 %197, 0
  br i1 %199, label %.loopexit.loopexit, label %200

; <label>:200:                                    ; preds = %.lr.ph.3
  switch i32 %197, label %212 [
    i32 0, label %213
    i32 118, label %211
    i32 68, label %210
    i32 100, label %209
    i32 108, label %208
    i32 105, label %205
    i32 99, label %202
    i32 86, label %201
  ]

; <label>:201:                                    ; preds = %200
  call void @ver()
  br label %212

; <label>:202:                                    ; preds = %200
  %203 = load i8*, i8** @optarg, align 8
  %204 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %203, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %213

; <label>:205:                                    ; preds = %200
  %206 = load i8*, i8** @optarg, align 8
  %207 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %206, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %213

; <label>:208:                                    ; preds = %200
  store i32 1, i32* @o_lookup, align 4
  br label %213

; <label>:209:                                    ; preds = %200
  store i32 1, i32* @o_daemon, align 4
  br label %213

; <label>:210:                                    ; preds = %200
  store i32 1, i32* @o_debug, align 4
  br label %213

; <label>:211:                                    ; preds = %200
  store i32 1, i32* @o_verbose, align 4
  br label %213

; <label>:212:                                    ; preds = %201, %200
  call void @usage()
  br label %213

; <label>:213:                                    ; preds = %212, %211, %210, %209, %208, %205, %202, %200
  %214 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %215 = icmp ne i32 %214, 0
  br i1 %215, label %.lr.ph.4, label %.loopexit.loopexit

.lr.ph.4:                                         ; preds = %213
  %216 = icmp slt i32 %214, 0
  br i1 %216, label %.loopexit.loopexit, label %217

; <label>:217:                                    ; preds = %.lr.ph.4
  switch i32 %214, label %229 [
    i32 0, label %230
    i32 118, label %228
    i32 68, label %227
    i32 100, label %226
    i32 108, label %225
    i32 105, label %222
    i32 99, label %219
    i32 86, label %218
  ]

; <label>:218:                                    ; preds = %217
  call void @ver()
  br label %229

; <label>:219:                                    ; preds = %217
  %220 = load i8*, i8** @optarg, align 8
  %221 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %220, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %230

; <label>:222:                                    ; preds = %217
  %223 = load i8*, i8** @optarg, align 8
  %224 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %223, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %230

; <label>:225:                                    ; preds = %217
  store i32 1, i32* @o_lookup, align 4
  br label %230

; <label>:226:                                    ; preds = %217
  store i32 1, i32* @o_daemon, align 4
  br label %230

; <label>:227:                                    ; preds = %217
  store i32 1, i32* @o_debug, align 4
  br label %230

; <label>:228:                                    ; preds = %217
  store i32 1, i32* @o_verbose, align 4
  br label %230

; <label>:229:                                    ; preds = %218, %217
  call void @usage()
  br label %230

; <label>:230:                                    ; preds = %229, %228, %227, %226, %225, %222, %219, %217
  %231 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %232 = icmp ne i32 %231, 0
  br i1 %232, label %.lr.ph.5, label %.loopexit.loopexit

.lr.ph.5:                                         ; preds = %230
  %233 = icmp slt i32 %231, 0
  br i1 %233, label %.loopexit.loopexit, label %234

; <label>:234:                                    ; preds = %.lr.ph.5
  switch i32 %231, label %246 [
    i32 0, label %247
    i32 118, label %245
    i32 68, label %244
    i32 100, label %243
    i32 108, label %242
    i32 105, label %239
    i32 99, label %236
    i32 86, label %235
  ]

; <label>:235:                                    ; preds = %234
  call void @ver()
  br label %246

; <label>:236:                                    ; preds = %234
  %237 = load i8*, i8** @optarg, align 8
  %238 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %237, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %247

; <label>:239:                                    ; preds = %234
  %240 = load i8*, i8** @optarg, align 8
  %241 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %240, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %247

; <label>:242:                                    ; preds = %234
  store i32 1, i32* @o_lookup, align 4
  br label %247

; <label>:243:                                    ; preds = %234
  store i32 1, i32* @o_daemon, align 4
  br label %247

; <label>:244:                                    ; preds = %234
  store i32 1, i32* @o_debug, align 4
  br label %247

; <label>:245:                                    ; preds = %234
  store i32 1, i32* @o_verbose, align 4
  br label %247

; <label>:246:                                    ; preds = %235, %234
  call void @usage()
  br label %247

; <label>:247:                                    ; preds = %246, %245, %244, %243, %242, %239, %236, %234
  %248 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %249 = icmp ne i32 %248, 0
  br i1 %249, label %.lr.ph.6, label %.loopexit.loopexit

.lr.ph.6:                                         ; preds = %247
  %250 = icmp slt i32 %248, 0
  br i1 %250, label %.loopexit.loopexit, label %251

; <label>:251:                                    ; preds = %.lr.ph.6
  switch i32 %248, label %263 [
    i32 0, label %264
    i32 118, label %262
    i32 68, label %261
    i32 100, label %260
    i32 108, label %259
    i32 105, label %256
    i32 99, label %253
    i32 86, label %252
  ]

; <label>:252:                                    ; preds = %251
  call void @ver()
  br label %263

; <label>:253:                                    ; preds = %251
  %254 = load i8*, i8** @optarg, align 8
  %255 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %254, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %264

; <label>:256:                                    ; preds = %251
  %257 = load i8*, i8** @optarg, align 8
  %258 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %257, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %264

; <label>:259:                                    ; preds = %251
  store i32 1, i32* @o_lookup, align 4
  br label %264

; <label>:260:                                    ; preds = %251
  store i32 1, i32* @o_daemon, align 4
  br label %264

; <label>:261:                                    ; preds = %251
  store i32 1, i32* @o_debug, align 4
  br label %264

; <label>:262:                                    ; preds = %251
  store i32 1, i32* @o_verbose, align 4
  br label %264

; <label>:263:                                    ; preds = %252, %251
  call void @usage()
  br label %264

; <label>:264:                                    ; preds = %263, %262, %261, %260, %259, %256, %253, %251
  %265 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %266 = icmp ne i32 %265, 0
  br i1 %266, label %.lr.ph.7, label %.loopexit.loopexit

.lr.ph.7:                                         ; preds = %264
  %267 = icmp slt i32 %265, 0
  br i1 %267, label %.loopexit.loopexit, label %268

; <label>:268:                                    ; preds = %.lr.ph.7
  switch i32 %265, label %280 [
    i32 0, label %281
    i32 118, label %279
    i32 68, label %278
    i32 100, label %277
    i32 108, label %276
    i32 105, label %273
    i32 99, label %270
    i32 86, label %269
  ]

; <label>:269:                                    ; preds = %268
  call void @ver()
  br label %280

; <label>:270:                                    ; preds = %268
  %271 = load i8*, i8** @optarg, align 8
  %272 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %271, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %281

; <label>:273:                                    ; preds = %268
  %274 = load i8*, i8** @optarg, align 8
  %275 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %274, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %281

; <label>:276:                                    ; preds = %268
  store i32 1, i32* @o_lookup, align 4
  br label %281

; <label>:277:                                    ; preds = %268
  store i32 1, i32* @o_daemon, align 4
  br label %281

; <label>:278:                                    ; preds = %268
  store i32 1, i32* @o_debug, align 4
  br label %281

; <label>:279:                                    ; preds = %268
  store i32 1, i32* @o_verbose, align 4
  br label %281

; <label>:280:                                    ; preds = %269, %268
  call void @usage()
  br label %281

; <label>:281:                                    ; preds = %280, %279, %278, %277, %276, %273, %270, %268
  %282 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %283 = icmp ne i32 %282, 0
  br i1 %283, label %.lr.ph.8, label %.loopexit.loopexit

.lr.ph.8:                                         ; preds = %281
  %284 = icmp slt i32 %282, 0
  br i1 %284, label %.loopexit.loopexit, label %285

; <label>:285:                                    ; preds = %.lr.ph.8
  switch i32 %282, label %297 [
    i32 0, label %298
    i32 118, label %296
    i32 68, label %295
    i32 100, label %294
    i32 108, label %293
    i32 105, label %290
    i32 99, label %287
    i32 86, label %286
  ]

; <label>:286:                                    ; preds = %285
  call void @ver()
  br label %297

; <label>:287:                                    ; preds = %285
  %288 = load i8*, i8** @optarg, align 8
  %289 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %288, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %298

; <label>:290:                                    ; preds = %285
  %291 = load i8*, i8** @optarg, align 8
  %292 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %291, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %298

; <label>:293:                                    ; preds = %285
  store i32 1, i32* @o_lookup, align 4
  br label %298

; <label>:294:                                    ; preds = %285
  store i32 1, i32* @o_daemon, align 4
  br label %298

; <label>:295:                                    ; preds = %285
  store i32 1, i32* @o_debug, align 4
  br label %298

; <label>:296:                                    ; preds = %285
  store i32 1, i32* @o_verbose, align 4
  br label %298

; <label>:297:                                    ; preds = %286, %285
  call void @usage()
  br label %298

; <label>:298:                                    ; preds = %297, %296, %295, %294, %293, %290, %287, %285
  %299 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %300 = icmp ne i32 %299, 0
  br i1 %300, label %.lr.ph.9, label %.loopexit.loopexit

.lr.ph.9:                                         ; preds = %298
  %301 = icmp slt i32 %299, 0
  br i1 %301, label %.loopexit.loopexit, label %302

; <label>:302:                                    ; preds = %.lr.ph.9
  switch i32 %299, label %314 [
    i32 0, label %315
    i32 118, label %313
    i32 68, label %312
    i32 100, label %311
    i32 108, label %310
    i32 105, label %307
    i32 99, label %304
    i32 86, label %303
  ]

; <label>:303:                                    ; preds = %302
  call void @ver()
  br label %314

; <label>:304:                                    ; preds = %302
  %305 = load i8*, i8** @optarg, align 8
  %306 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %305, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %315

; <label>:307:                                    ; preds = %302
  %308 = load i8*, i8** @optarg, align 8
  %309 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %308, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %315

; <label>:310:                                    ; preds = %302
  store i32 1, i32* @o_lookup, align 4
  br label %315

; <label>:311:                                    ; preds = %302
  store i32 1, i32* @o_daemon, align 4
  br label %315

; <label>:312:                                    ; preds = %302
  store i32 1, i32* @o_debug, align 4
  br label %315

; <label>:313:                                    ; preds = %302
  store i32 1, i32* @o_verbose, align 4
  br label %315

; <label>:314:                                    ; preds = %303, %302
  call void @usage()
  br label %315

; <label>:315:                                    ; preds = %314, %313, %312, %311, %310, %307, %304, %302
  %316 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %317 = icmp ne i32 %316, 0
  br i1 %317, label %.lr.ph.10, label %.loopexit.loopexit

.lr.ph.10:                                        ; preds = %315
  %318 = icmp slt i32 %316, 0
  br i1 %318, label %.loopexit.loopexit, label %319

; <label>:319:                                    ; preds = %.lr.ph.10
  switch i32 %316, label %331 [
    i32 0, label %332
    i32 118, label %330
    i32 68, label %329
    i32 100, label %328
    i32 108, label %327
    i32 105, label %324
    i32 99, label %321
    i32 86, label %320
  ]

; <label>:320:                                    ; preds = %319
  call void @ver()
  br label %331

; <label>:321:                                    ; preds = %319
  %322 = load i8*, i8** @optarg, align 8
  %323 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %322, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %332

; <label>:324:                                    ; preds = %319
  %325 = load i8*, i8** @optarg, align 8
  %326 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %325, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %332

; <label>:327:                                    ; preds = %319
  store i32 1, i32* @o_lookup, align 4
  br label %332

; <label>:328:                                    ; preds = %319
  store i32 1, i32* @o_daemon, align 4
  br label %332

; <label>:329:                                    ; preds = %319
  store i32 1, i32* @o_debug, align 4
  br label %332

; <label>:330:                                    ; preds = %319
  store i32 1, i32* @o_verbose, align 4
  br label %332

; <label>:331:                                    ; preds = %320, %319
  call void @usage()
  br label %332

; <label>:332:                                    ; preds = %331, %330, %329, %328, %327, %324, %321, %319
  %333 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %334 = icmp ne i32 %333, 0
  br i1 %334, label %.lr.ph.11, label %.loopexit.loopexit

.lr.ph.11:                                        ; preds = %332
  %335 = icmp slt i32 %333, 0
  br i1 %335, label %.loopexit.loopexit, label %336

; <label>:336:                                    ; preds = %.lr.ph.11
  switch i32 %333, label %348 [
    i32 0, label %349
    i32 118, label %347
    i32 68, label %346
    i32 100, label %345
    i32 108, label %344
    i32 105, label %341
    i32 99, label %338
    i32 86, label %337
  ]

; <label>:337:                                    ; preds = %336
  call void @ver()
  br label %348

; <label>:338:                                    ; preds = %336
  %339 = load i8*, i8** @optarg, align 8
  %340 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %339, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %349

; <label>:341:                                    ; preds = %336
  %342 = load i8*, i8** @optarg, align 8
  %343 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %342, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %349

; <label>:344:                                    ; preds = %336
  store i32 1, i32* @o_lookup, align 4
  br label %349

; <label>:345:                                    ; preds = %336
  store i32 1, i32* @o_daemon, align 4
  br label %349

; <label>:346:                                    ; preds = %336
  store i32 1, i32* @o_debug, align 4
  br label %349

; <label>:347:                                    ; preds = %336
  store i32 1, i32* @o_verbose, align 4
  br label %349

; <label>:348:                                    ; preds = %337, %336
  call void @usage()
  br label %349

; <label>:349:                                    ; preds = %348, %347, %346, %345, %344, %341, %338, %336
  %350 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %351 = icmp ne i32 %350, 0
  br i1 %351, label %.lr.ph.12, label %.loopexit.loopexit

.lr.ph.12:                                        ; preds = %349
  %352 = icmp slt i32 %350, 0
  br i1 %352, label %.loopexit.loopexit, label %353

; <label>:353:                                    ; preds = %.lr.ph.12
  switch i32 %350, label %365 [
    i32 0, label %366
    i32 118, label %364
    i32 68, label %363
    i32 100, label %362
    i32 108, label %361
    i32 105, label %358
    i32 99, label %355
    i32 86, label %354
  ]

; <label>:354:                                    ; preds = %353
  call void @ver()
  br label %365

; <label>:355:                                    ; preds = %353
  %356 = load i8*, i8** @optarg, align 8
  %357 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %356, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %366

; <label>:358:                                    ; preds = %353
  %359 = load i8*, i8** @optarg, align 8
  %360 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %359, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %366

; <label>:361:                                    ; preds = %353
  store i32 1, i32* @o_lookup, align 4
  br label %366

; <label>:362:                                    ; preds = %353
  store i32 1, i32* @o_daemon, align 4
  br label %366

; <label>:363:                                    ; preds = %353
  store i32 1, i32* @o_debug, align 4
  br label %366

; <label>:364:                                    ; preds = %353
  store i32 1, i32* @o_verbose, align 4
  br label %366

; <label>:365:                                    ; preds = %354, %353
  call void @usage()
  br label %366

; <label>:366:                                    ; preds = %365, %364, %363, %362, %361, %358, %355, %353
  %367 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %368 = icmp ne i32 %367, 0
  br i1 %368, label %.lr.ph.13, label %.loopexit.loopexit

.lr.ph.13:                                        ; preds = %366
  %369 = icmp slt i32 %367, 0
  br i1 %369, label %.loopexit.loopexit, label %370

; <label>:370:                                    ; preds = %.lr.ph.13
  switch i32 %367, label %382 [
    i32 0, label %383
    i32 118, label %381
    i32 68, label %380
    i32 100, label %379
    i32 108, label %378
    i32 105, label %375
    i32 99, label %372
    i32 86, label %371
  ]

; <label>:371:                                    ; preds = %370
  call void @ver()
  br label %382

; <label>:372:                                    ; preds = %370
  %373 = load i8*, i8** @optarg, align 8
  %374 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %373, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %383

; <label>:375:                                    ; preds = %370
  %376 = load i8*, i8** @optarg, align 8
  %377 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %376, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %383

; <label>:378:                                    ; preds = %370
  store i32 1, i32* @o_lookup, align 4
  br label %383

; <label>:379:                                    ; preds = %370
  store i32 1, i32* @o_daemon, align 4
  br label %383

; <label>:380:                                    ; preds = %370
  store i32 1, i32* @o_debug, align 4
  br label %383

; <label>:381:                                    ; preds = %370
  store i32 1, i32* @o_verbose, align 4
  br label %383

; <label>:382:                                    ; preds = %371, %370
  call void @usage()
  br label %383

; <label>:383:                                    ; preds = %382, %381, %380, %379, %378, %375, %372, %370
  %384 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %385 = icmp ne i32 %384, 0
  br i1 %385, label %.lr.ph.14, label %.loopexit.loopexit

.lr.ph.14:                                        ; preds = %383
  %386 = icmp slt i32 %384, 0
  br i1 %386, label %.loopexit.loopexit, label %387

; <label>:387:                                    ; preds = %.lr.ph.14
  switch i32 %384, label %399 [
    i32 0, label %400
    i32 118, label %398
    i32 68, label %397
    i32 100, label %396
    i32 108, label %395
    i32 105, label %392
    i32 99, label %389
    i32 86, label %388
  ]

; <label>:388:                                    ; preds = %387
  call void @ver()
  br label %399

; <label>:389:                                    ; preds = %387
  %390 = load i8*, i8** @optarg, align 8
  %391 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %390, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %400

; <label>:392:                                    ; preds = %387
  %393 = load i8*, i8** @optarg, align 8
  %394 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %393, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %400

; <label>:395:                                    ; preds = %387
  store i32 1, i32* @o_lookup, align 4
  br label %400

; <label>:396:                                    ; preds = %387
  store i32 1, i32* @o_daemon, align 4
  br label %400

; <label>:397:                                    ; preds = %387
  store i32 1, i32* @o_debug, align 4
  br label %400

; <label>:398:                                    ; preds = %387
  store i32 1, i32* @o_verbose, align 4
  br label %400

; <label>:399:                                    ; preds = %388, %387
  call void @usage()
  br label %400

; <label>:400:                                    ; preds = %399, %398, %397, %396, %395, %392, %389, %387
  %401 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %402 = icmp ne i32 %401, 0
  br i1 %402, label %.lr.ph.15, label %.loopexit.loopexit

.lr.ph.15:                                        ; preds = %400
  %403 = icmp slt i32 %401, 0
  br i1 %403, label %.loopexit.loopexit, label %404

; <label>:404:                                    ; preds = %.lr.ph.15
  switch i32 %401, label %416 [
    i32 0, label %417
    i32 118, label %415
    i32 68, label %414
    i32 100, label %413
    i32 108, label %412
    i32 105, label %409
    i32 99, label %406
    i32 86, label %405
  ]

; <label>:405:                                    ; preds = %404
  call void @ver()
  br label %416

; <label>:406:                                    ; preds = %404
  %407 = load i8*, i8** @optarg, align 8
  %408 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %407, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %417

; <label>:409:                                    ; preds = %404
  %410 = load i8*, i8** @optarg, align 8
  %411 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %410, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %417

; <label>:412:                                    ; preds = %404
  store i32 1, i32* @o_lookup, align 4
  br label %417

; <label>:413:                                    ; preds = %404
  store i32 1, i32* @o_daemon, align 4
  br label %417

; <label>:414:                                    ; preds = %404
  store i32 1, i32* @o_debug, align 4
  br label %417

; <label>:415:                                    ; preds = %404
  store i32 1, i32* @o_verbose, align 4
  br label %417

; <label>:416:                                    ; preds = %405, %404
  call void @usage()
  br label %417

; <label>:417:                                    ; preds = %416, %415, %414, %413, %412, %409, %406, %404
  %418 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %419 = icmp ne i32 %418, 0
  br i1 %419, label %.lr.ph.16, label %.loopexit.loopexit

.lr.ph.16:                                        ; preds = %417
  %420 = icmp slt i32 %418, 0
  br i1 %420, label %.loopexit.loopexit, label %421

; <label>:421:                                    ; preds = %.lr.ph.16
  switch i32 %418, label %433 [
    i32 0, label %434
    i32 118, label %432
    i32 68, label %431
    i32 100, label %430
    i32 108, label %429
    i32 105, label %426
    i32 99, label %423
    i32 86, label %422
  ]

; <label>:422:                                    ; preds = %421
  call void @ver()
  br label %433

; <label>:423:                                    ; preds = %421
  %424 = load i8*, i8** @optarg, align 8
  %425 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %424, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %434

; <label>:426:                                    ; preds = %421
  %427 = load i8*, i8** @optarg, align 8
  %428 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %427, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %434

; <label>:429:                                    ; preds = %421
  store i32 1, i32* @o_lookup, align 4
  br label %434

; <label>:430:                                    ; preds = %421
  store i32 1, i32* @o_daemon, align 4
  br label %434

; <label>:431:                                    ; preds = %421
  store i32 1, i32* @o_debug, align 4
  br label %434

; <label>:432:                                    ; preds = %421
  store i32 1, i32* @o_verbose, align 4
  br label %434

; <label>:433:                                    ; preds = %422, %421
  call void @usage()
  br label %434

; <label>:434:                                    ; preds = %433, %432, %431, %430, %429, %426, %423, %421
  %435 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %436 = icmp ne i32 %435, 0
  br i1 %436, label %.lr.ph.17, label %.loopexit.loopexit

.lr.ph.17:                                        ; preds = %434
  %437 = icmp slt i32 %435, 0
  br i1 %437, label %.loopexit.loopexit, label %438

; <label>:438:                                    ; preds = %.lr.ph.17
  switch i32 %435, label %450 [
    i32 0, label %451
    i32 118, label %449
    i32 68, label %448
    i32 100, label %447
    i32 108, label %446
    i32 105, label %443
    i32 99, label %440
    i32 86, label %439
  ]

; <label>:439:                                    ; preds = %438
  call void @ver()
  br label %450

; <label>:440:                                    ; preds = %438
  %441 = load i8*, i8** @optarg, align 8
  %442 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %441, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %451

; <label>:443:                                    ; preds = %438
  %444 = load i8*, i8** @optarg, align 8
  %445 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %444, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %451

; <label>:446:                                    ; preds = %438
  store i32 1, i32* @o_lookup, align 4
  br label %451

; <label>:447:                                    ; preds = %438
  store i32 1, i32* @o_daemon, align 4
  br label %451

; <label>:448:                                    ; preds = %438
  store i32 1, i32* @o_debug, align 4
  br label %451

; <label>:449:                                    ; preds = %438
  store i32 1, i32* @o_verbose, align 4
  br label %451

; <label>:450:                                    ; preds = %439, %438
  call void @usage()
  br label %451

; <label>:451:                                    ; preds = %450, %449, %448, %447, %446, %443, %440, %438
  %452 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %453 = icmp ne i32 %452, 0
  br i1 %453, label %.lr.ph.18, label %.loopexit.loopexit

.lr.ph.18:                                        ; preds = %451
  %454 = icmp slt i32 %452, 0
  br i1 %454, label %.loopexit.loopexit, label %455

; <label>:455:                                    ; preds = %.lr.ph.18
  switch i32 %452, label %467 [
    i32 0, label %468
    i32 118, label %466
    i32 68, label %465
    i32 100, label %464
    i32 108, label %463
    i32 105, label %460
    i32 99, label %457
    i32 86, label %456
  ]

; <label>:456:                                    ; preds = %455
  call void @ver()
  br label %467

; <label>:457:                                    ; preds = %455
  %458 = load i8*, i8** @optarg, align 8
  %459 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %458, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %468

; <label>:460:                                    ; preds = %455
  %461 = load i8*, i8** @optarg, align 8
  %462 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %461, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %468

; <label>:463:                                    ; preds = %455
  store i32 1, i32* @o_lookup, align 4
  br label %468

; <label>:464:                                    ; preds = %455
  store i32 1, i32* @o_daemon, align 4
  br label %468

; <label>:465:                                    ; preds = %455
  store i32 1, i32* @o_debug, align 4
  br label %468

; <label>:466:                                    ; preds = %455
  store i32 1, i32* @o_verbose, align 4
  br label %468

; <label>:467:                                    ; preds = %456, %455
  call void @usage()
  br label %468

; <label>:468:                                    ; preds = %467, %466, %465, %464, %463, %460, %457, %455
  %469 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  %470 = icmp ne i32 %469, 0
  br i1 %470, label %.lr.ph.19, label %.loopexit.loopexit

.lr.ph.19:                                        ; preds = %468
  %471 = icmp slt i32 %469, 0
  br i1 %471, label %.loopexit.loopexit, label %472

; <label>:472:                                    ; preds = %.lr.ph.19
  switch i32 %469, label %484 [
    i32 0, label %485
    i32 118, label %483
    i32 68, label %482
    i32 100, label %481
    i32 108, label %480
    i32 105, label %477
    i32 99, label %474
    i32 86, label %473
  ]

; <label>:473:                                    ; preds = %472
  call void @ver()
  br label %484

; <label>:474:                                    ; preds = %472
  %475 = load i8*, i8** @optarg, align 8
  %476 = call i8* @strncpy(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 0), i8* %475, i64 99) #7, !track !15
  store i8 0, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99), align 1
  br label %485

; <label>:477:                                    ; preds = %472
  %478 = load i8*, i8** @optarg, align 8
  %479 = call i8* @strncpy(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 0), i8* %478, i64 31) #7, !track !14
  store i8 0, i8* getelementptr inbounds ([32 x i8], [32 x i8]* @o_int, i64 0, i64 31), align 1
  br label %485

; <label>:480:                                    ; preds = %472
  store i32 1, i32* @o_lookup, align 4
  br label %485

; <label>:481:                                    ; preds = %472
  store i32 1, i32* @o_daemon, align 4
  br label %485

; <label>:482:                                    ; preds = %472
  store i32 1, i32* @o_debug, align 4
  br label %485

; <label>:483:                                    ; preds = %472
  store i32 1, i32* @o_verbose, align 4
  br label %485

; <label>:484:                                    ; preds = %473, %472
  call void @usage()
  br label %485

; <label>:485:                                    ; preds = %484, %483, %482, %481, %480, %477, %474, %472
  %486 = call i32 @getopt_long(i32 3, i8** %20, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.8, i64 0, i64 0), %struct.option* getelementptr inbounds ([9 x %struct.option], [9 x %struct.option]* @main.opts, i64 0, i64 0), i32* %23) #7, !track_argc !13
  br label %.loopexit.loopexit

; <label>:487:                                    ; preds = %157
  %488 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %489 = call i32 @pcap_dispatch(%struct.pcap* %488, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %490 = icmp sge i32 %489, 0
  br i1 %490, label %491, label %161

; <label>:491:                                    ; preds = %487
  %492 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %493 = call i32 @pcap_dispatch(%struct.pcap* %492, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %494 = icmp sge i32 %493, 0
  br i1 %494, label %495, label %161

; <label>:495:                                    ; preds = %491
  %496 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %497 = call i32 @pcap_dispatch(%struct.pcap* %496, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %498 = icmp sge i32 %497, 0
  br i1 %498, label %499, label %161

; <label>:499:                                    ; preds = %495
  %500 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %501 = call i32 @pcap_dispatch(%struct.pcap* %500, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %502 = icmp sge i32 %501, 0
  br i1 %502, label %503, label %161

; <label>:503:                                    ; preds = %499
  %504 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %505 = call i32 @pcap_dispatch(%struct.pcap* %504, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %506 = icmp sge i32 %505, 0
  br i1 %506, label %507, label %161

; <label>:507:                                    ; preds = %503
  %508 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %509 = call i32 @pcap_dispatch(%struct.pcap* %508, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %510 = icmp sge i32 %509, 0
  br i1 %510, label %511, label %161

; <label>:511:                                    ; preds = %507
  %512 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %513 = call i32 @pcap_dispatch(%struct.pcap* %512, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %514 = icmp sge i32 %513, 0
  br i1 %514, label %515, label %161

; <label>:515:                                    ; preds = %511
  %516 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %517 = call i32 @pcap_dispatch(%struct.pcap* %516, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %518 = icmp sge i32 %517, 0
  br i1 %518, label %519, label %161

; <label>:519:                                    ; preds = %515
  %520 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %521 = call i32 @pcap_dispatch(%struct.pcap* %520, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %522 = icmp sge i32 %521, 0
  br i1 %522, label %523, label %161

; <label>:523:                                    ; preds = %519
  %524 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %525 = call i32 @pcap_dispatch(%struct.pcap* %524, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %526 = icmp sge i32 %525, 0
  br i1 %526, label %527, label %161

; <label>:527:                                    ; preds = %523
  %528 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %529 = call i32 @pcap_dispatch(%struct.pcap* %528, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %530 = icmp sge i32 %529, 0
  br i1 %530, label %531, label %161

; <label>:531:                                    ; preds = %527
  %532 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %533 = call i32 @pcap_dispatch(%struct.pcap* %532, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %534 = icmp sge i32 %533, 0
  br i1 %534, label %535, label %161

; <label>:535:                                    ; preds = %531
  %536 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %537 = call i32 @pcap_dispatch(%struct.pcap* %536, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %538 = icmp sge i32 %537, 0
  br i1 %538, label %539, label %161

; <label>:539:                                    ; preds = %535
  %540 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %541 = call i32 @pcap_dispatch(%struct.pcap* %540, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %542 = icmp sge i32 %541, 0
  br i1 %542, label %543, label %161

; <label>:543:                                    ; preds = %539
  %544 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %545 = call i32 @pcap_dispatch(%struct.pcap* %544, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %546 = icmp sge i32 %545, 0
  br i1 %546, label %547, label %161

; <label>:547:                                    ; preds = %543
  %548 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %549 = call i32 @pcap_dispatch(%struct.pcap* %548, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %550 = icmp sge i32 %549, 0
  br i1 %550, label %551, label %161

; <label>:551:                                    ; preds = %547
  %552 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %553 = call i32 @pcap_dispatch(%struct.pcap* %552, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %554 = icmp sge i32 %553, 0
  br i1 %554, label %555, label %161

; <label>:555:                                    ; preds = %551
  %556 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %557 = call i32 @pcap_dispatch(%struct.pcap* %556, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %558 = icmp sge i32 %557, 0
  br i1 %558, label %559, label %161

; <label>:559:                                    ; preds = %555
  %560 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %561 = call i32 @pcap_dispatch(%struct.pcap* %560, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  br label %161
}

declare void @__loop_termination_test___1()

declare void @__loop_iteration_test___1()

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
