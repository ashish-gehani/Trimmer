; ModuleID = 'workdir/out3.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [8 x i8] c"=friend\00", align 1
@.str.2 = private unnamed_addr constant [2 x i8] c"=\00", align 1
@.str.3 = private unnamed_addr constant [7 x i8] c"friend\00", align 1
@str.3 = private unnamed_addr constant [13 x i8] c"branchPruned\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(i8* %buf) #0 {
  %1 = tail call i8* @strchr(i8* %buf, i32 61) #3
  %2 = tail call i32 @strcmp(i8* %1, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i64 0, i64 0)) #3
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @str.3, i64 0, i64 0))
  br label %5

; <label>:5                                       ; preds = %0, %4
  %6 = tail call i64 @strcspn(i8* %buf, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.2, i64 0, i64 0)) #3
  %sext = shl i64 %6, 32
  %7 = ashr exact i64 %sext, 32
  %8 = getelementptr inbounds i8, i8* %buf, i64 %7
  %9 = getelementptr inbounds i8, i8* %8, i64 1
  store i8 0, i8* %8, align 1
  %10 = tail call i32 @strcmp(i8* %9, i8* nonnull getelementptr inbounds ([7 x i8], [7 x i8]* @.str.3, i64 0, i64 0)) #3
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %13

; <label>:12                                      ; preds = %5
  %puts1 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @str.3, i64 0, i64 0))
  br label %13

; <label>:13                                      ; preds = %5, %12
  ret void
}

; Function Attrs: nounwind readonly
declare i8* @strchr(i8*, i32) #1

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind readonly
declare i64 @strcspn(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %puts.i = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.3, i64 0, i64 0)) #2
  %puts1.i = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.3, i64 0, i64 0)) #2
  ret i32 0
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(i8* nocapture %buf) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.3, i64 0, i64 0))
  %1 = getelementptr inbounds i8, i8* %buf, i64 2
  store i8 0, i8* %1, align 1
  %puts1 = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @str.3, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
