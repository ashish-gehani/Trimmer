; ModuleID = 'workdir/inter17t2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD, [100 x i8], [8 x i32] }
%struct.COORD = type { i32, i32 }

@.str = private unnamed_addr constant [11 x i8] c"x matches\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"y matches\0A\00", align 1
@.str.2 = private unnamed_addr constant [13 x i8] c"arr matches\0A\00", align 1
@.str.3 = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.4 = private unnamed_addr constant [13 x i8] c"str matches\0A\00", align 1
@.str.5 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@0 = constant [11 x i8] c"helloWorld\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType* byval align 8 %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 0
  %2 = getelementptr inbounds %struct.COORD, %struct.COORD* %1, i32 0, i32 0
  %3 = load i32, i32* %2, align 8
  %4 = icmp eq i32 %3, 4
  br i1 %4, label %5, label %7

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0))
  br label %28

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 0
  %9 = getelementptr inbounds %struct.COORD, %struct.COORD* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp eq i32 %10, 8
  br i1 %11, label %12, label %14

; <label>:12                                      ; preds = %7
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  br label %28

; <label>:14                                      ; preds = %7
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 2
  %16 = getelementptr inbounds [8 x i32], [8 x i32]* %15, i64 0, i64 1
  %17 = load i32, i32* %16, align 4
  %18 = icmp eq i32 %17, 12
  br i1 %18, label %19, label %21

; <label>:19                                      ; preds = %14
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.2, i32 0, i32 0))
  br label %28

; <label>:21                                      ; preds = %14
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 1
  %23 = getelementptr inbounds [100 x i8], [100 x i8]* %22, i32 0, i32 0
  %24 = call i32 @strcmp(i8* %23, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.3, i32 0, i32 0)) #4
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %28, label %26

; <label>:26                                      ; preds = %21
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i32 0, i32 0))
  br label %28

; <label>:28                                      ; preds = %12, %21, %26, %19, %5
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

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
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i32 0, i32 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %obj = alloca %struct.stType, align 8
  call void @initialize_clone(%struct.stType* %obj)
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
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i32 0, i32 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType* byval align 8 %obj) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 0
  %2 = getelementptr inbounds %struct.COORD, %struct.COORD* %1, i32 0, i32 0
  %3 = load i32, i32* %2, align 8
  %4 = icmp eq i32 4, 4
  br i1 %4, label %5, label %7

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0))
  br label %29

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 0
  %9 = getelementptr inbounds %struct.COORD, %struct.COORD* %8, i32 0, i32 1
  %10 = load i32, i32* %9, align 4
  %11 = icmp eq i32 8, 8
  br i1 %11, label %12, label %14

; <label>:12                                      ; preds = %7
  %13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  br label %29

; <label>:14                                      ; preds = %7
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 2
  %16 = getelementptr inbounds [8 x i32], [8 x i32]* %15, i64 0, i64 1
  %17 = load i32, i32* %16, align 4
  %18 = icmp eq i32 12, 12
  br i1 %18, label %19, label %21

; <label>:19                                      ; preds = %14
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.2, i32 0, i32 0))
  br label %29

; <label>:21                                      ; preds = %14
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %obj, i32 0, i32 1
  %23 = getelementptr inbounds [100 x i8], [100 x i8]* %22, i32 0, i32 0
  %24 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %25 = call i32 @strcmp(i8* %24, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.3, i32 0, i32 0)) #4
  %26 = icmp ne i32 0, 0
  br i1 %26, label %29, label %27

; <label>:27                                      ; preds = %21
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i32 0, i32 0))
  br label %29

; <label>:29                                      ; preds = %27, %21, %19, %12, %5
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
