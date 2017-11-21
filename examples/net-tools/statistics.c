/*
 * Copyright 1997,1999,2000 Andi Kleen. Subject to the GPL. 
 * $Id: statistics.c,v 1.23 2010-10-29 19:24:36 ecki Exp $
 * 19980630 - i18n - Arnaldo Carvalho de Melo <acme@conectiva.com.br> 
 * 19981113 - i18n fixes - Arnaldo Carvalho de Melo <acme@conectiva.com.br> 
 * 19990101 - added net/netstat, -t, -u, -w supprt - Bernd Eckenfels 
 */
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "config.h"
#include "intl.h"
#include "proc.h"

/* #define WARN 1 */

#ifdef WARN
#define UFWARN(x) x
#else
#define UFWARN(x)
#endif

int print_static,f_raw,f_tcp,f_udp,f_unknown = 1;

enum State {
    number = 0, opt_number, i_forward, i_inp_icmp, i_outp_icmp, i_rto_alg,
    MaxState
};

#define normal number

struct entry {
    char *title;
    char *out;
    enum State type;
};

struct statedesc { 
    int indent;
    char *title; 
}; 

struct statedesc states[] = { 
    [number] = { 4, NULL },
    [opt_number] = { 4, NULL }, 
    [i_forward] = { 4, NULL },
    [i_inp_icmp] = { 8, N_("ICMP input histogram:") },
    [i_outp_icmp] = { 8, N_("ICMP output histogram:") },
    [MaxState] = {0},
}; 

static enum State state;

#define I_STATIC (1<<16)	/* static configuration option. */
#define I_TITLE  (1<<17)

/* 
 * XXX check against the snmp mib rfc.
 *
 * Don't mark the first field as translatable! It's a snmp MIB standard.
 * - acme
 */
struct entry Iptab[] =
{
    {"Forwarding", N_("Forwarding is %s"), i_forward | I_STATIC},
    {"DefaultTTL", N_("Default TTL is %u"), number | I_STATIC},
    {"InReceives", N_("%u total packets received"), number},
    {"InHdrErrors", N_("%u with invalid headers"), opt_number},
    {"InAddrErrors", N_("%u with invalid addresses"), opt_number},
    {"ForwDatagrams", N_("%u forwarded"), number},
    {"InUnknownProtos", N_("%u with unknown protocol"), opt_number},
    {"InDiscards", N_("%u incoming packets discarded"), number},
    {"InDelivers", N_("%u incoming packets delivered"), number},
    {"OutRequests", N_("%u requests sent out"), number},	/*? */
    {"OutDiscards", N_("%u outgoing packets dropped"), opt_number},
    {"OutNoRoutes", N_("%u dropped because of missing route"), opt_number},
    {"ReasmTimeout", N_("%u fragments dropped after timeout"), opt_number},
    {"ReasmReqds", N_("%u reassemblies required"), opt_number},	/* ? */
    {"ReasmOKs", N_("%u packets reassembled ok"), opt_number},
    {"ReasmFails", N_("%u packet reassembles failed"), opt_number},
    {"FragOKs", N_("%u fragments received ok"), opt_number},
    {"FragFails", N_("%u fragments failed"), opt_number},
    {"FragCreates", N_("%u fragments created"), opt_number}
};

struct entry Ip6tab[] =
{
    {"Ip6InReceives", N_("%u total packets received"), number},
    {"Ip6InHdrErrors", N_("%u with invalid headers"), opt_number},
    {"Ip6InTooBigErrors", N_("%u with packets too big"), opt_number},
    {"Ip6InNoRoutes", N_("%u incoming packets with no route"), opt_number},
    {"Ip6InAddrErrors", N_("%u with invalid addresses"), opt_number},
    {"Ip6InUnknownProtos", N_("%u with unknown protocol"), opt_number},
    {"Ip6InTruncatedPkts", N_("%u with truncated packets"), opt_number},
    {"Ip6InDiscards", N_("%u incoming packets discarded"), number},
    {"Ip6InDelivers", N_("%u incoming packets delivered"), number},
    {"Ip6OutForwDatagrams", N_("%u forwarded"), number},
    {"Ip6OutRequests", N_("%u requests sent out"), number},     /*? */
    {"Ip6OutDiscards", N_("%u outgoing packets dropped"), opt_number},
    {"Ip6OutNoRoutes", N_("%u dropped because of missing route"), opt_number},
    {"Ip6ReasmTimeout", N_("%u fragments dropped after timeout"), opt_number},
    {"Ip6ReasmReqds", N_("%u reassemblies required"), opt_number}, /* ? */
    {"Ip6ReasmOKs", N_("%u packets reassembled ok"), opt_number},
    {"Ip6ReasmFails", N_("%u packet reassembles failed"), opt_number},
    {"Ip6FragOKs", N_("%u fragments received ok"), opt_number},
    {"Ip6FragFails", N_("%u fragments failed"), opt_number},
    {"Ip6FragCreates", N_("%u fragments created"), opt_number},
    {"Ip6InMcastPkts", N_("%u incoming multicast packets"), opt_number},
    {"Ip6OutMcastPkts", N_("%u outgoing multicast packets"), opt_number}
};

