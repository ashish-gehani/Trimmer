; ModuleID = 'workdir/out5.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str.1 = private constant [10 x i8] c"value=key\00", align 16
@str.2 = private unnamed_addr constant [23 x i8] c"Both strings are equal\00"

; Function Attrs: nounwind uwtable
define void @branchNotPruned(i8* nocapture readonly %buffer, i8* nocapture readonly %buffer2) #0 {
  %1 = tail call i32 @strcmp(i8* %buffer, i8* %buffer2) #5
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([23 x i8], [23 x i8]* @str.2, i64 0, i64 0))
  br label %4

; <label>:4                                       ; preds = %3, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %buffer = alloca [100 x i8], align 16
  %1 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0), i64 100, i32 16, i1 false)
  call void @externalFunc(i8* %1) #4
  %2 = call i32 @strcmp(i8* %1, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0)) #5
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %branchNotPruned_clone_clone.exit

; <label>:4                                       ; preds = %0
  %puts.i = call i32 @puts(i8* nonnull getelementptr inbounds ([23 x i8], [23 x i8]* @str.2, i64 0, i64 0)) #4
  br label %branchNotPruned_clone_clone.exit

branchNotPruned_clone_clone.exit:                 ; preds = %0, %4
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #2

declare void @externalFunc(i8*) #3

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(i8* nocapture readonly %buffer, i8* nocapture readnone %buffer2) #0 {
  %1 = tail call i32 @strcmp(i8* %buffer, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0)) #5
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([23 x i8], [23 x i8]* @str.2, i64 0, i64 0))
  br label %4

; <label>:4                                       ; preds = %3, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone_clone(i8* nocapture readonly %buffer, i8* nocapture readnone %buffer2) #0 {
  %1 = tail call i32 @strcmp(i8* %buffer, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.1, i64 0, i64 0)) #5
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([23 x i8], [23 x i8]* @str.2, i64 0, i64 0))
  br label %4

; <label>:4                                       ; preds = %3, %0
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
