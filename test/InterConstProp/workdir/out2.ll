; ModuleID = 'workdir/out2.bc'
source_filename = "inter2.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str.1 = private constant [11 x i8] c"ielloWorld\00", align 1
@.str.2 = private constant [11 x i8] c"ialloWorld\00", align 1
@buffer = common global [100 x i8] zeroinitializer, align 16
@.str.4 = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@str.2 = private unnamed_addr constant [13 x i8] c"branchPruned\00"
@str.3 = private unnamed_addr constant [16 x i8] c"branchNotPruned\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(i8* nocapture readonly) local_unnamed_addr #0 {
  %2 = load i8, i8* %0, align 1
  %3 = icmp eq i8 %2, 105
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %1
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.2, i64 0, i64 0))
  br label %5

; <label>:5:                                      ; preds = %4, %1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned(i8* nocapture readonly) local_unnamed_addr #0 {
  %2 = getelementptr inbounds i8, i8* %0, i64 1
  %3 = load i8, i8* %2, align 1
  switch i8 %3, label %4 [
    i8 97, label %10
    i8 101, label %10
  ]

; <label>:4:                                      ; preds = %1
  %5 = tail call i32 @strcmp(i8* nonnull %0, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0)) #5
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %10

; <label>:7:                                      ; preds = %4
  %8 = tail call i32 @strcmp(i8* nonnull %0, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i64 0, i64 0)) #5
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %11, label %10

; <label>:10:                                     ; preds = %1, %1, %7, %4
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @str.3, i64 0, i64 0))
  br label %11

; <label>:11:                                     ; preds = %7, %10
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #1

; Function Attrs: noinline norecurse nounwind uwtable
define void @modify(i8* nocapture, i32, i32) local_unnamed_addr #2 {
  %4 = icmp eq i32 %1, 3
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %3
  store i8 105, i8* %0, align 1
  br label %6

; <label>:6:                                      ; preds = %5, %3
  %7 = icmp eq i32 %2, 5
  br i1 %7, label %8, label %10

; <label>:8:                                      ; preds = %6
  %9 = getelementptr inbounds i8, i8* %0, i64 1
  store i8 97, i8* %9, align 1
  br label %10

; <label>:10:                                     ; preds = %8, %6
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8** nocapture readnone) local_unnamed_addr #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i64 0, i64 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i64 0, i64 0), i64 100, i32 1, i1 false)
  tail call void @modify_clone(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i64 0, i64 0), i32 undef, i32 %0)
  tail call void @branchPruned_clone(i8* undef)
  tail call void @branchNotPruned_clone(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline norecurse nounwind uwtable
define void @modify_clone(i8* nocapture, i32, i32) local_unnamed_addr #2 {
  store i8 105, i8* %0, align 1
  %4 = icmp eq i32 %2, 5
  br i1 %4, label %5, label %7

; <label>:5:                                      ; preds = %3
  %6 = getelementptr inbounds i8, i8* %0, i64 1
  store i8 97, i8* %6, align 1
  br label %7

; <label>:7:                                      ; preds = %5, %3
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(i8* nocapture readnone) local_unnamed_addr #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.2, i64 0, i64 0))
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned_clone(i8* nocapture readonly) local_unnamed_addr #0 {
  %2 = getelementptr inbounds i8, i8* %0, i64 1
  %3 = load i8, i8* %2, align 1
  switch i8 %3, label %4 [
    i8 97, label %10
    i8 101, label %10
  ]

; <label>:4:                                      ; preds = %1
  %5 = tail call i32 @strcmp(i8* nonnull %0, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0)) #5
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %10

; <label>:7:                                      ; preds = %4
  %8 = tail call i32 @strcmp(i8* nonnull %0, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i64 0, i64 0)) #5
  %9 = icmp eq i32 %8, 0
  br i1 %9, label %11, label %10

; <label>:10:                                     ; preds = %1, %1, %7, %4
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @str.3, i64 0, i64 0))
  br label %11

; <label>:11:                                     ; preds = %7, %10
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #4

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline norecurse nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
