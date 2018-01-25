; ModuleID = 'workdir/inter13t3.bc'
source_filename = "inter13.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { [100 x i8], [8 x i32] }

@.str = private unnamed_addr constant [18 x i8] c"*** Branch Taken\0A\00", align 1
@.str.1 = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.2 = private unnamed_addr constant [22 x i8] c"*** Branch Not Taken\0A\00", align 1
@.str.3 = private unnamed_addr constant [12 x i8] c"hellogorld\00\00", align 1
@.str.4 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@0 = constant [11 x i8] c"helloWorld\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType* byval align 8) #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %3 = getelementptr inbounds [8 x i32], [8 x i32]* %2, i64 0, i64 0
  %4 = load i32, i32* %3, align 4
  %5 = icmp eq i32 %4, 27
  br i1 %5, label %6, label %13

; <label>:6:                                      ; preds = %1
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %8 = getelementptr inbounds [8 x i32], [8 x i32]* %7, i64 0, i64 7
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 55
  br i1 %10, label %11, label %13

; <label>:11:                                     ; preds = %6
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i32 0, i32 0))
  br label %13

; <label>:13:                                     ; preds = %11, %6, %1
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned(%struct.stType* byval align 8) #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %3 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  %4 = call i32 @strcmp(i8* %3, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0)) #4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %20, label %6

; <label>:6:                                      ; preds = %1
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %8 = getelementptr inbounds [100 x i8], [100 x i8]* %7, i64 0, i64 4
  %9 = load i8, i8* %8, align 4
  %10 = sext i8 %9 to i32
  %11 = icmp eq i32 %10, 111
  br i1 %11, label %12, label %20

; <label>:12:                                     ; preds = %6
  %13 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %14 = getelementptr inbounds [100 x i8], [100 x i8]* %13, i64 0, i64 9
  %15 = load i8, i8* %14, align 1
  %16 = sext i8 %15 to i32
  %17 = icmp eq i32 %16, 100
  br i1 %17, label %18, label %20

; <label>:18:                                     ; preds = %12
  %19 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.2, i32 0, i32 0))
  br label %20

; <label>:20:                                     ; preds = %18, %12, %6, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

; Function Attrs: noinline nounwind uwtable
define i32 @main(i32, i8**) #0 {
  %3 = alloca %struct.stType, align 8
  %4 = icmp eq i32 %0, 1
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 0
  %6 = getelementptr inbounds [100 x i8], [100 x i8]* %5, i32 0, i32 0
  br i1 %4, label %7, label %8

; <label>:7:                                      ; preds = %2
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.3, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %9

; <label>:8:                                      ; preds = %2
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.4, i32 0, i32 0), i64 11, i32 1, i1 false)
  br label %9

; <label>:9:                                      ; preds = %8, %7
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 1
  %11 = getelementptr inbounds [8 x i32], [8 x i32]* %10, i64 0, i64 0
  store i32 27, i32* %11, align 4
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 1
  %13 = getelementptr inbounds [8 x i32], [8 x i32]* %12, i64 0, i64 7
  store i32 55, i32* %13, align 4
  call void @branchPruned_clone(%struct.stType* %3)
  call void @branchNotPruned_clone(%struct.stType* %3)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.stType* byval align 8) #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %3 = getelementptr inbounds [8 x i32], [8 x i32]* %2, i64 0, i64 0
  %4 = load i32, i32* %3, align 4
  %5 = icmp eq i32 27, 27
  br i1 true, label %6, label %13

; <label>:6:                                      ; preds = %1
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %8 = getelementptr inbounds [8 x i32], [8 x i32]* %7, i64 0, i64 7
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 55, 55
  br i1 true, label %11, label %13

; <label>:11:                                     ; preds = %6
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str, i32 0, i32 0))
  br label %13

; <label>:13:                                     ; preds = %11, %6, %1
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchNotPruned_clone(%struct.stType* byval align 8) #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %3 = getelementptr inbounds [100 x i8], [100 x i8]* %2, i32 0, i32 0
  %4 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %5 = call i32 @strcmp(i8* %3, i8* %4) #4
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %21, label %7

; <label>:7:                                      ; preds = %1
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %9 = getelementptr inbounds [100 x i8], [100 x i8]* %8, i64 0, i64 4
  %10 = load i8, i8* %9, align 4
  %11 = sext i8 111 to i32
  %12 = icmp eq i32 111, 111
  br i1 true, label %13, label %21

; <label>:13:                                     ; preds = %7
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %15 = getelementptr inbounds [100 x i8], [100 x i8]* %14, i64 0, i64 9
  %16 = load i8, i8* %15, align 1
  %17 = sext i8 100 to i32
  %18 = icmp eq i32 100, 100
  br i1 true, label %19, label %21

; <label>:19:                                     ; preds = %13
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.2, i32 0, i32 0))
  br label %21

; <label>:21:                                     ; preds = %19, %13, %7, %1
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
