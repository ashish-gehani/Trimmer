; ModuleID = 'workdir/out30.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Config = type { i32, i32, i32, i32 }
%struct.option = type { i8*, i32, i32*, i32 }

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
@.str.9 = private unnamed_addr constant [5 x i8] c"area\00", align 1
@.str.10 = private unnamed_addr constant [10 x i8] c"perimeter\00", align 1
@.str.11 = private unnamed_addr constant [7 x i8] c"length\00", align 1
@.str.12 = private unnamed_addr constant [8 x i8] c"breadth\00", align 1
@.str.13 = private unnamed_addr constant [9 x i8] c"defaultL\00", align 1
@.str.14 = private unnamed_addr constant [9 x i8] c"defaultB\00", align 1
@str.1 = private unnamed_addr constant [13 x i8] c"branchPruned\00"

; Function Attrs: nounwind uwtable
define void @branchPruned(i64 %config.coerce0, i64 %config.coerce1) #0 {
  %1 = icmp eq i64 %config.coerce0, 4294967297
  %2 = icmp eq i64 %config.coerce1, 42949672965
  %3 = and i1 %1, %2
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @str.1, i64 0, i64 0))
  br label %5

; <label>:5                                       ; preds = %4, %0
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
.lr.ph.preheader:
  %argv = alloca [6 x i8*], align 16
  %long_index = alloca i32, align 4
  %0 = bitcast [6 x i8*]* %argv to i8*
  call void @llvm.memset.p0i8.i64(i8* %0, i8 0, i64 48, i32 16, i1 false)
  %1 = getelementptr [6 x i8*], [6 x i8*]* %argv, i64 0, i64 0
  %2 = bitcast [6 x i8*]* %argv to <2 x i8*>*
  store <2 x i8*> <i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.1, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.2, i64 0, i64 0)>, <2 x i8*>* %2, align 16
  %3 = getelementptr [6 x i8*], [6 x i8*]* %argv, i64 0, i64 2
  %4 = bitcast i8** %3 to <2 x i8*>*
  store <2 x i8*> <i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.4, i64 0, i64 0)>, <2 x i8*>* %4, align 16
  %5 = getelementptr [6 x i8*], [6 x i8*]* %argv, i64 0, i64 4
  %6 = bitcast i8** %5 to <2 x i8*>*
  store <2 x i8*> <i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.5, i64 0, i64 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.6, i64 0, i64 0)>, <2 x i8*>* %6, align 16
  tail call void @llvm.memset.p0i8.i64(i8* bitcast (%struct.Config* @config to i8*), i8 0, i64 16, i32 4, i1 false)
  store i32 0, i32* %long_index, align 4
  %7 = call i32 @getopt_long(i32 6, i8** %1, i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str.7, i64 0, i64 0), %struct.option* getelementptr inbounds ([7 x %struct.option], [7 x %struct.option]* @long_options, i64 0, i64 0), i32* nonnull %long_index) #4
  br label %.lr.ph

.lr.ph:                                           ; preds = %17, %.lr.ph.preheader
  %8 = phi i32 [ %18, %17 ], [ 97, %.lr.ph.preheader ]
  switch i32 %8, label %17 [
    i32 97, label %9
    i32 112, label %10
    i32 108, label %11
    i32 98, label %14
  ]

; <label>:9                                       ; preds = %.lr.ph
  store i32 1, i32* getelementptr inbounds (%struct.Config, %struct.Config* @config, i64 0, i32 0), align 4
  br label %17

; <label>:10                                      ; preds = %.lr.ph
  store i32 1, i32* getelementptr inbounds (%struct.Config, %struct.Config* @config, i64 0, i32 1), align 4
  br label %17

; <label>:11                                      ; preds = %.lr.ph
  %12 = load i8*, i8** @optarg, align 8
  %13 = call i32 @atoi(i8* %12) #5
  store i32 %13, i32* getelementptr inbounds (%struct.Config, %struct.Config* @config, i64 0, i32 2), align 4
  br label %17

; <label>:14                                      ; preds = %.lr.ph
  %15 = load i8*, i8** @optarg, align 8
  %16 = call i32 @atoi(i8* %15) #5
  store i32 %16, i32* getelementptr inbounds (%struct.Config, %struct.Config* @config, i64 0, i32 3), align 4
  br label %17

; <label>:17                                      ; preds = %.lr.ph, %14, %11, %10, %9
  %18 = call i32 @getopt_long(i32 6, i8** %1, i8* nonnull getelementptr inbounds ([7 x i8], [7 x i8]* @.str.7, i64 0, i64 0), %struct.option* nonnull getelementptr inbounds ([7 x %struct.option], [7 x %struct.option]* @long_options, i64 0, i64 0), i32* nonnull %long_index) #4
  %19 = icmp eq i32 %18, -1
  br i1 %19, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %17
  %20 = load i64, i64* bitcast (%struct.Config* @config to i64*), align 4
  %21 = load i64, i64* bitcast (i32* getelementptr inbounds (%struct.Config, %struct.Config* @config, i64 0, i32 2) to i64*), align 4
  %22 = icmp eq i64 %20, 4294967297
  %23 = icmp eq i64 %21, 42949672965
  %24 = and i1 %22, %23
  br i1 %24, label %25, label %branchPruned_clone.exit

; <label>:25                                      ; preds = %._crit_edge
  %puts.i = call i32 @puts(i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @str.1, i64 0, i64 0)) #4
  br label %branchPruned_clone.exit

branchPruned_clone.exit:                          ; preds = %._crit_edge, %25
  %26 = call i32 (i8*, ...) @printf(i8* nonnull getelementptr inbounds ([4 x i8], [4 x i8]* @.str.8, i64 0, i64 0), i32 2)
  ret i32 0
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #2

; Function Attrs: nounwind
declare i32 @getopt_long(i32, i8**, i8*, %struct.option*, i32*) #1

; Function Attrs: nounwind readonly
declare i32 @atoi(i8* nocapture) #3

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(i64 %config.coerce0, i64 %config.coerce1) #0 {
  %1 = icmp eq i64 %config.coerce0, 4294967297
  %2 = icmp eq i64 %config.coerce1, 42949672965
  %3 = and i1 %1, %2
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @str.1, i64 0, i64 0))
  br label %5

; <label>:5                                       ; preds = %4, %0
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { argmemonly nounwind }
attributes #3 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
