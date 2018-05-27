; ModuleID = 'workdir/out36.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Config = type { [100 x i8], i32 }

@.str = private constant [12 x i8] c"helloWorld0\00", align 1
@.str.2 = private constant [12 x i8] c"helloWorld1\00", align 1
@config = common global %struct.Config* null, align 8
@.str.4 = private constant [2 x i8] c"1\00", align 1
@.str.5 = private unnamed_addr constant [19 x i8] c"inter35_fileio.txt\00", align 1
@str.2 = private unnamed_addr constant [15 x i8] c"file not found\00"
@str.3 = private unnamed_addr constant [18 x i8] c"branchNotPruned 0\00"
@str.4 = private unnamed_addr constant [18 x i8] c"branchNotPruned 1\00"

; Function Attrs: nounwind uwtable
define void @branchNotPruned(i8* nocapture readonly %buffer) #0 {
  %1 = tail call i32 @strcmp(i8* %buffer, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0)) #5
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.3, i64 0, i64 0))
  br label %8

; <label>:4                                       ; preds = %0
  %5 = tail call i32 @strcmp(i8* %buffer, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0)) #5
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %8

; <label>:7                                       ; preds = %4
  %puts1 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.4, i64 0, i64 0))
  br label %8

; <label>:8                                       ; preds = %4, %7, %3
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define void @initConfig(i8* nocapture readonly %str, i32 %fd) #0 {
  %1 = tail call noalias i8* @malloc(i64 104) #4
  store i8* %1, i8** bitcast (%struct.Config** @config to i8**), align 8
  %2 = getelementptr inbounds i8, i8* %1, i64 100
  %3 = bitcast i8* %2 to i32*
  store i32 %fd, i32* %3, align 4
  %4 = tail call i32 @strcmp(i8* %str, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0)) #5
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %11

; <label>:6                                       ; preds = %0
  %7 = getelementptr inbounds i8, i8* %1, i64 100
  %8 = bitcast i8* %7 to i32*
  %9 = load i32, i32* %8, align 4
  %10 = tail call i64 @lseek(i32 %9, i64 11, i32 0) #4
  br label %11

; <label>:11                                      ; preds = %0, %6
  ret void
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: nounwind
declare i64 @lseek(i32, i64, i32) #2

; Function Attrs: nounwind uwtable
define void @readConfig() #0 {
  %1 = load %struct.Config*, %struct.Config** @config, align 8
  %2 = getelementptr inbounds %struct.Config, %struct.Config* %1, i64 0, i32 1
  %3 = load i32, i32* %2, align 4
  %4 = getelementptr inbounds %struct.Config, %struct.Config* %1, i64 0, i32 0, i64 0
  %5 = tail call i64 @read(i32 %3, i8* %4, i64 11) #4
  %sext = shl i64 %5, 32
  %6 = ashr exact i64 %sext, 32
  %7 = load %struct.Config*, %struct.Config** @config, align 8
  %8 = getelementptr inbounds %struct.Config, %struct.Config* %7, i64 0, i32 0, i64 %6
  store i8 0, i8* %8, align 1
  ret void
}

declare i64 @read(i32, i8* nocapture, i64) #3

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readonly %argv) #0 {
  %1 = tail call i32 (i8*, i32, ...) @open(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.5, i64 0, i64 0), i32 0) #4
  %2 = icmp slt i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([15 x i8], [15 x i8]* @str.2, i64 0, i64 0))
  br label %4

; <label>:4                                       ; preds = %3, %0
  %5 = getelementptr inbounds i8*, i8** %argv, i64 1
  %6 = load i8*, i8** %5, align 8
  %7 = tail call noalias i8* @malloc(i64 104) #4
  store i8* %7, i8** bitcast (%struct.Config** @config to i8**), align 8
  %8 = getelementptr inbounds i8, i8* %7, i64 100
  %9 = bitcast i8* %8 to i32*
  store i32 %1, i32* %9, align 4
  %10 = tail call i32 @strcmp(i8* %6, i8* nonnull getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0)) #5
  %11 = icmp eq i32 %10, 0
  %12 = bitcast i8* %7 to %struct.Config*
  br i1 %11, label %13, label %initConfig_clone.exit

; <label>:13                                      ; preds = %4
  %14 = tail call i64 @lseek(i32 %1, i64 11, i32 0) #4
  %.pre = load %struct.Config*, %struct.Config** @config, align 8
  br label %initConfig_clone.exit

