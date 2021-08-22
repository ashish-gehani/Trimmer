; ModuleID = './work_dir/knockd_annotated.bc'
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

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main(i32, i8**) #0 {
  %3 = alloca [256 x i8], align 16, !track !11
  %4 = alloca i32, align 4
  %5 = bitcast [256 x i8]* %3 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 16 %5, i8 0, i64 256, i1 false)
  store i32 1, i32* %4, align 4
  %6 = getelementptr [11 x i8], [11 x i8]* @.str.8, i32 0, i32 0
  %7 = getelementptr [9 x %struct.option], [9 x %struct.option]* @main.opts, i32 0, i32 0
  %8 = call i32 @getopt_long(i32 %0, i8** %1, i8* %6, %struct.option* %7, i32* %4) #7, !track_argc !12
  %9 = icmp ne i32 %8, 0
  br i1 %9, label %.lr.ph, label %.loopexit

.lr.ph:                                           ; preds = %2
  br label %10

; <label>:10:                                     ; preds = %.lr.ph, %33
  %11 = phi i32 [ %8, %.lr.ph ], [ %36, %33 ]
  call void @unroll_loop(i32 1)
  %12 = icmp slt i32 %11, 0
  br i1 %12, label %13, label %14

; <label>:13:                                     ; preds = %10
  br label %38

; <label>:14:                                     ; preds = %10
  switch i32 %11, label %32 [
    i32 0, label %15
    i32 118, label %16
    i32 68, label %17
    i32 100, label %18
    i32 108, label %19
    i32 105, label %20
    i32 99, label %25
    i32 86, label %30
    i32 104, label %31
  ]

; <label>:15:                                     ; preds = %14
  br label %33

; <label>:16:                                     ; preds = %14
  store i32 1, i32* @o_verbose, align 4
  br label %33

; <label>:17:                                     ; preds = %14
  store i32 1, i32* @o_debug, align 4
  br label %33

; <label>:18:                                     ; preds = %14
  store i32 1, i32* @o_daemon, align 4
  br label %33

; <label>:19:                                     ; preds = %14
  store i32 1, i32* @o_lookup, align 4
  br label %33

; <label>:20:                                     ; preds = %14
  %21 = load i8*, i8** @optarg, align 8
  %22 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %23 = call i8* @strncpy(i8* %22, i8* %21, i64 31) #7, !track !13
  %24 = getelementptr [32 x i8], [32 x i8]* @o_int, i64 0, i64 31
  store i8 0, i8* %24, align 1
  br label %33

; <label>:25:                                     ; preds = %14
  %26 = load i8*, i8** @optarg, align 8
  %27 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i32 0, i32 0
  %28 = call i8* @strncpy(i8* %27, i8* %26, i64 99) #7, !track !14
  %29 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i64 0, i64 99
  store i8 0, i8* %29, align 1
  br label %33

; <label>:30:                                     ; preds = %14
  call void @ver()
  br label %31

; <label>:31:                                     ; preds = %14, %30
  br label %32

; <label>:32:                                     ; preds = %14, %31
  call void @usage()
  br label %33

; <label>:33:                                     ; preds = %32, %25, %20, %19, %18, %17, %16, %15
  %34 = getelementptr [11 x i8], [11 x i8]* @.str.8, i32 0, i32 0
  %35 = getelementptr [9 x %struct.option], [9 x %struct.option]* @main.opts, i32 0, i32 0
  %36 = call i32 @getopt_long(i32 %0, i8** %1, i8* %34, %struct.option* %35, i32* %4) #7, !track_argc !12
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %10, label %..loopexit_crit_edge

..loopexit_crit_edge:                             ; preds = %33
  br label %.loopexit

.loopexit:                                        ; preds = %..loopexit_crit_edge, %2
  br label %38

; <label>:38:                                     ; preds = %.loopexit, %13
  %39 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i32 0, i32 0
  %40 = call i32 @parseconfig(i8* %39)
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %42, label %43

; <label>:42:                                     ; preds = %38
  call void @exit(i32 1) #9
  br label %UnifiedUnreachableBlock

; <label>:43:                                     ; preds = %38
  %44 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %45 = call i64 @strlen(i8* %44) #10
  %46 = icmp eq i64 %45, 0
  br i1 %46, label %47, label %51

; <label>:47:                                     ; preds = %43
  %48 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %49 = getelementptr [5 x i8], [5 x i8]* @.str.9, i32 0, i32 0
  %50 = call i8* @strncpy(i8* %48, i8* %49, i64 32) #7, !track !15
  br label %51

; <label>:51:                                     ; preds = %47, %43
  %52 = load i32, i32* @o_usesyslog, align 4
  %53 = icmp ne i32 %52, 0
  br i1 %53, label %54, label %56

; <label>:54:                                     ; preds = %51
  %55 = getelementptr [7 x i8], [7 x i8]* @.str.10, i32 0, i32 0
  call void @openlog(i8* %55, i32 0, i32 8)
  br label %56

; <label>:56:                                     ; preds = %54, %51
  %57 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  %58 = call i64 @strlen(i8* %57) #10
  %59 = icmp ne i64 %58, 0
  br i1 %59, label %60, label %69

; <label>:60:                                     ; preds = %56
  %61 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  %62 = getelementptr [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %63 = call %struct._IO_FILE* @fopen(i8* %61, i8* %62), !track !16
  store %struct._IO_FILE* %63, %struct._IO_FILE** @logfd, align 8
  %64 = load %struct._IO_FILE*, %struct._IO_FILE** @logfd, align 8
  %65 = icmp eq %struct._IO_FILE* %64, null
  br i1 %65, label %66, label %68

; <label>:66:                                     ; preds = %60
  %67 = getelementptr [29 x i8], [29 x i8]* @.str.12, i32 0, i32 0
  call void @perror(i8* %67)
  br label %68

; <label>:68:                                     ; preds = %66, %60
  br label %69

; <label>:69:                                     ; preds = %68, %56
  %70 = getelementptr inbounds [256 x i8], [256 x i8]* %3, i32 0, i32 0
  %71 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %72 = call %struct.pcap* @pcap_open_live(i8* %71, i32 65535, i32 0, i32 0, i8* %70)
  store %struct.pcap* %72, %struct.pcap** @cap, align 8
  %73 = getelementptr inbounds [256 x i8], [256 x i8]* %3, i32 0, i32 0
  %74 = call i64 @strlen(i8* %73) #10
  %75 = icmp ne i64 %74, 0
  br i1 %75, label %76, label %82

; <label>:76:                                     ; preds = %69
  %77 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %78 = getelementptr inbounds [256 x i8], [256 x i8]* %3, i32 0, i32 0
  %79 = getelementptr [23 x i8], [23 x i8]* @.str.13, i32 0, i32 0
  %80 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %81 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %77, i8* %79, i8* %80, i8* %78)
  br label %82

; <label>:82:                                     ; preds = %76, %69
  %83 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %84 = icmp eq %struct.pcap* %83, null
  br i1 %84, label %85, label %86

; <label>:85:                                     ; preds = %82
  call void @exit(i32 1) #9
  br label %UnifiedUnreachableBlock

; <label>:86:                                     ; preds = %82
  %87 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %88 = call i32 @pcap_datalink(%struct.pcap* %87)
  store i32 %88, i32* @lltype, align 4
  %89 = load i32, i32* @lltype, align 4
  switch i32 %89, label %96 [
    i32 1, label %90
    i32 113, label %92
    i32 12, label %94
  ]

; <label>:90:                                     ; preds = %86
  %91 = getelementptr [29 x i8], [29 x i8]* @.str.14, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %91)
  br label %101

; <label>:92:                                     ; preds = %86
  %93 = getelementptr [55 x i8], [55 x i8]* @.str.15, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %93)
  br label %101

; <label>:94:                                     ; preds = %86
  %95 = getelementptr [42 x i8], [42 x i8]* @.str.16, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %95)
  br label %101

; <label>:96:                                     ; preds = %86
  %97 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %98 = load i32, i32* @lltype, align 4
  %99 = getelementptr [40 x i8], [40 x i8]* @.str.17, i32 0, i32 0
  %100 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %97, i8* %99, i32 %98)
  call void @cleanup(i32 1)
  br label %101

; <label>:101:                                    ; preds = %96, %94, %92, %90
  %102 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %103 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %104 = call i8* @get_ip(i8* %102, i8* %103, i32 32)
  %105 = icmp eq i8* %104, null
  br i1 %105, label %106, label %111

; <label>:106:                                    ; preds = %101
  %107 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %108 = getelementptr [33 x i8], [33 x i8]* @.str.18, i32 0, i32 0
  %109 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %110 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %107, i8* %108, i8* %109)
  call void @cleanup(i32 1)
  br label %114

; <label>:111:                                    ; preds = %101
  %112 = getelementptr [14 x i8], [14 x i8]* @.str.19, i32 0, i32 0
  %113 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %112, i8* %113)
  br label %114

; <label>:114:                                    ; preds = %111, %106
  call void @generate_pcap_filter()
  %115 = load i32, i32* @o_daemon, align 4
  %116 = icmp ne i32 %115, 0
  br i1 %116, label %117, label %144

; <label>:117:                                    ; preds = %114
  %118 = call i32 @daemon(i32 0, i32 0) #7
  %119 = icmp slt i32 %118, 0
  br i1 %119, label %120, label %122

; <label>:120:                                    ; preds = %117
  %121 = getelementptr [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  call void @perror(i8* %121)
  call void @cleanup(i32 1)
  br label %122

; <label>:122:                                    ; preds = %120, %117
  %123 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  %124 = getelementptr [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %125 = call %struct._IO_FILE* @fopen(i8* %123, i8* %124), !track !17
  %126 = icmp ne %struct._IO_FILE* %125, null
  br i1 %126, label %127, label %132

; <label>:127:                                    ; preds = %122
  %128 = call i32 @getpid() #7
  %129 = getelementptr [4 x i8], [4 x i8]* @.str.21, i32 0, i32 0
  %130 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %125, i8* %129, i32 %128)
  %131 = call i32 @fclose(%struct._IO_FILE* %125)
  br label %143

; <label>:132:                                    ; preds = %122
  %133 = call i32* @__errno_location() #11
  %134 = load i32, i32* %133, align 4
  %135 = call i8* @strerror(i32 %134) #7
  %136 = getelementptr [34 x i8], [34 x i8]* @.str.22, i32 0, i32 0
  %137 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %136, i8* %137, i8* %135)
  %138 = call i32* @__errno_location() #11
  %139 = load i32, i32* %138, align 4
  %140 = call i8* @strerror(i32 %139) #7
  %141 = getelementptr [33 x i8], [33 x i8]* @.str.23, i32 0, i32 0
  %142 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %141, i8* %142, i8* %140)
  br label %143

; <label>:143:                                    ; preds = %132, %127
  br label %144

; <label>:144:                                    ; preds = %143, %114
  %145 = call void (i32)* @signal(i32 2, void (i32)* @cleanup) #7
  %146 = call void (i32)* @signal(i32 15, void (i32)* @cleanup) #7
  %147 = call void (i32)* @signal(i32 17, void (i32)* @child_exit) #7
  %148 = call void (i32)* @signal(i32 1, void (i32)* @read_cfg) #7
  %149 = getelementptr [20 x i8], [20 x i8]* @.str.24, i32 0, i32 0
  %150 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %149, i8* %150)
  %151 = getelementptr [29 x i8], [29 x i8]* @.str.25, i32 0, i32 0
  %152 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %151, i8* %152)
  br label %153

; <label>:153:                                    ; preds = %144, %153
  call void @unroll_loop(i32 0)
  %154 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %155 = call i32 @pcap_dispatch(%struct.pcap* %154, i32 -1, void (i8*, %struct.pcap_pkthdr*, i8*)* @sniff, i8* null)
  %156 = icmp sge i32 %155, 0
  br i1 %156, label %153, label %157

; <label>:157:                                    ; preds = %153
  %.0.lcssa = phi i32 [ %155, %153 ]
  %158 = getelementptr [35 x i8], [35 x i8]* @.str.26, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %158, i32 %.0.lcssa)
  %159 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %160 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %159, i8* %160)
  call void @cleanup(i32 0)
  call void @exit(i32 0) #9
  br label %UnifiedUnreachableBlock
                                                  ; No predecessors!
  ret i32 0

UnifiedUnreachableBlock:                          ; preds = %157, %85, %42
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
                                                  ; No predecessors!
  ret void
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
                                                  ; No predecessors!
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @parseconfig(i8*) #0 {
  %2 = alloca [101 x i8], align 16, !track !18
  %3 = alloca i8*, align 8, !track !19
  %4 = alloca [256 x i8], align 16, !track !20
  store i8* null, i8** %3, align 8
  %5 = bitcast [256 x i8]* %4 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 16 %5, i8 0, i64 256, i1 false)
  %6 = getelementptr [2 x i8], [2 x i8]* @.str.52, i32 0, i32 0
  %7 = call %struct._IO_FILE* @fopen(i8* %0, i8* %6), !track !21
  %8 = icmp eq %struct._IO_FILE* %7, null
  br i1 %8, label %9, label %10

; <label>:9:                                      ; preds = %1
  call void @perror(i8* %0)
  br label %454

; <label>:10:                                     ; preds = %1
  %11 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %12 = call i8* @fgets(i8* %11, i32 100, %struct._IO_FILE* %7), !track !22
  %13 = icmp ne i8* %12, null
  br i1 %13, label %.lr.ph43.lr.ph, label %.outer._crit_edge

.lr.ph43.lr.ph:                                   ; preds = %10
  br label %.lr.ph43

.lr.ph43:                                         ; preds = %.lr.ph43.lr.ph, %.outer
  %.02.ph49 = phi i32 [ 0, %.lr.ph43.lr.ph ], [ %.lcssa40, %.outer ]
  %.03.ph48 = phi %struct.opendoor* [ null, %.lr.ph43.lr.ph ], [ %.2, %.outer ]
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
  %27 = call i8* @fgets(i8* %11, i32 100, %struct._IO_FILE* %7), !track !23
  %28 = icmp ne i8* %27, null
  br i1 %28, label %14, label %._crit_edge44

; <label>:29:                                     ; preds = %21
  %.lcssa40 = phi i32 [ %15, %21 ]
  %30 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  %31 = load i8, i8* %30, align 16
  %32 = sext i8 %31 to i32
  %33 = icmp eq i32 %32, 91
  br i1 %33, label %34, label %91

; <label>:34:                                     ; preds = %29
  %35 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %36 = call i64 @strlen(i8* %35) #10
  %37 = sub i64 %36, 1
  %38 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 %37
  %39 = load i8, i8* %38, align 1
  %40 = sext i8 %39 to i32
  %41 = icmp eq i32 %40, 93
  br i1 %41, label %42, label %91

; <label>:42:                                     ; preds = %34
  %43 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  store i8* %43, i8** %3, align 8
  %44 = load i8*, i8** %3, align 8
  %45 = getelementptr inbounds i8, i8* %44, i32 1
  store i8* %45, i8** %3, align 8
  %46 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %47 = load i8*, i8** %3, align 8
  %48 = call i8* @strncpy(i8* %46, i8* %47, i64 256) #7, !track !24
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
  br label %454

; <label>:62:                                     ; preds = %42
  %63 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %64 = getelementptr [8 x i8], [8 x i8]* @.str.55, i32 0, i32 0
  %65 = call i32 @strcmp(i8* %63, i8* %64) #10
  %66 = icmp ne i32 %65, 0
  br i1 %66, label %67, label %90

; <label>:67:                                     ; preds = %62
  %68 = call noalias i8* @malloc(i64 336) #7, !track !25
  %69 = bitcast i8* %68 to %struct.opendoor*
  %70 = icmp eq %struct.opendoor* %69, null
  br i1 %70, label %71, label %73

; <label>:71:                                     ; preds = %67
  %72 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %72)
  call void @exit(i32 1) #9
  br label %UnifiedUnreachableBlock

; <label>:73:                                     ; preds = %67
  %74 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %69, i32 0, i32 0
  %75 = getelementptr inbounds [128 x i8], [128 x i8]* %74, i32 0, i32 0
  %76 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %77 = call i8* @strncpy(i8* %75, i8* %76, i64 127) #7, !track !26
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
  br label %90

; <label>:90:                                     ; preds = %73, %62
  %.1 = phi %struct.opendoor* [ %69, %73 ], [ %.03.ph48, %62 ]
  br label %.outer

; <label>:91:                                     ; preds = %34, %29
  %92 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %93 = call i64 @strlen(i8* %92) #10
  %94 = icmp ne i64 %93, 0
  br i1 %94, label %99, label %95

; <label>:95:                                     ; preds = %91
  %.lcssa17 = phi i32 [ %.lcssa40, %91 ]
  %96 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %97 = getelementptr [58 x i8], [58 x i8]* @.str.57, i32 0, i32 0
  %98 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %96, i8* %97, i32 %.lcssa17)
  br label %454

; <label>:99:                                     ; preds = %91
  %100 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  store i8* %100, i8** %3, align 8
  %101 = getelementptr [2 x i8], [2 x i8]* @.str.58, i32 0, i32 0
  %102 = call i8* @strsep(i8** %3, i8* %101) #7
  %103 = icmp eq i8* %102, null
  br i1 %103, label %104, label %108

; <label>:104:                                    ; preds = %99
  %.lcssa18 = phi i32 [ %.lcssa40, %99 ]
  %105 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %106 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %107 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %105, i8* %106, i32 %.lcssa18)
  br label %454

; <label>:108:                                    ; preds = %99
  %109 = call i8* @trim(i8* %102)
  %110 = call i8* @strtoupper(i8* %102)
  %111 = load i8*, i8** %3, align 8
  %112 = icmp eq i8* %111, null
  br i1 %112, label %113, label %124

; <label>:113:                                    ; preds = %108
  %114 = getelementptr [10 x i8], [10 x i8]* @.str.60, i32 0, i32 0
  %115 = call i32 @strcmp(i8* %110, i8* %114) #10
  %116 = icmp ne i32 %115, 0
  br i1 %116, label %119, label %117

; <label>:117:                                    ; preds = %113
  store i32 1, i32* @o_usesyslog, align 4
  %118 = getelementptr [19 x i8], [19 x i8]* @.str.61, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %118)
  br label %123

; <label>:119:                                    ; preds = %113
  %.lcssa28 = phi i32 [ %.lcssa40, %113 ]
  %120 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %121 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %122 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %120, i8* %121, i32 %.lcssa28)
  br label %454

; <label>:123:                                    ; preds = %117
  br label %427

; <label>:124:                                    ; preds = %108
  %125 = load i8*, i8** %3, align 8
  %126 = call i8* @trim(i8* %125)
  %127 = getelementptr inbounds [256 x i8], [256 x i8]* %4, i32 0, i32 0
  %128 = getelementptr [8 x i8], [8 x i8]* @.str.55, i32 0, i32 0
  %129 = call i32 @strcmp(i8* %127, i8* %128) #10
  %130 = icmp ne i32 %129, 0
  br i1 %130, label %176, label %131

; <label>:131:                                    ; preds = %124
  %132 = getelementptr [8 x i8], [8 x i8]* @.str.62, i32 0, i32 0
  %133 = call i32 @strcmp(i8* %110, i8* %132) #10
  %134 = icmp ne i32 %133, 0
  br i1 %134, label %142, label %135

; <label>:135:                                    ; preds = %131
  %136 = load i8*, i8** %3, align 8
  %137 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  %138 = call i8* @strncpy(i8* %137, i8* %136, i64 99) #7, !track !27
  %139 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i64 0, i64 99
  store i8 0, i8* %139, align 1
  %140 = getelementptr [22 x i8], [22 x i8]* @.str.63, i32 0, i32 0
  %141 = getelementptr [100 x i8], [100 x i8]* @o_logfile, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %140, i8* %141)
  br label %175

; <label>:142:                                    ; preds = %131
  %143 = getelementptr [8 x i8], [8 x i8]* @.str.64, i32 0, i32 0
  %144 = call i32 @strcmp(i8* %110, i8* %143) #10
  %145 = icmp ne i32 %144, 0
  br i1 %145, label %153, label %146

; <label>:146:                                    ; preds = %142
  %147 = load i8*, i8** %3, align 8
  %148 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  %149 = call i8* @strncpy(i8* %148, i8* %147, i64 99) #7, !track !28
  %150 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i64 0, i64 99
  store i8 0, i8* %150, align 1
  %151 = getelementptr [22 x i8], [22 x i8]* @.str.65, i32 0, i32 0
  %152 = getelementptr [100 x i8], [100 x i8]* @o_pidfile, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %151, i8* %152)
  br label %174

; <label>:153:                                    ; preds = %142
  %154 = getelementptr [10 x i8], [10 x i8]* @.str.66, i32 0, i32 0
  %155 = call i32 @strcmp(i8* %110, i8* %154) #10
  %156 = icmp ne i32 %155, 0
  br i1 %156, label %169, label %157

; <label>:157:                                    ; preds = %153
  %158 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %159 = call i64 @strlen(i8* %158) #10
  %160 = icmp eq i64 %159, 0
  br i1 %160, label %161, label %168

; <label>:161:                                    ; preds = %157
  %162 = load i8*, i8** %3, align 8
  %163 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  %164 = call i8* @strncpy(i8* %163, i8* %162, i64 31) #7, !track !29
  %165 = getelementptr [32 x i8], [32 x i8]* @o_int, i64 0, i64 31
  store i8 0, i8* %165, align 1
  %166 = getelementptr [23 x i8], [23 x i8]* @.str.67, i32 0, i32 0
  %167 = getelementptr [32 x i8], [32 x i8]* @o_int, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %166, i8* %167)
  br label %168

; <label>:168:                                    ; preds = %161, %157
  br label %173

; <label>:169:                                    ; preds = %153
  %.lcssa19 = phi i32 [ %.lcssa40, %153 ]
  %170 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %171 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %172 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %170, i8* %171, i32 %.lcssa19)
  br label %454

; <label>:173:                                    ; preds = %168
  br label %174

; <label>:174:                                    ; preds = %173, %146
  br label %175

; <label>:175:                                    ; preds = %174, %135
  br label %425

; <label>:176:                                    ; preds = %124
  %177 = icmp eq %struct.opendoor* %.03.ph48, null
  br i1 %177, label %178, label %182

; <label>:178:                                    ; preds = %176
  %.lcssa20 = phi i32 [ %.lcssa40, %176 ]
  %.lcssa8 = phi i8* [ %110, %176 ]
  %179 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %180 = getelementptr [62 x i8], [62 x i8]* @.str.68, i32 0, i32 0
  %181 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %179, i8* %180, i32 %.lcssa20, i8* %.lcssa8)
  br label %454

; <label>:182:                                    ; preds = %176
  %183 = getelementptr [9 x i8], [9 x i8]* @.str.69, i32 0, i32 0
  %184 = call i32 @strcmp(i8* %110, i8* %183) #10
  %185 = icmp ne i32 %184, 0
  br i1 %185, label %195, label %186

; <label>:186:                                    ; preds = %182
  %187 = load i8*, i8** %3, align 8
  %188 = call i32 @parse_port_sequence(i8* %187, %struct.opendoor* %.03.ph48)
  %189 = icmp sgt i32 %188, 0
  br i1 %189, label %190, label %191

; <label>:190:                                    ; preds = %186
  %.lcssa6 = phi i32 [ %188, %186 ]
  br label %454

; <label>:191:                                    ; preds = %186
  %192 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %193 = getelementptr inbounds [128 x i8], [128 x i8]* %192, i32 0, i32 0
  %194 = getelementptr [23 x i8], [23 x i8]* @.str.70, i32 0, i32 0
  call void (%struct.opendoor*, i8*, ...) @dprint_sequence(%struct.opendoor* %.03.ph48, i8* %194, i8* %193)
  br label %424

; <label>:195:                                    ; preds = %182
  %196 = getelementptr [19 x i8], [19 x i8]* @.str.71, i32 0, i32 0
  %197 = call i32 @strcmp(i8* %110, i8* %196) #10
  %198 = icmp ne i32 %197, 0
  br i1 %198, label %222, label %199

; <label>:199:                                    ; preds = %195
  %200 = load i8*, i8** %3, align 8
  %201 = getelementptr [3 x i8], [3 x i8]* @.str.72, i32 0, i32 0
  %202 = call %struct._IO_FILE* @fopen(i8* %200, i8* %201), !track !30
  %203 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 14
  store %struct._IO_FILE* %202, %struct._IO_FILE** %203, align 8
  %204 = icmp eq %struct._IO_FILE* %202, null
  br i1 %204, label %205, label %207

; <label>:205:                                    ; preds = %199
  %206 = load i8*, i8** %3, align 8
  call void @perror(i8* %206)
  br label %454

; <label>:207:                                    ; preds = %199
  %208 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %209 = getelementptr inbounds [128 x i8], [128 x i8]* %208, i32 0, i32 0
  %210 = load i8*, i8** %3, align 8
  %211 = getelementptr [41 x i8], [41 x i8]* @.str.73, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %211, i8* %209, i8* %210)
  %212 = call i32 @get_new_one_time_sequence(%struct.opendoor* %.03.ph48)
  %213 = icmp eq i32 %212, 0
  br i1 %213, label %214, label %218

