; ModuleID = 'fgets_strchr2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@.str = private unnamed_addr constant [11 x i8] c"configFile\00", align 1
@.str.1 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@0 = internal unnamed_addr constant [19 x i8] c"logfile=/dev/null\0A\00"
@1 = internal unnamed_addr constant [9 x i8] c"port=80\0A\00"
@str.3 = private unnamed_addr constant [12 x i8] c"port is 80 \00"

; Function Attrs: nounwind readonly uwtable
define i32 @strcmp2(i8* nocapture readonly %s1, i8* nocapture readonly %s2) #0 {
  %1 = tail call i64 @strlen(i8* %s2) #6
  %2 = trunc i64 %1 to i32
  %3 = icmp sgt i32 %2, 0
  br i1 %3, label %.lr.ph.preheader, label %.loopexit

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %9
  %.010 = phi i8* [ %10, %9 ], [ %s1, %.lr.ph.preheader ]
  %.019 = phi i8* [ %11, %9 ], [ %s2, %.lr.ph.preheader ]
  %i.08 = phi i32 [ %12, %9 ], [ 0, %.lr.ph.preheader ]
  %4 = load i8, i8* %.010, align 1
  %5 = icmp eq i8 %4, 0
  br i1 %5, label %.loopexit.loopexit, label %6

; <label>:6                                       ; preds = %.lr.ph
  %7 = load i8, i8* %.019, align 1
  %8 = icmp eq i8 %4, %7
  br i1 %8, label %9, label %.loopexit.loopexit

; <label>:9                                       ; preds = %6
  %10 = getelementptr inbounds i8, i8* %.010, i64 1
  %11 = getelementptr inbounds i8, i8* %.019, i64 1
  %12 = add nuw nsw i32 %i.08, 1
  %13 = icmp slt i32 %12, %2
  br i1 %13, label %.lr.ph, label %.loopexit.loopexit

.loopexit.loopexit:                               ; preds = %6, %9, %.lr.ph
  %.0.lcssa.ph = phi i8* [ %.010, %6 ], [ %.010, %.lr.ph ], [ %10, %9 ]
  %.01.lcssa.ph = phi i8* [ %.019, %6 ], [ %.019, %.lr.ph ], [ %11, %9 ]
  br label %.loopexit

.loopexit:                                        ; preds = %.loopexit.loopexit, %0
  %.0.lcssa = phi i8* [ %s1, %0 ], [ %.0.lcssa.ph, %.loopexit.loopexit ]
  %.01.lcssa = phi i8* [ %s2, %0 ], [ %.01.lcssa.ph, %.loopexit.loopexit ]
  %14 = load i8, i8* %.0.lcssa, align 1
  %15 = zext i8 %14 to i32
  %16 = load i8, i8* %.01.lcssa, align 1
  %17 = zext i8 %16 to i32
  %18 = sub nsw i32 %15, %17
  ret i32 %18
}

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #1

; Function Attrs: norecurse nounwind readonly uwtable
define i8* @strchr2(i8* readonly %source, i8 signext %character) #2 {
  br label %1

; <label>:1                                       ; preds = %36, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next.1.1, %36 ]
  %i.08 = phi i32 [ 0, %0 ], [ %37, %36 ]
  %2 = getelementptr inbounds i8, i8* %source, i64 %indvars.iv
  %3 = load i8, i8* %2, align 1
  %4 = icmp eq i8 %3, 0
  %5 = icmp eq i8 %3, %character
  %or.cond = or i1 %4, %5
  %6 = trunc i64 %indvars.iv to i32
  br i1 %or.cond, label %.loopexit, label %7

; <label>:7                                       ; preds = %1
  %indvars.iv.next = or i64 %indvars.iv, 1
  %8 = getelementptr inbounds i8, i8* %source, i64 %indvars.iv.next
  %9 = load i8, i8* %8, align 1
  %10 = icmp eq i8 %9, 0
  %11 = icmp eq i8 %9, %character
  %or.cond.1 = or i1 %10, %11
  %12 = trunc i64 %indvars.iv.next to i32
  br i1 %or.cond.1, label %.loopexit, label %24

.loopexit:                                        ; preds = %36, %30, %24, %7, %1
  %.lcssa2 = phi i1 [ %5, %1 ], [ %11, %7 ], [ %28, %24 ], [ %34, %30 ], [ false, %36 ]
  %.lcssa = phi i1 [ %4, %1 ], [ %10, %7 ], [ %27, %24 ], [ %33, %30 ], [ false, %36 ]
  %i.0.lcssa = phi i32 [ %6, %1 ], [ %12, %7 ], [ %29, %24 ], [ %35, %30 ], [ %37, %36 ]
  %13 = sext i32 %i.0.lcssa to i64
  %14 = getelementptr inbounds i8, i8* %source, i64 %13
  %brmerge = or i1 %.lcssa2, %.lcssa
  %.mux = select i1 %.lcssa, i8* null, i8* %14
  br i1 %brmerge, label %._crit_edge, label %15

; <label>:15                                      ; preds = %.loopexit
  %16 = load i8, i8* %14, align 1
  %17 = icmp eq i8 %16, 0
  br i1 %17, label %._crit_edge, label %.lr.ph.preheader

.lr.ph.preheader:                                 ; preds = %15
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %20
  %18 = phi i8 [ %22, %20 ], [ %16, %.lr.ph.preheader ]
  %.017 = phi i8* [ %21, %20 ], [ %14, %.lr.ph.preheader ]
  %19 = icmp eq i8 %18, %character
  br i1 %19, label %._crit_edge.loopexit, label %20

; <label>:20                                      ; preds = %.lr.ph
  %21 = getelementptr inbounds i8, i8* %.017, i64 1
  %22 = load i8, i8* %21, align 1
  %23 = icmp eq i8 %22, 0
  br i1 %23, label %._crit_edge.loopexit, label %.lr.ph

