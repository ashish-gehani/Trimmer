; ModuleID = 'workdir/inter17t3.bc'
source_filename = "inter17.c"
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

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType* byval align 8) #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %3 = getelementptr inbounds %struct.COORD, %struct.COORD* %2, i32 0, i32 0
  %4 = load i32, i32* %3, align 8
  %5 = icmp eq i32 %4, 4
  br i1 %5, label %6, label %8

; <label>:6:                                      ; preds = %1
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0))
  br label %29

; <label>:8:                                      ; preds = %1
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %10 = getelementptr inbounds %struct.COORD, %struct.COORD* %9, i32 0, i32 1
  %11 = load i32, i32* %10, align 4
  %12 = icmp eq i32 %11, 8
  br i1 %12, label %13, label %15

; <label>:13:                                     ; preds = %8
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  br label %29

; <label>:15:                                     ; preds = %8
  %16 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 2
  %17 = getelementptr inbounds [8 x i32], [8 x i32]* %16, i64 0, i64 1
  %18 = load i32, i32* %17, align 4
  %19 = icmp eq i32 %18, 12
  br i1 %19, label %20, label %22

; <label>:20:                                     ; preds = %15
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.2, i32 0, i32 0))
  br label %29

; <label>:22:                                     ; preds = %15
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %24 = getelementptr inbounds [100 x i8], [100 x i8]* %23, i32 0, i32 0
  %25 = call i32 @strcmp(i8* %24, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.3, i32 0, i32 0)) #4
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %29, label %27

; <label>:27:                                     ; preds = %22
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i32 0, i32 0))
  br label %29

; <label>:29:                                     ; preds = %13, %22, %27, %20, %6
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

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
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i32 0, i32 0), i64 11, i32 1, i1 false)
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
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.5, i32 0, i32 0), i64 11, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.stType* byval align 8) #0 {
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %3 = getelementptr inbounds %struct.COORD, %struct.COORD* %2, i32 0, i32 0
  %4 = load i32, i32* %3, align 8
  %5 = icmp eq i32 4, 4
  br i1 true, label %6, label %8

; <label>:6:                                      ; preds = %1
  %7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0))
  br label %29

; <label>:8:                                      ; preds = %1
  %9 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 0
  %10 = getelementptr inbounds %struct.COORD, %struct.COORD* %9, i32 0, i32 1
  %11 = load i32, i32* %10, align 4
  %12 = icmp eq i32 %11, 8
  br i1 %12, label %13, label %15

; <label>:13:                                     ; preds = %8
  %14 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.1, i32 0, i32 0))
  br label %29

; <label>:15:                                     ; preds = %8
  %16 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 2
  %17 = getelementptr inbounds [8 x i32], [8 x i32]* %16, i64 0, i64 1
  %18 = load i32, i32* %17, align 4
  %19 = icmp eq i32 %18, 12
  br i1 %19, label %20, label %22

; <label>:20:                                     ; preds = %15
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.2, i32 0, i32 0))
  br label %29

; <label>:22:                                     ; preds = %15
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %0, i32 0, i32 1
  %24 = getelementptr inbounds [100 x i8], [100 x i8]* %23, i32 0, i32 0
  %25 = call i32 @strcmp(i8* %24, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.3, i32 0, i32 0)) #4
  %26 = icmp ne i32 %25, 0
  br i1 %26, label %29, label %27

; <label>:27:                                     ; preds = %22
  %28 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i32 0, i32 0))
  br label %29

; <label>:29:                                     ; preds = %27, %22, %20, %13, %6
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
