; ModuleID = 'workdir/inter40t2.bc'
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
  switch i32 %x, label %5 [
    i32 3, label %1
    i32 5, label %3
  ]

; <label>:1                                       ; preds = %0
  %2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str, i32 0, i32 0))
  br label %5

; <label>:3                                       ; preds = %0
  %4 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.1, i32 0, i32 0))
  br label %5

; <label>:5                                       ; preds = %3, %0, %1
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind uwtable
define signext i8 @checkSt() #0 {
  %1 = load i32, i32* getelementptr inbounds (%struct.stType, %struct.stType* @st, i32 0, i32 0), align 8
  %2 = icmp eq i32 %1, 0
  %3 = load i32, i32* getelementptr inbounds (%struct.stType, %struct.stType* @st, i32 0, i32 1), align 4
  %4 = icmp eq i32 %3, 0
  %or.cond = and i1 %2, %4
  br i1 %or.cond, label %5, label %10

; <label>:5                                       ; preds = %0
  %6 = load i8*, i8** getelementptr inbounds (%struct.stType, %struct.stType* @st, i32 0, i32 2), align 8
  %7 = call i32 @strcmp(i8* %6, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0)) #3
  %8 = icmp ne i32 %7, 0
  %9 = xor i1 %8, true
  br label %10

; <label>:10                                      ; preds = %5, %0
  %11 = phi i1 [ false, %0 ], [ %9, %5 ]
  %12 = zext i1 %11 to i32
  %13 = trunc i32 %12 to i8
  ret i8 %13
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = getelementptr inbounds i8*, i8** %argv, i64 1
  %2 = load i8*, i8** %1, align 8
  %3 = call i32 @strcmp(i8* %2, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.3, i32 0, i32 0)) #3
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %11, label %5

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.4, i32 0, i32 0))
  %7 = call signext i8 @checkSt()
  %8 = icmp ne i8 %7, 0
  br i1 %8, label %14, label %9

; <label>:9                                       ; preds = %5
  %10 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.5, i32 0, i32 0))
  br label %13

; <label>:11                                      ; preds = %0
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([20 x i8], [20 x i8]* @.str.6, i32 0, i32 0))
  br label %13

; <label>:13                                      ; preds = %11, %9
  %x.0 = phi i32 [ 5, %11 ], [ 3, %9 ]
  call void @branchPruned(i32 %x.0)
  br label %14

; <label>:14                                      ; preds = %5, %13
  ret i32 0
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
