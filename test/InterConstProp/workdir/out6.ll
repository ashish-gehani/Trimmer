; ModuleID = 'workdir/out6.bc'
source_filename = "inter6.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str.1 = private unnamed_addr constant [10 x i8] c"value=key\00", align 1
@.str.2 = private unnamed_addr constant [20 x i8] c"unroll count is %d\0A\00", align 1
@str.1 = private unnamed_addr constant [30 x i8] c"Func2: Both strings are equal\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #0 {
  %3 = tail call i32 @strcmp(i8* %0, i8* %1) #5
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %2
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @str.1, i64 0, i64 0))
  br label %6

; <label>:6:                                      ; preds = %5, %2
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #2

; Function Attrs: noinline nounwind uwtable
define void @initialize(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline nounwind uwtable
define void @unroll_loop(i32) local_unnamed_addr #0 {
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.2, i64 0, i64 0), i32 %0)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
.peel.begin:
  %0 = alloca [100 x i8], align 16
  %1 = alloca [100 x i8], align 16
  %2 = getelementptr inbounds [100 x i8], [100 x i8]* %0, i64 0, i64 0
  call void @initialize_clone(i8* nonnull %2)
  %3 = getelementptr inbounds [100 x i8], [100 x i8]* %1, i64 0, i64 0
  call void @initialize_clone.26(i8* nonnull %3)
  call void @initialize_clone.28(i8* nonnull %3)
  call void @initialize_clone.30(i8* nonnull %3)
  call void @initialize_clone.32(i8* nonnull %3)
  call void @initialize_clone.34(i8* nonnull %3)
  call void @initialize_clone.36(i8* nonnull %3)
  call void @initialize_clone.38(i8* nonnull %3)
  call void @initialize_clone.40(i8* nonnull %3)
  call void @initialize_clone.42(i8* nonnull %3)
  call void @initialize_clone.44(i8* nonnull %3)
  tail call void @branchPruned_clone(i8* undef, i8* undef)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main_clone() local_unnamed_addr #0 {
.peel.begin:
  %0 = alloca [100 x i8], align 16
  %1 = alloca [100 x i8], align 16
  %2 = getelementptr inbounds [100 x i8], [100 x i8]* %0, i64 0, i64 0
  call void @initialize_clone.4(i8* nonnull %2)
  %3 = getelementptr inbounds [100 x i8], [100 x i8]* %1, i64 0, i64 0
  call void @initialize_clone.6(i8* nonnull %3)
  call void @initialize_clone.8(i8* nonnull %3)
  call void @initialize_clone.10(i8* nonnull %3)
  call void @initialize_clone.12(i8* nonnull %3)
  call void @initialize_clone.14(i8* nonnull %3)
  call void @initialize_clone.16(i8* nonnull %3)
  call void @initialize_clone.18(i8* nonnull %3)
  call void @initialize_clone.20(i8* nonnull %3)
  call void @initialize_clone.22(i8* nonnull %3)
  call void @initialize_clone.24(i8* nonnull %3)
  call void @branchPruned(i8* nonnull %2, i8* nonnull %3)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.4(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.6(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.8(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.10(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.12(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.14(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.16(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.18(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.20(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.22(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.24(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.26(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.28(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.30(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.32(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.34(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.36(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.38(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.40(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.42(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone.44(i8* nocapture) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(i8* nocapture readnone, i8* nocapture readnone) local_unnamed_addr #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @str.1, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #4

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
