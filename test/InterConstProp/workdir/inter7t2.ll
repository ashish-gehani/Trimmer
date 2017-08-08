; ModuleID = 'workdir/inter7t2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD, [100 x i8], [8 x i32] }
%struct.COORD = type { i32, i32 }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"*** Branch Taken \0A\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@0 = constant [11 x i8] c"helloWorld\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType* byval align 8 %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 0
  %2 = getelementptr inbounds %struct.COORD, %struct.COORD* %1, i32 0, i32 0
  %3 = load i32, i32* %2, align 8
  %4 = icmp eq i32 %3, 4
  br i1 %4, label %5, label %34

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 0
  %7 = getelementptr inbounds %struct.COORD, %struct.COORD* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 %8, 8
  br i1 %9, label %10, label %34

; <label>:10                                      ; preds = %5
  %11 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 2
  %12 = getelementptr inbounds [8 x i32], [8 x i32]* %11, i64 0, i64 1
  %13 = load i32, i32* %12, align 4
  %14 = icmp eq i32 %13, 12
  br i1 %14, label %15, label %34

; <label>:15                                      ; preds = %10
  %16 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 1
  %17 = getelementptr inbounds [100 x i8], [100 x i8]* %16, i32 0, i32 0
  %18 = call i32 @strcmp(i8* %17, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #4
  %19 = icmp ne i32 %18, 0
  br i1 %19, label %34, label %20

; <label>:20                                      ; preds = %15
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 1
  %22 = getelementptr inbounds [100 x i8], [100 x i8]* %21, i64 0, i64 4
  %23 = load i8, i8* %22, align 4
  %24 = sext i8 %23 to i32
  %25 = icmp eq i32 %24, 111
  br i1 %25, label %26, label %34

; <label>:26                                      ; preds = %20
  %27 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 1
  %28 = getelementptr inbounds [100 x i8], [100 x i8]* %27, i64 0, i64 9
  %29 = load i8, i8* %28, align 1
  %30 = sext i8 %29 to i32
  %31 = icmp eq i32 %30, 100
  br i1 %31, label %32, label %34

; <label>:32                                      ; preds = %26
  %33 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %34

; <label>:34                                      ; preds = %32, %26, %20, %15, %10, %5, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define void @initialize(%struct.stType* %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 0
  %2 = getelementptr inbounds %struct.COORD, %struct.COORD* %1, i32 0, i32 0
  store i32 4, i32* %2, align 4
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 0
  %4 = getelementptr inbounds %struct.COORD, %struct.COORD* %3, i32 0, i32 1
  store i32 8, i32* %4, align 4
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 2
  %6 = getelementptr inbounds [8 x i32], [8 x i32]* %5, i64 0, i64 0
  store i32 12, i32* %6, align 4
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 2
  %8 = getelementptr inbounds [8 x i32], [8 x i32]* %7, i64 0, i64 1
  store i32 12, i32* %8, align 4
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 2
  %10 = getelementptr inbounds [8 x i32], [8 x i32]* %9, i64 0, i64 2
  store i32 12, i32* %10, align 4
  %11 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 1
  %12 = getelementptr inbounds [100 x i8], [100 x i8]* %11, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %obj = alloca %struct.stType, align 8
  call void @initialize(%struct.stType* %obj)
  call void @branchPruned_clone(%struct.stType* %obj)
  ret i32 0
}

; Function Attrs: nounwind uwtable
define void @initialize_clone(%struct.stType* %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 0
  %2 = getelementptr inbounds %struct.COORD, %struct.COORD* %1, i32 0, i32 0
  store i32 4, i32* %2, align 4
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 0
  %4 = getelementptr inbounds %struct.COORD, %struct.COORD* %3, i32 0, i32 1
  store i32 8, i32* %4, align 4
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 2
  %6 = getelementptr inbounds [8 x i32], [8 x i32]* %5, i64 0, i64 0
  store i32 12, i32* %6, align 4
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 2
  %8 = getelementptr inbounds [8 x i32], [8 x i32]* %7, i64 0, i64 1
  store i32 12, i32* %8, align 4
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 2
  %10 = getelementptr inbounds [8 x i32], [8 x i32]* %9, i64 0, i64 2
  store i32 12, i32* %10, align 4
  %11 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 1
  %12 = getelementptr inbounds [100 x i8], [100 x i8]* %11, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType* byval align 8 %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 0
  %2 = getelementptr inbounds %struct.COORD, %struct.COORD* %1, i32 0, i32 0
  %3 = load i32, i32* %2, align 8
  %4 = icmp eq i32 4, 4
  br i1 %4, label %5, label %35

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 0
  %7 = getelementptr inbounds %struct.COORD, %struct.COORD* %6, i32 0, i32 1
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 8, 8
  br i1 %9, label %10, label %35

; <label>:10                                      ; preds = %5
  %11 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 2
  %12 = getelementptr inbounds [8 x i32], [8 x i32]* %11, i64 0, i64 1
  %13 = load i32, i32* %12, align 4
  %14 = icmp eq i32 12, 12
  br i1 %14, label %15, label %35

; <label>:15                                      ; preds = %10
  %16 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 1
  %17 = getelementptr inbounds [100 x i8], [100 x i8]* %16, i32 0, i32 0
  %18 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %19 = call i32 @strcmp(i8* %18, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #4
  %20 = icmp ne i32 0, 0
  br i1 %20, label %35, label %21

; <label>:21                                      ; preds = %15
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 1
  %23 = getelementptr inbounds [100 x i8], [100 x i8]* %22, i64 0, i64 4
  %24 = load i8, i8* %23, align 4
  %25 = sext i8 111 to i32
  %26 = icmp eq i32 %25, 111
  br i1 %26, label %27, label %35

; <label>:27                                      ; preds = %21
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 1
  %29 = getelementptr inbounds [100 x i8], [100 x i8]* %28, i64 0, i64 9
  %30 = load i8, i8* %29, align 1
  %31 = sext i8 100 to i32
  %32 = icmp eq i32 %31, 100
  br i1 %32, label %33, label %35

; <label>:33                                      ; preds = %27
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %35

; <label>:35                                      ; preds = %33, %27, %21, %15, %10, %5, %0
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