; <label>:214:                                    ; preds = %207
  %215 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %216 = getelementptr inbounds [128 x i8], [128 x i8]* %215, i32 0, i32 0
  %217 = getelementptr [23 x i8], [23 x i8]* @.str.70, i32 0, i32 0
  call void (%struct.opendoor*, i8*, ...) @dprint_sequence(%struct.opendoor* %.03.ph48, i8* %217, i8* %216)
  br label %221

; <label>:218:                                    ; preds = %207
  %219 = load i8*, i8** %3, align 8
  %220 = getelementptr [66 x i8], [66 x i8]* @.str.74, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %220, i8* %219)
  br label %454

; <label>:221:                                    ; preds = %214
  br label %423

; <label>:222:                                    ; preds = %195
  %223 = getelementptr [12 x i8], [12 x i8]* @.str.75, i32 0, i32 0
  %224 = call i32 @strcmp(i8* %110, i8* %223) #10
  %225 = icmp ne i32 %224, 0
  br i1 %225, label %226, label %230

; <label>:226:                                    ; preds = %222
  %227 = getelementptr [8 x i8], [8 x i8]* @.str.76, i32 0, i32 0
  %228 = call i32 @strcmp(i8* %110, i8* %227) #10
  %229 = icmp ne i32 %228, 0
  br i1 %229, label %240, label %230

; <label>:230:                                    ; preds = %226, %222
  %231 = load i8*, i8** %3, align 8
  %232 = call i32 @atoi(i8* %231) #10
  %233 = sext i32 %232 to i64
  %234 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 4
  store i64 %233, i64* %234, align 8
  %235 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %236 = getelementptr inbounds [128 x i8], [128 x i8]* %235, i32 0, i32 0
  %237 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 4
  %238 = load i64, i64* %237, align 8
  %239 = getelementptr [29 x i8], [29 x i8]* @.str.77, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %239, i8* %236, i64 %238)
  br label %422

; <label>:240:                                    ; preds = %226
  %241 = getelementptr [14 x i8], [14 x i8]* @.str.78, i32 0, i32 0
  %242 = call i32 @strcmp(i8* %110, i8* %241) #10
  %243 = icmp ne i32 %242, 0
  br i1 %243, label %244, label %248

; <label>:244:                                    ; preds = %240
  %245 = getelementptr [8 x i8], [8 x i8]* @.str.79, i32 0, i32 0
  %246 = call i32 @strcmp(i8* %110, i8* %245) #10
  %247 = icmp ne i32 %246, 0
  br i1 %247, label %270, label %248

; <label>:248:                                    ; preds = %244, %240
  %249 = load i8*, i8** %3, align 8
  %250 = call i64 @strlen(i8* %249) #10
  %251 = add i64 %250, 1
  %252 = mul i64 1, %251
  %253 = call noalias i8* @malloc(i64 %252) #7, !track !31
  %254 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  store i8* %253, i8** %254, align 8
  %255 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  %256 = load i8*, i8** %255, align 8
  %257 = icmp eq i8* %256, null
  br i1 %257, label %258, label %260

; <label>:258:                                    ; preds = %248
  %259 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %259)
  call void @exit(i32 1) #9
  br label %UnifiedUnreachableBlock

; <label>:260:                                    ; preds = %248
  %261 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  %262 = load i8*, i8** %261, align 8
  %263 = load i8*, i8** %3, align 8
  %264 = call i8* @strcpy(i8* %262, i8* %263) #7, !track !32
  %265 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %266 = getelementptr inbounds [128 x i8], [128 x i8]* %265, i32 0, i32 0
  %267 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 5
  %268 = load i8*, i8** %267, align 8
  %269 = getelementptr [31 x i8], [31 x i8]* @.str.80, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %269, i8* %266, i8* %268)
  br label %421

; <label>:270:                                    ; preds = %244
  %271 = getelementptr [12 x i8], [12 x i8]* @.str.81, i32 0, i32 0
  %272 = call i32 @strcmp(i8* %110, i8* %271) #10
  %273 = icmp ne i32 %272, 0
  br i1 %273, label %284, label %274

; <label>:274:                                    ; preds = %270
  %275 = load i8*, i8** %3, align 8
  %276 = call i32 @atoi(i8* %275) #10
  %277 = sext i32 %276 to i64
  %278 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 6
  store i64 %277, i64* %278, align 8
  %279 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %280 = getelementptr inbounds [128 x i8], [128 x i8]* %279, i32 0, i32 0
  %281 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 6
  %282 = load i64, i64* %281, align 8
  %283 = getelementptr [29 x i8], [29 x i8]* @.str.82, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %283, i8* %280, i64 %282)
  br label %420

; <label>:284:                                    ; preds = %270
  %285 = getelementptr [13 x i8], [13 x i8]* @.str.83, i32 0, i32 0
  %286 = call i32 @strcmp(i8* %110, i8* %285) #10
  %287 = icmp ne i32 %286, 0
  br i1 %287, label %310, label %288

; <label>:288:                                    ; preds = %284
  %289 = load i8*, i8** %3, align 8
  %290 = call i64 @strlen(i8* %289) #10
  %291 = add i64 %290, 1
  %292 = mul i64 1, %291
  %293 = call noalias i8* @malloc(i64 %292) #7, !track !33
  %294 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  store i8* %293, i8** %294, align 8
  %295 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  %296 = load i8*, i8** %295, align 8
  %297 = icmp eq i8* %296, null
  br i1 %297, label %298, label %300

; <label>:298:                                    ; preds = %288
  %299 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %299)
  call void @exit(i32 1) #9
  br label %UnifiedUnreachableBlock

; <label>:300:                                    ; preds = %288
  %301 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  %302 = load i8*, i8** %301, align 8
  %303 = load i8*, i8** %3, align 8
  %304 = call i8* @strcpy(i8* %302, i8* %303) #7, !track !34
  %305 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 0
  %306 = getelementptr inbounds [128 x i8], [128 x i8]* %305, i32 0, i32 0
  %307 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 7
  %308 = load i8*, i8** %307, align 8
  %309 = getelementptr [30 x i8], [30 x i8]* @.str.84, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %309, i8* %306, i8* %308)
  br label %419

; <label>:310:                                    ; preds = %284
  %311 = getelementptr [9 x i8], [9 x i8]* @.str.85, i32 0, i32 0
  %312 = call i32 @strcmp(i8* %110, i8* %311) #10
  %313 = icmp ne i32 %312, 0
  br i1 %313, label %414, label %314

; <label>:314:                                    ; preds = %310
  %315 = load i8*, i8** %3, align 8
  %316 = call i8* @strtoupper(i8* %315)
  %317 = getelementptr [2 x i8], [2 x i8]* @.str.86, i32 0, i32 0
  %318 = call i8* @strsep(i8** %3, i8* %317) #7
  %319 = icmp ne i8* %318, null
  br i1 %319, label %.lr.ph46, label %413

.lr.ph46:                                         ; preds = %314
  br label %320

; <label>:320:                                    ; preds = %.lr.ph46, %408
  %321 = phi i8* [ %318, %.lr.ph46 ], [ %411, %408 ]
  call void @unroll_loop(i32 3)
  %322 = getelementptr [4 x i8], [4 x i8]* @.str.87, i32 0, i32 0
  %323 = call i32 @strcmp(i8* %321, i8* %322) #10
  %324 = icmp ne i32 %323, 0
  br i1 %324, label %327, label %325

; <label>:325:                                    ; preds = %320
  %326 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 8
  store i32 1, i32* %326, align 8
  br label %408

; <label>:327:                                    ; preds = %320
  %328 = getelementptr [5 x i8], [5 x i8]* @.str.88, i32 0, i32 0
  %329 = call i32 @strcmp(i8* %321, i8* %328) #10
  %330 = icmp ne i32 %329, 0
  br i1 %330, label %333, label %331

; <label>:331:                                    ; preds = %327
  %332 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 8
  store i32 2, i32* %332, align 8
  br label %407

; <label>:333:                                    ; preds = %327
  %334 = getelementptr [4 x i8], [4 x i8]* @.str.89, i32 0, i32 0
  %335 = call i32 @strcmp(i8* %321, i8* %334) #10
  %336 = icmp ne i32 %335, 0
  br i1 %336, label %339, label %337

; <label>:337:                                    ; preds = %333
  %338 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 9
  store i32 1, i32* %338, align 4
  br label %406

; <label>:339:                                    ; preds = %333
  %340 = getelementptr [5 x i8], [5 x i8]* @.str.90, i32 0, i32 0
  %341 = call i32 @strcmp(i8* %321, i8* %340) #10
  %342 = icmp ne i32 %341, 0
  br i1 %342, label %345, label %343

; <label>:343:                                    ; preds = %339
  %344 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 9
  store i32 2, i32* %344, align 4
  br label %405

; <label>:345:                                    ; preds = %339
  %346 = getelementptr [4 x i8], [4 x i8]* @.str.91, i32 0, i32 0
  %347 = call i32 @strcmp(i8* %321, i8* %346) #10
  %348 = icmp ne i32 %347, 0
  br i1 %348, label %351, label %349

; <label>:349:                                    ; preds = %345
  %350 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 10
  store i32 1, i32* %350, align 8
  br label %404

; <label>:351:                                    ; preds = %345
  %352 = getelementptr [5 x i8], [5 x i8]* @.str.92, i32 0, i32 0
  %353 = call i32 @strcmp(i8* %321, i8* %352) #10
  %354 = icmp ne i32 %353, 0
  br i1 %354, label %357, label %355

; <label>:355:                                    ; preds = %351
  %356 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 10
  store i32 2, i32* %356, align 8
  br label %403

; <label>:357:                                    ; preds = %351
  %358 = getelementptr [4 x i8], [4 x i8]* @.str.93, i32 0, i32 0
  %359 = call i32 @strcmp(i8* %321, i8* %358) #10
  %360 = icmp ne i32 %359, 0
  br i1 %360, label %363, label %361

; <label>:361:                                    ; preds = %357
  %362 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 11
  store i32 1, i32* %362, align 4
  br label %402

; <label>:363:                                    ; preds = %357
  %364 = getelementptr [5 x i8], [5 x i8]* @.str.94, i32 0, i32 0
  %365 = call i32 @strcmp(i8* %321, i8* %364) #10
  %366 = icmp ne i32 %365, 0
  br i1 %366, label %369, label %367

; <label>:367:                                    ; preds = %363
  %368 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 11
  store i32 2, i32* %368, align 4
  br label %401

; <label>:369:                                    ; preds = %363
  %370 = getelementptr [4 x i8], [4 x i8]* @.str.95, i32 0, i32 0
  %371 = call i32 @strcmp(i8* %321, i8* %370) #10
  %372 = icmp ne i32 %371, 0
  br i1 %372, label %375, label %373

; <label>:373:                                    ; preds = %369
  %374 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 12
  store i32 1, i32* %374, align 8
  br label %400

; <label>:375:                                    ; preds = %369
  %376 = getelementptr [5 x i8], [5 x i8]* @.str.96, i32 0, i32 0
  %377 = call i32 @strcmp(i8* %321, i8* %376) #10
  %378 = icmp ne i32 %377, 0
  br i1 %378, label %381, label %379

; <label>:379:                                    ; preds = %375
  %380 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 12
  store i32 2, i32* %380, align 8
  br label %399

; <label>:381:                                    ; preds = %375
  %382 = getelementptr [4 x i8], [4 x i8]* @.str.97, i32 0, i32 0
  %383 = call i32 @strcmp(i8* %321, i8* %382) #10
  %384 = icmp ne i32 %383, 0
  br i1 %384, label %387, label %385

; <label>:385:                                    ; preds = %381
  %386 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 13
  store i32 1, i32* %386, align 4
  br label %398

; <label>:387:                                    ; preds = %381
  %388 = getelementptr [5 x i8], [5 x i8]* @.str.98, i32 0, i32 0
  %389 = call i32 @strcmp(i8* %321, i8* %388) #10
  %390 = icmp ne i32 %389, 0
  br i1 %390, label %393, label %391

; <label>:391:                                    ; preds = %387
  %392 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.03.ph48, i32 0, i32 13
  store i32 2, i32* %392, align 4
  br label %397

; <label>:393:                                    ; preds = %387
  %.lcssa27 = phi i32 [ %.lcssa40, %387 ]
  %.lcssa5 = phi i8* [ %321, %387 ]
  %394 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %395 = getelementptr [41 x i8], [41 x i8]* @.str.99, i32 0, i32 0
  %396 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %394, i8* %395, i32 %.lcssa27, i8* %.lcssa5)
  br label %454

; <label>:397:                                    ; preds = %391
  br label %398

; <label>:398:                                    ; preds = %397, %385
  br label %399

; <label>:399:                                    ; preds = %398, %379
  br label %400

; <label>:400:                                    ; preds = %399, %373
  br label %401

; <label>:401:                                    ; preds = %400, %367
  br label %402

; <label>:402:                                    ; preds = %401, %361
  br label %403

; <label>:403:                                    ; preds = %402, %355
  br label %404

; <label>:404:                                    ; preds = %403, %349
  br label %405

; <label>:405:                                    ; preds = %404, %343
  br label %406

; <label>:406:                                    ; preds = %405, %337
  br label %407

; <label>:407:                                    ; preds = %406, %331
  br label %408

; <label>:408:                                    ; preds = %407, %325
  %409 = getelementptr [22 x i8], [22 x i8]* @.str.100, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %409, i8* %321)
  %410 = getelementptr [2 x i8], [2 x i8]* @.str.86, i32 0, i32 0
  %411 = call i8* @strsep(i8** %3, i8* %410) #7
  %412 = icmp ne i8* %411, null
  br i1 %412, label %320, label %._crit_edge47

._crit_edge47:                                    ; preds = %408
  br label %413

; <label>:413:                                    ; preds = %._crit_edge47, %314
  br label %418

; <label>:414:                                    ; preds = %310
  %.lcssa26 = phi i32 [ %.lcssa40, %310 ]
  %415 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %416 = getelementptr [31 x i8], [31 x i8]* @.str.59, i32 0, i32 0
  %417 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %415, i8* %416, i32 %.lcssa26)
  br label %454

; <label>:418:                                    ; preds = %413
  br label %419

; <label>:419:                                    ; preds = %418, %300
  %.0339 = phi %struct.opendoor* [ %.03.ph48, %418 ], [ %.03.ph48, %300 ]
  br label %420

; <label>:420:                                    ; preds = %419, %274
  %.0338 = phi %struct.opendoor* [ %.0339, %419 ], [ %.03.ph48, %274 ]
  br label %421

; <label>:421:                                    ; preds = %420, %260
  %.0337 = phi %struct.opendoor* [ %.0338, %420 ], [ %.03.ph48, %260 ]
  br label %422

; <label>:422:                                    ; preds = %421, %230
  %.0336 = phi %struct.opendoor* [ %.0337, %421 ], [ %.03.ph48, %230 ]
  br label %423

; <label>:423:                                    ; preds = %422, %221
  %.0335 = phi %struct.opendoor* [ %.0336, %422 ], [ %.03.ph48, %221 ]
  br label %424

; <label>:424:                                    ; preds = %423, %191
  %.0334 = phi %struct.opendoor* [ %.0335, %423 ], [ %.03.ph48, %191 ]
  br label %425

; <label>:425:                                    ; preds = %424, %175
  %.0333 = phi %struct.opendoor* [ %.0334, %424 ], [ %.03.ph48, %175 ]
  %426 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i64 0, i64 0
  store i8 0, i8* %426, align 16
  br label %427

; <label>:427:                                    ; preds = %425, %123
  %.0332 = phi %struct.opendoor* [ %.0333, %425 ], [ %.03.ph48, %123 ]
  br label %.outer

.outer:                                           ; preds = %427, %90
  %.2 = phi %struct.opendoor* [ %.1, %90 ], [ %.0332, %427 ]
  %428 = call i8* @fgets(i8* %11, i32 100, %struct._IO_FILE* %7), !track !35
  %429 = icmp ne i8* %428, null
  br i1 %429, label %.lr.ph43, label %.outer..outer._crit_edge_crit_edge

.outer..outer._crit_edge_crit_edge:               ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer..outer._crit_edge_crit_edge, %10
  br label %430

._crit_edge44:                                    ; preds = %26
  br label %430

; <label>:430:                                    ; preds = %._crit_edge44, %.outer._crit_edge
  %431 = call i32 @fclose(%struct._IO_FILE* %7)
  %432 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %433 = icmp ne %struct.__pmlist_t* %432, null
  br i1 %433, label %.lr.ph, label %453

.lr.ph:                                           ; preds = %430
  br label %434

; <label>:434:                                    ; preds = %.lr.ph, %449
  %.0141 = phi %struct.__pmlist_t* [ %432, %.lr.ph ], [ %451, %449 ]
  call void @unroll_loop(i32 4)
  %435 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.0141, i32 0, i32 0
  %436 = load i8*, i8** %435, align 8
  %437 = bitcast i8* %436 to %struct.opendoor*
  %438 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %437, i32 0, i32 1
  %439 = load i16, i16* %438, align 8
  %440 = zext i16 %439 to i32
  %441 = icmp eq i32 %440, 0
  br i1 %441, label %442, label %448

; <label>:442:                                    ; preds = %434
  %.lcssa = phi %struct.opendoor* [ %437, %434 ]
  %443 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %444 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %.lcssa, i32 0, i32 0
  %445 = getelementptr inbounds [128 x i8], [128 x i8]* %444, i32 0, i32 0
  %446 = getelementptr [49 x i8], [49 x i8]* @.str.101, i32 0, i32 0
  %447 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %443, i8* %446, i8* %445)
  br label %454

; <label>:448:                                    ; preds = %434
  br label %449

; <label>:449:                                    ; preds = %448
  %450 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.0141, i32 0, i32 2
  %451 = load %struct.__pmlist_t*, %struct.__pmlist_t** %450, align 8
  %452 = icmp ne %struct.__pmlist_t* %451, null
  br i1 %452, label %434, label %._crit_edge

._crit_edge:                                      ; preds = %449
  br label %453

; <label>:453:                                    ; preds = %._crit_edge, %430
  br label %454

; <label>:454:                                    ; preds = %453, %442, %414, %393, %218, %205, %190, %178, %169, %119, %104, %95, %58, %9
  %.0 = phi i32 [ 1, %9 ], [ 1, %58 ], [ 1, %104 ], [ 1, %119 ], [ 1, %178 ], [ 1, %414 ], [ 1, %393 ], [ 1, %205 ], [ 1, %218 ], [ %.lcssa6, %190 ], [ 1, %169 ], [ 1, %95 ], [ 1, %442 ], [ 0, %453 ]
  ret i32 %.0

UnifiedUnreachableBlock:                          ; preds = %298, %258, %71
  unreachable
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
                                                  ; No predecessors!
  ret void
}

; Function Attrs: noinline nounwind uwtable
define dso_local i8* @get_ip(i8*, i8*, i32) #0 {
  %4 = alloca %struct.ifreq, align 8, !track !36
  %5 = icmp sle i32 %2, 0
  br i1 %5, label %6, label %7

; <label>:6:                                      ; preds = %3
  br label %45

; <label>:7:                                      ; preds = %3
  %8 = icmp eq i8* %1, null
  br i1 %8, label %9, label %10

; <label>:9:                                      ; preds = %7
  br label %45

; <label>:10:                                     ; preds = %7
  %11 = getelementptr inbounds i8, i8* %1, i64 0
  store i8 0, i8* %11, align 1
  %12 = call i32 @socket(i32 2, i32 2, i32 0) #7
  %13 = icmp slt i32 %12, 0
  br i1 %13, label %14, label %15

; <label>:14:                                     ; preds = %10
  br label %45

; <label>:15:                                     ; preds = %10
  %16 = getelementptr inbounds %struct.ifreq, %struct.ifreq* %4, i32 0, i32 0
  %17 = bitcast %union.anon* %16 to [16 x i8]*
  %18 = bitcast [16 x i8]* %17 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 8 %18, i8 0, i64 16, i1 false)
  %19 = getelementptr inbounds %struct.ifreq, %struct.ifreq* %4, i32 0, i32 0
  %20 = bitcast %union.anon* %19 to [16 x i8]*
  %21 = getelementptr inbounds [16 x i8], [16 x i8]* %20, i32 0, i32 0
  %22 = call i8* @strncpy(i8* %21, i8* %0, i64 15) #7, !track !37
  %23 = getelementptr inbounds %struct.ifreq, %struct.ifreq* %4, i32 0, i32 0
  %24 = bitcast %union.anon* %23 to [16 x i8]*
  %25 = getelementptr inbounds [16 x i8], [16 x i8]* %24, i64 0, i64 15
  store i8 0, i8* %25, align 1
  %26 = call i32 (i32, i64, ...) @ioctl(i32 %12, i64 35093, %struct.ifreq* %4) #7
  %27 = icmp ne i32 %26, 0
  br i1 %27, label %28, label %30

; <label>:28:                                     ; preds = %15
  %29 = call i32 @close(i32 %12)
  br label %45

; <label>:30:                                     ; preds = %15
  %31 = call i32 @close(i32 %12)
  %32 = getelementptr inbounds %struct.ifreq, %struct.ifreq* %4, i32 0, i32 1
  %33 = bitcast %union.anon.1* %32 to %struct.sockaddr*
  %34 = bitcast %struct.sockaddr* %33 to %struct.sockaddr_in*
  %35 = getelementptr inbounds %struct.sockaddr_in, %struct.sockaddr_in* %34, i32 0, i32 2
  %36 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %35, i32 0, i32 0
  %37 = load i32, i32* %36, align 4
  %38 = call i8* @inet_ntoa(i32 %37) #7, !track !38
  %39 = sub nsw i32 %2, 1
  %40 = sext i32 %39 to i64
  %41 = call i8* @strncpy(i8* %1, i8* %38, i64 %40) #7, !track !39
  %42 = sub nsw i32 %2, 1
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds i8, i8* %1, i64 %43
  store i8 0, i8* %44, align 1
  br label %45

; <label>:45:                                     ; preds = %30, %28, %14, %9, %6
  %.0 = phi i8* [ null, %6 ], [ null, %9 ], [ null, %14 ], [ null, %28 ], [ %1, %30 ]
  ret i8* %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @generate_pcap_filter() #0 {
  %1 = alloca i8*, align 8, !track !40
  %2 = alloca [10 x i8], align 1
  %3 = alloca %struct.bpf_program, align 8, !track !41
  store i8* null, i8** %1, align 8
  %4 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %5 = icmp ne %struct.__pmlist_t* %4, null
  br i1 %5, label %.lr.ph51, label %269

.lr.ph51:                                         ; preds = %0
  br label %6

; <label>:6:                                      ; preds = %.lr.ph51, %265
  %.049 = phi %struct.__pmlist_t* [ %4, %.lr.ph51 ], [ %267, %265 ]
  %.0148 = phi i64 [ 0, %.lr.ph51 ], [ %.30, %265 ]
  %.02347 = phi i16 [ 0, %.lr.ph51 ], [ %.124, %265 ]
  call void @unroll_loop(i32 6)
  %7 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.049, i32 0, i32 0
  %8 = load i8*, i8** %7, align 8
  %9 = bitcast i8* %8 to %struct.opendoor*
  %10 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 15
  %11 = load i8*, i8** %10, align 8
  %12 = icmp ne i8* %11, null
  br i1 %12, label %13, label %14

; <label>:13:                                     ; preds = %6
  br label %265

; <label>:14:                                     ; preds = %6
  %15 = load i8*, i8** %1, align 8
  %16 = icmp eq i8* %15, null
  br i1 %16, label %17, label %27

; <label>:17:                                     ; preds = %14
  %18 = mul i64 1, 200
  %19 = call noalias i8* @malloc(i64 %18) #7, !track !42
  store i8* %19, i8** %1, align 8
  %20 = load i8*, i8** %1, align 8
  %21 = icmp eq i8* %20, null
  br i1 %21, label %22, label %24

; <label>:22:                                     ; preds = %17
  %23 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %23)
  call void @cleanup(i32 1)
  br label %24

; <label>:24:                                     ; preds = %22, %17
  %25 = load i8*, i8** %1, align 8
  %26 = getelementptr inbounds i8, i8* %25, i64 0
  store i8 0, i8* %26, align 1
  br label %27

; <label>:27:                                     ; preds = %24, %14
  %.12 = phi i64 [ 200, %24 ], [ %.0148, %14 ]
  %28 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 1
  %29 = load i16, i16* %28, align 8
  %30 = zext i16 %29 to i32
  %31 = icmp ult i32 0, %30
  br i1 %31, label %.lr.ph32, label %62

.lr.ph32:                                         ; preds = %27
  br label %32

; <label>:32:                                     ; preds = %.lr.ph32, %57
  %indvars.iv = phi i64 [ 0, %.lr.ph32 ], [ %indvars.iv.next, %57 ]
  %.230 = phi i64 [ %.12, %.lr.ph32 ], [ %.4, %57 ]
  %.0429 = phi i16 [ 0, %.lr.ph32 ], [ %.211, %57 ]
  %.01528 = phi i16 [ 0, %.lr.ph32 ], [ %.217, %57 ]
  call void @unroll_loop(i32 7)
  %33 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 3
  %34 = getelementptr inbounds [32 x i16], [32 x i16]* %33, i64 0, i64 %indvars.iv
  %35 = load i16, i16* %34, align 2
  %36 = zext i16 %35 to i32
  %37 = icmp eq i32 %36, 6
  br i1 %37, label %38, label %56