._crit_edge.loopexit:                             ; preds = %.lr.ph, %20
  %.0.ph = phi i8* [ %.017, %.lr.ph ], [ null, %20 ]
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %.loopexit, %15
  %.0 = phi i8* [ %.mux, %.loopexit ], [ null, %15 ], [ %.0.ph, %._crit_edge.loopexit ]
  ret i8* %.0

; <label>:24                                      ; preds = %7
  %indvars.iv.next.1 = or i64 %indvars.iv, 2
  %25 = getelementptr inbounds i8, i8* %source, i64 %indvars.iv.next.1
  %26 = load i8, i8* %25, align 1
  %27 = icmp eq i8 %26, 0
  %28 = icmp eq i8 %26, %character
  %or.cond.11 = or i1 %27, %28
  %29 = trunc i64 %indvars.iv.next.1 to i32
  br i1 %or.cond.11, label %.loopexit, label %30

; <label>:30                                      ; preds = %24
  %indvars.iv.next.12 = or i64 %indvars.iv, 3
  %31 = getelementptr inbounds i8, i8* %source, i64 %indvars.iv.next.12
  %32 = load i8, i8* %31, align 1
  %33 = icmp eq i8 %32, 0
  %34 = icmp eq i8 %32, %character
  %or.cond.1.1 = or i1 %33, %34
  %35 = trunc i64 %indvars.iv.next.12 to i32
  br i1 %or.cond.1.1, label %.loopexit, label %36

; <label>:36                                      ; preds = %30
  %indvars.iv.next.1.1 = add nuw nsw i64 %indvars.iv, 4
  %37 = add nuw nsw i32 %i.08, 4
  %38 = icmp slt i64 %indvars.iv.next.1.1, 100
  br i1 %38, label %1, label %.loopexit
}

; Function Attrs: nounwind readonly uwtable
define i8* @strchr3(i8* readonly %source, i8 signext %character, i32 %count) #0 {
  %1 = icmp sgt i32 %count, 0
  br i1 %1, label %.lr.ph.preheader, label %.thread

.lr.ph.preheader:                                 ; preds = %0
  %2 = sext i32 %count to i64
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader, %9
  %indvars.iv = phi i64 [ 0, %.lr.ph.preheader ], [ %indvars.iv.next, %9 ]
  %i.05 = phi i32 [ 0, %.lr.ph.preheader ], [ %10, %9 ]
  %3 = getelementptr inbounds i8, i8* %source, i64 %indvars.iv
  %4 = load i8, i8* %3, align 1
  %5 = icmp eq i8 %4, 0
  %6 = icmp eq i8 %4, %character
  %or.cond = or i1 %5, %6
  br i1 %or.cond, label %.loopexit.thread, label %9

.loopexit.thread:                                 ; preds = %.lr.ph
  %.lcssa = phi i1 [ %5, %.lr.ph ]
  %indvars.iv.lcssa = phi i64 [ %indvars.iv, %.lr.ph ]
  %sext = shl i64 %indvars.iv.lcssa, 32
  %7 = ashr exact i64 %sext, 32
  %8 = getelementptr inbounds i8, i8* %source, i64 %7
  %.mux1 = select i1 %.lcssa, i8* null, i8* %8
  br label %.thread

; <label>:9                                       ; preds = %.lr.ph
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %10 = add nuw nsw i32 %i.05, 1
  %11 = icmp slt i64 %indvars.iv.next, %2
  br i1 %11, label %.lr.ph, label %12

; <label>:12                                      ; preds = %9
  %.lcssa21 = phi i32 [ %10, %9 ]
  %13 = sext i32 %.lcssa21 to i64
  %14 = getelementptr inbounds i8, i8* %source, i64 %13
  %15 = sext i8 %character to i32
  %16 = tail call i8* @strchr(i8* %14, i32 %15) #6
  br label %.thread

.thread:                                          ; preds = %.loopexit.thread, %0, %12
  %.0 = phi i8* [ %16, %12 ], [ %source, %0 ], [ %.mux1, %.loopexit.thread ]
  ret i8* %.0
}

; Function Attrs: nounwind readonly
declare i8* @strchr(i8*, i32) #1

; Function Attrs: nounwind uwtable
define i32 @main() #3 {
._crit_edge:
  %str = alloca [60 x i8], align 16
  %0 = tail call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.1, i64 0, i64 0))
  %1 = getelementptr inbounds [60 x i8], [60 x i8]* %str, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @1, i64 0, i64 0), i64 9, i32 1, i1 false)
  %puts3 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @str.3, i64 0, i64 0))
  %2 = call i32 @puts(i8* %1)
  %3 = bitcast [60 x i8]* %str to i64*
  store i64 2942771727067235, i64* %3, align 16
  %4 = call i32 @puts(i8* %1)
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* nonnull getelementptr inbounds ([19 x i8], [19 x i8]* @0, i64 0, i64 0), i64 19, i32 16, i1 false)
  %5 = call i32 @puts(i8* %1)
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* nonnull getelementptr inbounds ([9 x i8], [9 x i8]* @1, i64 0, i64 0), i64 9, i32 1, i1 false)
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @str.3, i64 0, i64 0))
  %6 = call i32 @puts(i8* %1)
  %7 = tail call i32 @fclose(%struct._IO_FILE* %0)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) #4

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #4

; Function Attrs: nounwind
declare i32 @fclose(%struct._IO_FILE* nocapture) #4

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #5

attributes #0 = { nounwind readonly uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { norecurse nounwind readonly uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nounwind }
attributes #6 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-svn262614-1~exp1 (branches/release_38)"}
