; ModuleID = 'workdir/inter3t3.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [2 x i8] c"=\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"friend\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"name = %s\0A\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"value = %s\0A\00", align 1
@.str.4 = private unnamed_addr constant [8 x i8] c"friend\0A\00", align 1
@.str.5 = private unnamed_addr constant [40 x i8] c"random check for testing node merging \0A\00", align 1
@.str.6 = private unnamed_addr constant [10 x i8] c"my=friend\00", align 1
@0 = constant [10 x i8] c"my=friend\00"
@1 = constant [7 x i8] c"friend\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(i8* %buf) #0 {
  %1 = call i64 @strcspn(i8* %buf, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i32 0, i32 0)) #4
  %2 = trunc i64 %1 to i32
  %3 = sext i32 %2 to i64
  %4 = getelementptr inbounds i8, i8* %buf, i64 %3
  %5 = getelementptr inbounds i8, i8* %4, i32 1
  store i8 0, i8* %4, align 1
  %6 = call i32 @strcmp(i8* %5, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i32 0, i32 0)) #4
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %8, label %12

; <label>:8                                       ; preds = %0
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i32 0, i32 0), i8* %buf)
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i8* %5)
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.4, i32 0, i32 0))
  br label %12

; <label>:12                                      ; preds = %8, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i64 @strcspn(i8*, i8*) #1

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define void @branchNotPruned(i8* %buffer) #0 {
  %1 = getelementptr inbounds i8, i8* %buffer, i64 90
  %2 = load i8, i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 10
  br i1 %4, label %5, label %7

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.5, i32 0, i32 0))
  br label %7

; <label>:7                                       ; preds = %5, %0
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %buffer = alloca [100 x i8], align 16
  %1 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.6, i32 0, i32 0), i64 100, i32 1, i1 false)
  %2 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  call void @branchNotPruned(i8* %2)
  %3 = getelementptr inbounds [100 x i8], [100 x i8]* %buffer, i32 0, i32 0
  call void @branchPruned_clone_clone(i8* %3)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(i8* %buffer) #0 {
  %1 = getelementptr inbounds i8, i8* %buffer, i64 90
  %2 = load i8, i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 10
  br i1 %4, label %5, label %7

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.5, i32 0, i32 0))
  br label %7

; <label>:7                                       ; preds = %5, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(i8* %buf) #0 {
  %1 = call i64 @strcspn(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @0, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i32 0, i32 0)) #4
  %2 = getelementptr inbounds i8, i8* %buf, i64 2
  %3 = getelementptr inbounds i8, i8* %2, i32 1
  store i8 0, i8* %2, align 1
  %4 = call i32 @strcmp(i8* %3, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i32 0, i32 0)) #4
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %10

; <label>:6                                       ; preds = %0
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i32 0, i32 0), i8* %buf)
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i8* %3)
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.4, i32 0, i32 0))
  br label %10

; <label>:10                                      ; preds = %6, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone.1(i8* %buffer) #0 {
  %1 = getelementptr inbounds i8, i8* %buffer, i64 90
  %2 = load i8, i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 10
  br i1 %4, label %5, label %7

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([40 x i8], [40 x i8]* @.str.5, i32 0, i32 0))
  br label %7

; <label>:7                                       ; preds = %5, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone_clone(i8* %buf) #0 {
  %1 = call i64 @strcspn(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @0, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str, i32 0, i32 0)) #4
  %2 = getelementptr inbounds i8, i8* %buf, i64 2
  %3 = getelementptr inbounds i8, i8* %2, i32 1
  store i8 0, i8* %2, align 1
  %4 = getelementptr [7 x i8], [7 x i8]* @1, i64 0, i64 0
  %5 = call i32 @strcmp(i8* %4, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.1, i32 0, i32 0)) #4
  %6 = icmp eq i32 0, 0
  br i1 %6, label %7, label %11

; <label>:7                                       ; preds = %0
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i32 0, i32 0), i8* %buf)
  %9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i8* %3)
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.4, i32 0, i32 0))
  br label %11

; <label>:11                                      ; preds = %7, %0
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
