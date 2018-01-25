; ModuleID = 'workdir/out4.bc'
source_filename = "inter4.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@str.1 = private unnamed_addr constant [23 x i8] c"Both strings are equal\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(i8* nocapture readonly, i8* nocapture readonly) local_unnamed_addr #0 {
  %3 = tail call i32 @strcmp(i8* %0, i8* %1) #3
  %4 = icmp eq i32 %3, 0
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %2
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @str.1, i64 0, i64 0))
  br label %6

; <label>:6:                                      ; preds = %5, %2
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #1

; Function Attrs: noinline nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
  tail call void @branchPruned_clone(i8* undef, i8* undef)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(i8* nocapture readnone, i8* nocapture readnone) local_unnamed_addr #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([23 x i8], [23 x i8]* @str.1, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
