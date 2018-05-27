; ModuleID = 'workdir/inter40t1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { i32, i32, i8* }

@.str = private unnamed_addr constant [16 x i8] c"branchPruned 3\0A\00", align 1
@.str.1 = private unnamed_addr constant [16 x i8] c"branchPruned 5\0A\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloworld0\00", align 1
@st = global %struct.stType { i32 0, i32 0, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0) }, align 8
@.str.3 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str.4 = private unnamed_addr constant [21 x i8] c"it is equal to zero\0A\00", align 1
@.str.5 = private unnamed_addr constant [18 x i8] c"checkSt is false\0A\00", align 1
@.str.6 = private unnamed_addr constant [20 x i8] c"it is equal to one\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @branchPruned(i32 %x) #0 {
  %1 = alloca i32, align 4
  store i32 %x, i32* %1, align 4
  %2 = load i32, i32* %1, align 4
  %3 = icmp eq i32 %2, 3
  br i1 %3, label %4, label %6

; <label>:4                                       ; preds = %0
  %5 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i32 0, i32 0))
  br label %12

; <label>:6                                       ; preds = %0
  %7 = load i32, i32* %1, align 4
  %8 = icmp eq i32 %7, 5
  br i1 %8, label %9, label %11

; <label>:9                                       ; preds = %6
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i32 0, i32 0))
  br label %11

; <label>:11                                      ; preds = %9, %6
  br label %12

; <label>:12                                      ; preds = %11, %4
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind uwtable
define signext i8 @checkSt() #0 {
  %1 = load i32, i32* getelementptr inbounds (%struct.stType, %struct.stType* @st, i32 0, i32 0), align 8
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %11

; <label>:3                                       ; preds = %0
  %4 = load i32, i32* getelementptr inbounds (%struct.stType, %struct.stType* @st, i32 0, i32 1), align 4
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %11

; <label>:6                                       ; preds = %3
  %7 = load i8*, i8** getelementptr inbounds (%struct.stType, %struct.stType* @st, i32 0, i32 2), align 8
  %8 = call i32 @strcmp(i8* %7, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0)) #3
  %9 = icmp ne i32 %8, 0
  %10 = xor i1 %9, true
  br label %11

; <label>:11                                      ; preds = %6, %3, %0
  %12 = phi i1 [ false, %3 ], [ false, %0 ], [ %10, %6 ]
  %13 = zext i1 %12 to i32
  %14 = trunc i32 %13 to i8
  ret i8 %14
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %x = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  store i32 0, i32* %x, align 4
  %4 = load i8**, i8*** %3, align 8
  %5 = getelementptr inbounds i8*, i8** %4, i64 1
  %6 = load i8*, i8** %5, align 8
  %7 = call i32 @strcmp(i8* %6, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0)) #3
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %16, label %9

; <label>:9                                       ; preds = %0
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.4, i32 0, i32 0))
  store i32 3, i32* %x, align 4
  %11 = call signext i8 @checkSt()
  %12 = icmp ne i8 %11, 0
  br i1 %12, label %15, label %13

; <label>:13                                      ; preds = %9
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.5, i32 0, i32 0))
  br label %18

; <label>:15                                      ; preds = %9
  br label %20

; <label>:16                                      ; preds = %0
  %17 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.6, i32 0, i32 0))
  store i32 5, i32* %x, align 4
  br label %18

; <label>:18                                      ; preds = %16, %13
  %19 = load i32, i32* %x, align 4
  call void @branchPruned(i32 %19)
  br label %20

; <label>:20                                      ; preds = %18, %15
  ret i32 0
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
