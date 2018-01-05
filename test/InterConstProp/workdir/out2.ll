; ModuleID = 'workdir/out2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [11 x i8] c"ielloWorld\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"ialloWorld\00", align 1
@buffer = common global [100 x i8] zeroinitializer, align 16
@.str.3 = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@str.2 = private unnamed_addr constant [16 x i8] c"branchNotPruned\00"

; Function Attrs: nounwind uwtable
define void @branchNotPruned(i8* nocapture readonly %buffer) #0 {
  %1 = getelementptr inbounds i8, i8* %buffer, i64 1
  %2 = load i8, i8* %1, align 1
  switch i8 %2, label %3 [
    i8 97, label %9
    i8 101, label %9
  ]

; <label>:3                                       ; preds = %0
  %4 = tail call i32 @strcmp(i8* nonnull %buffer, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %9

; <label>:6                                       ; preds = %3
  %7 = tail call i32 @strcmp(i8* nonnull %buffer, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0)) #5
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %10, label %9

; <label>:9                                       ; preds = %0, %0, %6, %3
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @str.2, i64 0, i64 0))
  br label %10

; <label>:10                                      ; preds = %6, %9
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: norecurse nounwind uwtable
define void @modify(i8* nocapture %buffer, i32 %val, i32 %argc) #2 {
  %1 = icmp eq i32 %val, 3
  br i1 %1, label %2, label %3

; <label>:2                                       ; preds = %0
  store i8 105, i8* %buffer, align 1
  br label %3

; <label>:3                                       ; preds = %2, %0
  %4 = icmp eq i32 %argc, 5
  br i1 %4, label %5, label %7

; <label>:5                                       ; preds = %3
  %6 = getelementptr inbounds i8, i8* %buffer, i64 1
  store i8 97, i8* %6, align 1
  br label %7

; <label>:7                                       ; preds = %5, %3
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i64 0, i64 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.3, i64 0, i64 0), i64 100, i32 1, i1 false)
  store i8 105, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i64 0, i64 0), align 16
  %1 = icmp eq i32 %argc, 5
  br i1 %1, label %modify_clone_clone.exit.thread, label %branchNotPruned_clone_clone.exit

modify_clone_clone.exit.thread:                   ; preds = %0
  store i8 97, i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i64 0, i64 1), align 1
  br label %branchNotPruned_clone_clone.exit

branchNotPruned_clone_clone.exit:                 ; preds = %modify_clone_clone.exit.thread, %0
  %puts.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @str.2, i64 0, i64 0)) #4
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: norecurse nounwind uwtable
define void @modify_clone(i8* nocapture %buffer, i32 %val, i32 %argc) #2 {
  store i8 105, i8* %buffer, align 1
  %1 = icmp eq i32 %argc, 5
  br i1 %1, label %2, label %4

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds i8, i8* %buffer, i64 1
  store i8 97, i8* %3, align 1
  br label %4

; <label>:4                                       ; preds = %2, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(i8* nocapture readonly %buffer) #0 {
  %1 = getelementptr inbounds i8, i8* %buffer, i64 1
  %2 = load i8, i8* %1, align 1
  switch i8 %2, label %3 [
    i8 97, label %9
    i8 101, label %9
  ]

; <label>:3                                       ; preds = %0
  %4 = tail call i32 @strcmp(i8* nonnull %buffer, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %9

; <label>:6                                       ; preds = %3
  %7 = tail call i32 @strcmp(i8* nonnull %buffer, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0)) #5
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %10, label %9

; <label>:9                                       ; preds = %0, %0, %6, %3
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @str.2, i64 0, i64 0))
  br label %10

; <label>:10                                      ; preds = %6, %9
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define void @modify_clone_clone(i8* nocapture %buffer, i32 %val, i32 %argc) #2 {
  store i8 105, i8* %buffer, align 1
  %1 = icmp eq i32 %argc, 5
  br i1 %1, label %2, label %4

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds i8, i8* %buffer, i64 1
  store i8 97, i8* %3, align 1
  br label %4

; <label>:4                                       ; preds = %2, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone_clone(i8* nocapture readonly %buffer) #0 {
  %1 = getelementptr inbounds i8, i8* %buffer, i64 1
  %2 = load i8, i8* %1, align 1
  switch i8 %2, label %3 [
    i8 97, label %9
    i8 101, label %9
  ]

; <label>:3                                       ; preds = %0
  %4 = tail call i32 @strcmp(i8* nonnull %buffer, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #5
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %9

; <label>:6                                       ; preds = %3
  %7 = tail call i32 @strcmp(i8* nonnull %buffer, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i64 0, i64 0)) #5
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %10, label %9

; <label>:9                                       ; preds = %0, %0, %6, %3
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @str.2, i64 0, i64 0))
  br label %10

; <label>:10                                      ; preds = %6, %9
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
