; ModuleID = 'workdir/inter36t1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Config = type { [100 x i8], i32 }

@.str = private unnamed_addr constant [12 x i8] c"helloWorld0\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"branchNotPruned 0\0A\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloWorld1\00", align 1
@.str.3 = private unnamed_addr constant [19 x i8] c"branchNotPruned 1\0A\00", align 1
@config = common global %struct.Config* null, align 8
@.str.4 = private unnamed_addr constant [2 x i8] c"1\00", align 1
@.str.5 = private unnamed_addr constant [19 x i8] c"inter35_fileio.txt\00", align 1
@.str.6 = private unnamed_addr constant [16 x i8] c"file not found\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @branchNotPruned(i8* %buffer) #0 {
  %1 = alloca i8*, align 8
  store i8* %buffer, i8** %1, align 8
  %2 = load i8*, i8** %1, align 8
  %3 = call i32 @strcmp(i8* %2, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i32 0, i32 0)) #4
  %4 = icmp ne i32 %3, 0
  br i1 %4, label %7, label %5

; <label>:5                                       ; preds = %0
  %6 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %14

; <label>:7                                       ; preds = %0
  %8 = load i8*, i8** %1, align 8
  %9 = call i32 @strcmp(i8* %8, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0)) #4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %13, label %11

; <label>:11                                      ; preds = %7
  %12 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.3, i32 0, i32 0))
  br label %13

; <label>:13                                      ; preds = %11, %7
  br label %14

; <label>:14                                      ; preds = %13, %5
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define void @initConfig(i8* %str, i32 %fd) #0 {
  %1 = alloca i8*, align 8
  %2 = alloca i32, align 4
  store i8* %str, i8** %1, align 8
  store i32 %fd, i32* %2, align 4
  %3 = call noalias i8* @malloc(i64 104) #5
  %4 = bitcast i8* %3 to %struct.Config*
  store %struct.Config* %4, %struct.Config** @config, align 8
  %5 = load i32, i32* %2, align 4
  %6 = load %struct.Config*, %struct.Config** @config, align 8
  %7 = getelementptr inbounds %struct.Config, %struct.Config* %6, i32 0, i32 1
  store i32 %5, i32* %7, align 4
  %8 = load i8*, i8** %1, align 8
  %9 = call i32 @strcmp(i8* %8, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i32 0, i32 0)) #4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %16, label %11

; <label>:11                                      ; preds = %0
  %12 = load %struct.Config*, %struct.Config** @config, align 8
  %13 = getelementptr inbounds %struct.Config, %struct.Config* %12, i32 0, i32 1
  %14 = load i32, i32* %13, align 4
  %15 = call i64 @lseek(i32 %14, i64 11, i32 0) #5
  br label %16

; <label>:16                                      ; preds = %11, %0
  ret void
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: nounwind
declare i64 @lseek(i32, i64, i32) #3

; Function Attrs: nounwind uwtable
define void @readConfig() #0 {
  %bytes_read = alloca i32, align 4
  %1 = load %struct.Config*, %struct.Config** @config, align 8
  %2 = getelementptr inbounds %struct.Config, %struct.Config* %1, i32 0, i32 1
  %3 = load i32, i32* %2, align 4
  %4 = load %struct.Config*, %struct.Config** @config, align 8
  %5 = getelementptr inbounds %struct.Config, %struct.Config* %4, i32 0, i32 0
  %6 = getelementptr inbounds [100 x i8], [100 x i8]* %5, i32 0, i32 0
  %7 = call i64 @read(i32 %3, i8* %6, i64 11)
  %8 = trunc i64 %7 to i32
  store i32 %8, i32* %bytes_read, align 4
  %9 = load i32, i32* %bytes_read, align 4
  %10 = sext i32 %9 to i64
  %11 = load %struct.Config*, %struct.Config** @config, align 8
  %12 = getelementptr inbounds %struct.Config, %struct.Config* %11, i32 0, i32 0
  %13 = getelementptr inbounds [100 x i8], [100 x i8]* %12, i64 0, i64 %10
  store i8 0, i8* %13, align 1
  ret void
}

declare i64 @read(i32, i8*, i64) #2

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** %argv) #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %fd = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.5, i32 0, i32 0), i32 0)
  store i32 %4, i32* %fd, align 4
  %5 = load i32, i32* %fd, align 4
  %6 = icmp slt i32 %5, 0
  br i1 %6, label %7, label %9

; <label>:7                                       ; preds = %0
  %8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.6, i32 0, i32 0))
  br label %9

; <label>:9                                       ; preds = %7, %0
  %10 = load i8**, i8*** %3, align 8
  %11 = getelementptr inbounds i8*, i8** %10, i64 1
  %12 = load i8*, i8** %11, align 8
  %13 = load i32, i32* %fd, align 4
  call void @initConfig(i8* %12, i32 %13)
  call void @readConfig()
  %14 = load %struct.Config*, %struct.Config** @config, align 8
  %15 = getelementptr inbounds %struct.Config, %struct.Config* %14, i32 0, i32 0
  %16 = getelementptr inbounds [100 x i8], [100 x i8]* %15, i32 0, i32 0
  call void @branchNotPruned(i8* %16)
  ret i32 0
}

declare i32 @open(i8*, i32, ...) #2

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }
attributes #5 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
