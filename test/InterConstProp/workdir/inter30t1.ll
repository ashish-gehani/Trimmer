; ModuleID = 'workdir/inter30t1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Config = type { i32, i32, i32, i32 }
%struct.option = type { i8*, i32, i32*, i32 }

@.str = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"test\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"--area\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"-p\00", align 1
@.str.4 = private unnamed_addr constant [9 x i8] c"--length\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"5\00", align 1
@.str.6 = private unnamed_addr constant [11 x i8] c"--defaultB\00", align 1
@config = common global %struct.Config zeroinitializer, align 4
@.str.7 = private unnamed_addr constant [7 x i8] c"apl:b:\00", align 1
@long_options = internal global [7 x %struct.option] [%struct.option { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.9, i32 0, i32 0), i32 0, i32* null, i32 97 }, %struct.option { i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.10, i32 0, i32 0), i32 0, i32* null, i32 112 }, %struct.option { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.11, i32 0, i32 0), i32 1, i32* null, i32 108 }, %struct.option { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.12, i32 0, i32 0), i32 1, i32* null, i32 98 }, %struct.option { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.13, i32 0, i32 0), i32 0, i32* bitcast (i8* getelementptr (i8, i8* bitcast (%struct.Config* @config to i8*), i64 8) to i32*), i32 10 }, %struct.option { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.14, i32 0, i32 0), i32 0, i32* bitcast (i8* getelementptr (i8, i8* bitcast (%struct.Config* @config to i8*), i64 12) to i32*), i32 10 }, %struct.option zeroinitializer], align 16
@optarg = external global i8*, align 8
@.str.8 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@optind = external global i32, align 4
@.str.9 = private unnamed_addr constant [5 x i8] c"area\00", align 1
@.str.10 = private unnamed_addr constant [10 x i8] c"perimeter\00", align 1
@.str.11 = private unnamed_addr constant [7 x i8] c"length\00", align 1
@.str.12 = private unnamed_addr constant [8 x i8] c"breadth\00", align 1
@.str.13 = private unnamed_addr constant [9 x i8] c"defaultL\00", align 1
@.str.14 = private unnamed_addr constant [9 x i8] c"defaultB\00", align 1

; Function Attrs: nounwind uwtable
define void @branchPruned(i64 %config.coerce0, i64 %config.coerce1) #0 {
  %config = alloca %struct.Config, align 4
  %1 = bitcast %struct.Config* %config to { i64, i64 }*
  %2 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %1, i32 0, i32 0
  store i64 %config.coerce0, i64* %2, align 4
  %3 = getelementptr inbounds { i64, i64 }, { i64, i64 }* %1, i32 0, i32 1
  store i64 %config.coerce1, i64* %3, align 4
  %4 = getelementptr inbounds %struct.Config, %struct.Config* %config, i32 0, i32 0
  %5 = load i32, i32* %4, align 4
  %6 = icmp eq i32 %5, 1
  br i1 %6, label %7, label %21

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds %struct.Config, %struct.Config* %config, i32 0, i32 1
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %21

; <label>:11                                      ; preds = %7
  %12 = getelementptr inbounds %struct.Config, %struct.Config* %config, i32 0, i32 2
  %13 = load i32, i32* %12, align 4
  %14 = icmp eq i32 %13, 5
  br i1 %14, label %15, label %21

; <label>:15                                      ; preds = %11
  %16 = getelementptr inbounds %struct.Config, %struct.Config* %config, i32 0, i32 3
  %17 = load i32, i32* %16, align 4
  %18 = icmp eq i32 %17, 10
  br i1 %18, label %19, label %21

; <label>:19                                      ; preds = %15
  %20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i32 0, i32 0))
  br label %21

