/* Generated by ./xlat/gen.sh from ./xlat/iffflags.in; do not edit. */

#ifdef IN_MPERS

# error static const struct xlat iffflags in mpers mode

#else

static
const struct xlat iffflags[] = {
#if defined(IFF_UP) || (defined(HAVE_DECL_IFF_UP) && HAVE_DECL_IFF_UP)
  XLAT(IFF_UP),
#endif
#if defined(IFF_BROADCAST) || (defined(HAVE_DECL_IFF_BROADCAST) && HAVE_DECL_IFF_BROADCAST)
  XLAT(IFF_BROADCAST),
#endif
#if defined(IFF_DEBUG) || (defined(HAVE_DECL_IFF_DEBUG) && HAVE_DECL_IFF_DEBUG)
  XLAT(IFF_DEBUG),
#endif
#if defined(IFF_LOOPBACK) || (defined(HAVE_DECL_IFF_LOOPBACK) && HAVE_DECL_IFF_LOOPBACK)
  XLAT(IFF_LOOPBACK),
#endif
#if defined(IFF_POINTOPOINT) || (defined(HAVE_DECL_IFF_POINTOPOINT) && HAVE_DECL_IFF_POINTOPOINT)
  XLAT(IFF_POINTOPOINT),
#endif
#if defined(IFF_NOTRAILERS) || (defined(HAVE_DECL_IFF_NOTRAILERS) && HAVE_DECL_IFF_NOTRAILERS)
  XLAT(IFF_NOTRAILERS),
#endif
#if defined(IFF_RUNNING) || (defined(HAVE_DECL_IFF_RUNNING) && HAVE_DECL_IFF_RUNNING)
  XLAT(IFF_RUNNING),
#endif
#if defined(IFF_NOARP) || (defined(HAVE_DECL_IFF_NOARP) && HAVE_DECL_IFF_NOARP)
  XLAT(IFF_NOARP),
#endif
#if defined(IFF_PROMISC) || (defined(HAVE_DECL_IFF_PROMISC) && HAVE_DECL_IFF_PROMISC)
  XLAT(IFF_PROMISC),
#endif
#if defined(IFF_ALLMULTI) || (defined(HAVE_DECL_IFF_ALLMULTI) && HAVE_DECL_IFF_ALLMULTI)
  XLAT(IFF_ALLMULTI),
#endif
#if defined(IFF_MASTER) || (defined(HAVE_DECL_IFF_MASTER) && HAVE_DECL_IFF_MASTER)
  XLAT(IFF_MASTER),
#endif
#if defined(IFF_SLAVE) || (defined(HAVE_DECL_IFF_SLAVE) && HAVE_DECL_IFF_SLAVE)
  XLAT(IFF_SLAVE),
#endif
#if defined(IFF_MULTICAST) || (defined(HAVE_DECL_IFF_MULTICAST) && HAVE_DECL_IFF_MULTICAST)
  XLAT(IFF_MULTICAST),
#endif
#if defined(IFF_PORTSEL) || (defined(HAVE_DECL_IFF_PORTSEL) && HAVE_DECL_IFF_PORTSEL)
  XLAT(IFF_PORTSEL),
#endif
#if defined(IFF_AUTOMEDIA) || (defined(HAVE_DECL_IFF_AUTOMEDIA) && HAVE_DECL_IFF_AUTOMEDIA)
  XLAT(IFF_AUTOMEDIA),
#endif
 XLAT_END
};

#endif /* !IN_MPERS */