; <label>:38:                                     ; preds = %32
  %39 = icmp ne i16 %.0429, 0
  br i1 %39, label %43, label %40

; <label>:40:                                     ; preds = %38
  %41 = getelementptr [16 x i8], [16 x i8]* @.str.112, i32 0, i32 0
  %42 = call i64 @realloc_strcat(i8** %1, i8* %41, i64 %.230)
  br label %46

; <label>:43:                                     ; preds = %38
  %44 = getelementptr [5 x i8], [5 x i8]* @.str.113, i32 0, i32 0
  %45 = call i64 @realloc_strcat(i8** %1, i8* %44, i64 %.230)
  br label %46

; <label>:46:                                     ; preds = %43, %40
  %.116 = phi i16 [ %.01528, %43 ], [ 1, %40 ]
  %.110 = phi i16 [ %.0429, %43 ], [ 1, %40 ]
  %.3 = phi i64 [ %45, %43 ], [ %42, %40 ]
  %47 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %48 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 2
  %49 = getelementptr inbounds [32 x i16], [32 x i16]* %48, i64 0, i64 %indvars.iv
  %50 = load i16, i16* %49, align 2
  %51 = zext i16 %50 to i32
  %52 = getelementptr [4 x i8], [4 x i8]* @.str.114, i32 0, i32 0
  %53 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %47, i64 10, i8* %52, i32 %51) #7
  %54 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %55 = call i64 @realloc_strcat(i8** %1, i8* %54, i64 %.3)
  br label %56

; <label>:56:                                     ; preds = %46, %32
  %.217 = phi i16 [ %.116, %46 ], [ %.01528, %32 ]
  %.211 = phi i16 [ %.110, %46 ], [ %.0429, %32 ]
  %.4 = phi i64 [ %55, %46 ], [ %.230, %32 ]
  br label %57

; <label>:57:                                     ; preds = %56
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %58 = load i16, i16* %28, align 8
  %59 = zext i16 %58 to i32
  %60 = zext i32 %59 to i64
  %61 = icmp ult i64 %indvars.iv.next, %60
  br i1 %61, label %32, label %._crit_edge33

._crit_edge33:                                    ; preds = %57
  %split34 = phi i16 [ %.217, %57 ]
  %split35 = phi i64 [ %.4, %57 ]
  br label %62

; <label>:62:                                     ; preds = %._crit_edge33, %27
  %.015.lcssa = phi i16 [ %split34, %._crit_edge33 ], [ 0, %27 ]
  %.2.lcssa = phi i64 [ %split35, %._crit_edge33 ], [ %.12, %27 ]
  %63 = icmp ne i16 %.015.lcssa, 0
  br i1 %63, label %64, label %67

; <label>:64:                                     ; preds = %62
  %65 = getelementptr [2 x i8], [2 x i8]* @.str.115, i32 0, i32 0
  %66 = call i64 @realloc_strcat(i8** %1, i8* %65, i64 %.2.lcssa)
  br label %67

; <label>:67:                                     ; preds = %64, %62
  %.5 = phi i64 [ %66, %64 ], [ %.2.lcssa, %62 ]
  %68 = icmp ne i16 %.015.lcssa, 0
  br i1 %68, label %69, label %198

; <label>:69:                                     ; preds = %67
  %70 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 8
  %71 = load i32, i32* %70, align 8
  %72 = icmp ne i32 %71, 0
  br i1 %72, label %73, label %90

; <label>:73:                                     ; preds = %69
  %74 = getelementptr [30 x i8], [30 x i8]* @.str.116, i32 0, i32 0
  %75 = call i64 @realloc_strcat(i8** %1, i8* %74, i64 %.5)
  %76 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 8
  %77 = load i32, i32* %76, align 8
  %78 = icmp eq i32 %77, 1
  br i1 %78, label %79, label %82

; <label>:79:                                     ; preds = %73
  %80 = getelementptr [5 x i8], [5 x i8]* @.str.117, i32 0, i32 0
  %81 = call i64 @realloc_strcat(i8** %1, i8* %80, i64 %75)
  br label %82

; <label>:82:                                     ; preds = %79, %73
  %.6 = phi i64 [ %81, %79 ], [ %75, %73 ]
  %83 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 8
  %84 = load i32, i32* %83, align 8
  %85 = icmp eq i32 %84, 2
  br i1 %85, label %86, label %89

; <label>:86:                                     ; preds = %82
  %87 = getelementptr [5 x i8], [5 x i8]* @.str.118, i32 0, i32 0
  %88 = call i64 @realloc_strcat(i8** %1, i8* %87, i64 %.6)
  br label %89

; <label>:89:                                     ; preds = %86, %82
  %.7 = phi i64 [ %88, %86 ], [ %.6, %82 ]
  br label %90

; <label>:90:                                     ; preds = %89, %69
  %.8 = phi i64 [ %.7, %89 ], [ %.5, %69 ]
  %91 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 9
  %92 = load i32, i32* %91, align 4
  %93 = icmp ne i32 %92, 0
  br i1 %93, label %94, label %111

; <label>:94:                                     ; preds = %90
  %95 = getelementptr [30 x i8], [30 x i8]* @.str.119, i32 0, i32 0
  %96 = call i64 @realloc_strcat(i8** %1, i8* %95, i64 %.8)
  %97 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 9
  %98 = load i32, i32* %97, align 4
  %99 = icmp eq i32 %98, 1
  br i1 %99, label %100, label %103

; <label>:100:                                    ; preds = %94
  %101 = getelementptr [5 x i8], [5 x i8]* @.str.117, i32 0, i32 0
  %102 = call i64 @realloc_strcat(i8** %1, i8* %101, i64 %96)
  br label %103

; <label>:103:                                    ; preds = %100, %94
  %.9 = phi i64 [ %102, %100 ], [ %96, %94 ]
  %104 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 9
  %105 = load i32, i32* %104, align 4
  %106 = icmp eq i32 %105, 2
  br i1 %106, label %107, label %110

; <label>:107:                                    ; preds = %103
  %108 = getelementptr [5 x i8], [5 x i8]* @.str.118, i32 0, i32 0
  %109 = call i64 @realloc_strcat(i8** %1, i8* %108, i64 %.9)
  br label %110

; <label>:110:                                    ; preds = %107, %103
  %.10 = phi i64 [ %109, %107 ], [ %.9, %103 ]
  br label %111

; <label>:111:                                    ; preds = %110, %90
  %.11 = phi i64 [ %.10, %110 ], [ %.8, %90 ]
  %112 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 10
  %113 = load i32, i32* %112, align 8
  %114 = icmp ne i32 %113, 0
  br i1 %114, label %115, label %132

; <label>:115:                                    ; preds = %111
  %116 = getelementptr [30 x i8], [30 x i8]* @.str.120, i32 0, i32 0
  %117 = call i64 @realloc_strcat(i8** %1, i8* %116, i64 %.11)
  %118 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 10
  %119 = load i32, i32* %118, align 8
  %120 = icmp eq i32 %119, 1
  br i1 %120, label %121, label %124

; <label>:121:                                    ; preds = %115
  %122 = getelementptr [5 x i8], [5 x i8]* @.str.117, i32 0, i32 0
  %123 = call i64 @realloc_strcat(i8** %1, i8* %122, i64 %117)
  br label %124

; <label>:124:                                    ; preds = %121, %115
  %.123 = phi i64 [ %123, %121 ], [ %117, %115 ]
  %125 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 10
  %126 = load i32, i32* %125, align 8
  %127 = icmp eq i32 %126, 2
  br i1 %127, label %128, label %131

; <label>:128:                                    ; preds = %124
  %129 = getelementptr [5 x i8], [5 x i8]* @.str.118, i32 0, i32 0
  %130 = call i64 @realloc_strcat(i8** %1, i8* %129, i64 %.123)
  br label %131

; <label>:131:                                    ; preds = %128, %124
  %.13 = phi i64 [ %130, %128 ], [ %.123, %124 ]
  br label %132

; <label>:132:                                    ; preds = %131, %111
  %.14 = phi i64 [ %.13, %131 ], [ %.11, %111 ]
  %133 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 11
  %134 = load i32, i32* %133, align 4
  %135 = icmp ne i32 %134, 0
  br i1 %135, label %136, label %153

; <label>:136:                                    ; preds = %132
  %137 = getelementptr [30 x i8], [30 x i8]* @.str.121, i32 0, i32 0
  %138 = call i64 @realloc_strcat(i8** %1, i8* %137, i64 %.14)
  %139 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 11
  %140 = load i32, i32* %139, align 4
  %141 = icmp eq i32 %140, 1
  br i1 %141, label %142, label %145

; <label>:142:                                    ; preds = %136
  %143 = getelementptr [5 x i8], [5 x i8]* @.str.117, i32 0, i32 0
  %144 = call i64 @realloc_strcat(i8** %1, i8* %143, i64 %138)
  br label %145

; <label>:145:                                    ; preds = %142, %136
  %.15 = phi i64 [ %144, %142 ], [ %138, %136 ]
  %146 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 11
  %147 = load i32, i32* %146, align 4
  %148 = icmp eq i32 %147, 2
  br i1 %148, label %149, label %152

; <label>:149:                                    ; preds = %145
  %150 = getelementptr [5 x i8], [5 x i8]* @.str.118, i32 0, i32 0
  %151 = call i64 @realloc_strcat(i8** %1, i8* %150, i64 %.15)
  br label %152

; <label>:152:                                    ; preds = %149, %145
  %.16 = phi i64 [ %151, %149 ], [ %.15, %145 ]
  br label %153

; <label>:153:                                    ; preds = %152, %132
  %.17 = phi i64 [ %.16, %152 ], [ %.14, %132 ]
  %154 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 12
  %155 = load i32, i32* %154, align 8
  %156 = icmp ne i32 %155, 0
  br i1 %156, label %157, label %174

; <label>:157:                                    ; preds = %153
  %158 = getelementptr [30 x i8], [30 x i8]* @.str.122, i32 0, i32 0
  %159 = call i64 @realloc_strcat(i8** %1, i8* %158, i64 %.17)
  %160 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 12
  %161 = load i32, i32* %160, align 8
  %162 = icmp eq i32 %161, 1
  br i1 %162, label %163, label %166

; <label>:163:                                    ; preds = %157
  %164 = getelementptr [5 x i8], [5 x i8]* @.str.117, i32 0, i32 0
  %165 = call i64 @realloc_strcat(i8** %1, i8* %164, i64 %159)
  br label %166

; <label>:166:                                    ; preds = %163, %157
  %.18 = phi i64 [ %165, %163 ], [ %159, %157 ]
  %167 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 12
  %168 = load i32, i32* %167, align 8
  %169 = icmp eq i32 %168, 2
  br i1 %169, label %170, label %173

; <label>:170:                                    ; preds = %166
  %171 = getelementptr [5 x i8], [5 x i8]* @.str.118, i32 0, i32 0
  %172 = call i64 @realloc_strcat(i8** %1, i8* %171, i64 %.18)
  br label %173

; <label>:173:                                    ; preds = %170, %166
  %.19 = phi i64 [ %172, %170 ], [ %.18, %166 ]
  br label %174

; <label>:174:                                    ; preds = %173, %153
  %.20 = phi i64 [ %.19, %173 ], [ %.17, %153 ]
  %175 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 13
  %176 = load i32, i32* %175, align 4
  %177 = icmp ne i32 %176, 0
  br i1 %177, label %178, label %195

; <label>:178:                                    ; preds = %174
  %179 = getelementptr [30 x i8], [30 x i8]* @.str.123, i32 0, i32 0
  %180 = call i64 @realloc_strcat(i8** %1, i8* %179, i64 %.20)
  %181 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 13
  %182 = load i32, i32* %181, align 4
  %183 = icmp eq i32 %182, 1
  br i1 %183, label %184, label %187

; <label>:184:                                    ; preds = %178
  %185 = getelementptr [5 x i8], [5 x i8]* @.str.117, i32 0, i32 0
  %186 = call i64 @realloc_strcat(i8** %1, i8* %185, i64 %180)
  br label %187

; <label>:187:                                    ; preds = %184, %178
  %.21 = phi i64 [ %186, %184 ], [ %180, %178 ]
  %188 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 13
  %189 = load i32, i32* %188, align 4
  %190 = icmp eq i32 %189, 2
  br i1 %190, label %191, label %194

; <label>:191:                                    ; preds = %187
  %192 = getelementptr [5 x i8], [5 x i8]* @.str.118, i32 0, i32 0
  %193 = call i64 @realloc_strcat(i8** %1, i8* %192, i64 %.21)
  br label %194

; <label>:194:                                    ; preds = %191, %187
  %.22 = phi i64 [ %193, %191 ], [ %.21, %187 ]
  br label %195

; <label>:195:                                    ; preds = %194, %174
  %.23 = phi i64 [ %.22, %194 ], [ %.20, %174 ]
  %196 = getelementptr [2 x i8], [2 x i8]* @.str.115, i32 0, i32 0
  %197 = call i64 @realloc_strcat(i8** %1, i8* %196, i64 %.23)
  br label %198

; <label>:198:                                    ; preds = %195, %67
  %.24 = phi i64 [ %197, %195 ], [ %.5, %67 ]
  %199 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 1
  %200 = load i16, i16* %199, align 8
  %201 = zext i16 %200 to i32
  %202 = icmp ult i32 0, %201
  br i1 %202, label %.lr.ph41, label %238

.lr.ph41:                                         ; preds = %198
  br label %203

; <label>:203:                                    ; preds = %.lr.ph41, %233
  %indvars.iv45 = phi i64 [ 0, %.lr.ph41 ], [ %indvars.iv.next46, %233 ]
  %.2539 = phi i64 [ %.24, %.lr.ph41 ], [ %.28, %233 ]
  %.31238 = phi i16 [ 0, %.lr.ph41 ], [ %.514, %233 ]
  %.01837 = phi i16 [ 0, %.lr.ph41 ], [ %.220, %233 ]
  call void @unroll_loop(i32 8)
  %204 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 3
  %205 = getelementptr inbounds [32 x i16], [32 x i16]* %204, i64 0, i64 %indvars.iv45
  %206 = load i16, i16* %205, align 2
  %207 = zext i16 %206 to i32
  %208 = icmp eq i32 %207, 17
  br i1 %208, label %209, label %232

; <label>:209:                                    ; preds = %203
  %210 = icmp ne i16 %.31238, 0
  br i1 %210, label %219, label %211

; <label>:211:                                    ; preds = %209
  %212 = icmp ne i16 %.015.lcssa, 0
  br i1 %212, label %213, label %216

; <label>:213:                                    ; preds = %211
  %214 = getelementptr [5 x i8], [5 x i8]* @.str.113, i32 0, i32 0
  %215 = call i64 @realloc_strcat(i8** %1, i8* %214, i64 %.2539)
  br label %216

; <label>:216:                                    ; preds = %213, %211
  %.26 = phi i64 [ %215, %213 ], [ %.2539, %211 ]
  %217 = getelementptr [15 x i8], [15 x i8]* @.str.124, i32 0, i32 0
  %218 = call i64 @realloc_strcat(i8** %1, i8* %217, i64 %.26)
  br label %222

; <label>:219:                                    ; preds = %209
  %220 = getelementptr [5 x i8], [5 x i8]* @.str.113, i32 0, i32 0
  %221 = call i64 @realloc_strcat(i8** %1, i8* %220, i64 %.2539)
  br label %222

; <label>:222:                                    ; preds = %219, %216
  %.119 = phi i16 [ %.01837, %219 ], [ 1, %216 ]
  %.413 = phi i16 [ %.31238, %219 ], [ 1, %216 ]
  %.27 = phi i64 [ %221, %219 ], [ %218, %216 ]
  %223 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %224 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 2
  %225 = getelementptr inbounds [32 x i16], [32 x i16]* %224, i64 0, i64 %indvars.iv45
  %226 = load i16, i16* %225, align 2
  %227 = zext i16 %226 to i32
  %228 = getelementptr [4 x i8], [4 x i8]* @.str.114, i32 0, i32 0
  %229 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %223, i64 10, i8* %228, i32 %227) #7
  %230 = getelementptr inbounds [10 x i8], [10 x i8]* %2, i32 0, i32 0
  %231 = call i64 @realloc_strcat(i8** %1, i8* %230, i64 %.27)
  br label %232

; <label>:232:                                    ; preds = %222, %203
  %.220 = phi i16 [ %.119, %222 ], [ %.01837, %203 ]
  %.514 = phi i16 [ %.413, %222 ], [ %.31238, %203 ]
  %.28 = phi i64 [ %231, %222 ], [ %.2539, %203 ]
  br label %233

; <label>:233:                                    ; preds = %232
  %indvars.iv.next46 = add nuw nsw i64 %indvars.iv45, 1
  %234 = load i16, i16* %199, align 8
  %235 = zext i16 %234 to i32
  %236 = zext i32 %235 to i64
  %237 = icmp ult i64 %indvars.iv.next46, %236
  br i1 %237, label %203, label %._crit_edge42

._crit_edge42:                                    ; preds = %233
  %split43 = phi i16 [ %.220, %233 ]
  %split44 = phi i64 [ %.28, %233 ]
  br label %238

; <label>:238:                                    ; preds = %._crit_edge42, %198
  %.018.lcssa = phi i16 [ %split43, %._crit_edge42 ], [ 0, %198 ]
  %.25.lcssa = phi i64 [ %split44, %._crit_edge42 ], [ %.24, %198 ]
  %239 = icmp ne i16 %.018.lcssa, 0
  br i1 %239, label %240, label %243

; <label>:240:                                    ; preds = %238
  %241 = getelementptr [2 x i8], [2 x i8]* @.str.115, i32 0, i32 0
  %242 = call i64 @realloc_strcat(i8** %1, i8* %241, i64 %.25.lcssa)
  br label %243

; <label>:243:                                    ; preds = %240, %238
  %.29 = phi i64 [ %242, %240 ], [ %.25.lcssa, %238 ]
  %244 = icmp eq i64 %.29, 0
  br i1 %244, label %245, label %247

; <label>:245:                                    ; preds = %243
  %246 = getelementptr [8 x i8], [8 x i8]* @.str.125, i32 0, i32 0
  call void @perror(i8* %246)
  call void @cleanup(i32 1)
  br label %247

; <label>:247:                                    ; preds = %245, %243
  %248 = load i8*, i8** %1, align 8
  %249 = call i64 @strlen(i8* %248) #10
  %250 = add i64 %249, 1
  %251 = call noalias i8* @malloc(i64 %250) #7, !track !43
  %252 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 15
  store i8* %251, i8** %252, align 8
  %253 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 15
  %254 = load i8*, i8** %253, align 8
  %255 = icmp eq i8* %254, null
  br i1 %255, label %256, label %258

; <label>:256:                                    ; preds = %247
  %257 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %257)
  call void @cleanup(i32 1)
  br label %258

; <label>:258:                                    ; preds = %256, %247
  %259 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %9, i32 0, i32 15
  %260 = load i8*, i8** %259, align 8
  %261 = load i8*, i8** %1, align 8
  %262 = call i8* @strcpy(i8* %260, i8* %261) #7, !track !44
  %263 = load i8*, i8** %1, align 8
  %264 = getelementptr inbounds i8, i8* %263, i64 0
  store i8 0, i8* %264, align 1
  br label %265

; <label>:265:                                    ; preds = %258, %13
  %.124 = phi i16 [ %.02347, %13 ], [ 1, %258 ]
  %.30 = phi i64 [ %.0148, %13 ], [ %.29, %258 ]
  %266 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.049, i32 0, i32 2
  %267 = load %struct.__pmlist_t*, %struct.__pmlist_t** %266, align 8
  %268 = icmp ne %struct.__pmlist_t* %267, null
  br i1 %268, label %6, label %._crit_edge52

._crit_edge52:                                    ; preds = %265
  %split53 = phi i16 [ %.124, %265 ]
  %split54 = phi i64 [ %.30, %265 ]
  br label %269

; <label>:269:                                    ; preds = %._crit_edge52, %0
  %.023.lcssa = phi i16 [ %split53, %._crit_edge52 ], [ 0, %0 ]
  %.01.lcssa = phi i64 [ %split54, %._crit_edge52 ], [ 0, %0 ]
  %270 = icmp ne i16 %.023.lcssa, 0
  br i1 %270, label %271, label %321

; <label>:271:                                    ; preds = %269
  %272 = getelementptr [10 x i8], [10 x i8]* @.str.126, i32 0, i32 0
  %273 = call i64 @realloc_strcat(i8** %1, i8* %272, i64 %.01.lcssa)
  %274 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %275 = call i64 @realloc_strcat(i8** %1, i8* %274, i64 %273)
  %276 = getelementptr [7 x i8], [7 x i8]* @.str.127, i32 0, i32 0
  %277 = call i64 @realloc_strcat(i8** %1, i8* %276, i64 %275)
  %278 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %279 = icmp ne %struct.__pmlist_t* %278, null
  br i1 %279, label %.lr.ph, label %298

.lr.ph:                                           ; preds = %271
  br label %280

; <label>:280:                                    ; preds = %.lr.ph, %294
  %.126 = phi %struct.__pmlist_t* [ %278, %.lr.ph ], [ %296, %294 ]
  %.3125 = phi i64 [ %277, %.lr.ph ], [ %.32, %294 ]
  call void @unroll_loop(i32 9)
  %281 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.126, i32 0, i32 0
  %282 = load i8*, i8** %281, align 8
  %283 = bitcast i8* %282 to %struct.opendoor*
  %284 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %283, i32 0, i32 15
  %285 = load i8*, i8** %284, align 8
  %286 = call i64 @realloc_strcat(i8** %1, i8* %285, i64 %.3125)
  %287 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.126, i32 0, i32 2
  %288 = load %struct.__pmlist_t*, %struct.__pmlist_t** %287, align 8
  %289 = icmp ne %struct.__pmlist_t* %288, null
  br i1 %289, label %290, label %293

; <label>:290:                                    ; preds = %280
  %291 = getelementptr [5 x i8], [5 x i8]* @.str.113, i32 0, i32 0
  %292 = call i64 @realloc_strcat(i8** %1, i8* %291, i64 %286)
  br label %293

; <label>:293:                                    ; preds = %290, %280
  %.32 = phi i64 [ %292, %290 ], [ %286, %280 ]
  br label %294

; <label>:294:                                    ; preds = %293
  %295 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.126, i32 0, i32 2
  %296 = load %struct.__pmlist_t*, %struct.__pmlist_t** %295, align 8
  %297 = icmp ne %struct.__pmlist_t* %296, null
  br i1 %297, label %280, label %._crit_edge

._crit_edge:                                      ; preds = %294
  %split = phi i64 [ %.32, %294 ]
  br label %298

; <label>:298:                                    ; preds = %._crit_edge, %271
  %.31.lcssa = phi i64 [ %split, %._crit_edge ], [ %277, %271 ]
  %299 = getelementptr [2 x i8], [2 x i8]* @.str.115, i32 0, i32 0
  %300 = call i64 @realloc_strcat(i8** %1, i8* %299, i64 %.31.lcssa)
  %301 = icmp eq i64 %300, 0
  br i1 %301, label %302, label %304

; <label>:302:                                    ; preds = %298
  %303 = getelementptr [8 x i8], [8 x i8]* @.str.125, i32 0, i32 0
  call void @perror(i8* %303)
  call void @cleanup(i32 1)
  br label %304

; <label>:304:                                    ; preds = %302, %298
  %305 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %306 = load i8*, i8** %1, align 8
  %307 = call i32 @pcap_compile(%struct.pcap* %305, %struct.bpf_program* %3, i8* %306, i32 1, i32 0)
  %308 = icmp slt i32 %307, 0
  br i1 %308, label %309, label %312

; <label>:309:                                    ; preds = %304
  %310 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %311 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %310, i8* %311)
  call void @cleanup(i32 1)
  br label %312

; <label>:312:                                    ; preds = %309, %304
  %313 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %314 = call i32 @pcap_setfilter(%struct.pcap* %313, %struct.bpf_program* %3)
  %315 = icmp slt i32 %314, 0
  br i1 %315, label %316, label %319

; <label>:316:                                    ; preds = %312
  %317 = load %struct.pcap*, %struct.pcap** @cap, align 8
  %318 = getelementptr [5 x i8], [5 x i8]* @.str.27, i32 0, i32 0
  call void @pcap_perror(%struct.pcap* %317, i8* %318)
  call void @cleanup(i32 1)
  br label %319

; <label>:319:                                    ; preds = %316, %312
  call void @pcap_freecode(%struct.bpf_program* %3)
  %320 = load i8*, i8** %1, align 8
  call void @free(i8* %320) #7
  br label %321

; <label>:321:                                    ; preds = %319, %269
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
  %2 = alloca [1024 x i8], align 16, !track !45
  %3 = alloca [1 x %struct.__va_list_tag], align 16, !track !46
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
  br i1 %7, label %.lr.ph, label %16

