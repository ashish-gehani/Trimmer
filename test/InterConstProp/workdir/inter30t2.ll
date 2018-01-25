; ModuleID = 'workdir/inter30t2.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Config = type { i8, i8, i32, i32 }
%struct.option = type { i8*, i32, i32*, i32 }

@config = common global %struct.Config zeroinitializer, align 4
@.str = private unnamed_addr constant [14 x i8] c"branchPruned\0A\00", align 1
@.str.1 = private unnamed_addr constant [5 x i8] c"test\00", align 1
@.str.2 = private unnamed_addr constant [7 x i8] c"--area\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"-p\00", align 1
@.str.4 = private unnamed_addr constant [9 x i8] c"--length\00", align 1
@.str.5 = private unnamed_addr constant [2 x i8] c"5\00", align 1
@.str.6 = private unnamed_addr constant [11 x i8] c"--defaultB\00", align 1
@.str.7 = private unnamed_addr constant [7 x i8] c"apl:b:\00", align 1
@long_options = internal global [7 x %struct.option] [%struct.option { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.8, i32 0, i32 0), i32 0, i32* null, i32 97 }, %struct.option { i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.9, i32 0, i32 0), i32 0, i32* null, i32 112 }, %struct.option { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.10, i32 0, i32 0), i32 1, i32* null, i32 108 }, %struct.option { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.11, i32 0, i32 0), i32 1, i32* null, i32 98 }, %struct.option { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.12, i32 0, i32 0), i32 0, i32* bitcast (i8* getelementptr (i8, i8* getelementptr inbounds (%struct.Config, %struct.Config* @config, i32 0, i32 0), i64 4) to i32*), i32 10 }, %struct.option { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.13, i32 0, i32 0), i32 0, i32* bitcast (i8* getelementptr (i8, i8* getelementptr inbounds (%struct.Config, %struct.Config* @config, i32 0, i32 0), i64 8) to i32*), i32 10 }, %struct.option zeroinitializer], align 16
@optarg = external global i8*, align 8
@.str.8 = private unnamed_addr constant [5 x i8] c"area\00", align 1
@.str.9 = private unnamed_addr constant [10 x i8] c"perimeter\00", align 1
@.str.10 = private unnamed_addr constant [7 x i8] c"length\00", align 1
@.str.11 = private unnamed_addr constant [8 x i8] c"breadth\00", align 1
@.str.12 = private unnamed_addr constant [9 x i8] c"defaultL\00", align 1
@.str.13 = private unnamed_addr constant [9 x i8] c"defaultB\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(i64, i32) #0 {
  %3 = alloca %struct.Config, align 4
  %4 = alloca { i64, i32 }, align 4
  %5 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %4, i32 0, i32 0
  store i64 %0, i64* %5, align 4
  %6 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %4, i32 0, i32 1
  store i32 %1, i32* %6, align 4
  %7 = bitcast %struct.Config* %3 to i8*
  %8 = bitcast { i64, i32 }* %4 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %7, i8* %8, i64 12, i32 4, i1 false)
  %9 = getelementptr inbounds %struct.Config, %struct.Config* %3, i32 0, i32 0
  %10 = load i8, i8* %9, align 4
  %11 = sext i8 %10 to i32
  %12 = icmp eq i32 %11, 1
  br i1 %12, label %13, label %28

; <label>:13:                                     ; preds = %2
  %14 = getelementptr inbounds %struct.Config, %struct.Config* %3, i32 0, i32 1
  %15 = load i8, i8* %14, align 1
  %16 = sext i8 %15 to i32
  %17 = icmp eq i32 %16, 1
  br i1 %17, label %18, label %28

; <label>:18:                                     ; preds = %13
  %19 = getelementptr inbounds %struct.Config, %struct.Config* %3, i32 0, i32 2
  %20 = load i32, i32* %19, align 4
  %21 = icmp eq i32 %20, 5
  br i1 %21, label %22, label %28

; <label>:22:                                     ; preds = %18
  %23 = getelementptr inbounds %struct.Config, %struct.Config* %3, i32 0, i32 3
  %24 = load i32, i32* %23, align 4
  %25 = icmp eq i32 %24, 10
  br i1 %25, label %26, label %28

; <label>:26:                                     ; preds = %22
  %27 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i32 0, i32 0))
  br label %28

