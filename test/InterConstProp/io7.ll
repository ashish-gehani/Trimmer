; ModuleID = 'io7.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { i32, i32, i8* }

@str = private unnamed_addr constant [18 x i8] c"*** Branch Taken \00"

; Function Attrs: nounwind uwtable
define void @func(%struct.stType* nocapture readonly %obj) #0 {
  %1 = bitcast %struct.stType* %obj to i64*
  %2 = load i64, i64* %1, align 8
  %3 = icmp eq i64 %2, 34359738372
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str, i64 0, i64 0))
  br label %5

; <label>:5                                       ; preds = %4, %0
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
func.exit:
  %puts.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str, i64 0, i64 0)) #1
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
