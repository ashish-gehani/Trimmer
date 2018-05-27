; ModuleID = 'workdir/inter2t3.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"ielloWorld\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"ialloWorld\00", align 1
@.str.3 = private unnamed_addr constant [17 x i8] c"branchNotPruned\0A\00", align 1
@buffer = common global [100 x i8] zeroinitializer, align 16
@.str.4 = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@0 = constant [11 x i8] c"ielloWorld\00"
@1 = constant [11 x i8] c"ialloWorld\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(i8* %buffer) #0 {
  %1 = getelementptr inbounds i8, i8* %buffer, i64 0
  %2 = load i8, i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 105
  br i1 %4, label %5, label %7

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i32 0, i32 0))
  br label %7

; <label>:7                                       ; preds = %5, %0
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind uwtable
define void @branchNotPruned(i8* %buffer) #0 {
  %1 = getelementptr inbounds i8, i8* %buffer, i64 1
  %2 = load i8, i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 97
  br i1 %4, label %16, label %5

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds i8, i8* %buffer, i64 1
  %7 = load i8, i8* %6, align 1
  %8 = sext i8 %7 to i32
  %9 = icmp eq i32 %8, 101
  br i1 %9, label %16, label %10

; <label>:10                                      ; preds = %5
  %11 = call i32 @strcmp(i8* %buffer, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0)) #4
  %12 = icmp ne i32 %11, 0
  br i1 %12, label %16, label %13

; <label>:13                                      ; preds = %10
  %14 = call i32 @strcmp(i8* %buffer, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i32 0, i32 0)) #4
  %15 = icmp ne i32 %14, 0
  br i1 %15, label %16, label %18

; <label>:16                                      ; preds = %13, %10, %5, %0
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i32 0, i32 0))
  br label %18

; <label>:18                                      ; preds = %16, %13
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

; Function Attrs: nounwind uwtable
define void @modify(i8* %buffer, i32 %val, i32 %argc) #0 {
  %1 = icmp eq i32 %val, 3
  br i1 %1, label %2, label %4

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds i8, i8* %buffer, i64 0
  store i8 105, i8* %3, align 1
  br label %4

; <label>:4                                       ; preds = %2, %0
  %5 = icmp eq i32 %argc, 5
  br i1 %5, label %6, label %8

; <label>:6                                       ; preds = %4
  %7 = getelementptr inbounds i8, i8* %buffer, i64 1
  store i8 97, i8* %7, align 1
  br label %8

; <label>:8                                       ; preds = %6, %4
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.4, i32 0, i32 0), i64 100, i32 1, i1 false)
  call void @modify_clone(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i32 0, i32 0), i32 3, i32 %argc)
  call void @branchPruned_clone(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i32 0, i32 0))
  call void @branchNotPruned_clone(i8* getelementptr inbounds ([100 x i8], [100 x i8]* @buffer, i32 0, i32 0))
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind uwtable
define void @modify_clone(i8* %buffer, i32 %val, i32 %argc) #0 {
  %1 = icmp eq i32 3, 3
  br i1 true, label %2, label %4

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds i8, i8* %buffer, i64 0
  store i8 105, i8* %3, align 1
  br label %4

; <label>:4                                       ; preds = %2, %0
  %5 = icmp eq i32 %argc, 5
  br i1 %5, label %6, label %8

; <label>:6                                       ; preds = %4
  %7 = getelementptr inbounds i8, i8* %buffer, i64 1
  store i8 97, i8* %7, align 1
  br label %8

; <label>:8                                       ; preds = %6, %4
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(i8* %buffer) #0 {
  %1 = getelementptr inbounds i8, i8* %buffer, i64 0
  %2 = load i8, i8* %1, align 1
  %3 = sext i8 105 to i32
  %4 = icmp eq i32 105, 105
  br i1 true, label %5, label %7

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i32 0, i32 0))
  br label %7

; <label>:7                                       ; preds = %5, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(i8* %buffer) #0 {
  %1 = getelementptr inbounds i8, i8* %buffer, i64 1
  %2 = load i8, i8* %1, align 1
  %3 = sext i8 %2 to i32
  %4 = icmp eq i32 %3, 97
  br i1 %4, label %18, label %5

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds i8, i8* %buffer, i64 1
  %7 = load i8, i8* %6, align 1
  %8 = sext i8 %7 to i32
  %9 = icmp eq i32 %8, 101
  br i1 %9, label %18, label %10

; <label>:10                                      ; preds = %5
  %11 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %12 = call i32 @strcmp(i8* %buffer, i8* %11) #4
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %18, label %14

; <label>:14                                      ; preds = %10
  %15 = getelementptr [11 x i8], [11 x i8]* @1, i64 0, i64 0
  %16 = call i32 @strcmp(i8* %buffer, i8* %15) #4
  %17 = icmp ne i32 %16, 0
  br i1 %17, label %18, label %20

; <label>:18                                      ; preds = %14, %10, %5, %0
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.3, i32 0, i32 0))
  br label %20

; <label>:20                                      ; preds = %18, %14
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
