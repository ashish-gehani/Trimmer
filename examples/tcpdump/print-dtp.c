/*
 * Copyright (c) 1998-2007 The TCPDUMP project
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that: (1) source code
 * distributions retain the above copyright notice and this paragraph
 * in its entirety, and (2) distributions including binary code include
 * the above copyright notice and this paragraph in its entirety in
 * the documentation or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED ``AS IS'' AND
 * WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, WITHOUT
 * LIMITATION, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE.
 *
 * Original code by Carles Kishimoto <carles.kishimoto@gmail.com>
 */

/* \summary: Dynamic Trunking Protocol (DTP) printer */

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#include "netdissect-stdinc.h"

#include "netdissect.h"
#include "addrtoname.h"
#include "extract.h"


#define DTP_HEADER_LEN			1
#define DTP_DOMAIN_TLV			0x0001
#define DTP_STATUS_TLV			0x0002
#define DTP_DTP_TYPE_TLV		0x0003
#define DTP_NEIGHBOR_TLV		0x0004

static const struct tok dtp_tlv_values[] = {
    { DTP_DOMAIN_TLV, "Domain TLV"},
    { DTP_STATUS_TLV, "Status TLV"},
    { DTP_DTP_TYPE_TLV, "DTP type TLV"},
    { DTP_NEIGHBOR_TLV, "Neighbor TLV"},
    { 0, NULL}
};

void
dtp_print (netdissect_options *ndo, const u_char *pptr, u_int length)
{
    int type, len;
    const u_char *tptr;

    ndo->ndo_protocol = "dtp";
    if (length < DTP_HEADER_LEN)
        goto trunc;

    tptr = pptr;

    ND_TCHECK_LEN(tptr, DTP_HEADER_LEN);

    ND_PRINT("DTPv%u, length %u",
           EXTRACT_U_1(tptr),
           length);

    /*
     * In non-verbose mode, just print version.
     */
    if (ndo->ndo_vflag < 1) {
	return;
    }

    tptr += DTP_HEADER_LEN;

    while (tptr < (pptr+length)) {

        ND_TCHECK_4(tptr);
	type = EXTRACT_BE_U_2(tptr);
        len  = EXTRACT_BE_U_2(tptr + 2);
       /* XXX: should not be but sometimes it is, see the test captures */
        if (type == 0)
            return;
        ND_PRINT("\n\t%s (0x%04x) TLV, length %u",
               tok2str(dtp_tlv_values, "Unknown", type),
               type, len);

        /* infinite loop check */
        if (len < 4)
            goto invalid;
        ND_TCHECK_LEN(tptr, len);

        switch (type) {
	case DTP_DOMAIN_TLV:
		ND_PRINT(", ");
		nd_printzp(ndo, tptr+4, len-4, pptr+length);
		break;

	case DTP_STATUS_TLV:
	case DTP_DTP_TYPE_TLV:
                if (len < 5)
                    goto invalid;
                ND_PRINT(", 0x%x", EXTRACT_U_1(tptr + 4));
                break;

	case DTP_NEIGHBOR_TLV:
                if (len < 10)
                    goto invalid;
                ND_PRINT(", %s", etheraddr_string(ndo, tptr+4));
                break;

        default:
            break;
        }
        tptr += len;
    }

    return;

 invalid:
    ND_PRINT("%s", istr);
    return;
 trunc:
    nd_print_trunc(ndo);
}
