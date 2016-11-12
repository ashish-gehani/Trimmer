; ModuleID = 'fgets_fp2.bc'
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
  %1 = tail call i64 @strlen(i8* %s2) #5
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

; Function Attrs: nounwind uwtable
define i32 @main() #2 {
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
  %6 = call i32 @puts(i8* nonnull %1)
  %7 = tail call i32 @fclose(%struct._IO_FILE* %0)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias %struct._IO_FILE* @fopen(i8* nocapture readonly, i8* nocapture readonly) #3

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #3

; Function Attrs: nounwind
declare i32 @fclose(%struct._IO_FILE* nocapture) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #4

attributes #0 = { nounwind readonly uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-svn262614-1~exp1 (branches/release_38)"}
