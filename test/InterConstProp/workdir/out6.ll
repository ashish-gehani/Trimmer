; ModuleID = 'workdir/out6.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@str = private unnamed_addr constant [30 x i8] c"Func2: Both strings are equal\00"

; Function Attrs: nounwind uwtable
define void @branchNotPruned(i8* nocapture readonly %buffer, i8* nocapture readonly %buffer2) #0 {
  %1 = tail call i32 @strcmp(i8* %buffer, i8* %buffer2) #3
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([30 x i8], [30 x i8]* @str, i64 0, i64 0))
  br label %4

; <label>:4                                       ; preds = %3, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
branchNotPruned.exit:
  %puts.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([30 x i8], [30 x i8]* @str, i64 0, i64 0)) #2
  %puts.i1 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([30 x i8], [30 x i8]* @str, i64 0, i64 0)) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