.lr.ph:                                           ; preds = %1
  br label %8

; <label>:8:                                      ; preds = %.lr.ph, %12
  %.01 = phi %struct.__pmlist_t* [ %6, %.lr.ph ], [ %14, %12 ]
  call void @unroll_loop(i32 10)
  %9 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.01, i32 0, i32 0
  %10 = load i8*, i8** %9, align 8
  %11 = bitcast i8* %10 to %struct.opendoor*
  call void @close_door(%struct.opendoor* %11)
  br label %12

; <label>:12:                                     ; preds = %8
  %13 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.01, i32 0, i32 2
  %14 = load %struct.__pmlist_t*, %struct.__pmlist_t** %13, align 8
  %15 = icmp ne %struct.__pmlist_t* %14, null
  br i1 %15, label %8, label %._crit_edge

._crit_edge:                                      ; preds = %12
  br label %16

; <label>:16:                                     ; preds = %._crit_edge, %1
  %17 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  call void @list_free(%struct.__pmlist_t* %17)
  %18 = getelementptr [100 x i8], [100 x i8]* @o_cfg, i32 0, i32 0
  %19 = call i32 @parseconfig(i8* %18)
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
  %5 = alloca %struct.in_addr, align 4, !track !47
  %6 = alloca [16 x i8], align 16, !track !48
  %7 = alloca [16 x i8], align 16, !track !49
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
  br i1 %17, label %18, label %29

; <label>:18:                                     ; preds = %3
  %19 = bitcast i8* %2 to %struct.ethhdr*
  %20 = getelementptr inbounds %struct.ethhdr, %struct.ethhdr* %19, i32 0, i32 2
  %21 = load i16, i16* %20, align 1
  %22 = call zeroext i16 @ntohs(i16 zeroext %21) #11
  %23 = zext i16 %22 to i32
  %24 = icmp ne i32 %23, 2048
  br i1 %24, label %25, label %26

; <label>:25:                                     ; preds = %18
  br label %1169

; <label>:26:                                     ; preds = %18
  %27 = getelementptr inbounds i8, i8* %2, i64 14
  %28 = bitcast i8* %27 to %struct.iphdr*
  br label %42

; <label>:29:                                     ; preds = %3
  %30 = load i32, i32* @lltype, align 4
  %31 = icmp eq i32 %30, 113
  br i1 %31, label %32, label %35

; <label>:32:                                     ; preds = %29
  %33 = getelementptr inbounds i8, i8* %2, i64 16
  %34 = bitcast i8* %33 to %struct.iphdr*
  br label %41

; <label>:35:                                     ; preds = %29
  %36 = load i32, i32* @lltype, align 4
  %37 = icmp eq i32 %36, 12
  br i1 %37, label %38, label %40

; <label>:38:                                     ; preds = %35
  %39 = bitcast i8* %2 to %struct.iphdr*
  br label %40

; <label>:40:                                     ; preds = %38, %35
  %.011 = phi %struct.iphdr* [ %39, %38 ], [ null, %35 ]
  br label %41

; <label>:41:                                     ; preds = %40, %32
  %.112 = phi %struct.iphdr* [ %34, %32 ], [ %.011, %40 ]
  br label %42

; <label>:42:                                     ; preds = %41, %26
  %.213 = phi %struct.iphdr* [ %28, %26 ], [ %.112, %41 ]
  %43 = bitcast %struct.iphdr* %.213 to i8*
  %44 = load i8, i8* %43, align 4
  %45 = lshr i8 %44, 4
  %46 = zext i8 %45 to i32
  %47 = icmp ne i32 %46, 4
  br i1 %47, label %48, label %50

; <label>:48:                                     ; preds = %42
  %49 = getelementptr [33 x i8], [33 x i8]* @.str.134, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %49)
  br label %1169

; <label>:50:                                     ; preds = %42
  %51 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %52 = load i8, i8* %51, align 1
  %53 = zext i8 %52 to i32
  %54 = icmp eq i32 %53, 1
  br i1 %54, label %55, label %56

; <label>:55:                                     ; preds = %50
  br label %1169

; <label>:56:                                     ; preds = %50
  %57 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %58 = call i32 @inet_aton(i8* %57, %struct.in_addr* %5) #7
  %59 = icmp eq i32 %58, 0
  br i1 %59, label %60, label %65

; <label>:60:                                     ; preds = %56
  %61 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %62 = getelementptr [44 x i8], [44 x i8]* @.str.135, i32 0, i32 0
  %63 = getelementptr [32 x i8], [32 x i8]* @myip, i32 0, i32 0
  %64 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %61, i8* %62, i8* %63)
  br label %1169

; <label>:65:                                     ; preds = %56
  %66 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 9
  %67 = load i32, i32* %66, align 4
  %68 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  %69 = load i32, i32* %68, align 4
  %70 = icmp ne i32 %67, %69
  br i1 %70, label %71, label %73

; <label>:71:                                     ; preds = %65
  %72 = getelementptr [47 x i8], [47 x i8]* @.str.136, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %72)
  br label %1169

; <label>:73:                                     ; preds = %65
  %74 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %75 = load i8, i8* %74, align 1
  %76 = zext i8 %75 to i32
  %77 = icmp eq i32 %76, 6
  br i1 %77, label %78, label %101

; <label>:78:                                     ; preds = %73
  %79 = getelementptr inbounds [8 x i8], [8 x i8]* %4, i32 0, i32 0
  %80 = getelementptr [4 x i8], [4 x i8]* @.str.137, i32 0, i32 0
  %81 = call i8* @strncpy(i8* %79, i8* %80, i64 8) #7
  %82 = bitcast %struct.iphdr* %.213 to i8*
  %83 = bitcast %struct.iphdr* %.213 to i8*
  %84 = load i8, i8* %83, align 4
  %85 = and i8 %84, 15
  %86 = zext i8 %85 to i32
  %87 = mul nsw i32 %86, 4
  %88 = sext i32 %87 to i64
  %89 = getelementptr inbounds i8, i8* %82, i64 %88
  %90 = bitcast i8* %89 to %struct.tcphdr*
  %91 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %90, i32 0, i32 0
  %92 = bitcast %union.anon.4* %91 to %struct.anon.6*
  %93 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %92, i32 0, i32 0
  %94 = load i16, i16* %93, align 4
  %95 = call zeroext i16 @ntohs(i16 zeroext %94) #11
  %96 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %90, i32 0, i32 0
  %97 = bitcast %union.anon.4* %96 to %struct.anon.6*
  %98 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %97, i32 0, i32 1
  %99 = load i16, i16* %98, align 2
  %100 = call zeroext i16 @ntohs(i16 zeroext %99) #11
  br label %101

; <label>:101:                                    ; preds = %78, %73
  %.017 = phi i16 [ %100, %78 ], [ 0, %73 ]
  %.015 = phi i16 [ %95, %78 ], [ 0, %73 ]
  %.014 = phi %struct.tcphdr* [ %90, %78 ], [ null, %73 ]
  %102 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %103 = load i8, i8* %102, align 1
  %104 = zext i8 %103 to i32
  %105 = icmp eq i32 %104, 17
  br i1 %105, label %106, label %129

; <label>:106:                                    ; preds = %101
  %107 = getelementptr inbounds [8 x i8], [8 x i8]* %4, i32 0, i32 0
  %108 = getelementptr [4 x i8], [4 x i8]* @.str.138, i32 0, i32 0
  %109 = call i8* @strncpy(i8* %107, i8* %108, i64 8) #7
  %110 = bitcast %struct.iphdr* %.213 to i8*
  %111 = bitcast %struct.iphdr* %.213 to i8*
  %112 = load i8, i8* %111, align 4
  %113 = and i8 %112, 15
  %114 = zext i8 %113 to i32
  %115 = mul nsw i32 %114, 4
  %116 = sext i32 %115 to i64
  %117 = getelementptr inbounds i8, i8* %110, i64 %116
  %118 = bitcast i8* %117 to %struct.udphdr*
  %119 = getelementptr inbounds %struct.udphdr, %struct.udphdr* %118, i32 0, i32 0
  %120 = bitcast %union.anon.7* %119 to %struct.anon.8*
  %121 = getelementptr inbounds %struct.anon.8, %struct.anon.8* %120, i32 0, i32 0
  %122 = load i16, i16* %121, align 2
  %123 = call zeroext i16 @ntohs(i16 zeroext %122) #11
  %124 = getelementptr inbounds %struct.udphdr, %struct.udphdr* %118, i32 0, i32 0
  %125 = bitcast %union.anon.7* %124 to %struct.anon.8*
  %126 = getelementptr inbounds %struct.anon.8, %struct.anon.8* %125, i32 0, i32 1
  %127 = load i16, i16* %126, align 2
  %128 = call zeroext i16 @ntohs(i16 zeroext %127) #11
  br label %129

; <label>:129:                                    ; preds = %106, %101
  %.118 = phi i16 [ %128, %106 ], [ %.017, %101 ]
  %.116 = phi i16 [ %123, %106 ], [ %.015, %101 ]
  %130 = call %struct.tm* @localtime(i64* %8) #7
  %131 = getelementptr inbounds [11 x i8], [11 x i8]* %9, i32 0, i32 0
  %132 = getelementptr inbounds %struct.tm, %struct.tm* %130, i32 0, i32 5
  %133 = load i32, i32* %132, align 4
  %134 = add nsw i32 %133, 1900
  %135 = getelementptr inbounds %struct.tm, %struct.tm* %130, i32 0, i32 4
  %136 = load i32, i32* %135, align 8
  %137 = getelementptr inbounds %struct.tm, %struct.tm* %130, i32 0, i32 3
  %138 = load i32, i32* %137, align 4
  %139 = getelementptr [15 x i8], [15 x i8]* @.str.139, i32 0, i32 0
  %140 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %131, i64 11, i8* %139, i32 %134, i32 %136, i32 %138) #7
  %141 = getelementptr inbounds [9 x i8], [9 x i8]* %10, i32 0, i32 0
  %142 = getelementptr inbounds %struct.tm, %struct.tm* %130, i32 0, i32 2
  %143 = load i32, i32* %142, align 8
  %144 = getelementptr inbounds %struct.tm, %struct.tm* %130, i32 0, i32 1
  %145 = load i32, i32* %144, align 4
  %146 = getelementptr inbounds %struct.tm, %struct.tm* %130, i32 0, i32 0
  %147 = load i32, i32* %146, align 8
  %148 = getelementptr [15 x i8], [15 x i8]* @.str.140, i32 0, i32 0
  %149 = call i32 (i8*, i64, i8*, ...) @snprintf(i8* %141, i64 9, i8* %148, i32 %143, i32 %145, i32 %147) #7
  %150 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 8
  %151 = load i32, i32* %150, align 4
  %152 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  store i32 %151, i32* %152, align 4
  %153 = getelementptr inbounds [16 x i8], [16 x i8]* %6, i32 0, i32 0
  %154 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  %155 = load i32, i32* %154, align 4
  %156 = call i8* @inet_ntoa(i32 %155) #7, !track !50
  %157 = call i8* @strncpy(i8* %153, i8* %156, i64 15) #7, !track !51
  %158 = getelementptr inbounds [16 x i8], [16 x i8]* %6, i64 0, i64 15
  store i8 0, i8* %158, align 1
  %159 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 9
  %160 = load i32, i32* %159, align 4
  %161 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  store i32 %160, i32* %161, align 4
  %162 = getelementptr inbounds [16 x i8], [16 x i8]* %7, i32 0, i32 0
  %163 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  %164 = load i32, i32* %163, align 4
  %165 = call i8* @inet_ntoa(i32 %164) #7, !track !52
  %166 = call i8* @strncpy(i8* %162, i8* %165, i64 15) #7, !track !53
  %167 = getelementptr inbounds [16 x i8], [16 x i8]* %7, i64 0, i64 15
  store i8 0, i8* %167, align 1
  %168 = getelementptr inbounds [11 x i8], [11 x i8]* %9, i32 0, i32 0
  %169 = getelementptr inbounds [9 x i8], [9 x i8]* %10, i32 0, i32 0
  %170 = getelementptr inbounds [8 x i8], [8 x i8]* %4, i32 0, i32 0
  %171 = getelementptr inbounds [16 x i8], [16 x i8]* %6, i32 0, i32 0
  %172 = zext i16 %.116 to i32
  %173 = getelementptr inbounds [16 x i8], [16 x i8]* %7, i32 0, i32 0
  %174 = zext i16 %.118 to i32
  %175 = getelementptr inbounds %struct.pcap_pkthdr, %struct.pcap_pkthdr* %1, i32 0, i32 2
  %176 = load i32, i32* %175, align 4
  %177 = getelementptr [36 x i8], [36 x i8]* @.str.141, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %177, i8* %168, i8* %169, i8* %170, i8* %171, i32 %172, i8* %173, i32 %174, i32 %176)
  %178 = load %struct.__pmlist_t*, %struct.__pmlist_t** @attempts, align 8
  %179 = icmp ne %struct.__pmlist_t* %178, null
  br i1 %179, label %.lr.ph30, label %308

.lr.ph30:                                         ; preds = %129
  br label %180

; <label>:180:                                    ; preds = %.lr.ph30, %304
  %.02028 = phi %struct.__pmlist_t* [ %178, %.lr.ph30 ], [ %306, %304 ]
  call void @unroll_loop(i32 14)
  %181 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 0
  %182 = load i8*, i8** %181, align 8
  %183 = bitcast i8* %182 to %struct.knocker*
  %184 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 1
  %185 = load i16, i16* %184, align 8
  %186 = sext i16 %185 to i32
  %187 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 0
  %188 = load %struct.opendoor*, %struct.opendoor** %187, align 8
  %189 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %188, i32 0, i32 1
  %190 = load i16, i16* %189, align 8
  %191 = zext i16 %190 to i32
  %192 = icmp sge i32 %186, %191
  br i1 %192, label %193, label %197

; <label>:193:                                    ; preds = %180
  %194 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 2
  %195 = getelementptr inbounds [16 x i8], [16 x i8]* %194, i32 0, i32 0
  %196 = getelementptr [40 x i8], [40 x i8]* @.str.142, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %196, i8* %195)
  br label %197

; <label>:197:                                    ; preds = %193, %180
  %.01 = phi i32 [ 1, %193 ], [ 0, %180 ]
  %198 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 1
  %199 = load i16, i16* %198, align 8
  %200 = sext i16 %199 to i32
  %201 = icmp slt i32 %200, 0
  br i1 %201, label %202, label %206

; <label>:202:                                    ; preds = %197
  %203 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 2
  %204 = getelementptr inbounds [16 x i8], [16 x i8]* %203, i32 0, i32 0
  %205 = getelementptr [36 x i8], [36 x i8]* @.str.143, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %205, i8* %204)
  br label %206

; <label>:206:                                    ; preds = %202, %197
  %.19 = phi i32 [ 1, %202 ], [ %.01, %197 ]
  %207 = icmp ne i32 %.19, 0
  br i1 %207, label %269, label %208

; <label>:208:                                    ; preds = %206
  %209 = load i64, i64* %8, align 8
  %210 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 4
  %211 = load i64, i64* %210, align 8
  %212 = sub nsw i64 %209, %211
  %213 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 0
  %214 = load %struct.opendoor*, %struct.opendoor** %213, align 8
  %215 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %214, i32 0, i32 4
  %216 = load i64, i64* %215, align 8
  %217 = icmp sge i64 %212, %216
  br i1 %217, label %218, label %269

; <label>:218:                                    ; preds = %208
  %219 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 3
  %220 = load i8*, i8** %219, align 8
  %221 = icmp ne i8* %220, null
  br i1 %221, label %222, label %247

; <label>:222:                                    ; preds = %218
  %223 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 2
  %224 = getelementptr inbounds [16 x i8], [16 x i8]* %223, i32 0, i32 0
  %225 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 3
  %226 = load i8*, i8** %225, align 8
  %227 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 0
  %228 = load %struct.opendoor*, %struct.opendoor** %227, align 8
  %229 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %228, i32 0, i32 0
  %230 = getelementptr inbounds [128 x i8], [128 x i8]* %229, i32 0, i32 0
  %231 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 1
  %232 = load i16, i16* %231, align 8
  %233 = sext i16 %232 to i32
  %234 = getelementptr [42 x i8], [42 x i8]* @.str.144, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %234, i8* %224, i8* %226, i8* %230, i32 %233)
  %235 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 2
  %236 = getelementptr inbounds [16 x i8], [16 x i8]* %235, i32 0, i32 0
  %237 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 3
  %238 = load i8*, i8** %237, align 8
  %239 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 0
  %240 = load %struct.opendoor*, %struct.opendoor** %239, align 8
  %241 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %240, i32 0, i32 0
  %242 = getelementptr inbounds [128 x i8], [128 x i8]* %241, i32 0, i32 0
  %243 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 1
  %244 = load i16, i16* %243, align 8
  %245 = sext i16 %244 to i32
  %246 = getelementptr [42 x i8], [42 x i8]* @.str.144, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %246, i8* %236, i8* %238, i8* %242, i32 %245)
  br label %268

; <label>:247:                                    ; preds = %218
  %248 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 2
  %249 = getelementptr inbounds [16 x i8], [16 x i8]* %248, i32 0, i32 0
  %250 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 0
  %251 = load %struct.opendoor*, %struct.opendoor** %250, align 8
  %252 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %251, i32 0, i32 0
  %253 = getelementptr inbounds [128 x i8], [128 x i8]* %252, i32 0, i32 0
  %254 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 1
  %255 = load i16, i16* %254, align 8
  %256 = sext i16 %255 to i32
  %257 = getelementptr [37 x i8], [37 x i8]* @.str.145, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %257, i8* %249, i8* %253, i32 %256)
  %258 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 2
  %259 = getelementptr inbounds [16 x i8], [16 x i8]* %258, i32 0, i32 0
  %260 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 0
  %261 = load %struct.opendoor*, %struct.opendoor** %260, align 8
  %262 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %261, i32 0, i32 0
  %263 = getelementptr inbounds [128 x i8], [128 x i8]* %262, i32 0, i32 0
  %264 = getelementptr inbounds %struct.knocker, %struct.knocker* %183, i32 0, i32 1
  %265 = load i16, i16* %264, align 8
  %266 = sext i16 %265 to i32
  %267 = getelementptr [37 x i8], [37 x i8]* @.str.145, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %267, i8* %259, i8* %263, i32 %266)
  br label %268

; <label>:268:                                    ; preds = %247, %222
  br label %269

; <label>:269:                                    ; preds = %268, %208, %206
  %.210 = phi i32 [ %.19, %206 ], [ 1, %268 ], [ %.19, %208 ]
  %270 = icmp ne i32 %.210, 0
  br i1 %270, label %271, label %303

; <label>:271:                                    ; preds = %269
  %272 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 0
  %273 = load i8*, i8** %272, align 8
  %274 = bitcast i8* %273 to %struct.knocker*
  %275 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 1
  %276 = load %struct.__pmlist_t*, %struct.__pmlist_t** %275, align 8
  %277 = icmp ne %struct.__pmlist_t* %276, null
  br i1 %277, label %278, label %284

; <label>:278:                                    ; preds = %271
  %279 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  %280 = load %struct.__pmlist_t*, %struct.__pmlist_t** %279, align 8
  %281 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 1
  %282 = load %struct.__pmlist_t*, %struct.__pmlist_t** %281, align 8
  %283 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %282, i32 0, i32 2
  store %struct.__pmlist_t* %280, %struct.__pmlist_t** %283, align 8
  br label %284

; <label>:284:                                    ; preds = %278, %271
  %285 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  %286 = load %struct.__pmlist_t*, %struct.__pmlist_t** %285, align 8
  %287 = icmp ne %struct.__pmlist_t* %286, null
  br i1 %287, label %288, label %294

; <label>:288:                                    ; preds = %284
  %289 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 1
  %290 = load %struct.__pmlist_t*, %struct.__pmlist_t** %289, align 8
  %291 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  %292 = load %struct.__pmlist_t*, %struct.__pmlist_t** %291, align 8
  %293 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %292, i32 0, i32 1
  store %struct.__pmlist_t* %290, %struct.__pmlist_t** %293, align 8
  br label %294

; <label>:294:                                    ; preds = %288, %284
  %295 = load %struct.__pmlist_t*, %struct.__pmlist_t** @attempts, align 8
  %296 = icmp eq %struct.__pmlist_t* %.02028, %295
  br i1 %296, label %297, label %298

; <label>:297:                                    ; preds = %294
  store %struct.__pmlist_t* null, %struct.__pmlist_t** @attempts, align 8
  br label %298

; <label>:298:                                    ; preds = %297, %294
  %299 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  store %struct.__pmlist_t* null, %struct.__pmlist_t** %299, align 8
  %300 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 1
  store %struct.__pmlist_t* null, %struct.__pmlist_t** %300, align 8
  %301 = getelementptr inbounds %struct.knocker, %struct.knocker* %274, i32 0, i32 3
  %302 = load i8*, i8** %301, align 8
  call void @free(i8* %302) #7
  call void @list_free(%struct.__pmlist_t* %.02028)
  br label %304

; <label>:303:                                    ; preds = %269
  br label %304

; <label>:304:                                    ; preds = %303, %298
  %305 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.02028, i32 0, i32 2
  %306 = load %struct.__pmlist_t*, %struct.__pmlist_t** %305, align 8
  %307 = icmp ne %struct.__pmlist_t* %306, null
  br i1 %307, label %180, label %._crit_edge31

._crit_edge31:                                    ; preds = %304
  br label %308

; <label>:308:                                    ; preds = %._crit_edge31, %129
  %309 = load %struct.__pmlist_t*, %struct.__pmlist_t** @attempts, align 8
  %310 = icmp ne %struct.__pmlist_t* %309, null
  br i1 %310, label %.lr.ph27, label %.loopexit

.lr.ph27:                                         ; preds = %308
  br label %311

; <label>:311:                                    ; preds = %.lr.ph27, %325
  %.12125 = phi %struct.__pmlist_t* [ %309, %.lr.ph27 ], [ %327, %325 ]
  call void @unroll_loop(i32 15)
  %312 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.12125, i32 0, i32 0
  %313 = load i8*, i8** %312, align 8
  %314 = bitcast i8* %313 to %struct.knocker*
  %315 = getelementptr inbounds %struct.knocker, %struct.knocker* %314, i32 0, i32 2
  %316 = getelementptr inbounds [16 x i8], [16 x i8]* %315, i32 0, i32 0
  %317 = getelementptr inbounds [16 x i8], [16 x i8]* %6, i32 0, i32 0
  %318 = call i32 @strncmp(i8* %316, i8* %317, i64 16) #10
  %319 = icmp ne i32 %318, 0
  br i1 %319, label %324, label %320

; <label>:320:                                    ; preds = %311
  %.121.lcssa23 = phi %struct.__pmlist_t* [ %.12125, %311 ]
  %321 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.121.lcssa23, i32 0, i32 0
  %322 = load i8*, i8** %321, align 8
  %323 = bitcast i8* %322 to %struct.knocker*
  br label %329

; <label>:324:                                    ; preds = %311
  br label %325

; <label>:325:                                    ; preds = %324
  %326 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.12125, i32 0, i32 2
  %327 = load %struct.__pmlist_t*, %struct.__pmlist_t** %326, align 8
  %328 = icmp ne %struct.__pmlist_t* %327, null
  br i1 %328, label %311, label %..loopexit_crit_edge

..loopexit_crit_edge:                             ; preds = %325
  %split = phi %struct.knocker* [ null, %325 ]
  br label %.loopexit

.loopexit:                                        ; preds = %..loopexit_crit_edge, %308
  %.019.ph = phi %struct.knocker* [ %split, %..loopexit_crit_edge ], [ null, %308 ]
  br label %329

; <label>:329:                                    ; preds = %.loopexit, %320
  %.019 = phi %struct.knocker* [ %323, %320 ], [ %.019.ph, %.loopexit ]
  %330 = icmp ne %struct.knocker* %.019, null
  br i1 %330, label %331, label %860

; <label>:331:                                    ; preds = %329
  %332 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %333 = load i8, i8* %332, align 1
  %334 = zext i8 %333 to i32
  %335 = icmp eq i32 %334, 6
  br i1 %335, label %336, label %583

; <label>:336:                                    ; preds = %331
  %337 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %338 = load %struct.opendoor*, %struct.opendoor** %337, align 8
  %339 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %338, i32 0, i32 8
  %340 = load i32, i32* %339, align 8
  %341 = icmp ne i32 %340, 0
  br i1 %341, label %342, label %377

; <label>:342:                                    ; preds = %336
  %343 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %344 = load %struct.opendoor*, %struct.opendoor** %343, align 8
  %345 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %344, i32 0, i32 8
  %346 = load i32, i32* %345, align 8
  %347 = icmp eq i32 %346, 1
  br i1 %347, label %348, label %359

; <label>:348:                                    ; preds = %342
  %349 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %350 = bitcast %union.anon.4* %349 to %struct.anon.6*
  %351 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %350, i32 0, i32 4
  %352 = load i16, i16* %351, align 4
  %353 = lshr i16 %352, 8
  %354 = and i16 %353, 1
  %355 = zext i16 %354 to i32
  %356 = icmp ne i32 %355, 1
  br i1 %356, label %357, label %359