; <label>:28:                                     ; preds = %26, %22, %18, %13, %2
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca [6 x i8*], align 16
  %2 = alloca i32, align 4
  %3 = alloca { i64, i32 }, align 4
  %4 = bitcast [6 x i8*]* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 48, i32 16, i1 false)
  %5 = bitcast i8* %4 to [6 x i8*]*
  %6 = getelementptr [6 x i8*], [6 x i8*]* %5, i32 0, i32 0
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i32 0, i32 0), i8** %6
  %7 = getelementptr [6 x i8*], [6 x i8*]* %5, i32 0, i32 1
  store i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i32 0, i32 0), i8** %7
  %8 = getelementptr [6 x i8*], [6 x i8*]* %5, i32 0, i32 2
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i32 0, i32 0), i8** %8
  %9 = getelementptr [6 x i8*], [6 x i8*]* %5, i32 0, i32 3
  store i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.4, i32 0, i32 0), i8** %9
  %10 = getelementptr [6 x i8*], [6 x i8*]* %5, i32 0, i32 4
  store i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i32 0, i32 0), i8** %10
  %11 = getelementptr [6 x i8*], [6 x i8*]* %5, i32 0, i32 5
  store i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.6, i32 0, i32 0), i8** %11
  call void @llvm.memset.p0i8.i64(i8* getelementptr inbounds (%struct.Config, %struct.Config* @config, i32 0, i32 0), i8 0, i64 12, i32 4, i1 false)
  store i32 0, i32* %2, align 4
  %12 = getelementptr inbounds [6 x i8*], [6 x i8*]* %1, i32 0, i32 0
  %13 = call i32 @getopt_long(i32 6, i8** %12, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.7, i32 0, i32 0), %struct.option* getelementptr inbounds ([7 x %struct.option], [7 x %struct.option]* @long_options, i32 0, i32 0), i32* %2) #5
  %14 = icmp ne i32 %13, -1
  br i1 %14, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %0, %24
  %15 = phi i32 [ %25, %24 ], [ %13, %0 ]
  switch i32 %15, label %24 [
    i32 97, label %16
    i32 112, label %17
    i32 108, label %18
    i32 98, label %21
  ]

; <label>:16:                                     ; preds = %.lr.ph
  store i8 1, i8* getelementptr inbounds (%struct.Config, %struct.Config* @config, i32 0, i32 0), align 4
  br label %24

; <label>:17:                                     ; preds = %.lr.ph
  store i8 1, i8* getelementptr inbounds (%struct.Config, %struct.Config* @config, i32 0, i32 1), align 1
  br label %24

; <label>:18:                                     ; preds = %.lr.ph
  %19 = load i8*, i8** @optarg, align 8
  %20 = call i32 @atoi(i8* %19) #6
  store i32 %20, i32* getelementptr inbounds (%struct.Config, %struct.Config* @config, i32 0, i32 2), align 4
  br label %24

; <label>:21:                                     ; preds = %.lr.ph
  %22 = load i8*, i8** @optarg, align 8
  %23 = call i32 @atoi(i8* %22) #6
  store i32 %23, i32* getelementptr inbounds (%struct.Config, %struct.Config* @config, i32 0, i32 3), align 4
  br label %24

; <label>:24:                                     ; preds = %.lr.ph, %21, %18, %17, %16
  %25 = call i32 @getopt_long(i32 6, i8** %12, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.7, i32 0, i32 0), %struct.option* getelementptr inbounds ([7 x %struct.option], [7 x %struct.option]* @long_options, i32 0, i32 0), i32* %2) #5
  %26 = icmp ne i32 %25, -1
  br i1 %26, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %24, %0
  %27 = bitcast { i64, i32 }* %3 to i8*
  %28 = bitcast %struct.Config* @config to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* %28, i64 12, i32 4, i1 false)
  %29 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %3, i32 0, i32 0
  %30 = load i64, i64* %29, align 4
  %31 = getelementptr inbounds { i64, i32 }, { i64, i32 }* %3, i32 0, i32 1
  %32 = load i32, i32* %31, align 4
  call void @branchPruned(i64 %30, i32 %32)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i32, i1) #1

; Function Attrs: nounwind
declare i32 @getopt_long(i32, i8**, i8*, %struct.option*, i32*) #3

; Function Attrs: nounwind readonly
declare i32 @atoi(i8*) #4

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
