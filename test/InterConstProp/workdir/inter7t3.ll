; ModuleID = 'workdir/inter7t3.bc'
source_filename = "inter7.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD, [100 x i8], [8 x i32] }
%struct.COORD = type { i32, i32 }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"*** Branch Taken \0A\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@0 = constant [11 x i8] c"helloWorld\00"
@1 = constant [11 x i8] c"helloWorld\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType* byval align 8) #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %3 = getelementptr inbounds %struct.COORD, %struct.COORD* %2, i32 0, i32 0
  %4 = load i32, i32* %3, align 8
  %5 = icmp eq i32 %4, 4
  br i1 %5, label %6, label %35

; <label>:6:                                      ; preds = %1
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %8 = getelementptr inbounds %struct.COORD, %struct.COORD* %7, i32 0, i32 1
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 8
  br i1 %10, label %11, label %35

; <label>:11:                                     ; preds = %6
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 2
  %13 = getelementptr inbounds [8 x i32], [8 x i32]* %12, i64 0, i64 1
  %14 = load i32, i32* %13, align 4
  %15 = icmp eq i32 %14, 12
  br i1 %15, label %16, label %35

; <label>:16:                                     ; preds = %11
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %18 = getelementptr inbounds [100 x i8], [100 x i8]* %17, i32 0, i32 0
  %19 = call i32 @strcmp(i8* %18, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #4
  %20 = icmp ne i32 %19, 0
  br i1 %20, label %35, label %21

; <label>:21:                                     ; preds = %16
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %23 = getelementptr inbounds [100 x i8], [100 x i8]* %22, i64 0, i64 4
  %24 = load i8, i8* %23, align 4
  %25 = sext i8 %24 to i32
  %26 = icmp eq i32 %25, 111
  br i1 %26, label %27, label %35

; <label>:27:                                     ; preds = %21
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %29 = getelementptr inbounds [100 x i8], [100 x i8]* %28, i64 0, i64 9
  %30 = load i8, i8* %29, align 1
  %31 = sext i8 %30 to i32
  %32 = icmp eq i32 %31, 100
  br i1 %32, label %33, label %35

; <label>:33:                                     ; preds = %27
  %34 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %35

; <label>:35:                                     ; preds = %33, %27, %21, %16, %11, %6, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define void @initialize(%struct.stType*) #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %3 = getelementptr inbounds %struct.COORD, %struct.COORD* %2, i32 0, i32 0
  store i32 4, i32* %3, align 4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %5 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i32 0, i32 1
  store i32 8, i32* %5, align 4
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 2
  %7 = getelementptr inbounds [8 x i32], [8 x i32]* %6, i64 0, i64 0
  store i32 12, i32* %7, align 4
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 2
  %9 = getelementptr inbounds [8 x i32], [8 x i32]* %8, i64 0, i64 1
  store i32 12, i32* %9, align 4
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 2
  %11 = getelementptr inbounds [8 x i32], [8 x i32]* %10, i64 0, i64 2
  store i32 12, i32* %11, align 4
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %13 = getelementptr inbounds [100 x i8], [100 x i8]* %12, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca %struct.stType, align 8
  call void @initialize_clone(%struct.stType* %1)
  call void @branchPruned_clone(%struct.stType* %1)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone(%struct.stType*) #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %3 = getelementptr inbounds %struct.COORD, %struct.COORD* %2, i32 0, i32 0
  store i32 4, i32* %3, align 4
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %5 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i32 0, i32 1
  store i32 8, i32* %5, align 4
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 2
  %7 = getelementptr inbounds [8 x i32], [8 x i32]* %6, i64 0, i64 0
  store i32 12, i32* %7, align 4
  %8 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 2
  %9 = getelementptr inbounds [8 x i32], [8 x i32]* %8, i64 0, i64 1
  store i32 12, i32* %9, align 4
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 2
  %11 = getelementptr inbounds [8 x i32], [8 x i32]* %10, i64 0, i64 2
  store i32 12, i32* %11, align 4
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %13 = getelementptr inbounds [100 x i8], [100 x i8]* %12, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.stType* byval align 8) #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %3 = getelementptr inbounds %struct.COORD, %struct.COORD* %2, i32 0, i32 0
  %4 = load i32, i32* %3, align 8
  %5 = icmp eq i32 4, 4
  br i1 true, label %6, label %37

; <label>:6:                                      ; preds = %1
  %7 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %8 = getelementptr inbounds %struct.COORD, %struct.COORD* %7, i32 0, i32 1
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 8, 8
  br i1 true, label %11, label %37

; <label>:11:                                     ; preds = %6
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 2
  %13 = getelementptr inbounds [8 x i32], [8 x i32]* %12, i64 0, i64 1
  %14 = load i32, i32* %13, align 4
  %15 = icmp eq i32 12, 12
  br i1 true, label %16, label %37

; <label>:16:                                     ; preds = %11
  %17 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %18 = getelementptr inbounds [100 x i8], [100 x i8]* %17, i32 0, i32 0
  %19 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %20 = getelementptr [11 x i8], [11 x i8]* @1, i64 0, i64 0
  %21 = call i32 @strcmp(i8* %19, i8* %20) #4
  %22 = icmp ne i32 0, 0
  br i1 false, label %37, label %23

; <label>:23:                                     ; preds = %16
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %25 = getelementptr inbounds [100 x i8], [100 x i8]* %24, i64 0, i64 4
  %26 = load i8, i8* %25, align 4
  %27 = sext i8 111 to i32
  %28 = icmp eq i32 111, 111
  br i1 true, label %29, label %37

; <label>:29:                                     ; preds = %23
  %30 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %31 = getelementptr inbounds [100 x i8], [100 x i8]* %30, i64 0, i64 9
  %32 = load i8, i8* %31, align 1
  %33 = sext i8 100 to i32
  %34 = icmp eq i32 100, 100
  br i1 true, label %35, label %37

; <label>:35:                                     ; preds = %29
  %36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %37

; <label>:37:                                     ; preds = %35, %29, %23, %16, %11, %6, %1
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