; <label>:21                                      ; preds = %19, %15, %11, %7, %0
  ret void
}

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %opt = alloca i32, align 4
  %argc = alloca i32, align 4
  %argv = alloca [6 x i8*], align 16
  %long_index = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 0, i32* %opt, align 4
  store i32 6, i32* %argc, align 4
  %2 = bitcast [6 x i8*]* %argv to i8*
  call void @llvm.memset.p0i8.i64(i8* %2, i8 0, i64 48, i32 16, i1 false)
  %3 = bitcast i8* %2 to [6 x i8*]*
  %4 = getelementptr [6 x i8*], [6 x i8*]* %3, i32 0, i32 0
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0), i8** %4
  %5 = getelementptr [6 x i8*], [6 x i8*]* %3, i32 0, i32 1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i32 0, i32 0), i8** %5
  %6 = getelementptr [6 x i8*], [6 x i8*]* %3, i32 0, i32 2
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i32 0, i32 0), i8** %6
  %7 = getelementptr [6 x i8*], [6 x i8*]* %3, i32 0, i32 3
  store i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.4, i32 0, i32 0), i8** %7
  %8 = getelementptr [6 x i8*], [6 x i8*]* %3, i32 0, i32 4
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0), i8** %8
  %9 = getelementptr [6 x i8*], [6 x i8*]* %3, i32 0, i32 5
  store i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.6, i32 0, i32 0), i8** %9
  call void @llvm.memset.p0i8.i64(i8* bitcast (%struct.Config* @config to i8*), i8 0, i64 16, i32 4, i1 false)
  store i32 0, i32* %long_index, align 4
  br label %10

; <label>:10                                      ; preds = %25, %0
  %11 = load i32, i32* %argc, align 4
  %12 = getelementptr inbounds [6 x i8*], [6 x i8*]* %argv, i32 0, i32 0
  %13 = call i32 @getopt_long(i32 %11, i8** %12, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.7, i32 0, i32 0), %struct.option* getelementptr inbounds ([7 x %struct.option], [7 x %struct.option]* @long_options, i32 0, i32 0), i32* %long_index) #5
  store i32 %13, i32* %opt, align 4
  %14 = icmp ne i32 %13, -1
  br i1 %14, label %15, label %26

; <label>:15                                      ; preds = %10
  %16 = load i32, i32* %opt, align 4
  switch i32 %16, label %25 [
    i32 97, label %17
    i32 112, label %18
    i32 108, label %19
    i32 98, label %22
  ]

; <label>:17                                      ; preds = %15
  store i32 1, i32* getelementptr inbounds (%struct.Config, %struct.Config* @config, i32 0, i32 0), align 4
  br label %25

; <label>:18                                      ; preds = %15
  store i32 1, i32* getelementptr inbounds (%struct.Config, %struct.Config* @config, i32 0, i32 1), align 4
  br label %25

; <label>:19                                      ; preds = %15
  %20 = load i8*, i8** @optarg, align 8
  %21 = call i32 @atoi(i8* %20) #6
  store i32 %21, i32* getelementptr inbounds (%struct.Config, %struct.Config* @config, i32 0, i32 2), align 4
  br label %25

; <label>:22                                      ; preds = %15
  %23 = load i8*, i8** @optarg, align 8
  %24 = call i32 @atoi(i8* %23) #6
  store i32 %24, i32* getelementptr inbounds (%struct.Config, %struct.Config* @config, i32 0, i32 3), align 4
  br label %25

; <label>:25                                      ; preds = %15, %22, %19, %18, %17
  br label %10

; <label>:26                                      ; preds = %10
  %27 = load i64, i64* getelementptr inbounds ({ i64, i64 }, { i64, i64 }* bitcast (%struct.Config* @config to { i64, i64 }*), i32 0, i32 0), align 4
  %28 = load i64, i64* getelementptr inbounds ({ i64, i64 }, { i64, i64 }* bitcast (%struct.Config* @config to { i64, i64 }*), i32 0, i32 1), align 4
  call void @branchPruned(i64 %27, i64 %28)
  %29 = load i32, i32* @optind, align 4
  %30 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.8, i32 0, i32 0), i32 %29)
  %31 = load i32, i32* %1, align 4
  ret i32 %31
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #2

; Function Attrs: nounwind
declare i32 @getopt_long(i32, i8**, i8*, %struct.option*, i32*) #3

; Function Attrs: nounwind readonly
declare i32 @atoi(i8*) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