initConfig_clone.exit:                            ; preds = %4, %13
  %15 = phi %struct.Config* [ %12, %4 ], [ %.pre, %13 ]
  %16 = getelementptr inbounds %struct.Config, %struct.Config* %15, i64 0, i32 1
  %17 = load i32, i32* %16, align 4
  %18 = getelementptr inbounds %struct.Config, %struct.Config* %15, i64 0, i32 0, i64 0
  %19 = tail call i64 @read(i32 %17, i8* %18, i64 11) #4
  %sext.i = shl i64 %19, 32
  %20 = ashr exact i64 %sext.i, 32
  %21 = load %struct.Config*, %struct.Config** @config, align 8
  %22 = getelementptr inbounds %struct.Config, %struct.Config* %21, i64 0, i32 0, i64 %20
  store i8 0, i8* %22, align 1
  %23 = load %struct.Config*, %struct.Config** @config, align 8
  %24 = getelementptr inbounds %struct.Config, %struct.Config* %23, i64 0, i32 0, i64 0
  %25 = tail call i32 @strcmp(i8* %24, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0)) #5
  %26 = icmp eq i32 %25, 0
  br i1 %26, label %27, label %28

; <label>:27                                      ; preds = %initConfig_clone.exit
  %puts.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.3, i64 0, i64 0)) #4
  br label %branchNotPruned_clone.exit

; <label>:28                                      ; preds = %initConfig_clone.exit
  %29 = tail call i32 @strcmp(i8* %24, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0)) #5
  %30 = icmp eq i32 %29, 0
  br i1 %30, label %31, label %branchNotPruned_clone.exit

; <label>:31                                      ; preds = %28
  %puts1.i = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.4, i64 0, i64 0)) #4
  br label %branchNotPruned_clone.exit

branchNotPruned_clone.exit:                       ; preds = %27, %28, %31
  ret i32 0
}

declare i32 @open(i8* nocapture readonly, i32, ...) #3

; Function Attrs: nounwind uwtable
define void @initConfig_clone(i8* nocapture readonly %str, i32 %fd) #0 {
  %1 = tail call noalias i8* @malloc(i64 104) #4
  store i8* %1, i8** bitcast (%struct.Config** @config to i8**), align 8
  %2 = getelementptr inbounds i8, i8* %1, i64 100
  %3 = bitcast i8* %2 to i32*
  store i32 %fd, i32* %3, align 4
  %4 = tail call i32 @strcmp(i8* %str, i8* getelementptr inbounds ([2 x i8], [2 x i8]* @.str.4, i64 0, i64 0)) #5
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %11

; <label>:6                                       ; preds = %0
  %7 = getelementptr inbounds i8, i8* %1, i64 100
  %8 = bitcast i8* %7 to i32*
  %9 = load i32, i32* %8, align 4
  %10 = tail call i64 @lseek(i32 %9, i64 11, i32 0) #4
  br label %11

; <label>:11                                      ; preds = %0, %6
  ret void
}

; Function Attrs: nounwind uwtable
define void @readConfig_clone() #0 {
  %1 = load %struct.Config*, %struct.Config** @config, align 8
  %2 = getelementptr inbounds %struct.Config, %struct.Config* %1, i64 0, i32 1
  %3 = load i32, i32* %2, align 4
  %4 = getelementptr inbounds %struct.Config, %struct.Config* %1, i64 0, i32 0, i64 0
  %5 = tail call i64 @read(i32 %3, i8* %4, i64 11) #4
  %sext = shl i64 %5, 32
  %6 = ashr exact i64 %sext, 32
  %7 = load %struct.Config*, %struct.Config** @config, align 8
  %8 = getelementptr inbounds %struct.Config, %struct.Config* %7, i64 0, i32 0, i64 %6
  store i8 0, i8* %8, align 1
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchNotPruned_clone(i8* nocapture readonly %buffer) #0 {
  %1 = tail call i32 @strcmp(i8* %buffer, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str, i64 0, i64 0)) #5
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.3, i64 0, i64 0))
  br label %8

; <label>:4                                       ; preds = %0
  %5 = tail call i32 @strcmp(i8* %buffer, i8* nonnull getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0)) #5
  %6 = icmp eq i32 %5, 0
  br i1 %6, label %7, label %8

; <label>:7                                       ; preds = %4
  %puts1 = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.4, i64 0, i64 0))
  br label %8

; <label>:8                                       ; preds = %4, %7, %3
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