; <label>:357:                                    ; preds = %348
  %358 = getelementptr [32 x i8], [32 x i8]* @.str.146, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %358)
  br label %359

; <label>:359:                                    ; preds = %357, %348, %342
  %.0 = phi i32 [ 0, %357 ], [ 1, %348 ], [ 1, %342 ]
  %360 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %361 = load %struct.opendoor*, %struct.opendoor** %360, align 8
  %362 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %361, i32 0, i32 8
  %363 = load i32, i32* %362, align 8
  %364 = icmp eq i32 %363, 2
  br i1 %364, label %365, label %376

; <label>:365:                                    ; preds = %359
  %366 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %367 = bitcast %union.anon.4* %366 to %struct.anon.6*
  %368 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %367, i32 0, i32 4
  %369 = load i16, i16* %368, align 4
  %370 = lshr i16 %369, 8
  %371 = and i16 %370, 1
  %372 = zext i16 %371 to i32
  %373 = icmp eq i32 %372, 1
  br i1 %373, label %374, label %376

; <label>:374:                                    ; preds = %365
  %375 = getelementptr [33 x i8], [33 x i8]* @.str.147, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %375)
  br label %376

; <label>:376:                                    ; preds = %374, %365, %359
  %.1 = phi i32 [ 0, %374 ], [ %.0, %365 ], [ %.0, %359 ]
  br label %377

; <label>:377:                                    ; preds = %376, %336
  %.2 = phi i32 [ %.1, %376 ], [ 1, %336 ]
  %378 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %379 = load %struct.opendoor*, %struct.opendoor** %378, align 8
  %380 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %379, i32 0, i32 9
  %381 = load i32, i32* %380, align 4
  %382 = icmp ne i32 %381, 0
  br i1 %382, label %383, label %418

; <label>:383:                                    ; preds = %377
  %384 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %385 = load %struct.opendoor*, %struct.opendoor** %384, align 8
  %386 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %385, i32 0, i32 9
  %387 = load i32, i32* %386, align 4
  %388 = icmp eq i32 %387, 1
  br i1 %388, label %389, label %400

; <label>:389:                                    ; preds = %383
  %390 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %391 = bitcast %union.anon.4* %390 to %struct.anon.6*
  %392 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %391, i32 0, i32 4
  %393 = load i16, i16* %392, align 4
  %394 = lshr i16 %393, 9
  %395 = and i16 %394, 1
  %396 = zext i16 %395 to i32
  %397 = icmp ne i32 %396, 1
  br i1 %397, label %398, label %400

; <label>:398:                                    ; preds = %389
  %399 = getelementptr [32 x i8], [32 x i8]* @.str.148, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %399)
  br label %400

; <label>:400:                                    ; preds = %398, %389, %383
  %.3 = phi i32 [ 0, %398 ], [ %.2, %389 ], [ %.2, %383 ]
  %401 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %402 = load %struct.opendoor*, %struct.opendoor** %401, align 8
  %403 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %402, i32 0, i32 9
  %404 = load i32, i32* %403, align 4
  %405 = icmp eq i32 %404, 2
  br i1 %405, label %406, label %417

; <label>:406:                                    ; preds = %400
  %407 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %408 = bitcast %union.anon.4* %407 to %struct.anon.6*
  %409 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %408, i32 0, i32 4
  %410 = load i16, i16* %409, align 4
  %411 = lshr i16 %410, 9
  %412 = and i16 %411, 1
  %413 = zext i16 %412 to i32
  %414 = icmp eq i32 %413, 1
  br i1 %414, label %415, label %417

; <label>:415:                                    ; preds = %406
  %416 = getelementptr [33 x i8], [33 x i8]* @.str.149, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %416)
  br label %417

; <label>:417:                                    ; preds = %415, %406, %400
  %.4 = phi i32 [ 0, %415 ], [ %.3, %406 ], [ %.3, %400 ]
  br label %418

; <label>:418:                                    ; preds = %417, %377
  %.5 = phi i32 [ %.4, %417 ], [ %.2, %377 ]
  %419 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %420 = load %struct.opendoor*, %struct.opendoor** %419, align 8
  %421 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %420, i32 0, i32 10
  %422 = load i32, i32* %421, align 8
  %423 = icmp ne i32 %422, 0
  br i1 %423, label %424, label %459

; <label>:424:                                    ; preds = %418
  %425 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %426 = load %struct.opendoor*, %struct.opendoor** %425, align 8
  %427 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %426, i32 0, i32 10
  %428 = load i32, i32* %427, align 8
  %429 = icmp eq i32 %428, 1
  br i1 %429, label %430, label %441

; <label>:430:                                    ; preds = %424
  %431 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %432 = bitcast %union.anon.4* %431 to %struct.anon.6*
  %433 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %432, i32 0, i32 4
  %434 = load i16, i16* %433, align 4
  %435 = lshr i16 %434, 10
  %436 = and i16 %435, 1
  %437 = zext i16 %436 to i32
  %438 = icmp ne i32 %437, 1
  br i1 %438, label %439, label %441

; <label>:439:                                    ; preds = %430
  %440 = getelementptr [32 x i8], [32 x i8]* @.str.150, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %440)
  br label %441

; <label>:441:                                    ; preds = %439, %430, %424
  %.6 = phi i32 [ 0, %439 ], [ %.5, %430 ], [ %.5, %424 ]
  %442 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %443 = load %struct.opendoor*, %struct.opendoor** %442, align 8
  %444 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %443, i32 0, i32 10
  %445 = load i32, i32* %444, align 8
  %446 = icmp eq i32 %445, 2
  br i1 %446, label %447, label %458

; <label>:447:                                    ; preds = %441
  %448 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %449 = bitcast %union.anon.4* %448 to %struct.anon.6*
  %450 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %449, i32 0, i32 4
  %451 = load i16, i16* %450, align 4
  %452 = lshr i16 %451, 10
  %453 = and i16 %452, 1
  %454 = zext i16 %453 to i32
  %455 = icmp eq i32 %454, 1
  br i1 %455, label %456, label %458

; <label>:456:                                    ; preds = %447
  %457 = getelementptr [33 x i8], [33 x i8]* @.str.151, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %457)
  br label %458

; <label>:458:                                    ; preds = %456, %447, %441
  %.7 = phi i32 [ 0, %456 ], [ %.6, %447 ], [ %.6, %441 ]
  br label %459

; <label>:459:                                    ; preds = %458, %418
  %.8 = phi i32 [ %.7, %458 ], [ %.5, %418 ]
  %460 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %461 = load %struct.opendoor*, %struct.opendoor** %460, align 8
  %462 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %461, i32 0, i32 11
  %463 = load i32, i32* %462, align 4
  %464 = icmp ne i32 %463, 0
  br i1 %464, label %465, label %500

; <label>:465:                                    ; preds = %459
  %466 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %467 = load %struct.opendoor*, %struct.opendoor** %466, align 8
  %468 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %467, i32 0, i32 11
  %469 = load i32, i32* %468, align 4
  %470 = icmp eq i32 %469, 1
  br i1 %470, label %471, label %482

; <label>:471:                                    ; preds = %465
  %472 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %473 = bitcast %union.anon.4* %472 to %struct.anon.6*
  %474 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %473, i32 0, i32 4
  %475 = load i16, i16* %474, align 4
  %476 = lshr i16 %475, 11
  %477 = and i16 %476, 1
  %478 = zext i16 %477 to i32
  %479 = icmp ne i32 %478, 1
  br i1 %479, label %480, label %482

; <label>:480:                                    ; preds = %471
  %481 = getelementptr [32 x i8], [32 x i8]* @.str.152, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %481)
  br label %482

; <label>:482:                                    ; preds = %480, %471, %465
  %.9 = phi i32 [ 0, %480 ], [ %.8, %471 ], [ %.8, %465 ]
  %483 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %484 = load %struct.opendoor*, %struct.opendoor** %483, align 8
  %485 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %484, i32 0, i32 11
  %486 = load i32, i32* %485, align 4
  %487 = icmp eq i32 %486, 2
  br i1 %487, label %488, label %499

; <label>:488:                                    ; preds = %482
  %489 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %490 = bitcast %union.anon.4* %489 to %struct.anon.6*
  %491 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %490, i32 0, i32 4
  %492 = load i16, i16* %491, align 4
  %493 = lshr i16 %492, 11
  %494 = and i16 %493, 1
  %495 = zext i16 %494 to i32
  %496 = icmp eq i32 %495, 1
  br i1 %496, label %497, label %499

; <label>:497:                                    ; preds = %488
  %498 = getelementptr [33 x i8], [33 x i8]* @.str.153, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %498)
  br label %499

; <label>:499:                                    ; preds = %497, %488, %482
  %.10 = phi i32 [ 0, %497 ], [ %.9, %488 ], [ %.9, %482 ]
  br label %500

; <label>:500:                                    ; preds = %499, %459
  %.11 = phi i32 [ %.10, %499 ], [ %.8, %459 ]
  %501 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %502 = load %struct.opendoor*, %struct.opendoor** %501, align 8
  %503 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %502, i32 0, i32 12
  %504 = load i32, i32* %503, align 8
  %505 = icmp ne i32 %504, 0
  br i1 %505, label %506, label %541

; <label>:506:                                    ; preds = %500
  %507 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %508 = load %struct.opendoor*, %struct.opendoor** %507, align 8
  %509 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %508, i32 0, i32 12
  %510 = load i32, i32* %509, align 8
  %511 = icmp eq i32 %510, 1
  br i1 %511, label %512, label %523

; <label>:512:                                    ; preds = %506
  %513 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %514 = bitcast %union.anon.4* %513 to %struct.anon.6*
  %515 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %514, i32 0, i32 4
  %516 = load i16, i16* %515, align 4
  %517 = lshr i16 %516, 12
  %518 = and i16 %517, 1
  %519 = zext i16 %518 to i32
  %520 = icmp ne i32 %519, 1
  br i1 %520, label %521, label %523

; <label>:521:                                    ; preds = %512
  %522 = getelementptr [32 x i8], [32 x i8]* @.str.154, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %522)
  br label %523

; <label>:523:                                    ; preds = %521, %512, %506
  %.12 = phi i32 [ 0, %521 ], [ %.11, %512 ], [ %.11, %506 ]
  %524 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %525 = load %struct.opendoor*, %struct.opendoor** %524, align 8
  %526 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %525, i32 0, i32 12
  %527 = load i32, i32* %526, align 8
  %528 = icmp eq i32 %527, 2
  br i1 %528, label %529, label %540

; <label>:529:                                    ; preds = %523
  %530 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %531 = bitcast %union.anon.4* %530 to %struct.anon.6*
  %532 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %531, i32 0, i32 4
  %533 = load i16, i16* %532, align 4
  %534 = lshr i16 %533, 12
  %535 = and i16 %534, 1
  %536 = zext i16 %535 to i32
  %537 = icmp eq i32 %536, 1
  br i1 %537, label %538, label %540

; <label>:538:                                    ; preds = %529
  %539 = getelementptr [33 x i8], [33 x i8]* @.str.155, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %539)
  br label %540

; <label>:540:                                    ; preds = %538, %529, %523
  %.13 = phi i32 [ 0, %538 ], [ %.12, %529 ], [ %.12, %523 ]
  br label %541

; <label>:541:                                    ; preds = %540, %500
  %.14 = phi i32 [ %.13, %540 ], [ %.11, %500 ]
  %542 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %543 = load %struct.opendoor*, %struct.opendoor** %542, align 8
  %544 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %543, i32 0, i32 13
  %545 = load i32, i32* %544, align 4
  %546 = icmp ne i32 %545, 0
  br i1 %546, label %547, label %582

; <label>:547:                                    ; preds = %541
  %548 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %549 = load %struct.opendoor*, %struct.opendoor** %548, align 8
  %550 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %549, i32 0, i32 13
  %551 = load i32, i32* %550, align 4
  %552 = icmp eq i32 %551, 1
  br i1 %552, label %553, label %564

; <label>:553:                                    ; preds = %547
  %554 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %555 = bitcast %union.anon.4* %554 to %struct.anon.6*
  %556 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %555, i32 0, i32 4
  %557 = load i16, i16* %556, align 4
  %558 = lshr i16 %557, 13
  %559 = and i16 %558, 1
  %560 = zext i16 %559 to i32
  %561 = icmp ne i32 %560, 1
  br i1 %561, label %562, label %564

; <label>:562:                                    ; preds = %553
  %563 = getelementptr [32 x i8], [32 x i8]* @.str.156, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %563)
  br label %564

; <label>:564:                                    ; preds = %562, %553, %547
  %.15 = phi i32 [ 0, %562 ], [ %.14, %553 ], [ %.14, %547 ]
  %565 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %566 = load %struct.opendoor*, %struct.opendoor** %565, align 8
  %567 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %566, i32 0, i32 13
  %568 = load i32, i32* %567, align 4
  %569 = icmp eq i32 %568, 2
  br i1 %569, label %570, label %581

; <label>:570:                                    ; preds = %564
  %571 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %572 = bitcast %union.anon.4* %571 to %struct.anon.6*
  %573 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %572, i32 0, i32 4
  %574 = load i16, i16* %573, align 4
  %575 = lshr i16 %574, 13
  %576 = and i16 %575, 1
  %577 = zext i16 %576 to i32
  %578 = icmp eq i32 %577, 1
  br i1 %578, label %579, label %581

; <label>:579:                                    ; preds = %570
  %580 = getelementptr [33 x i8], [33 x i8]* @.str.157, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %580)
  br label %581

; <label>:581:                                    ; preds = %579, %570, %564
  %.16 = phi i32 [ 0, %579 ], [ %.15, %570 ], [ %.15, %564 ]
  br label %582

; <label>:582:                                    ; preds = %581, %541
  %.17 = phi i32 [ %.16, %581 ], [ %.14, %541 ]
  br label %583

; <label>:583:                                    ; preds = %582, %331
  %.18 = phi i32 [ %.17, %582 ], [ 1, %331 ]
  %584 = icmp ne i32 %.18, 0
  br i1 %584, label %585, label %853

; <label>:585:                                    ; preds = %583
  %586 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %587 = load i8, i8* %586, align 1
  %588 = zext i8 %587 to i32
  %589 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %590 = load %struct.opendoor*, %struct.opendoor** %589, align 8
  %591 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %590, i32 0, i32 3
  %592 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %593 = load i16, i16* %592, align 8
  %594 = sext i16 %593 to i64
  %595 = getelementptr inbounds [32 x i16], [32 x i16]* %591, i64 0, i64 %594
  %596 = load i16, i16* %595, align 2
  %597 = zext i16 %596 to i32
  %598 = icmp eq i32 %588, %597
  br i1 %598, label %599, label %853

; <label>:599:                                    ; preds = %585
  %600 = zext i16 %.118 to i32
  %601 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %602 = load %struct.opendoor*, %struct.opendoor** %601, align 8
  %603 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %602, i32 0, i32 2
  %604 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %605 = load i16, i16* %604, align 8
  %606 = sext i16 %605 to i64
  %607 = getelementptr inbounds [32 x i16], [32 x i16]* %603, i64 0, i64 %606
  %608 = load i16, i16* %607, align 2
  %609 = zext i16 %608 to i32
  %610 = icmp eq i32 %600, %609
  br i1 %610, label %611, label %853

; <label>:611:                                    ; preds = %599
  %612 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %613 = load i16, i16* %612, align 8
  %614 = add i16 %613, 1
  store i16 %614, i16* %612, align 8
  %615 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %616 = load i8*, i8** %615, align 8
  %617 = icmp ne i8* %616, null
  br i1 %617, label %618, label %643

; <label>:618:                                    ; preds = %611
  %619 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %620 = getelementptr inbounds [16 x i8], [16 x i8]* %619, i32 0, i32 0
  %621 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %622 = load i8*, i8** %621, align 8
  %623 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %624 = load %struct.opendoor*, %struct.opendoor** %623, align 8
  %625 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %624, i32 0, i32 0
  %626 = getelementptr inbounds [128 x i8], [128 x i8]* %625, i32 0, i32 0
  %627 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %628 = load i16, i16* %627, align 8
  %629 = sext i16 %628 to i32
  %630 = getelementptr [23 x i8], [23 x i8]* @.str.158, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %630, i8* %620, i8* %622, i8* %626, i32 %629)
  %631 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %632 = getelementptr inbounds [16 x i8], [16 x i8]* %631, i32 0, i32 0
  %633 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %634 = load i8*, i8** %633, align 8
  %635 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %636 = load %struct.opendoor*, %struct.opendoor** %635, align 8
  %637 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %636, i32 0, i32 0
  %638 = getelementptr inbounds [128 x i8], [128 x i8]* %637, i32 0, i32 0
  %639 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %640 = load i16, i16* %639, align 8
  %641 = sext i16 %640 to i32
  %642 = getelementptr [22 x i8], [22 x i8]* @.str.159, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %642, i8* %632, i8* %634, i8* %638, i32 %641)
  br label %664

; <label>:643:                                    ; preds = %611
  %644 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %645 = getelementptr inbounds [16 x i8], [16 x i8]* %644, i32 0, i32 0
  %646 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %647 = load %struct.opendoor*, %struct.opendoor** %646, align 8
  %648 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %647, i32 0, i32 0
  %649 = getelementptr inbounds [128 x i8], [128 x i8]* %648, i32 0, i32 0
  %650 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %651 = load i16, i16* %650, align 8
  %652 = sext i16 %651 to i32
  %653 = getelementptr [18 x i8], [18 x i8]* @.str.160, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %653, i8* %645, i8* %649, i32 %652)
  %654 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %655 = getelementptr inbounds [16 x i8], [16 x i8]* %654, i32 0, i32 0
  %656 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %657 = load %struct.opendoor*, %struct.opendoor** %656, align 8
  %658 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %657, i32 0, i32 0
  %659 = getelementptr inbounds [128 x i8], [128 x i8]* %658, i32 0, i32 0
  %660 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %661 = load i16, i16* %660, align 8
  %662 = sext i16 %661 to i32
  %663 = getelementptr [17 x i8], [17 x i8]* @.str.161, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %663, i8* %655, i8* %659, i32 %662)
  br label %664

; <label>:664:                                    ; preds = %643, %618
  %665 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  %666 = load i16, i16* %665, align 8
  %667 = sext i16 %666 to i32
  %668 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %669 = load %struct.opendoor*, %struct.opendoor** %668, align 8
  %670 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %669, i32 0, i32 1
  %671 = load i16, i16* %670, align 8
  %672 = zext i16 %671 to i32
  %673 = icmp sge i32 %667, %672
  br i1 %673, label %674, label %852

; <label>:674:                                    ; preds = %664
  %675 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %676 = load i8*, i8** %675, align 8
  %677 = icmp ne i8* %676, null
  br i1 %677, label %678, label %697

; <label>:678:                                    ; preds = %674
  %679 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %680 = getelementptr inbounds [16 x i8], [16 x i8]* %679, i32 0, i32 0
  %681 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %682 = load i8*, i8** %681, align 8
  %683 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %684 = load %struct.opendoor*, %struct.opendoor** %683, align 8
  %685 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %684, i32 0, i32 0
  %686 = getelementptr inbounds [128 x i8], [128 x i8]* %685, i32 0, i32 0
  %687 = getelementptr [26 x i8], [26 x i8]* @.str.162, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %687, i8* %680, i8* %682, i8* %686)
  %688 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %689 = getelementptr inbounds [16 x i8], [16 x i8]* %688, i32 0, i32 0
  %690 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %691 = load i8*, i8** %690, align 8
  %692 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %693 = load %struct.opendoor*, %struct.opendoor** %692, align 8
  %694 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %693, i32 0, i32 0
  %695 = getelementptr inbounds [128 x i8], [128 x i8]* %694, i32 0, i32 0
  %696 = getelementptr [25 x i8], [25 x i8]* @.str.163, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %696, i8* %689, i8* %691, i8* %695)
  br label %712

; <label>:697:                                    ; preds = %674
  %698 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %699 = getelementptr inbounds [16 x i8], [16 x i8]* %698, i32 0, i32 0
  %700 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %701 = load %struct.opendoor*, %struct.opendoor** %700, align 8
  %702 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %701, i32 0, i32 0
  %703 = getelementptr inbounds [128 x i8], [128 x i8]* %702, i32 0, i32 0
  %704 = getelementptr [21 x i8], [21 x i8]* @.str.164, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %704, i8* %699, i8* %703)
  %705 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %706 = getelementptr inbounds [16 x i8], [16 x i8]* %705, i32 0, i32 0
  %707 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %708 = load %struct.opendoor*, %struct.opendoor** %707, align 8
  %709 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %708, i32 0, i32 0
  %710 = getelementptr inbounds [128 x i8], [128 x i8]* %709, i32 0, i32 0
  %711 = getelementptr [20 x i8], [20 x i8]* @.str.165, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %711, i8* %706, i8* %710)
  br label %712

; <label>:712:                                    ; preds = %697, %678
  %713 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %714 = load %struct.opendoor*, %struct.opendoor** %713, align 8
  %715 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %714, i32 0, i32 5
  %716 = load i8*, i8** %715, align 8
  %717 = icmp ne i8* %716, null
  br i1 %717, label %718, label %831

; <label>:718:                                    ; preds = %712
  %719 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %720 = load %struct.opendoor*, %struct.opendoor** %719, align 8
  %721 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %720, i32 0, i32 5
  %722 = load i8*, i8** %721, align 8
  %723 = call i64 @strlen(i8* %722) #10
  %724 = icmp ne i64 %723, 0
  br i1 %724, label %725, label %831

; <label>:725:                                    ; preds = %718
  %726 = call i32 @fork() #7
  %727 = icmp eq i32 %726, 0
  br i1 %727, label %728, label %830

; <label>:728:                                    ; preds = %725
  %729 = call i32 @setsid() #7
  %730 = getelementptr inbounds [100 x i8], [100 x i8]* %11, i32 0, i32 0
  %731 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %732 = load %struct.opendoor*, %struct.opendoor** %731, align 8
  %733 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %732, i32 0, i32 5
  %734 = load i8*, i8** %733, align 8
  %735 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %736 = getelementptr inbounds [16 x i8], [16 x i8]* %735, i32 0, i32 0
  %737 = call i64 @parse_cmd(i8* %730, i64 100, i8* %734, i8* %736)
  %738 = icmp uge i64 %737, 100
  br i1 %738, label %739, label %744

; <label>:739:                                    ; preds = %728
  %740 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %741 = getelementptr [70 x i8], [70 x i8]* @.str.166, i32 0, i32 0
  %742 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %740, i8* %741)
  %743 = getelementptr [69 x i8], [69 x i8]* @.str.167, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %743)
  call void @exit(i32 0) #9
  br label %UnifiedUnreachableBlock

; <label>:744:                                    ; preds = %728
  %745 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %746 = load %struct.opendoor*, %struct.opendoor** %745, align 8
  %747 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %746, i32 0, i32 7
  %748 = load i8*, i8** %747, align 8
  %749 = icmp ne i8* %748, null
  br i1 %749, label %750, label %766

; <label>:750:                                    ; preds = %744
  %751 = getelementptr inbounds [100 x i8], [100 x i8]* %12, i32 0, i32 0
  %752 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %753 = load %struct.opendoor*, %struct.opendoor** %752, align 8
  %754 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %753, i32 0, i32 7
  %755 = load i8*, i8** %754, align 8
  %756 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %757 = getelementptr inbounds [16 x i8], [16 x i8]* %756, i32 0, i32 0
  %758 = call i64 @parse_cmd(i8* %751, i64 100, i8* %755, i8* %757)
  %759 = icmp uge i64 %758, 100
  br i1 %759, label %760, label %765

; <label>:760:                                    ; preds = %750
  %761 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %762 = getelementptr [80 x i8], [80 x i8]* @.str.168, i32 0, i32 0
  %763 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %761, i8* %762)
  %764 = getelementptr [79 x i8], [79 x i8]* @.str.169, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %764)
  call void @exit(i32 0) #9
  br label %UnifiedUnreachableBlock

; <label>:765:                                    ; preds = %750
  br label %766

; <label>:766:                                    ; preds = %765, %744
  %767 = getelementptr inbounds [100 x i8], [100 x i8]* %11, i32 0, i32 0
  %768 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %769 = load %struct.opendoor*, %struct.opendoor** %768, align 8
  %770 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %769, i32 0, i32 0
  %771 = getelementptr inbounds [128 x i8], [128 x i8]* %770, i32 0, i32 0
  %772 = call i32 @exec_cmd(i8* %767, i8* %771)
  %773 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %774 = load %struct.opendoor*, %struct.opendoor** %773, align 8
  %775 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %774, i32 0, i32 7
  %776 = load i8*, i8** %775, align 8
  %777 = icmp ne i8* %776, null
  br i1 %777, label %778, label %829

; <label>:778:                                    ; preds = %766
  %779 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %780 = load %struct.opendoor*, %struct.opendoor** %779, align 8
  %781 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %780, i32 0, i32 6
  %782 = load i64, i64* %781, align 8
  %783 = trunc i64 %782 to i32
  %784 = call i32 @sleep(i32 %783)
  %785 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %786 = load i8*, i8** %785, align 8
  %787 = icmp ne i8* %786, null
  br i1 %787, label %788, label %807

