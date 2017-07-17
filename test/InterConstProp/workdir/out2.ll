; ModuleID = 'workdir/out2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@0 = internal unnamed_addr constant [10 x i8] c"my=friend\00"
@str.1 = private unnamed_addr constant [7 x i8] c"friend\00", align 1

; Function Attrs: nounwind uwtable
define void @branchPruned(i8* %buffer) #0 {
  %1 = tail call i8* @strchr(i8* %buffer, i32 61) #3
  %2 = getelementptr inbounds i8, i8* %1, i64 1
  store i8 0, i8* %1, align 1
  %3 = tail call i32 @strcmp(i8* %2, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @str.1, i64 0, i64 0)) #3
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([7 x i8], [7 x i8]* @str.1, i64 0, i64 0))
  br label %6

; <label>:6                                       ; preds = %5, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i8* @strchr(i8*, i32) #1

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  store i8 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @0, i64 0, i64 2), align 1
  %puts.i = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @str.1, i64 0, i64 0)) #2
  ret i32 0
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(i8* nocapture readnone %buffer) #0 {
  store i8 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @0, i64 0, i64 2), align 1
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @str.1, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

; Function Attrs: nounwind uwtable
define void @branchPruned_clone_clone(i8* nocapture readnone %buffer) #0 {
  store i8 0, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @0, i64 0, i64 2), align 1
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @str.1, i64 0, i64 0))
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