struct entry Icmptab[] =
{
    {"InMsgs", N_("%u ICMP messages received"), number},
    {"InErrors", N_("%u input ICMP message failed."), number},
    {"InDestUnreachs", N_("destination unreachable: %u"), i_inp_icmp | I_TITLE},
    {"InTimeExcds", N_("timeout in transit: %u"), i_inp_icmp | I_TITLE},
    {"InParmProbs", N_("wrong parameters: %u"), i_inp_icmp | I_TITLE},	/*? */
    {"InSrcQuenchs", N_("source quenches: %u"), i_inp_icmp | I_TITLE},
    {"InRedirects", N_("redirects: %u"), i_inp_icmp | I_TITLE},
    {"InEchos", N_("echo requests: %u"), i_inp_icmp | I_TITLE},
    {"InEchoReps", N_("echo replies: %u"), i_inp_icmp | I_TITLE},
    {"InTimestamps", N_("timestamp request: %u"), i_inp_icmp | I_TITLE},
    {"InTimestampReps", N_("timestamp reply: %u"), i_inp_icmp | I_TITLE},
    {"InAddrMasks", N_("address mask request: %u"), i_inp_icmp | I_TITLE},	/*? */
    {"InAddrMaskReps", N_("address mask replies: %u"), i_inp_icmp | I_TITLE},	/*? */
    {"OutMsgs", N_("%u ICMP messages sent"), number},
    {"OutErrors", N_("%u ICMP messages failed"), number},
    {"OutDestUnreachs", N_("destination unreachable: %u"), i_outp_icmp | I_TITLE},
    {"OutTimeExcds", N_("time exceeded: %u"), i_outp_icmp | I_TITLE},
    {"OutParmProbs", N_("wrong parameters: %u"), i_outp_icmp | I_TITLE},	/*? */
    {"OutSrcQuenchs", N_("source quench: %u"), i_outp_icmp | I_TITLE},
    {"OutRedirects", N_("redirect: %u"), i_outp_icmp | I_TITLE},
    {"OutEchos", N_("echo request: %u"), i_outp_icmp | I_TITLE},
    {"OutEchoReps", N_("echo replies: %u"), i_outp_icmp | I_TITLE},
    {"OutTimestamps", N_("timestamp requests: %u"), i_outp_icmp | I_TITLE},
    {"OutTimestampReps", N_("timestamp replies: %u"), i_outp_icmp | I_TITLE},
    {"OutAddrMasks", N_("address mask requests: %u"), i_outp_icmp | I_TITLE},
    {"OutAddrMaskReps", N_("address mask replies: %u"), i_outp_icmp | I_TITLE},
};