; <label>:788:                                    ; preds = %778
  %789 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %790 = getelementptr inbounds [16 x i8], [16 x i8]* %789, i32 0, i32 0
  %791 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %792 = load i8*, i8** %791, align 8
  %793 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %794 = load %struct.opendoor*, %struct.opendoor** %793, align 8
  %795 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %794, i32 0, i32 0
  %796 = getelementptr inbounds [128 x i8], [128 x i8]* %795, i32 0, i32 0
  %797 = getelementptr [30 x i8], [30 x i8]* @.str.170, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %797, i8* %790, i8* %792, i8* %796)
  %798 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %799 = getelementptr inbounds [16 x i8], [16 x i8]* %798, i32 0, i32 0
  %800 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 3
  %801 = load i8*, i8** %800, align 8
  %802 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %803 = load %struct.opendoor*, %struct.opendoor** %802, align 8
  %804 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %803, i32 0, i32 0
  %805 = getelementptr inbounds [128 x i8], [128 x i8]* %804, i32 0, i32 0
  %806 = getelementptr [29 x i8], [29 x i8]* @.str.171, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %806, i8* %799, i8* %801, i8* %805)
  br label %822

; <label>:807:                                    ; preds = %778
  %808 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %809 = getelementptr inbounds [16 x i8], [16 x i8]* %808, i32 0, i32 0
  %810 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %811 = load %struct.opendoor*, %struct.opendoor** %810, align 8
  %812 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %811, i32 0, i32 0
  %813 = getelementptr inbounds [128 x i8], [128 x i8]* %812, i32 0, i32 0
  %814 = getelementptr [25 x i8], [25 x i8]* @.str.172, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %814, i8* %809, i8* %813)
  %815 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 2
  %816 = getelementptr inbounds [16 x i8], [16 x i8]* %815, i32 0, i32 0
  %817 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %818 = load %struct.opendoor*, %struct.opendoor** %817, align 8
  %819 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %818, i32 0, i32 0
  %820 = getelementptr inbounds [128 x i8], [128 x i8]* %819, i32 0, i32 0
  %821 = getelementptr [24 x i8], [24 x i8]* @.str.173, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %821, i8* %816, i8* %820)
  br label %822

; <label>:822:                                    ; preds = %807, %788
  %823 = getelementptr inbounds [100 x i8], [100 x i8]* %12, i32 0, i32 0
  %824 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %825 = load %struct.opendoor*, %struct.opendoor** %824, align 8
  %826 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %825, i32 0, i32 0
  %827 = getelementptr inbounds [128 x i8], [128 x i8]* %826, i32 0, i32 0
  %828 = call i32 @exec_cmd(i8* %823, i8* %827)
  br label %829

; <label>:829:                                    ; preds = %822, %766
  call void @exit(i32 0) #9
  br label %UnifiedUnreachableBlock

; <label>:830:                                    ; preds = %725
  br label %831

; <label>:831:                                    ; preds = %830, %718, %712
  %832 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %833 = load %struct.opendoor*, %struct.opendoor** %832, align 8
  %834 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %833, i32 0, i32 14
  %835 = load %struct._IO_FILE*, %struct._IO_FILE** %834, align 8
  %836 = icmp ne %struct._IO_FILE* %835, null
  br i1 %836, label %837, label %851

; <label>:837:                                    ; preds = %831
  %838 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %839 = load %struct.opendoor*, %struct.opendoor** %838, align 8
  %840 = call i32 @disable_used_one_time_sequence(%struct.opendoor* %839)
  %841 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %842 = load %struct.opendoor*, %struct.opendoor** %841, align 8
  %843 = call i32 @get_new_one_time_sequence(%struct.opendoor* %842)
  %844 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %845 = load %struct.opendoor*, %struct.opendoor** %844, align 8
  %846 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %845, i32 0, i32 15
  %847 = load i8*, i8** %846, align 8
  call void @free(i8* %847) #7
  %848 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 0
  %849 = load %struct.opendoor*, %struct.opendoor** %848, align 8
  %850 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %849, i32 0, i32 15
  store i8* null, i8** %850, align 8
  call void @generate_pcap_filter()
  br label %851

; <label>:851:                                    ; preds = %837, %831
  br label %852

; <label>:852:                                    ; preds = %851, %664
  br label %859

; <label>:853:                                    ; preds = %599, %585, %583
  %854 = icmp eq i32 %.18, 0
  br i1 %854, label %855, label %856

; <label>:855:                                    ; preds = %853
  br label %858

; <label>:856:                                    ; preds = %853
  %857 = getelementptr inbounds %struct.knocker, %struct.knocker* %.019, i32 0, i32 1
  store i16 -1, i16* %857, align 8
  br label %858

; <label>:858:                                    ; preds = %856, %855
  br label %859

; <label>:859:                                    ; preds = %858, %852
  br label %1169

; <label>:860:                                    ; preds = %329
  %861 = load %struct.__pmlist_t*, %struct.__pmlist_t** @doors, align 8
  %862 = icmp ne %struct.__pmlist_t* %861, null
  br i1 %862, label %.lr.ph, label %1168

.lr.ph:                                           ; preds = %860
  br label %863

; <label>:863:                                    ; preds = %.lr.ph, %1164
  %.22224 = phi %struct.__pmlist_t* [ %861, %.lr.ph ], [ %1166, %1164 ]
  call void @unroll_loop(i32 16)
  %864 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.22224, i32 0, i32 0
  %865 = load i8*, i8** %864, align 8
  %866 = bitcast i8* %865 to %struct.opendoor*
  %867 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %868 = load i8, i8* %867, align 1
  %869 = zext i8 %868 to i32
  %870 = icmp eq i32 %869, 6
  br i1 %870, label %871, label %1082

; <label>:871:                                    ; preds = %863
  %872 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 8
  %873 = load i32, i32* %872, align 8
  %874 = icmp ne i32 %873, 0
  br i1 %874, label %875, label %906

; <label>:875:                                    ; preds = %871
  %876 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 8
  %877 = load i32, i32* %876, align 8
  %878 = icmp eq i32 %877, 1
  br i1 %878, label %879, label %890

; <label>:879:                                    ; preds = %875
  %880 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %881 = bitcast %union.anon.4* %880 to %struct.anon.6*
  %882 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %881, i32 0, i32 4
  %883 = load i16, i16* %882, align 4
  %884 = lshr i16 %883, 8
  %885 = and i16 %884, 1
  %886 = zext i16 %885 to i32
  %887 = icmp ne i32 %886, 1
  br i1 %887, label %888, label %890

; <label>:888:                                    ; preds = %879
  %889 = getelementptr [32 x i8], [32 x i8]* @.str.146, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %889)
  br label %1164

; <label>:890:                                    ; preds = %879, %875
  %891 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 8
  %892 = load i32, i32* %891, align 8
  %893 = icmp eq i32 %892, 2
  br i1 %893, label %894, label %905

; <label>:894:                                    ; preds = %890
  %895 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %896 = bitcast %union.anon.4* %895 to %struct.anon.6*
  %897 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %896, i32 0, i32 4
  %898 = load i16, i16* %897, align 4
  %899 = lshr i16 %898, 8
  %900 = and i16 %899, 1
  %901 = zext i16 %900 to i32
  %902 = icmp eq i32 %901, 1
  br i1 %902, label %903, label %905

; <label>:903:                                    ; preds = %894
  %904 = getelementptr [33 x i8], [33 x i8]* @.str.147, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %904)
  br label %1164

; <label>:905:                                    ; preds = %894, %890
  br label %906

; <label>:906:                                    ; preds = %905, %871
  %907 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 9
  %908 = load i32, i32* %907, align 4
  %909 = icmp ne i32 %908, 0
  br i1 %909, label %910, label %941

; <label>:910:                                    ; preds = %906
  %911 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 9
  %912 = load i32, i32* %911, align 4
  %913 = icmp eq i32 %912, 1
  br i1 %913, label %914, label %925

; <label>:914:                                    ; preds = %910
  %915 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %916 = bitcast %union.anon.4* %915 to %struct.anon.6*
  %917 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %916, i32 0, i32 4
  %918 = load i16, i16* %917, align 4
  %919 = lshr i16 %918, 9
  %920 = and i16 %919, 1
  %921 = zext i16 %920 to i32
  %922 = icmp ne i32 %921, 1
  br i1 %922, label %923, label %925

; <label>:923:                                    ; preds = %914
  %924 = getelementptr [32 x i8], [32 x i8]* @.str.148, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %924)
  br label %1164

; <label>:925:                                    ; preds = %914, %910
  %926 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 9
  %927 = load i32, i32* %926, align 4
  %928 = icmp eq i32 %927, 2
  br i1 %928, label %929, label %940

; <label>:929:                                    ; preds = %925
  %930 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %931 = bitcast %union.anon.4* %930 to %struct.anon.6*
  %932 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %931, i32 0, i32 4
  %933 = load i16, i16* %932, align 4
  %934 = lshr i16 %933, 9
  %935 = and i16 %934, 1
  %936 = zext i16 %935 to i32
  %937 = icmp eq i32 %936, 1
  br i1 %937, label %938, label %940

; <label>:938:                                    ; preds = %929
  %939 = getelementptr [33 x i8], [33 x i8]* @.str.149, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %939)
  br label %1164

; <label>:940:                                    ; preds = %929, %925
  br label %941

; <label>:941:                                    ; preds = %940, %906
  %942 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 10
  %943 = load i32, i32* %942, align 8
  %944 = icmp ne i32 %943, 0
  br i1 %944, label %945, label %976

; <label>:945:                                    ; preds = %941
  %946 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 10
  %947 = load i32, i32* %946, align 8
  %948 = icmp eq i32 %947, 1
  br i1 %948, label %949, label %960

; <label>:949:                                    ; preds = %945
  %950 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %951 = bitcast %union.anon.4* %950 to %struct.anon.6*
  %952 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %951, i32 0, i32 4
  %953 = load i16, i16* %952, align 4
  %954 = lshr i16 %953, 10
  %955 = and i16 %954, 1
  %956 = zext i16 %955 to i32
  %957 = icmp ne i32 %956, 1
  br i1 %957, label %958, label %960

; <label>:958:                                    ; preds = %949
  %959 = getelementptr [32 x i8], [32 x i8]* @.str.150, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %959)
  br label %1164

; <label>:960:                                    ; preds = %949, %945
  %961 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 10
  %962 = load i32, i32* %961, align 8
  %963 = icmp eq i32 %962, 2
  br i1 %963, label %964, label %975

; <label>:964:                                    ; preds = %960
  %965 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %966 = bitcast %union.anon.4* %965 to %struct.anon.6*
  %967 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %966, i32 0, i32 4
  %968 = load i16, i16* %967, align 4
  %969 = lshr i16 %968, 10
  %970 = and i16 %969, 1
  %971 = zext i16 %970 to i32
  %972 = icmp eq i32 %971, 1
  br i1 %972, label %973, label %975

; <label>:973:                                    ; preds = %964
  %974 = getelementptr [33 x i8], [33 x i8]* @.str.151, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %974)
  br label %1164

; <label>:975:                                    ; preds = %964, %960
  br label %976

; <label>:976:                                    ; preds = %975, %941
  %977 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 11
  %978 = load i32, i32* %977, align 4
  %979 = icmp ne i32 %978, 0
  br i1 %979, label %980, label %1011

; <label>:980:                                    ; preds = %976
  %981 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 11
  %982 = load i32, i32* %981, align 4
  %983 = icmp eq i32 %982, 1
  br i1 %983, label %984, label %995

; <label>:984:                                    ; preds = %980
  %985 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %986 = bitcast %union.anon.4* %985 to %struct.anon.6*
  %987 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %986, i32 0, i32 4
  %988 = load i16, i16* %987, align 4
  %989 = lshr i16 %988, 11
  %990 = and i16 %989, 1
  %991 = zext i16 %990 to i32
  %992 = icmp ne i32 %991, 1
  br i1 %992, label %993, label %995

; <label>:993:                                    ; preds = %984
  %994 = getelementptr [32 x i8], [32 x i8]* @.str.152, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %994)
  br label %1164

; <label>:995:                                    ; preds = %984, %980
  %996 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 11
  %997 = load i32, i32* %996, align 4
  %998 = icmp eq i32 %997, 2
  br i1 %998, label %999, label %1010

; <label>:999:                                    ; preds = %995
  %1000 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %1001 = bitcast %union.anon.4* %1000 to %struct.anon.6*
  %1002 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %1001, i32 0, i32 4
  %1003 = load i16, i16* %1002, align 4
  %1004 = lshr i16 %1003, 11
  %1005 = and i16 %1004, 1
  %1006 = zext i16 %1005 to i32
  %1007 = icmp eq i32 %1006, 1
  br i1 %1007, label %1008, label %1010

; <label>:1008:                                   ; preds = %999
  %1009 = getelementptr [33 x i8], [33 x i8]* @.str.153, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %1009)
  br label %1164

; <label>:1010:                                   ; preds = %999, %995
  br label %1011

; <label>:1011:                                   ; preds = %1010, %976
  %1012 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 12
  %1013 = load i32, i32* %1012, align 8
  %1014 = icmp ne i32 %1013, 0
  br i1 %1014, label %1015, label %1046

; <label>:1015:                                   ; preds = %1011
  %1016 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 12
  %1017 = load i32, i32* %1016, align 8
  %1018 = icmp eq i32 %1017, 1
  br i1 %1018, label %1019, label %1030

; <label>:1019:                                   ; preds = %1015
  %1020 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %1021 = bitcast %union.anon.4* %1020 to %struct.anon.6*
  %1022 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %1021, i32 0, i32 4
  %1023 = load i16, i16* %1022, align 4
  %1024 = lshr i16 %1023, 12
  %1025 = and i16 %1024, 1
  %1026 = zext i16 %1025 to i32
  %1027 = icmp ne i32 %1026, 1
  br i1 %1027, label %1028, label %1030

; <label>:1028:                                   ; preds = %1019
  %1029 = getelementptr [32 x i8], [32 x i8]* @.str.154, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %1029)
  br label %1164

; <label>:1030:                                   ; preds = %1019, %1015
  %1031 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 12
  %1032 = load i32, i32* %1031, align 8
  %1033 = icmp eq i32 %1032, 2
  br i1 %1033, label %1034, label %1045

; <label>:1034:                                   ; preds = %1030
  %1035 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %1036 = bitcast %union.anon.4* %1035 to %struct.anon.6*
  %1037 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %1036, i32 0, i32 4
  %1038 = load i16, i16* %1037, align 4
  %1039 = lshr i16 %1038, 12
  %1040 = and i16 %1039, 1
  %1041 = zext i16 %1040 to i32
  %1042 = icmp eq i32 %1041, 1
  br i1 %1042, label %1043, label %1045

; <label>:1043:                                   ; preds = %1034
  %1044 = getelementptr [33 x i8], [33 x i8]* @.str.155, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %1044)
  br label %1164

; <label>:1045:                                   ; preds = %1034, %1030
  br label %1046

; <label>:1046:                                   ; preds = %1045, %1011
  %1047 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 13
  %1048 = load i32, i32* %1047, align 4
  %1049 = icmp ne i32 %1048, 0
  br i1 %1049, label %1050, label %1081

; <label>:1050:                                   ; preds = %1046
  %1051 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 13
  %1052 = load i32, i32* %1051, align 4
  %1053 = icmp eq i32 %1052, 1
  br i1 %1053, label %1054, label %1065

; <label>:1054:                                   ; preds = %1050
  %1055 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %1056 = bitcast %union.anon.4* %1055 to %struct.anon.6*
  %1057 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %1056, i32 0, i32 4
  %1058 = load i16, i16* %1057, align 4
  %1059 = lshr i16 %1058, 13
  %1060 = and i16 %1059, 1
  %1061 = zext i16 %1060 to i32
  %1062 = icmp ne i32 %1061, 1
  br i1 %1062, label %1063, label %1065

; <label>:1063:                                   ; preds = %1054
  %1064 = getelementptr [32 x i8], [32 x i8]* @.str.156, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %1064)
  br label %1164

; <label>:1065:                                   ; preds = %1054, %1050
  %1066 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 13
  %1067 = load i32, i32* %1066, align 4
  %1068 = icmp eq i32 %1067, 2
  br i1 %1068, label %1069, label %1080

; <label>:1069:                                   ; preds = %1065
  %1070 = getelementptr inbounds %struct.tcphdr, %struct.tcphdr* %.014, i32 0, i32 0
  %1071 = bitcast %union.anon.4* %1070 to %struct.anon.6*
  %1072 = getelementptr inbounds %struct.anon.6, %struct.anon.6* %1071, i32 0, i32 4
  %1073 = load i16, i16* %1072, align 4
  %1074 = lshr i16 %1073, 13
  %1075 = and i16 %1074, 1
  %1076 = zext i16 %1075 to i32
  %1077 = icmp eq i32 %1076, 1
  br i1 %1077, label %1078, label %1080

; <label>:1078:                                   ; preds = %1069
  %1079 = getelementptr [33 x i8], [33 x i8]* @.str.157, i32 0, i32 0
  call void (i8*, ...) @dprint(i8* %1079)
  br label %1164

; <label>:1080:                                   ; preds = %1069, %1065
  br label %1081

; <label>:1081:                                   ; preds = %1080, %1046
  br label %1082

; <label>:1082:                                   ; preds = %1081, %863
  %1083 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 6
  %1084 = load i8, i8* %1083, align 1
  %1085 = zext i8 %1084 to i32
  %1086 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 3
  %1087 = getelementptr inbounds [32 x i16], [32 x i16]* %1086, i64 0, i64 0
  %1088 = load i16, i16* %1087, align 2
  %1089 = zext i16 %1088 to i32
  %1090 = icmp eq i32 %1085, %1089
  br i1 %1090, label %1091, label %1163

; <label>:1091:                                   ; preds = %1082
  %1092 = zext i16 %.118 to i32
  %1093 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 2
  %1094 = getelementptr inbounds [32 x i16], [32 x i16]* %1093, i64 0, i64 0
  %1095 = load i16, i16* %1094, align 2
  %1096 = zext i16 %1095 to i32
  %1097 = icmp eq i32 %1092, %1096
  br i1 %1097, label %1098, label %1163

; <label>:1098:                                   ; preds = %1091
  %1099 = call noalias i8* @malloc(i64 48) #7, !track !54
  %1100 = bitcast i8* %1099 to %struct.knocker*
  %1101 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 3
  store i8* null, i8** %1101, align 8
  %1102 = icmp eq %struct.knocker* %1100, null
  br i1 %1102, label %1103, label %1105

; <label>:1103:                                   ; preds = %1098
  %1104 = getelementptr [7 x i8], [7 x i8]* @.str.56, i32 0, i32 0
  call void @perror(i8* %1104)
  call void @exit(i32 1) #9
  br label %UnifiedUnreachableBlock

; <label>:1105:                                   ; preds = %1098
  %1106 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 2
  %1107 = getelementptr inbounds [16 x i8], [16 x i8]* %1106, i32 0, i32 0
  %1108 = getelementptr inbounds [16 x i8], [16 x i8]* %6, i32 0, i32 0
  %1109 = call i8* @strcpy(i8* %1107, i8* %1108) #7, !track !55
  %1110 = load i32, i32* @o_lookup, align 4
  %1111 = icmp ne i32 %1110, 0
  br i1 %1111, label %1112, label %1125

; <label>:1112:                                   ; preds = %1105
  %1113 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %.213, i32 0, i32 8
  %1114 = load i32, i32* %1113, align 4
  %1115 = getelementptr inbounds %struct.in_addr, %struct.in_addr* %5, i32 0, i32 0
  store i32 %1114, i32* %1115, align 4
  %1116 = bitcast %struct.in_addr* %5 to i8*
  %1117 = call %struct.hostent* @gethostbyaddr(i8* %1116, i32 4, i32 2), !track !56
  %1118 = icmp ne %struct.hostent* %1117, null
  br i1 %1118, label %1119, label %1124

; <label>:1119:                                   ; preds = %1112
  %1120 = getelementptr inbounds %struct.hostent, %struct.hostent* %1117, i32 0, i32 0
  %1121 = load i8*, i8** %1120, align 8
  %1122 = call noalias i8* @strdup(i8* %1121) #7, !track !57
  %1123 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 3
  store i8* %1122, i8** %1123, align 8
  br label %1124

; <label>:1124:                                   ; preds = %1119, %1112
  br label %1125

; <label>:1125:                                   ; preds = %1124, %1105
  %1126 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 1
  store i16 1, i16* %1126, align 8
  %1127 = load i64, i64* %8, align 8
  %1128 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 4
  store i64 %1127, i64* %1128, align 8
  %1129 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 0
  store %struct.opendoor* %866, %struct.opendoor** %1129, align 8
  %1130 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 3
  %1131 = load i8*, i8** %1130, align 8
  %1132 = icmp ne i8* %1131, null
  br i1 %1132, label %1133, label %1148

; <label>:1133:                                   ; preds = %1125
  %1134 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 2
  %1135 = getelementptr inbounds [16 x i8], [16 x i8]* %1134, i32 0, i32 0
  %1136 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 3
  %1137 = load i8*, i8** %1136, align 8
  %1138 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 0
  %1139 = getelementptr inbounds [128 x i8], [128 x i8]* %1138, i32 0, i32 0
  %1140 = getelementptr [22 x i8], [22 x i8]* @.str.174, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %1140, i8* %1135, i8* %1137, i8* %1139)
  %1141 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 2
  %1142 = getelementptr inbounds [16 x i8], [16 x i8]* %1141, i32 0, i32 0
  %1143 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 3
  %1144 = load i8*, i8** %1143, align 8
  %1145 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 0
  %1146 = getelementptr inbounds [128 x i8], [128 x i8]* %1145, i32 0, i32 0
  %1147 = getelementptr [21 x i8], [21 x i8]* @.str.175, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %1147, i8* %1142, i8* %1144, i8* %1146)
  br label %1159

; <label>:1148:                                   ; preds = %1125
  %1149 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 2
  %1150 = getelementptr inbounds [16 x i8], [16 x i8]* %1149, i32 0, i32 0
  %1151 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 0
  %1152 = getelementptr inbounds [128 x i8], [128 x i8]* %1151, i32 0, i32 0
  %1153 = getelementptr [17 x i8], [17 x i8]* @.str.176, i32 0, i32 0
  call void (i8*, ...) @vprint(i8* %1153, i8* %1150, i8* %1152)
  %1154 = getelementptr inbounds %struct.knocker, %struct.knocker* %1100, i32 0, i32 2
  %1155 = getelementptr inbounds [16 x i8], [16 x i8]* %1154, i32 0, i32 0
  %1156 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %866, i32 0, i32 0
  %1157 = getelementptr inbounds [128 x i8], [128 x i8]* %1156, i32 0, i32 0
  %1158 = getelementptr [16 x i8], [16 x i8]* @.str.177, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %1158, i8* %1155, i8* %1157)
  br label %1159

; <label>:1159:                                   ; preds = %1148, %1133
  %1160 = load %struct.__pmlist_t*, %struct.__pmlist_t** @attempts, align 8
  %1161 = bitcast %struct.knocker* %1100 to i8*
  %1162 = call %struct.__pmlist_t* @list_add(%struct.__pmlist_t* %1160, i8* %1161)
  store %struct.__pmlist_t* %1162, %struct.__pmlist_t** @attempts, align 8
  br label %1163

; <label>:1163:                                   ; preds = %1159, %1091, %1082
  br label %1164

; <label>:1164:                                   ; preds = %1163, %1078, %1063, %1043, %1028, %1008, %993, %973, %958, %938, %923, %903, %888
  %1165 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.22224, i32 0, i32 2
  %1166 = load %struct.__pmlist_t*, %struct.__pmlist_t** %1165, align 8
  %1167 = icmp ne %struct.__pmlist_t* %1166, null
  br i1 %1167, label %863, label %._crit_edge

._crit_edge:                                      ; preds = %1164
  br label %1168

; <label>:1168:                                   ; preds = %._crit_edge, %860
  br label %1169

; <label>:1169:                                   ; preds = %25, %48, %55, %60, %71, %1168, %859
  ret void

UnifiedUnreachableBlock:                          ; preds = %1103, %829, %760, %739
  unreachable
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
  br i1 %6, label %7, label %8

; <label>:7:                                      ; preds = %4
  br label %8

; <label>:8:                                      ; preds = %7, %4
  %.02 = phi i64 [ 1, %7 ], [ %1, %4 ]
  %.0 = phi i32 [ 0, %7 ], [ 1, %4 ]
  %9 = getelementptr [5 x i8], [5 x i8]* @.str.128, i32 0, i32 0
  %10 = call i8* @strstr(i8* %2, i8* %9) #10, !track !58
  %11 = icmp ne i8* %10, null
  br i1 %11, label %15, label %12

; <label>:12:                                     ; preds = %8
  %13 = getelementptr inbounds i8, i8* %2, i64 %5
  %14 = getelementptr inbounds i8, i8* %13, i64 1
  br label %15

; <label>:15:                                     ; preds = %12, %8
  %.05 = phi i8* [ %10, %8 ], [ %14, %12 ]
  %16 = load i8, i8* %2, align 1
  %17 = sext i8 %16 to i32
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %.lr.ph32, label %61

