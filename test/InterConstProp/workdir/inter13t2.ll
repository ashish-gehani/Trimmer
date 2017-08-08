; ModuleID = 'workdir/inter13t2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { [100 x i8], [8 x i32] }

@.str = private unnamed_addr constant [18 x i8] c"*** Branch Taken\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.2 = private unnamed_addr constant [22 x i8] c"*** Branch Not Taken\0A\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"hellogorld\00\00", align 1
@.str.4 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType* byval align 8 %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  %2 = getelementptr inbounds [8 x i32], [8 x i32]* %1, i64 0, i64 0
  %3 = load i32, i32* %2, align 4
  %4 = icmp eq i32 %3, 27
  br i1 %4, label %5, label %12

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  %7 = getelementptr inbounds [8 x i32], [8 x i32]* %6, i64 0, i64 7
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 %8, 55
  br i1 %9, label %10, label %12

; <label>:10                                      ; preds = %5
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i32 0, i32 0))
  br label %12

; <label>:12                                      ; preds = %10, %5, %0
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind uwtable
define void @branchNotPruned(%struct.stType* byval align 8 %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  %2 = getelementptr inbounds [100 x i8], [100 x i8]* %1, i32 0, i32 0
  %3 = call i32 @strcmp(i8* %2, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0)) #4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %19, label %5

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  %7 = getelementptr inbounds [100 x i8], [100 x i8]* %6, i64 0, i64 4
  %8 = load i8, i8* %7, align 4
  %9 = sext i8 %8 to i32
  %10 = icmp eq i32 %9, 111
  br i1 %10, label %11, label %19

; <label>:11                                      ; preds = %5
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  %13 = getelementptr inbounds [100 x i8], [100 x i8]* %12, i64 0, i64 9
  %14 = load i8, i8* %13, align 1
  %15 = sext i8 %14 to i32
  %16 = icmp eq i32 %15, 100
  br i1 %16, label %17, label %19

; <label>:17                                      ; preds = %11
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.2, i32 0, i32 0))
  br label %19

; <label>:19                                      ; preds = %17, %11, %5, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %st = alloca %struct.stType, align 8
  %1 = icmp eq i32 %argc, 1
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  %3 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  br i1 %1, label %4, label %9

; <label>:4                                       ; preds = %0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  %6 = getelementptr inbounds [8 x i32], [8 x i32]* %5, i64 0, i64 0
  store i32 27, i32* %6, align 4
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  %8 = getelementptr inbounds [8 x i32], [8 x i32]* %7, i64 0, i64 7
  store i32 55, i32* %8, align 4
  br label %14

; <label>:9                                       ; preds = %0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.4, i32 0, i32 0), i64 11, i32 1, i1 false)
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  %11 = getelementptr inbounds [8 x i32], [8 x i32]* %10, i64 0, i64 0
  store i32 27, i32* %11, align 4
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  %13 = getelementptr inbounds [8 x i32], [8 x i32]* %12, i64 0, i64 7
  store i32 55, i32* %13, align 4
  br label %14

; <label>:14                                      ; preds = %9, %4
  call void @branchPruned(%struct.stType* byval align 8 %st)
  call void @branchNotPruned(%struct.stType* byval align 8 %st)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType* byval align 8 %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  %2 = getelementptr inbounds [8 x i32], [8 x i32]* %1, i64 0, i64 0
  %3 = load i32, i32* %2, align 4
  %4 = icmp eq i32 27, 27
  br i1 %4, label %5, label %12

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 1
  %7 = getelementptr inbounds [8 x i32], [8 x i32]* %6, i64 0, i64 7
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 55, 55
  br i1 %9, label %10, label %12

; <label>:10                                      ; preds = %5
  %11 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i32 0, i32 0))
  br label %12

; <label>:12                                      ; preds = %10, %5, %0
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(%struct.stType* byval align 8 %st) #0 {
  %1 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  %2 = getelementptr inbounds [100 x i8], [100 x i8]* %1, i32 0, i32 0
  %3 = call i32 @strcmp(i8* %2, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0)) #4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %19, label %5

; <label>:5                                       ; preds = %0
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  %7 = getelementptr inbounds [100 x i8], [100 x i8]* %6, i64 0, i64 4
  %8 = load i8, i8* %7, align 4
  %9 = sext i8 %8 to i32
  %10 = icmp eq i32 %9, 111
  br i1 %10, label %11, label %19

; <label>:11                                      ; preds = %5
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %st, i32 0, i32 0
  %13 = getelementptr inbounds [100 x i8], [100 x i8]* %12, i64 0, i64 9
  %14 = load i8, i8* %13, align 1
  %15 = sext i8 %14 to i32
  %16 = icmp eq i32 %15, 100
  br i1 %16, label %17, label %19

; <label>:17                                      ; preds = %11
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.2, i32 0, i32 0))
  br label %19

; <label>:19                                      ; preds = %17, %11, %5, %0
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