struct entry Icmp6tab[] =
{
    {"Icmp6InMsgs", N_("%u ICMP messages received"), number},
    {"Icmp6InErrors", N_("%u input ICMP message failed."), number},
    {"Icmp6InDestUnreachs", N_("destination unreachable: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InPktTooBigs", N_("packets too big: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InTimeExcds", N_("received ICMPv6 time exceeded: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InParmProblems", N_("parameter problem: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InEchos", N_("echo requests: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InEchoReplies", N_("echo replies: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InGroupMembQueries", N_("group member queries: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InGroupMembResponses", N_("group member responses: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InGroupMembReductions", N_("group member reductions: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InRouterSolicits", N_("router solicits: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InRouterAdvertisements", N_("router advertisement: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InNeighborSolicits", N_("neighbour solicits: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InNeighborAdvertisements", N_("neighbour advertisement: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6InRedirects", N_("redirects: %u"), i_inp_icmp | I_TITLE},
    {"Icmp6OutMsgs", N_("%u ICMP messages sent"), number},
    {"Icmp6OutDestUnreachs", N_("destination unreachable: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutPktTooBigs", N_("packets too big: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutTimeExcds", N_("sent ICMPv6 time exceeded: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutParmProblems", N_("parameter problem: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutEchos", N_("echo requests: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutEchoReplies", N_("echo replies: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutGroupMembQueries", N_("group member queries: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutGroupMembResponses", N_("group member responses: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutGroupMembReductions", N_("group member reductions: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutRouterSolicits", N_("router solicits: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutRouterAdvertisements ", N_("router advertisement: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutNeighborSolicits", N_("neighbor solicits: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutNeighborAdvertisements", N_("neighbor advertisements: %u"), i_outp_icmp | I_TITLE},
    {"Icmp6OutRedirects", N_("redirects: %u"), i_outp_icmp | I_TITLE},
};

struct entry Tcptab[] =
{
    {"RtoAlgorithm", N_("RTO algorithm is %s"), i_rto_alg | I_STATIC},
    {"RtoMin", "", number},
    {"RtoMax", "", number},
    {"MaxConn", "", number},
    {"ActiveOpens", N_("%u active connections openings"), number},
    {"PassiveOpens", N_("%u passive connection openings"), number},
    {"AttemptFails", N_("%u failed connection attempts"), number},
    {"EstabResets", N_("%u connection resets received"), number},
    {"CurrEstab", N_("%u connections established"), number},
    {"InSegs", N_("%u segments received"), number},
    {"OutSegs", N_("%u segments send out"), number},
    {"RetransSegs", N_("%u segments retransmited"), number},
    {"InErrs", N_("%u bad segments received."), number},
    {"OutRsts", N_("%u resets sent"), number},
};

struct entry Udptab[] =
{
    {"InDatagrams", N_("%u packets received"), number},
    {"NoPorts", N_("%u packets to unknown port received."), number},
    {"InErrors", N_("%u packet receive errors"), number},
    {"OutDatagrams", N_("%u packets sent"), number},
    {"RcvbufErrors", N_("%u receive buffer errors"), number},
    {"SndbufErrors", N_("%u send buffer errors"), number},
 };

struct entry Udp6tab[] =
{
    {"Udp6InDatagrams", N_("%u packets received"), number},
    {"Udp6NoPorts", N_("%u packets to unknown port received."), number},
    {"Udp6InErrors", N_("%u packet receive errors"), number},
    {"Udp6OutDatagrams", N_("%u packets sent"), number},
};

struct entry Tcpexttab[] =
{
    {"SyncookiesSent", N_("%u SYN cookies sent"), opt_number},
    {"SyncookiesRecv", N_("%u SYN cookies received"), opt_number},
    {"SyncookiesFailed", N_("%u invalid SYN cookies received"), opt_number},

    { "EmbryonicRsts", N_("%u resets received for embryonic SYN_RECV sockets"),
      opt_number },  
    { "PruneCalled", N_("%u packets pruned from receive queue because of socket"
			" buffer overrun"), opt_number },  
    /* obsolete: 2.2.0 doesn't do that anymore */
    { "RcvPruned", N_("%u packets pruned from receive queue"), opt_number },
    { "OfoPruned", N_("%u packets dropped from out-of-order queue because of"
		      " socket buffer overrun"), opt_number }, 
    { "OutOfWindowIcmps", N_("%u ICMP packets dropped because they were "
			     "out-of-window"), opt_number }, 
    { "LockDroppedIcmps", N_("%u ICMP packets dropped because"
			     " socket was locked"), opt_number },
    { "TW", N_("%u TCP sockets finished time wait in fast timer"), opt_number },
    { "TWRecycled", N_("%u time wait sockets recycled by time stamp"), opt_number }, 
    { "TWKilled", N_("%u TCP sockets finished time wait in slow timer"), opt_number },
    { "PAWSPassive", N_("%u passive connections rejected because of"
			" time stamp"), opt_number },
    { "PAWSActive", N_("%u active connections rejected because of "
		       "time stamp"), opt_number },
    { "PAWSEstab", N_("%u packets rejects in established connections because of"
		      " timestamp"), opt_number },
    { "DelayedACKs", N_("%u delayed acks sent"), opt_number },
    { "DelayedACKLocked", N_("%u delayed acks further delayed because of"
			     " locked socket"), opt_number },
    { "DelayedACKLost", N_("Quick ack mode was activated %u times"), opt_number },
    { "ListenOverflows", N_("%u times the listen queue of a socket overflowed"),
      opt_number },
    { "ListenDrops", N_("%u SYNs to LISTEN sockets dropped"), opt_number },
    { "TCPPrequeued", N_("%u packets directly queued to recvmsg prequeue."), 
      opt_number },
    { "TCPDirectCopyFromBacklog", N_("%u bytes directly in process context from backlog"), opt_number },
    { "TCPDirectCopyFromPrequeue", N_("%u bytes directly received in process context from prequeue"),
				      opt_number },
    { "TCPPrequeueDropped", N_("%u packets dropped from prequeue"), opt_number },
    { "TCPHPHits", N_("%u packet headers predicted"), number },
    { "TCPHPHitsToUser", N_("%u packets header predicted and "
			    "directly queued to user"), opt_number },
    { "SockMallocOOM", N_("Ran %u times out of system memory during " 
			  "packet sending"), opt_number }, 
    { "TCPPureAcks", N_("%u acknowledgments not containing data payload received"), opt_number },
    { "TCPHPAcks", N_("%u predicted acknowledgments"), opt_number },
    { "TCPRenoRecovery", N_("%u times recovered from packet loss due to fast retransmit"), opt_number },
    { "TCPSackRecovery", N_("%u times recovered from packet loss by selective acknowledgements"), opt_number },
    { "TCPSACKReneging", N_("%u bad SACK blocks received"), opt_number },
    { "TCPFACKReorder", N_("Detected reordering %u times using FACK"), opt_number },
    { "TCPSACKReorder", N_("Detected reordering %u times using SACK"), opt_number },
    { "TCPTSReorder", N_("Detected reordering %u times using time stamp"), opt_number },
    { "TCPRenoReorder", N_("Detected reordering %u times using reno fast retransmit"), opt_number },
    { "TCPFullUndo", N_("%u congestion windows fully recovered without slow start"), opt_number }, 
    { "TCPPartialUndo", N_("%u congestion windows partially recovered using Hoe heuristic"), opt_number },
    { "TCPDSackUndo", N_("%u congestion window recovered without slow start using DSACK"), opt_number },
    { "TCPLossUndo", N_("%u congestion windows recovered without slow start after partial ack"), opt_number },
    { "TCPLostRetransmits", N_("%u retransmits lost"), opt_number },
    { "TCPRenoFailures",  N_("%u timeouts after reno fast retransmit"), opt_number },
    { "TCPSackFailures",  N_("%u timeouts after SACK recovery"), opt_number },
    { "TCPLossFailures",  N_("%u timeouts in loss state"), opt_number },
    { "TCPFastRetrans", N_("%u fast retransmits"), opt_number },
    { "TCPForwardRetrans", N_("%u forward retransmits"), opt_number }, 
    { "TCPSlowStartRetrans", N_("%u retransmits in slow start"), opt_number },
    { "TCPTimeouts", N_("%u other TCP timeouts"), opt_number },
    { "TCPRenoRecoveryFailed", N_("%u reno fast retransmits failed"), opt_number },
    { "TCPSackRecoveryFail", N_("%u SACK retransmits failed"), opt_number },
    { "TCPSchedulerFailed", N_("%u times receiver scheduled too late for direct processing"), opt_number },
    { "TCPRcvCollapsed", N_("%u packets collapsed in receive queue due to low socket buffer"), opt_number },
    { "TCPDSACKOldSent", N_("%u DSACKs sent for old packets"), opt_number },
    { "TCPDSACKOfoSent", N_("%u DSACKs sent for out of order packets"), opt_number },
    { "TCPDSACKRecv", N_("%u DSACKs received"), opt_number },
    { "TCPDSACKOfoRecv", N_("%u DSACKs for out of order packets received"), opt_number },
    { "TCPAbortOnSyn", N_("%u connections reset due to unexpected SYN"), opt_number },
    { "TCPAbortOnData", N_("%u connections reset due to unexpected data"), opt_number },
    { "TCPAbortOnClose", N_("%u connections reset due to early user close"), opt_number },
    { "TCPAbortOnMemory", N_("%u connections aborted due to memory pressure"), opt_number },
    { "TCPAbortOnTimeout", N_("%u connections aborted due to timeout"), opt_number },
    { "TCPAbortOnLinger", N_("%u connections aborted after user close in linger timeout"), opt_number },
    { "TCPAbortFailed", N_("%u times unabled to send RST due to no memory"), opt_number }, 
    { "TCPMemoryPressures", N_("TCP ran low on memory %u times"), opt_number }, 
    { "TCPLoss", N_("%u TCP data loss events"), opt_number },
    { "TCPDSACKUndo", N_("%u congestion windows recovered without slow start by DSACK"), 
	opt_number },
    { "TCPRenoRecoveryFail", N_("%u classic Reno fast retransmits failed"), opt_number },
};

struct tabtab {
    char *title;
    struct entry *tab;
    size_t size;
    int *flag; 
};

struct tabtab snmptabs[] =
{
    {"Ip", Iptab, sizeof(Iptab), &f_raw},
    {"Icmp", Icmptab, sizeof(Icmptab), &f_raw},
    {"Tcp", Tcptab, sizeof(Tcptab), &f_tcp},
    {"Udp", Udptab, sizeof(Udptab), &f_udp},
    {"TcpExt", Tcpexttab, sizeof(Tcpexttab), &f_tcp},
    {NULL}
};

struct tabtab snmp6tabs[] =
{
    {"Ip6", Ip6tab, sizeof(Ip6tab), &f_raw},
    {"Icmp6", Icmp6tab, sizeof(Icmp6tab), &f_raw},
    {"Udp6", Udp6tab, sizeof(Udp6tab), &f_udp},
    {"Tcp6", Tcptab, sizeof(Tcptab), &f_tcp},
    {NULL}
};

/* XXX IGMP */

int cmpentries(const void *a, const void *b)
{
    return strcmp(((struct entry *) a)->title, ((struct entry *) b)->title);
}

void printval(struct tabtab *tab, char *title, int val)
{
    struct entry *ent = NULL, key;
    int type;
    char buf[512];

    key.title = title;
	if (tab->tab) 
	    ent = bsearch(&key, tab->tab, tab->size / sizeof(struct entry),
			  sizeof(struct entry), cmpentries);
    if (!ent) {			/* try our best */
	if (val) 
		printf("%*s%s: %d\n", states[state].indent, "", title, val);
	return;
    }
    type = ent->type;
    if (type & I_STATIC) {
	type &= ~I_STATIC;
	if (!print_static)
	    return;
    }
    if (*ent->out == '\0')
	return;

    if (type & I_TITLE) {
	type &= ~I_TITLE;
	if (state != type)
	    printf("%*s%s\n", states[state].indent, "", _(states[type].title));
    }
    buf[0] = '\0';
    switch (type) {
    case opt_number:
	if (val == 0) 
	    break;
	/*FALL THOUGH*/
    case number:
	snprintf(buf, sizeof(buf), _(ent->out), val);
	break;
    case i_forward:
	type = normal;
	snprintf(buf, sizeof(buf), _(ent->out), val == 2 ? _("enabled") : _("disabled"));
	break;
    case i_outp_icmp:
    case i_inp_icmp:
	if (val > 0)
	    snprintf(buf, sizeof(buf), _(ent->out), val);
	break;
    case i_rto_alg:		/* XXXX */
	break;
    default:
	abort();
    }
    if (buf[0])
	printf("%*s%s\n", states[type].indent, "", buf);

    state = type;
}

struct tabtab *newtable(struct tabtab *tabs, char *title)
{
    struct tabtab *t;
	static struct tabtab dummytab;
	
    for (t = tabs; t->title; t++) {
		if (!strcmp(title, t->title)) {
	    	if (*(t->flag))
				printf("%s:\n", _(title));
		    state = normal;
	   		return t;
		}
	}
	if (!f_unknown) 
		return NULL; 
	printf("%s:\n", _(title));
	dummytab.title = title;
	dummytab.flag = &f_unknown; 
	return &dummytab;
}

int process_fd(FILE *f, int all, char *filter)
{
    char buf1[2048], buf2[2048];
    char *sp, *np, *p;
    while (fgets(buf1, sizeof buf1, f)) {
	int endflag;
	struct tabtab *tab;

        if (buf1[0] == '\n') // skip empty first line in 2.6 kernels
            continue;
            
	if (!fgets(buf2, sizeof buf2, f))
	    break;
	sp = strchr(buf1, ':');
	np = strchr(buf2, ':');
	if (!np || !sp)
	    goto formaterr;
	*sp = '\0';

        if (!all)
           if (strncmp(buf1, filter, strlen(filter)))
               continue;

	tab = newtable(snmptabs, buf1);
	if (tab == NULL) {
		printf("unknown %s\n", buf1);
		continue;
	}
	np++;
	sp++;

	endflag = 0;
	while (!endflag) {
	    sp += strspn(sp, " \t\n"); 
	    np += strspn(np, " \t\n"); 
	    /*if (*np == '\0') goto formaterr; */

	    p = sp+strcspn(sp, " \t\n");
	    if (*p == '\0')
		endflag = 1;
	    *p = '\0';

	    if (*sp != '\0' && *(tab->flag)) 	
		printval(tab, sp, strtoul(np, &np, 10));

	    sp = p + 1;
	}
    }
  return 0;
  
formaterr:
  return -1;
}

void cpytitle(char *original, char *new)
{
     char *ptr = original;
     while(*ptr != '6' && *ptr != '\0') {
           *new = *ptr;
            new++;
            ptr++;
     }
    *new = *ptr;
    new++;
    *new = '\0';
}

void process6_fd(FILE *f)
{
   char buf1[1024],buf2[50],buf3[1024];
   unsigned long val;
   struct tabtab *tab = NULL;
   int cpflg = 0;

   while (fgets(buf1, sizeof buf1, f)) {
          sscanf(buf1, "%s %lu", buf2, &val);
          if(!cpflg) {
             cpytitle(buf2, buf3);
             tab = newtable(snmp6tabs, buf3);
             cpflg = 1;
          }
          if(!strstr(buf2, buf3)) {
             cpytitle(buf2, buf3);
             tab = newtable(snmp6tabs, buf3);
          }
          if (*(tab->flag))
             printval(tab, buf2, val);
   }

}

void parsesnmp(int flag_raw, int flag_tcp, int flag_udp)
{
    FILE *f;

    f_raw = flag_raw; f_tcp = flag_tcp; f_udp = flag_udp;
    
    f = proc_fopen("/proc/net/snmp");
    if (!f) {
	perror(_("cannot open /proc/net/snmp"));
	return;
    }

    if (process_fd(f, 1, NULL) < 0)
      fprintf(stderr, _("Problem while parsing /proc/net/snmp\n"));

    if (ferror(f))
	perror("/proc/net/snmp");

    fclose(f);

    f = proc_fopen("/proc/net/netstat");

    if (f) {
    	if (process_fd(f, 1, NULL) <0)
          fprintf(stderr, _("Problem while parsing /proc/net/netstat\n"));

        if (ferror(f))
	    perror("/proc/net/netstat");
    
        fclose(f);
    }
    return;
}
    
void parsesnmp6(int flag_raw, int flag_tcp, int flag_udp)
{
    FILE *f;

    f_raw = flag_raw; f_tcp = flag_tcp; f_udp = flag_udp;

    f = fopen("/proc/net/snmp6", "r");
    if (!f) {
        perror(_("cannot open /proc/net/snmp6"));
        return;
    }
    process6_fd(f);
    if (ferror(f))
        perror("/proc/net/snmp6");

    fclose(f);
    f = fopen("/proc/net/snmp", "r");
    if (!f) {
        perror(_("cannot open /proc/net/snmp"));
        return;
    }
    process_fd(f, 0, "Tcp");
    if (ferror(f))
        perror("/proc/net/snmp");

    fclose(f);
}

void inittab(void)
{
    struct tabtab *t;

    /* we sort at runtime because I'm lazy ;) */
    for (t = snmptabs; t->title; t++)
	qsort(t->tab, t->size / sizeof(struct entry),
	      sizeof(struct entry), cmpentries);
}

void inittab6(void)
{
    struct tabtab *t;

    for (t = snmp6tabs; t->title; t++)
        qsort(t->tab, t->size / sizeof(struct entry),
              sizeof(struct entry), cmpentries);
}