.lr.ph32:                                         ; preds = %15
  br label %19

; <label>:19:                                     ; preds = %.lr.ph32, %55
  %.0130 = phi i64 [ 0, %.lr.ph32 ], [ %57, %55 ]
  %.1329 = phi i64 [ %.02, %.lr.ph32 ], [ %.5, %55 ]
  %.1628 = phi i8* [ %.05, %.lr.ph32 ], [ %.38, %55 ]
  %.0927 = phi i8* [ %0, %.lr.ph32 ], [ %.413, %55 ]
  %.01426 = phi i8* [ %2, %.lr.ph32 ], [ %56, %55 ]
  %.01625 = phi i8* [ %3, %.lr.ph32 ], [ %.218, %55 ]
  call void @unroll_loop(i32 11)
  %20 = icmp ult i8* %.01426, %.1628
  br i1 %20, label %21, label %28

; <label>:21:                                     ; preds = %19
  %22 = icmp ne i64 %.1329, 1
  br i1 %22, label %23, label %27

; <label>:23:                                     ; preds = %21
  %24 = load i8, i8* %.01426, align 1
  %25 = getelementptr inbounds i8, i8* %.0927, i32 1
  store i8 %24, i8* %.0927, align 1
  %26 = add i64 %.1329, -1
  br label %27

; <label>:27:                                     ; preds = %23, %21
  %.110 = phi i8* [ %25, %23 ], [ %.0927, %21 ]
  %.24 = phi i64 [ %26, %23 ], [ %.1329, %21 ]
  br label %55

; <label>:28:                                     ; preds = %19
  %29 = load i8, i8* %.01625, align 1
  %30 = sext i8 %29 to i32
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %.lr.ph, label %44

.lr.ph:                                           ; preds = %28
  br label %32

; <label>:32:                                     ; preds = %.lr.ph, %38
  %.122 = phi i64 [ %.0130, %.lr.ph ], [ %40, %38 ]
  %.321 = phi i64 [ %.1329, %.lr.ph ], [ %.4, %38 ]
  %.21120 = phi i8* [ %.0927, %.lr.ph ], [ %.312, %38 ]
  %.11719 = phi i8* [ %.01625, %.lr.ph ], [ %39, %38 ]
  call void @unroll_loop(i32 12)
  %33 = icmp ne i64 %.321, 1
  br i1 %33, label %34, label %38

; <label>:34:                                     ; preds = %32
  %35 = load i8, i8* %.11719, align 1
  %36 = getelementptr inbounds i8, i8* %.21120, i32 1
  store i8 %35, i8* %.21120, align 1
  %37 = add i64 %.321, -1
  br label %38

; <label>:38:                                     ; preds = %34, %32
  %.312 = phi i8* [ %36, %34 ], [ %.21120, %32 ]
  %.4 = phi i64 [ %37, %34 ], [ %.321, %32 ]
  %39 = getelementptr inbounds i8, i8* %.11719, i32 1
  %40 = add i64 %.122, 1
  %41 = load i8, i8* %39, align 1
  %42 = sext i8 %41 to i32
  %43 = icmp ne i32 %42, 0
  br i1 %43, label %32, label %._crit_edge

._crit_edge:                                      ; preds = %38
  %split = phi i8* [ %.312, %38 ]
  %split23 = phi i64 [ %.4, %38 ]
  %split24 = phi i64 [ %40, %38 ]
  br label %44

; <label>:44:                                     ; preds = %._crit_edge, %28
  %.211.lcssa = phi i8* [ %split, %._crit_edge ], [ %.0927, %28 ]
  %.3.lcssa = phi i64 [ %split23, %._crit_edge ], [ %.1329, %28 ]
  %.1.lcssa = phi i64 [ %split24, %._crit_edge ], [ %.0130, %28 ]
  %45 = getelementptr inbounds i8, i8* %.01426, i64 4
  %46 = getelementptr [5 x i8], [5 x i8]* @.str.128, i32 0, i32 0
  %47 = call i8* @strstr(i8* %45, i8* %46) #10, !track !59
  %48 = icmp ne i8* %47, null
  br i1 %48, label %52, label %49

; <label>:49:                                     ; preds = %44
  %50 = getelementptr inbounds i8, i8* %45, i64 %5
  %51 = getelementptr inbounds i8, i8* %50, i64 1
  br label %52

; <label>:52:                                     ; preds = %49, %44
  %.27 = phi i8* [ %47, %44 ], [ %51, %49 ]
  %53 = getelementptr inbounds i8, i8* %45, i32 -1
  %54 = add i64 %.1.lcssa, -1
  br label %55

; <label>:55:                                     ; preds = %52, %27
  %.218 = phi i8* [ %.01625, %27 ], [ %3, %52 ]
  %.115 = phi i8* [ %.01426, %27 ], [ %53, %52 ]
  %.413 = phi i8* [ %.110, %27 ], [ %.211.lcssa, %52 ]
  %.38 = phi i8* [ %.1628, %27 ], [ %.27, %52 ]
  %.5 = phi i64 [ %.24, %27 ], [ %.3.lcssa, %52 ]
  %.2 = phi i64 [ %.0130, %27 ], [ %54, %52 ]
  %56 = getelementptr inbounds i8, i8* %.115, i32 1
  %57 = add i64 %.2, 1
  %58 = load i8, i8* %56, align 1
  %59 = sext i8 %58 to i32
  %60 = icmp ne i32 %59, 0
  br i1 %60, label %19, label %._crit_edge33

._crit_edge33:                                    ; preds = %55
  %split34 = phi i8* [ %.413, %55 ]
  %split35 = phi i64 [ %57, %55 ]
  br label %61

; <label>:61:                                     ; preds = %._crit_edge33, %15
  %.09.lcssa = phi i8* [ %split34, %._crit_edge33 ], [ %0, %15 ]
  %.01.lcssa = phi i64 [ %split35, %._crit_edge33 ], [ 0, %15 ]
  %62 = icmp ne i32 %.0, 0
  br i1 %62, label %63, label %64

; <label>:63:                                     ; preds = %61
  store i8 0, i8* %.09.lcssa, align 1
  br label %64

; <label>:64:                                     ; preds = %63, %61
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
  %8 = icmp eq i32 %7, -1
  br i1 %8, label %9, label %14

; <label>:9:                                      ; preds = %2
  %10 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %11 = getelementptr [29 x i8], [29 x i8]* @.str.130, i32 0, i32 0
  %12 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %10, i8* %11)
  %13 = getelementptr [28 x i8], [28 x i8]* @.str.131, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %13)
  br label %32

; <label>:14:                                     ; preds = %2
  %15 = icmp ne i32 %7, 0
  br i1 %15, label %16, label %31

; <label>:16:                                     ; preds = %14
  %17 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %18 = bitcast %struct.in_addr* %3 to i32*
  store i32 %7, i32* %18, align 4
  %19 = bitcast %struct.in_addr* %3 to i32*
  %20 = load i32, i32* %19, align 4
  %21 = and i32 %20, 65280
  %22 = ashr i32 %21, 8
  %23 = getelementptr [48 x i8], [48 x i8]* @.str.132, i32 0, i32 0
  %24 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %17, i8* %23, i8* %1, i32 %22)
  %25 = bitcast %struct.in_addr* %4 to i32*
  store i32 %7, i32* %25, align 4
  %26 = bitcast %struct.in_addr* %4 to i32*
  %27 = load i32, i32* %26, align 4
  %28 = and i32 %27, 65280
  %29 = ashr i32 %28, 8
  %30 = getelementptr [47 x i8], [47 x i8]* @.str.133, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %30, i8* %1, i32 %29)
  br label %31

; <label>:31:                                     ; preds = %16, %14
  br label %32

; <label>:32:                                     ; preds = %31, %9
  ret i32 %7
}

declare dso_local i32 @sleep(i32) #5

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @disable_used_one_time_sequence(%struct.opendoor*) #0 {
  %2 = call i64 @get_current_one_time_sequence_position(%struct.opendoor* %0)
  %3 = icmp sge i64 %2, 0
  br i1 %3, label %4, label %33

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
  br label %34

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
  br label %34

; <label>:32:                                     ; preds = %18
  br label %33

; <label>:33:                                     ; preds = %32, %1
  br label %34

; <label>:34:                                     ; preds = %33, %23, %9
  %.0 = phi i32 [ 1, %9 ], [ 1, %23 ], [ 0, %33 ]
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
  %2 = alloca [101 x i8], align 16, !track !60
  %3 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %4 = load %struct._IO_FILE*, %struct._IO_FILE** %3, align 8
  %5 = call i64 @ftell(%struct._IO_FILE* %4)
  %6 = trunc i64 %5 to i32
  %7 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %8 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %9 = load %struct._IO_FILE*, %struct._IO_FILE** %8, align 8
  %10 = call i8* @fgets(i8* %7, i32 100, %struct._IO_FILE* %9), !track !61
  %11 = icmp ne i8* %10, null
  br i1 %11, label %.lr.ph.lr.ph, label %.outer._crit_edge

.lr.ph.lr.ph:                                     ; preds = %1
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.lr.ph, %.outer
  %.01.ph3 = phi i32 [ %6, %.lr.ph.lr.ph ], [ %30, %.outer ]
  call void @unroll_loop(i32 13)
  br label %16

; <label>:12:                                     ; preds = %34
  %13 = load %struct._IO_FILE*, %struct._IO_FILE** %8, align 8
  %14 = call i8* @fgets(i8* %7, i32 100, %struct._IO_FILE* %13), !track !62
  %15 = icmp ne i8* %14, null
  br i1 %15, label %16, label %._crit_edge

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
  %32 = call i8* @fgets(i8* %7, i32 100, %struct._IO_FILE* %31), !track !63
  %33 = icmp ne i8* %32, null
  br i1 %33, label %.lr.ph, label %.outer..outer._crit_edge_crit_edge

; <label>:34:                                     ; preds = %22
  %35 = getelementptr inbounds [101 x i8], [101 x i8]* %2, i32 0, i32 0
  %36 = call i32 @parse_port_sequence(i8* %35, %struct.opendoor* %0)
  %37 = icmp sgt i32 %36, 0
  br i1 %37, label %12, label %38

; <label>:38:                                     ; preds = %34
  %.01.lcssa2 = phi i32 [ %.01.ph3, %34 ]
  %39 = sext i32 %.01.lcssa2 to i64
  br label %41

.outer..outer._crit_edge_crit_edge:               ; preds = %.outer
  br label %.outer._crit_edge

.outer._crit_edge:                                ; preds = %.outer..outer._crit_edge_crit_edge, %1
  br label %40

._crit_edge:                                      ; preds = %12
  br label %40

; <label>:40:                                     ; preds = %._crit_edge, %.outer._crit_edge
  br label %41

; <label>:41:                                     ; preds = %40, %38
  %.0 = phi i64 [ %39, %38 ], [ -1, %40 ]
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
  br i1 %5, label %6, label %64

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
  br i1 %16, label %.lr.ph, label %61

.lr.ph:                                           ; preds = %6
  br label %17

; <label>:17:                                     ; preds = %.lr.ph, %56
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %56 ]
  call void @unroll_loop(i32 18)
  %18 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 3
  %19 = getelementptr inbounds [32 x i16], [32 x i16]* %18, i64 0, i64 %indvars.iv
  %20 = load i16, i16* %19, align 2
  %21 = zext i16 %20 to i32
  switch i32 %21, label %39 [
    i32 17, label %22
    i32 6, label %38
  ]

; <label>:22:                                     ; preds = %17
  %23 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  %24 = load i16, i16* %23, align 8
  %25 = zext i16 %24 to i32
  %26 = sub nsw i32 %25, 1
  %27 = zext i32 %26 to i64
  %28 = icmp eq i64 %indvars.iv, %27
  %29 = zext i1 %28 to i64
  %30 = getelementptr [8 x i8], [8 x i8]* @.str.30, i32 0, i32 0
  %31 = getelementptr [8 x i8], [8 x i8]* @.str.31, i32 0, i32 0
  %32 = select i1 %28, i8* %30, i8* %31
  %33 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 2
  %34 = getelementptr inbounds [32 x i16], [32 x i16]* %33, i64 0, i64 %indvars.iv
  %35 = load i16, i16* %34, align 2
  %36 = zext i16 %35 to i32
  %37 = call i32 (i8*, ...) @printf(i8* %32, i32 %36)
  br label %55

; <label>:38:                                     ; preds = %17
  br label %39

; <label>:39:                                     ; preds = %17, %38
  %40 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  %41 = load i16, i16* %40, align 8
  %42 = zext i16 %41 to i32
  %43 = sub nsw i32 %42, 1
  %44 = zext i32 %43 to i64
  %45 = icmp eq i64 %indvars.iv, %44
  %46 = zext i1 %45 to i64
  %47 = getelementptr [8 x i8], [8 x i8]* @.str.32, i32 0, i32 0
  %48 = getelementptr [8 x i8], [8 x i8]* @.str.33, i32 0, i32 0
  %49 = select i1 %45, i8* %47, i8* %48
  %50 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 2
  %51 = getelementptr inbounds [32 x i16], [32 x i16]* %50, i64 0, i64 %indvars.iv
  %52 = load i16, i16* %51, align 2
  %53 = zext i16 %52 to i32
  %54 = call i32 (i8*, ...) @printf(i8* %49, i32 %53)
  br label %55

; <label>:55:                                     ; preds = %39, %22
  br label %56

; <label>:56:                                     ; preds = %55
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %57 = load i16, i16* %13, align 8
  %58 = zext i16 %57 to i32
  %59 = zext i32 %58 to i64
  %60 = icmp ult i64 %indvars.iv.next, %59
  br i1 %60, label %17, label %._crit_edge

._crit_edge:                                      ; preds = %56
  br label %61

; <label>:61:                                     ; preds = %._crit_edge, %6
  %62 = load %struct._IO_FILE*, %struct._IO_FILE** @stdout, align 8
  %63 = call i32 @fflush(%struct._IO_FILE* %62)
  br label %64

; <label>:64:                                     ; preds = %61, %2
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
  call void @llvm.memmove.p0i8.p0i8.i64(i8* align 1 %0, i8* align 1 %.0.lcssa, i64 %18, i1 false), !track !64
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
  %3 = alloca i8*, align 8, !track !65
  %4 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  %5 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  store i16 0, i16* %5, align 8
  %6 = getelementptr [2 x i8], [2 x i8]* @.str.86, i32 0, i32 0
  %7 = call i8* @strsep(i8** %3, i8* %6) #7
  store i8* %7, i8** %4, align 8
  %8 = icmp ne i8* %7, null
  br i1 %8, label %.lr.ph, label %86

.lr.ph:                                           ; preds = %2
  br label %9

; <label>:9:                                      ; preds = %.lr.ph, %82
  call void @unroll_loop(i32 21)
  %10 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %11 = load i16, i16* %10, align 8
  %12 = zext i16 %11 to i32
  %13 = icmp sge i32 %12, 32
  br i1 %13, label %14, label %23

; <label>:14:                                     ; preds = %9
  %15 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %16 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 0
  %17 = getelementptr inbounds [128 x i8], [128 x i8]* %16, i32 0, i32 0
  %18 = getelementptr [54 x i8], [54 x i8]* @.str.102, i32 0, i32 0
  %19 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %15, i8* %18, i8* %17)
  %20 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 0
  %21 = getelementptr inbounds [128 x i8], [128 x i8]* %20, i32 0, i32 0
  %22 = getelementptr [53 x i8], [53 x i8]* @.str.103, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %22, i8* %21)
  br label %87

; <label>:23:                                     ; preds = %9
  %24 = getelementptr [2 x i8], [2 x i8]* @.str.104, i32 0, i32 0
  %25 = call i8* @strsep(i8** %4, i8* %24) #7
  %26 = call i32 @atoi(i8* %25) #10
  %27 = trunc i32 %26 to i16
  %28 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 2
  %29 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %30 = load i16, i16* %29, align 8
  %31 = add i16 %30, 1
  store i16 %31, i16* %29, align 8
  %32 = zext i16 %30 to i64
  %33 = getelementptr inbounds [32 x i16], [32 x i16]* %28, i64 0, i64 %32
  store i16 %27, i16* %33, align 2
  %34 = getelementptr [2 x i8], [2 x i8]* @.str.104, i32 0, i32 0
  %35 = call i8* @strsep(i8** %4, i8* %34) #7
  %36 = icmp ne i8* %35, null
  br i1 %36, label %37, label %74

; <label>:37:                                     ; preds = %23
  %38 = call i8* @trim(i8* %35)
  %39 = call i8* @strtoupper(i8* %38)
  %40 = getelementptr [4 x i8], [4 x i8]* @.str.105, i32 0, i32 0
  %41 = call i32 @strcmp(i8* %39, i8* %40) #10
  %42 = icmp ne i32 %41, 0
  br i1 %42, label %51, label %43

; <label>:43:                                     ; preds = %37
  %44 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 3
  %45 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %46 = load i16, i16* %45, align 8
  %47 = zext i16 %46 to i32
  %48 = sub nsw i32 %47, 1
  %49 = sext i32 %48 to i64
  %50 = getelementptr inbounds [32 x i16], [32 x i16]* %44, i64 0, i64 %49
  store i16 6, i16* %50, align 2
  br label %73

; <label>:51:                                     ; preds = %37
  %52 = getelementptr [4 x i8], [4 x i8]* @.str.106, i32 0, i32 0
  %53 = call i32 @strcmp(i8* %39, i8* %52) #10
  %54 = icmp ne i32 %53, 0
  br i1 %54, label %63, label %55

; <label>:55:                                     ; preds = %51
  %56 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 3
  %57 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %58 = load i16, i16* %57, align 8
  %59 = zext i16 %58 to i32
  %60 = sub nsw i32 %59, 1
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds [32 x i16], [32 x i16]* %56, i64 0, i64 %61
  store i16 17, i16* %62, align 2
  br label %72

; <label>:63:                                     ; preds = %51
  %64 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8
  %65 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 0
  %66 = getelementptr inbounds [128 x i8], [128 x i8]* %65, i32 0, i32 0
  %67 = getelementptr [56 x i8], [56 x i8]* @.str.107, i32 0, i32 0
  %68 = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %64, i8* %67, i8* %66)
  %69 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 0
  %70 = getelementptr inbounds [128 x i8], [128 x i8]* %69, i32 0, i32 0
  %71 = getelementptr [55 x i8], [55 x i8]* @.str.108, i32 0, i32 0
  call void (i8*, ...) @logprint(i8* %71, i8* %70)
  br label %87

; <label>:72:                                     ; preds = %55
  br label %73

; <label>:73:                                     ; preds = %72, %43
  br label %82

; <label>:74:                                     ; preds = %23
  %75 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 3
  %76 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %1, i32 0, i32 1
  %77 = load i16, i16* %76, align 8
  %78 = zext i16 %77 to i32
  %79 = sub nsw i32 %78, 1
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds [32 x i16], [32 x i16]* %75, i64 0, i64 %80
  store i16 6, i16* %81, align 2
  br label %82

; <label>:82:                                     ; preds = %74, %73
  %83 = getelementptr [2 x i8], [2 x i8]* @.str.86, i32 0, i32 0
  %84 = call i8* @strsep(i8** %3, i8* %83) #7
  store i8* %84, i8** %4, align 8
  %85 = icmp ne i8* %84, null
  br i1 %85, label %9, label %._crit_edge

._crit_edge:                                      ; preds = %82
  br label %86

; <label>:86:                                     ; preds = %._crit_edge, %2
  br label %87

; <label>:87:                                     ; preds = %86, %63, %14
  %.0 = phi i32 [ 1, %14 ], [ 1, %63 ], [ 0, %86 ]
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
  br i1 %3, label %.lr.ph, label %12

.lr.ph:                                           ; preds = %1
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %4
  %.01 = phi i8* [ %0, %.lr.ph ], [ %9, %4 ]
  call void @unroll_loop(i32 22)
  %5 = load i8, i8* %.01, align 1
  %6 = sext i8 %5 to i32
  %7 = call i32 @toupper(i32 %6) #10
  %8 = trunc i32 %7 to i8
  store i8 %8, i8* %.01, align 1
  %9 = getelementptr inbounds i8, i8* %.01, i32 1
  %10 = load i8, i8* %9, align 1
  %11 = icmp ne i8 %10, 0
  br i1 %11, label %4, label %._crit_edge

._crit_edge:                                      ; preds = %4
  br label %12

; <label>:12:                                     ; preds = %._crit_edge, %1
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
  %2 = alloca %struct.opendoor, align 8, !track !66
  %3 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %4 = load %struct._IO_FILE*, %struct._IO_FILE** %3, align 8
  call void @rewind(%struct._IO_FILE* %4)
  %5 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 14
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** %5, align 8
  %7 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %2, i32 0, i32 14
  store %struct._IO_FILE* %6, %struct._IO_FILE** %7, align 8
  %8 = call i64 @get_next_one_time_sequence(%struct.opendoor* %2)
  %9 = icmp sge i64 %8, 0
  br i1 %9, label %.lr.ph, label %47

.lr.ph:                                           ; preds = %1
  br label %10

; <label>:10:                                     ; preds = %.lr.ph, %44
  %.013 = phi i64 [ %8, %.lr.ph ], [ %45, %44 ]
  call void @unroll_loop(i32 23)
  %11 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  %12 = load i16, i16* %11, align 8
  %13 = zext i16 %12 to i32
  %14 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %2, i32 0, i32 1
  %15 = load i16, i16* %14, align 8
  %16 = zext i16 %15 to i32
  %17 = icmp eq i32 %13, %16
  br i1 %17, label %18, label %44

; <label>:18:                                     ; preds = %10
  %19 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 2
  %20 = getelementptr inbounds [32 x i16], [32 x i16]* %19, i32 0, i32 0
  %21 = bitcast i16* %20 to i8*
  %22 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %2, i32 0, i32 2
  %23 = getelementptr inbounds [32 x i16], [32 x i16]* %22, i32 0, i32 0
  %24 = bitcast i16* %23 to i8*
  %25 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  %26 = load i16, i16* %25, align 8
  %27 = zext i16 %26 to i64
  %28 = call i32 @memcmp(i8* %21, i8* %24, i64 %27) #10
  %29 = icmp eq i32 %28, 0
  br i1 %29, label %30, label %43

; <label>:30:                                     ; preds = %18
  %31 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 3
  %32 = getelementptr inbounds [32 x i16], [32 x i16]* %31, i32 0, i32 0
  %33 = bitcast i16* %32 to i8*
  %34 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %2, i32 0, i32 3
  %35 = getelementptr inbounds [32 x i16], [32 x i16]* %34, i32 0, i32 0
  %36 = bitcast i16* %35 to i8*
  %37 = getelementptr inbounds %struct.opendoor, %struct.opendoor* %0, i32 0, i32 1
  %38 = load i16, i16* %37, align 8
  %39 = zext i16 %38 to i64
  %40 = call i32 @memcmp(i8* %33, i8* %36, i64 %39) #10
  %41 = icmp eq i32 %40, 0
  br i1 %41, label %42, label %43

; <label>:42:                                     ; preds = %30
  %.01.lcssa2 = phi i64 [ %.013, %30 ]
  br label %48

; <label>:43:                                     ; preds = %30, %18
  br label %44

; <label>:44:                                     ; preds = %43, %10
  %45 = call i64 @get_next_one_time_sequence(%struct.opendoor* %2)
  %46 = icmp sge i64 %45, 0
  br i1 %46, label %10, label %._crit_edge

._crit_edge:                                      ; preds = %44
  br label %47

; <label>:47:                                     ; preds = %._crit_edge, %1
  br label %48

; <label>:48:                                     ; preds = %47, %42
  %.0 = phi i64 [ %.01.lcssa2, %42 ], [ -1, %47 ]
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
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %3
  br label %28

; <label>:6:                                      ; preds = %3
  %7 = load i8*, i8** %0, align 8
  %8 = call i64 @strlen(i8* %7) #10
  %9 = call i64 @strlen(i8* %1) #10
  %10 = add i64 %8, %9
  %11 = add i64 %10, 1
  %12 = icmp ugt i64 %11, %2
  br i1 %12, label %.lr.ph, label %16

.lr.ph:                                           ; preds = %6
  br label %13

; <label>:13:                                     ; preds = %.lr.ph, %13
  %.012 = phi i64 [ %2, %.lr.ph ], [ %14, %13 ]
  call void @unroll_loop(i32 24)
  %14 = mul i64 %.012, 2
  %15 = icmp ugt i64 %11, %14
  br i1 %15, label %13, label %._crit_edge

._crit_edge:                                      ; preds = %13
  %split = phi i64 [ %14, %13 ]
  br label %16

; <label>:16:                                     ; preds = %._crit_edge, %6
  %.01.lcssa = phi i64 [ %split, %._crit_edge ], [ %2, %6 ]
  %17 = icmp ne i64 %.01.lcssa, %2
  br i1 %17, label %18, label %25

; <label>:18:                                     ; preds = %16
  %19 = load i8*, i8** %0, align 8
  %20 = call i8* @realloc(i8* %19, i64 %.01.lcssa) #7, !track !67
  store i8* %20, i8** %0, align 8
  %21 = load i8*, i8** %0, align 8
  %22 = icmp eq i8* %21, null
  br i1 %22, label %23, label %24

