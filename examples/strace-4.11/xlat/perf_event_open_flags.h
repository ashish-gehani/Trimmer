/* Generated by ./xlat/gen.sh from ./xlat/perf_event_open_flags.in; do not edit. */
#if !(defined(PERF_FLAG_FD_NO_GROUP) || (defined(HAVE_DECL_PERF_FLAG_FD_NO_GROUP) && HAVE_DECL_PERF_FLAG_FD_NO_GROUP))
# define PERF_FLAG_FD_NO_GROUP 1
#endif
#if !(defined(PERF_FLAG_FD_OUTPUT) || (defined(HAVE_DECL_PERF_FLAG_FD_OUTPUT) && HAVE_DECL_PERF_FLAG_FD_OUTPUT))
# define PERF_FLAG_FD_OUTPUT 2
#endif
#if !(defined(PERF_FLAG_PID_CGROUP) || (defined(HAVE_DECL_PERF_FLAG_PID_CGROUP) && HAVE_DECL_PERF_FLAG_PID_CGROUP))
# define PERF_FLAG_PID_CGROUP 4
#endif
#if !(defined(PERF_FLAG_FD_CLOEXEC) || (defined(HAVE_DECL_PERF_FLAG_FD_CLOEXEC) && HAVE_DECL_PERF_FLAG_FD_CLOEXEC))
# define PERF_FLAG_FD_CLOEXEC 8
#endif

#ifdef IN_MPERS

# error static const struct xlat perf_event_open_flags in mpers mode

#else

static
const struct xlat perf_event_open_flags[] = {
 XLAT(PERF_FLAG_FD_NO_GROUP),
 XLAT(PERF_FLAG_FD_OUTPUT),
 XLAT(PERF_FLAG_PID_CGROUP),
 XLAT(PERF_FLAG_FD_CLOEXEC),
 XLAT_END
};

#endif /* !IN_MPERS */
