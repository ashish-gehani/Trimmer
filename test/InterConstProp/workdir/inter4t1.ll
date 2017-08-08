; ModuleID = 'workdir/inter4t1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [24 x i8] c"Both strings are equal\0A\00", align 1
@.str.1 = private unnamed_addr constant [40 x i8] c"random check for testing node merging \0A\00", align 1
@.str.2 = private unnamed_addr constant [10 x i8] c"value=key\00", align 1

; Function Attrs: nounwind uwtable
define void @branchPruned(i8* %buffer, i8* %buffer2) #0 {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  store i8* %buffer, i8** %1, align 8
  store i8* %buffer2, i8** %2, align 8
  %3 = load i8*, i8** %1, align 8
  %4 = load i8*, i8** %2, align 8
  %5 = call i32 @strcmp(i8* %3, i8* %4) #4
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %9

; <label>:7                                       ; preds = %0
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str, i32 0, i32 0))
  br label %9

; <label>:9                                       ; preds = %7, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define void @branchNotPruned(i8* %buffer) #0 {
  %1 = alloca i8*, align 8
  store i8* %buffer, i8** %1, align 8
  %2 = load i8*, i8** %1, align 8
  %3 = getelementptr inbounds i8, i8* %2, i64 90
  %4 = load i8, i8* %3, align 1
  %5 = sext i8 %4 to i32
  %6 = icmp eq i32 %5, 10
  br i1 %6, label %7, label %9

; <label>:7                                       ; preds = %0
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.1, i32 0, i32 0))
  br label %9

; <label>:9                                       ; preds = %7, %0
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %buffer = alloca [100 x i8], align 16
  %buffer2 = alloca [100 x i8], align 16
  store i32 0, i32* %1, align 4
  %2 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.2, i32 0, i32 0), i64 100, i32 1, i1 false)
  %3 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer2, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.2, i32 0, i32 0), i64 100, i32 1, i1 false)
  %4 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  call void @branchNotPruned(i8* %4)
  %5 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  %6 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer2, i32 0, i32 0
  call void @branchPruned(i8* %5, i8* %6)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