; <label>:23:                                     ; preds = %18
  br label %28

; <label>:24:                                     ; preds = %18
  br label %25

; <label>:25:                                     ; preds = %24, %16
  %26 = load i8*, i8** %0, align 8
  %27 = call i8* @strcat(i8* %26, i8* %1) #7, !track !68
  br label %28

; <label>:28:                                     ; preds = %25, %23, %5
  %.0 = phi i64 [ 0, %5 ], [ 0, %23 ], [ %.01.lcssa, %25 ]
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
  %1 = call noalias i8* @malloc(i64 24) #7, !track !69
  %2 = bitcast i8* %1 to %struct.__pmlist_t*
  %3 = icmp eq %struct.__pmlist_t* %2, null
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %0
  br label %9

; <label>:5:                                      ; preds = %0
  %6 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %2, i32 0, i32 0
  store i8* null, i8** %6, align 8
  %7 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %2, i32 0, i32 1
  store %struct.__pmlist_t* null, %struct.__pmlist_t** %7, align 8
  %8 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %2, i32 0, i32 2
  store %struct.__pmlist_t* null, %struct.__pmlist_t** %8, align 8
  br label %9

; <label>:9:                                      ; preds = %5, %4
  %.0 = phi %struct.__pmlist_t* [ null, %4 ], [ %2, %5 ]
  ret %struct.__pmlist_t* %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local void @list_free(%struct.__pmlist_t*) #0 {
  %2 = icmp eq %struct.__pmlist_t* %0, null
  br i1 %2, label %3, label %4

; <label>:3:                                      ; preds = %1
  br label %21

; <label>:4:                                      ; preds = %1
  %5 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %0, i32 0, i32 0
  %6 = load i8*, i8** %5, align 8
  %7 = icmp ne i8* %6, null
  br i1 %7, label %8, label %12

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %0, i32 0, i32 0
  %10 = load i8*, i8** %9, align 8
  call void @free(i8* %10) #7
  %11 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %0, i32 0, i32 0
  store i8* null, i8** %11, align 8
  br label %12

; <label>:12:                                     ; preds = %8, %4
  %13 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %0, i32 0, i32 2
  %14 = load %struct.__pmlist_t*, %struct.__pmlist_t** %13, align 8
  %15 = icmp ne %struct.__pmlist_t* %14, null
  br i1 %15, label %16, label %19

; <label>:16:                                     ; preds = %12
  %17 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %0, i32 0, i32 2
  %18 = load %struct.__pmlist_t*, %struct.__pmlist_t** %17, align 8
  call void @list_free(%struct.__pmlist_t* %18)
  br label %19

; <label>:19:                                     ; preds = %16, %12
  %20 = bitcast %struct.__pmlist_t* %0 to i8*
  call void @free(i8* %20) #7
  br label %21

; <label>:21:                                     ; preds = %19, %3
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
  br i1 %8, label %9, label %14

; <label>:9:                                      ; preds = %6
  %10 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %7, i32 0, i32 0
  %11 = load i8*, i8** %10, align 8
  %12 = icmp eq i8* %11, null
  br i1 %12, label %13, label %14

; <label>:13:                                     ; preds = %9
  br label %27

; <label>:14:                                     ; preds = %9, %6
  %15 = call %struct.__pmlist_t* @list_new()
  %16 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %7, i32 0, i32 2
  store %struct.__pmlist_t* %15, %struct.__pmlist_t** %16, align 8
  %17 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %7, i32 0, i32 2
  %18 = load %struct.__pmlist_t*, %struct.__pmlist_t** %17, align 8
  %19 = icmp eq %struct.__pmlist_t* %18, null
  br i1 %19, label %20, label %21

; <label>:20:                                     ; preds = %14
  br label %29

; <label>:21:                                     ; preds = %14
  %22 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %7, i32 0, i32 2
  %23 = load %struct.__pmlist_t*, %struct.__pmlist_t** %22, align 8
  %24 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %23, i32 0, i32 1
  store %struct.__pmlist_t* %7, %struct.__pmlist_t** %24, align 8
  %25 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %7, i32 0, i32 2
  %26 = load %struct.__pmlist_t*, %struct.__pmlist_t** %25, align 8
  br label %27

; <label>:27:                                     ; preds = %21, %13
  %.01 = phi %struct.__pmlist_t* [ %7, %13 ], [ %26, %21 ]
  %28 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.01, i32 0, i32 0
  store i8* %1, i8** %28, align 8
  br label %29

; <label>:29:                                     ; preds = %27, %20
  %.0 = phi %struct.__pmlist_t* [ %.02, %27 ], [ null, %20 ]
  ret %struct.__pmlist_t* %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.__pmlist_t* @list_last(%struct.__pmlist_t*) #8 {
  br label %2

; <label>:2:                                      ; preds = %11, %1
  %.0 = phi %struct.__pmlist_t* [ %0, %1 ], [ %13, %11 ]
  call void @unroll_loop(i32 25)
  %3 = icmp ne %struct.__pmlist_t* %.0, null
  br i1 %3, label %4, label %8

; <label>:4:                                      ; preds = %2
  %5 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.0, i32 0, i32 2
  %6 = load %struct.__pmlist_t*, %struct.__pmlist_t** %5, align 8
  %7 = icmp ne %struct.__pmlist_t* %6, null
  br label %8

; <label>:8:                                      ; preds = %4, %2
  %9 = phi i1 [ false, %2 ], [ %7, %4 ]
  br i1 %9, label %10, label %14

; <label>:10:                                     ; preds = %8
  br label %11

; <label>:11:                                     ; preds = %10
  %12 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.0, i32 0, i32 2
  %13 = load %struct.__pmlist_t*, %struct.__pmlist_t** %12, align 8
  br label %2

; <label>:14:                                     ; preds = %8
  %.0.lcssa = phi %struct.__pmlist_t* [ %.0, %8 ]
  ret %struct.__pmlist_t* %.0.lcssa
}

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.__pmlist_t* @list_remove(%struct.__pmlist_t*, i8*) #8 {
  %3 = icmp ne %struct.__pmlist_t* %0, null
  br i1 %3, label %.lr.ph, label %39

.lr.ph:                                           ; preds = %2
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %35
  %.03 = phi %struct.__pmlist_t* [ %0, %.lr.ph ], [ %37, %35 ]
  %.012 = phi %struct.__pmlist_t* [ %0, %.lr.ph ], [ %.2, %35 ]
  call void @unroll_loop(i32 26)
  %5 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 0
  %6 = load i8*, i8** %5, align 8
  %7 = icmp eq i8* %6, %1
  br i1 %7, label %8, label %34

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 1
  %10 = load %struct.__pmlist_t*, %struct.__pmlist_t** %9, align 8
  %11 = icmp ne %struct.__pmlist_t* %10, null
  br i1 %11, label %12, label %18

; <label>:12:                                     ; preds = %8
  %13 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 2
  %14 = load %struct.__pmlist_t*, %struct.__pmlist_t** %13, align 8
  %15 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 1
  %16 = load %struct.__pmlist_t*, %struct.__pmlist_t** %15, align 8
  %17 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %16, i32 0, i32 2
  store %struct.__pmlist_t* %14, %struct.__pmlist_t** %17, align 8
  br label %18

; <label>:18:                                     ; preds = %12, %8
  %19 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 2
  %20 = load %struct.__pmlist_t*, %struct.__pmlist_t** %19, align 8
  %21 = icmp ne %struct.__pmlist_t* %20, null
  br i1 %21, label %22, label %28

; <label>:22:                                     ; preds = %18
  %23 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 1
  %24 = load %struct.__pmlist_t*, %struct.__pmlist_t** %23, align 8
  %25 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 2
  %26 = load %struct.__pmlist_t*, %struct.__pmlist_t** %25, align 8
  %27 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %26, i32 0, i32 1
  store %struct.__pmlist_t* %24, %struct.__pmlist_t** %27, align 8
  br label %28

; <label>:28:                                     ; preds = %22, %18
  %29 = icmp eq %struct.__pmlist_t* %.03, %.012
  br i1 %29, label %30, label %33

; <label>:30:                                     ; preds = %28
  %31 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 2
  %32 = load %struct.__pmlist_t*, %struct.__pmlist_t** %31, align 8
  br label %33

; <label>:33:                                     ; preds = %30, %28
  %.1 = phi %struct.__pmlist_t* [ %32, %30 ], [ %.012, %28 ]
  br label %34

; <label>:34:                                     ; preds = %33, %4
  %.2 = phi %struct.__pmlist_t* [ %.1, %33 ], [ %.012, %4 ]
  br label %35

; <label>:35:                                     ; preds = %34
  %36 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 2
  %37 = load %struct.__pmlist_t*, %struct.__pmlist_t** %36, align 8
  %38 = icmp ne %struct.__pmlist_t* %37, null
  br i1 %38, label %4, label %._crit_edge

._crit_edge:                                      ; preds = %35
  %split = phi %struct.__pmlist_t* [ %.2, %35 ]
  br label %39

; <label>:39:                                     ; preds = %._crit_edge, %2
  %.01.lcssa = phi %struct.__pmlist_t* [ %split, %._crit_edge ], [ %0, %2 ]
  ret %struct.__pmlist_t* %.01.lcssa
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @list_count(%struct.__pmlist_t*) #0 {
  %2 = icmp ne %struct.__pmlist_t* %0, null
  br i1 %2, label %.lr.ph, label %9

.lr.ph:                                           ; preds = %1
  br label %3

; <label>:3:                                      ; preds = %.lr.ph, %4
  %.03 = phi %struct.__pmlist_t* [ %0, %.lr.ph ], [ %6, %4 ]
  %.012 = phi i32 [ 0, %.lr.ph ], [ %7, %4 ]
  br label %4

; <label>:4:                                      ; preds = %3
  %5 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.03, i32 0, i32 2
  %6 = load %struct.__pmlist_t*, %struct.__pmlist_t** %5, align 8
  %7 = add nuw nsw i32 %.012, 1
  %8 = icmp ne %struct.__pmlist_t* %6, null
  br i1 %8, label %3, label %._crit_edge

._crit_edge:                                      ; preds = %4
  %split = phi i32 [ %7, %4 ]
  br label %9

; <label>:9:                                      ; preds = %._crit_edge, %1
  %.01.lcssa = phi i32 [ %split, %._crit_edge ], [ 0, %1 ]
  ret i32 %.01.lcssa
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @list_isin(%struct.__pmlist_t*, i8*) #0 {
  %3 = icmp ne %struct.__pmlist_t* %0, null
  br i1 %3, label %.lr.ph, label %14

.lr.ph:                                           ; preds = %2
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %10
  %.012 = phi %struct.__pmlist_t* [ %0, %.lr.ph ], [ %12, %10 ]
  %5 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.012, i32 0, i32 0
  %6 = load i8*, i8** %5, align 8
  %7 = icmp eq i8* %6, %1
  br i1 %7, label %8, label %9

; <label>:8:                                      ; preds = %4
  br label %15

; <label>:9:                                      ; preds = %4
  br label %10

; <label>:10:                                     ; preds = %9
  %11 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.012, i32 0, i32 2
  %12 = load %struct.__pmlist_t*, %struct.__pmlist_t** %11, align 8
  %13 = icmp ne %struct.__pmlist_t* %12, null
  br i1 %13, label %4, label %._crit_edge

._crit_edge:                                      ; preds = %10
  br label %14

; <label>:14:                                     ; preds = %._crit_edge, %2
  br label %15

; <label>:15:                                     ; preds = %14, %8
  %.0 = phi i32 [ 1, %8 ], [ 0, %14 ]
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @is_in(i8*, %struct.__pmlist_t*) #0 {
  %3 = icmp ne %struct.__pmlist_t* %1, null
  br i1 %3, label %.lr.ph, label %19

.lr.ph:                                           ; preds = %2
  br label %4

; <label>:4:                                      ; preds = %.lr.ph, %15
  %.012 = phi %struct.__pmlist_t* [ %1, %.lr.ph ], [ %17, %15 ]
  %5 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.012, i32 0, i32 0
  %6 = load i8*, i8** %5, align 8
  %7 = icmp ne i8* %6, null
  br i1 %7, label %8, label %14

; <label>:8:                                      ; preds = %4
  %9 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.012, i32 0, i32 0
  %10 = load i8*, i8** %9, align 8
  %11 = call i32 @strcmp(i8* %10, i8* %0) #10
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %14, label %13

; <label>:13:                                     ; preds = %8
  br label %20

; <label>:14:                                     ; preds = %8, %4
  br label %15

; <label>:15:                                     ; preds = %14
  %16 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.012, i32 0, i32 2
  %17 = load %struct.__pmlist_t*, %struct.__pmlist_t** %16, align 8
  %18 = icmp ne %struct.__pmlist_t* %17, null
  br i1 %18, label %4, label %._crit_edge

._crit_edge:                                      ; preds = %15
  br label %19

; <label>:19:                                     ; preds = %._crit_edge, %2
  br label %20

; <label>:20:                                     ; preds = %19, %13
  %.0 = phi i32 [ 1, %13 ], [ 0, %19 ]
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local %struct.__pmlist_t* @list_merge(%struct.__pmlist_t*, %struct.__pmlist_t*) #0 {
  %3 = icmp eq %struct.__pmlist_t* %1, null
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %2
  br label %26

; <label>:5:                                      ; preds = %2
  %6 = icmp eq %struct.__pmlist_t* %0, null
  br i1 %6, label %7, label %9

; <label>:7:                                      ; preds = %5
  %8 = call %struct.__pmlist_t* @list_new()
  br label %9

; <label>:9:                                      ; preds = %7, %5
  %.01 = phi %struct.__pmlist_t* [ %8, %7 ], [ %0, %5 ]
  %10 = icmp ne %struct.__pmlist_t* %1, null
  br i1 %10, label %.lr.ph, label %25

.lr.ph:                                           ; preds = %9
  br label %11

; <label>:11:                                     ; preds = %.lr.ph, %21
  %.14 = phi %struct.__pmlist_t* [ %.01, %.lr.ph ], [ %.2, %21 ]
  %.023 = phi %struct.__pmlist_t* [ %1, %.lr.ph ], [ %23, %21 ]
  call void @unroll_loop(i32 27)
  %12 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.023, i32 0, i32 0
  %13 = load i8*, i8** %12, align 8
  %14 = icmp ne i8* %13, null
  br i1 %14, label %15, label %20

; <label>:15:                                     ; preds = %11
  %16 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.023, i32 0, i32 0
  %17 = load i8*, i8** %16, align 8
  %18 = call %struct.__pmlist_t* @list_add(%struct.__pmlist_t* %.14, i8* %17)
  %19 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.023, i32 0, i32 0
  store i8* null, i8** %19, align 8
  br label %20

; <label>:20:                                     ; preds = %15, %11
  %.2 = phi %struct.__pmlist_t* [ %18, %15 ], [ %.14, %11 ]
  br label %21

; <label>:21:                                     ; preds = %20
  %22 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.023, i32 0, i32 2
  %23 = load %struct.__pmlist_t*, %struct.__pmlist_t** %22, align 8
  %24 = icmp ne %struct.__pmlist_t* %23, null
  br i1 %24, label %11, label %._crit_edge

._crit_edge:                                      ; preds = %21
  %split = phi %struct.__pmlist_t* [ %.2, %21 ]
  br label %25

; <label>:25:                                     ; preds = %._crit_edge, %9
  %.1.lcssa = phi %struct.__pmlist_t* [ %split, %._crit_edge ], [ %.01, %9 ]
  br label %26

; <label>:26:                                     ; preds = %25, %4
  %.0 = phi %struct.__pmlist_t* [ %0, %4 ], [ %.1.lcssa, %25 ]
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
  br i1 %2, label %3, label %4

; <label>:3:                                      ; preds = %1
  br label %34

; <label>:4:                                      ; preds = %1
  %5 = call i32 @list_count(%struct.__pmlist_t* %0)
  %6 = zext i32 %5 to i64
  %7 = mul i64 %6, 8
  %8 = call noalias i8* @malloc(i64 %7) #7
  %9 = bitcast i8* %8 to i8**
  %10 = icmp ne %struct.__pmlist_t* %0, null
  br i1 %10, label %.lr.ph9, label %19

.lr.ph9:                                          ; preds = %4
  br label %11

; <label>:11:                                     ; preds = %.lr.ph9, %15
  %indvars.iv11 = phi i64 [ 0, %.lr.ph9 ], [ %indvars.iv.next12, %15 ]
  %.026 = phi %struct.__pmlist_t* [ %0, %.lr.ph9 ], [ %17, %15 ]
  %12 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.026, i32 0, i32 0
  %13 = load i8*, i8** %12, align 8
  %indvars.iv.next12 = add nuw i64 %indvars.iv11, 1
  %14 = getelementptr inbounds i8*, i8** %9, i64 %indvars.iv11
  store i8* %13, i8** %14, align 8
  br label %15

; <label>:15:                                     ; preds = %11
  %16 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.026, i32 0, i32 2
  %17 = load %struct.__pmlist_t*, %struct.__pmlist_t** %16, align 8
  %18 = icmp ne %struct.__pmlist_t* %17, null
  br i1 %18, label %11, label %._crit_edge10

._crit_edge10:                                    ; preds = %15
  br label %19

; <label>:19:                                     ; preds = %._crit_edge10, %4
  %20 = bitcast i8** %9 to i8*
  %21 = zext i32 %5 to i64
  call void @qsort(i8* %20, i64 %21, i64 8, i32 (i8*, i8*)* @list_strcmp)
  %22 = icmp ult i32 0, %5
  br i1 %22, label %.lr.ph, label %29

.lr.ph:                                           ; preds = %19
  br label %23

; <label>:23:                                     ; preds = %.lr.ph, %28
  %indvars.iv = phi i64 [ 0, %.lr.ph ], [ %indvars.iv.next, %28 ]
  %.134 = phi %struct.__pmlist_t* [ null, %.lr.ph ], [ %27, %28 ]
  call void @unroll_loop(i32 28)
  %24 = getelementptr inbounds i8*, i8** %9, i64 %indvars.iv
  %25 = load i8*, i8** %24, align 8
  %26 = call noalias i8* @strdup(i8* %25) #7, !track !70
  %27 = call %struct.__pmlist_t* @list_add(%struct.__pmlist_t* %.134, i8* %26)
  br label %28

; <label>:28:                                     ; preds = %23
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %wide.trip.count = zext i32 %5 to i64
  %exitcond = icmp ne i64 %indvars.iv.next, %wide.trip.count
  br i1 %exitcond, label %23, label %._crit_edge

._crit_edge:                                      ; preds = %28
  %split = phi %struct.__pmlist_t* [ %27, %28 ]
  br label %29

; <label>:29:                                     ; preds = %._crit_edge, %19
  %.13.lcssa = phi %struct.__pmlist_t* [ %split, %._crit_edge ], [ null, %19 ]
  %30 = icmp ne i8** %9, null
  br i1 %30, label %31, label %33

; <label>:31:                                     ; preds = %29
  %32 = bitcast i8** %9 to i8*
  call void @free(i8* %32) #7
  br label %33

; <label>:33:                                     ; preds = %31, %29
  br label %34

; <label>:34:                                     ; preds = %33, %3
  %.0 = phi %struct.__pmlist_t* [ null, %3 ], [ %.13.lcssa, %33 ]
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
  br i1 %13, label %14, label %49

; <label>:14:                                     ; preds = %8
  %15 = add i32 %10, 1
  %16 = icmp ne %struct.__pmlist_t* %1, null
  br i1 %16, label %.lr.ph8, label %46

.lr.ph8:                                          ; preds = %14
  br label %17

; <label>:17:                                     ; preds = %.lr.ph8, %42
  %.016 = phi %struct.__pmlist_t* [ %1, %.lr.ph8 ], [ %44, %42 ]
  %.025 = phi i32 [ %10, %.lr.ph8 ], [ %41, %42 ]
  %18 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.016, i32 0, i32 0
  %19 = load i8*, i8** %18, align 8
  %20 = call i64 @strlen(i8* %19) #10
  %21 = add i64 %20, 1
  %22 = trunc i64 %21 to i32
  %23 = add nsw i32 %22, %.025
  %24 = icmp sge i32 %23, %.03
  br i1 %24, label %25, label %36

; <label>:25:                                     ; preds = %17
  %26 = getelementptr [2 x i8], [2 x i8]* @.str.2.180, i32 0, i32 0
  %27 = call i32 (i8*, ...) @printf(i8* %26)
  %28 = add nsw i32 %10, 1
  %29 = icmp slt i32 0, %28
  br i1 %29, label %.lr.ph, label %35

.lr.ph:                                           ; preds = %25
  br label %30

; <label>:30:                                     ; preds = %.lr.ph, %33
  %.04 = phi i32 [ 0, %.lr.ph ], [ %34, %33 ]
  %31 = getelementptr [2 x i8], [2 x i8]* @.str.3.181, i32 0, i32 0
  %32 = call i32 (i8*, ...) @printf(i8* %31)
  br label %33

; <label>:33:                                     ; preds = %30
  %34 = add nuw nsw i32 %.04, 1
  %exitcond = icmp ne i32 %34, %15
  br i1 %exitcond, label %30, label %._crit_edge

._crit_edge:                                      ; preds = %33
  br label %35

; <label>:35:                                     ; preds = %._crit_edge, %25
  br label %36

; <label>:36:                                     ; preds = %35, %17
  %.1 = phi i32 [ %10, %35 ], [ %.025, %17 ]
  %37 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.016, i32 0, i32 0
  %38 = load i8*, i8** %37, align 8
  %39 = getelementptr [4 x i8], [4 x i8]* @.str.1.179, i32 0, i32 0
  %40 = call i32 (i8*, ...) @printf(i8* %39, i8* %38)
  %41 = add nsw i32 %.1, %22
  br label %42

; <label>:42:                                     ; preds = %36
  %43 = getelementptr inbounds %struct.__pmlist_t, %struct.__pmlist_t* %.016, i32 0, i32 2
  %44 = load %struct.__pmlist_t*, %struct.__pmlist_t** %43, align 8
  %45 = icmp ne %struct.__pmlist_t* %44, null
  br i1 %45, label %17, label %._crit_edge9

._crit_edge9:                                     ; preds = %42
  br label %46

; <label>:46:                                     ; preds = %._crit_edge9, %14
  %47 = getelementptr [2 x i8], [2 x i8]* @.str.2.180, i32 0, i32 0
  %48 = call i32 (i8*, ...) @printf(i8* %47)
  br label %52

; <label>:49:                                     ; preds = %8
  %50 = getelementptr [6 x i8], [6 x i8]* @.str.4.182, i32 0, i32 0
  %51 = call i32 (i8*, ...) @printf(i8* %50)
  br label %52

; <label>:52:                                     ; preds = %49, %46
  ret void
}

; Function Attrs: nounwind
declare dso_local i8* @getenv(i8*) #2

declare void @unroll_loop(i32)

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

!llvm.ident = !{!9, !9}
!llvm.module.flags = !{!10}

!0 = !{i64 1}
!1 = !{i64 4}
!2 = !{i64 6}
!3 = !{i64 9}
!4 = !{i64 38}
!5 = !{i64 37}
!6 = !{i64 36}
!7 = !{i64 34}
!8 = !{i64 35}
!9 = !{!"clang version 7.0.0 (tags/RELEASE_700/final)"}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = !{i64 33}
!12 = !{!"1"}
!13 = !{i64 42}
!14 = !{i64 27}
!15 = !{i64 26}
!16 = !{i64 25}
!17 = !{i64 24}
!18 = !{i64 2}
!19 = !{i64 3}
!20 = !{i64 21}
!21 = !{i64 20}
!22 = !{i64 32}
!23 = !{i64 19}
!24 = !{i64 28}
!25 = !{i64 7}
!26 = !{i64 55}
!27 = !{i64 66}
!28 = !{i64 65}
!29 = !{i64 64}
!30 = !{i64 8}
!31 = !{i64 11}
!32 = !{i64 29}
!33 = !{i64 13}
!34 = !{i64 60}
!35 = !{i64 30}
!36 = !{i64 17}
!37 = !{i64 59}
!38 = !{i64 58}
!39 = !{i64 57}
!40 = !{i64 5}
!41 = !{i64 68}
!42 = !{i64 54}
!43 = !{i64 53}
!44 = !{i64 52}
!45 = !{i64 51}
!46 = !{i64 50}
!47 = !{i64 10}
!48 = !{i64 47}
!49 = !{i64 46}
!50 = !{i64 45}
!51 = !{i64 44}
!52 = !{i64 43}
!53 = !{i64 49}
!54 = !{i64 12}
!55 = !{i64 63}
!56 = !{i64 16}
!57 = !{i64 14}
!58 = !{i64 56}
!59 = !{i64 61}
!60 = !{i64 15}
!61 = !{i64 62}
!62 = !{i64 67}
!63 = !{i64 48}
!64 = !{i64 22}
!65 = !{i64 23}
!66 = !{i64 18}
!67 = !{i64 31}
!68 = !{i64 39}
!69 = !{i64 40}
!70 = !{i64 41}
