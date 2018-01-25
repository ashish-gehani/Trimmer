; ModuleID = 'workdir/inter29t1.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Config = type { i8, i8, i8, i8* }

@.str = private unnamed_addr constant [6 x i8] c"hello\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"test\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"-a\00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"-b\00", align 1
@.str.5 = private unnamed_addr constant [3 x i8] c"-s\00", align 1
@.str.6 = private unnamed_addr constant [5 x i8] c"abs:\00", align 1
@optarg = external global i8*, align 8
@optind = external global i32, align 4
@.str.7 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(i64, i8*) #0 {
  %3 = alloca %struct.Config, align 8
  %4 = bitcast %struct.Config* %3 to { i64, i8* }*
  %5 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %4, i32 0, i32 0
  store i64 %0, i64* %5, align 8
  %6 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %4, i32 0, i32 1
  store i8* %1, i8** %6, align 8
  %7 = getelementptr inbounds %struct.Config, %struct.Config* %3, i32 0, i32 0
  %8 = load i8, i8* %7, align 8
  %9 = sext i8 %8 to i32
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %28

; <label>:11:                                     ; preds = %2
  %12 = getelementptr inbounds %struct.Config, %struct.Config* %3, i32 0, i32 1
  %13 = load i8, i8* %12, align 1
  %14 = sext i8 %13 to i32
  %15 = icmp eq i32 %14, 1
  br i1 %15, label %16, label %28

; <label>:16:                                     ; preds = %11
  %17 = getelementptr inbounds %struct.Config, %struct.Config* %3, i32 0, i32 2
  %18 = load i8, i8* %17, align 2
  %19 = sext i8 %18 to i32
  %20 = icmp eq i32 %19, 1
  br i1 %20, label %21, label %28

; <label>:21:                                     ; preds = %16
  %22 = getelementptr inbounds %struct.Config, %struct.Config* %3, i32 0, i32 3
  %23 = load i8*, i8** %22, align 8
  %24 = call i32 @strcmp(i8* %23, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0)) #5
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %28, label %26

; <label>:26:                                     ; preds = %21
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i32 0, i32 0))
  br label %28

; <label>:28:                                     ; preds = %26, %21, %16, %11, %2
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca [5 x i8*], align 16
  %4 = alloca i8, align 1
  %5 = alloca %struct.Config, align 8
  store i32 0, i32* %1, align 4
  store i32 5, i32* %2, align 4
  %6 = bitcast [5 x i8*]* %3 to i8*
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 40, i32 16, i1 false)
  %7 = bitcast i8* %6 to [5 x i8*]*
  %8 = getelementptr [5 x i8*], [5 x i8*]* %7, i32 0, i32 0
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i32 0, i32 0), i8** %8
  %9 = getelementptr [5 x i8*], [5 x i8*]* %7, i32 0, i32 1
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i32 0, i32 0), i8** %9
  %10 = getelementptr [5 x i8*], [5 x i8*]* %7, i32 0, i32 2
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0), i8** %10
  %11 = getelementptr [5 x i8*], [5 x i8*]* %7, i32 0, i32 3
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.5, i32 0, i32 0), i8** %11
  %12 = getelementptr [5 x i8*], [5 x i8*]* %7, i32 0, i32 4
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i8** %12
  %13 = bitcast %struct.Config* %5 to i8*
  call void @llvm.memset.p0i8.i64(i8* %13, i8 0, i64 16, i32 8, i1 false)
  br label %14

; <label>:14:                                     ; preds = %40, %0
  %15 = load i32, i32* %2, align 4
  %16 = getelementptr inbounds [5 x i8*], [5 x i8*]* %3, i32 0, i32 0
  %17 = call i32 @getopt(i32 %15, i8** %16, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %18 = trunc i32 %17 to i8
  store i8 %18, i8* %4, align 1
  %19 = sext i8 %18 to i32
  %20 = icmp ne i32 %19, -1
  br i1 %20, label %21, label %41

; <label>:21:                                     ; preds = %14
  %22 = load i8, i8* %4, align 1
  %23 = sext i8 %22 to i32
  switch i32 %23, label %40 [
    i32 97, label %24
    i32 98, label %26
    i32 115, label %28
  ]

; <label>:24:                                     ; preds = %21
  %25 = getelementptr inbounds %struct.Config, %struct.Config* %5, i32 0, i32 0
  store i8 1, i8* %25, align 8
  br label %40

; <label>:26:                                     ; preds = %21
  %27 = getelementptr inbounds %struct.Config, %struct.Config* %5, i32 0, i32 1
  store i8 1, i8* %27, align 1
  br label %40

; <label>:28:                                     ; preds = %21
  %29 = getelementptr inbounds %struct.Config, %struct.Config* %5, i32 0, i32 2
  store i8 1, i8* %29, align 2
  %30 = load i8*, i8** @optarg, align 8
  %31 = call i64 @strlen(i8* %30) #5
  %32 = mul i64 1, %31
  %33 = call noalias i8* @malloc(i64 %32) #6
  %34 = getelementptr inbounds %struct.Config, %struct.Config* %5, i32 0, i32 3
  store i8* %33, i8** %34, align 8
  %35 = getelementptr inbounds %struct.Config, %struct.Config* %5, i32 0, i32 3
  %36 = load i8*, i8** %35, align 8
  %37 = load i8*, i8** @optarg, align 8
  %38 = load i8*, i8** @optarg, align 8
  %39 = call i64 @strlen(i8* %38) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %36, i8* %37, i64 %39, i32 1, i1 false)
  br label %40

; <label>:40:                                     ; preds = %21, %28, %26, %24
  br label %14

; <label>:41:                                     ; preds = %14
  %42 = bitcast %struct.Config* %5 to { i64, i8* }*
  %43 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %42, i32 0, i32 0
  %44 = load i64, i64* %43, align 8
  %45 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %42, i32 0, i32 1
  %46 = load i8*, i8** %45, align 8
  call void @branchPruned(i64 %44, i8* %46)
  %47 = load i32, i32* @optind, align 4
  %48 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.7, i32 0, i32 0), i32 %47)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #3

; Function Attrs: nounwind
declare i32 @getopt(i32, i8**, i8*) #4

; Function Attrs: nounwind readonly
declare i64 @strlen(i8*) #1

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #4

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
