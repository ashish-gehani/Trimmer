; ModuleID = 'workdir/inter29t3.bc'
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
@0 = constant [6 x i8] c"hello\00"
@1 = constant [6 x i8] c"hello\00"
@2 = constant [6 x i8] c"hello\00"
@3 = constant [6 x i8] c"hello\00"
@4 = constant [6 x i8] c"hello\00"
@5 = constant [6 x i8] c"hello\00"

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
  %1 = alloca [5 x i8*], align 16
  %2 = alloca %struct.Config, align 8
  %3 = bitcast [5 x i8*]* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* %3, i8 0, i64 40, i32 16, i1 false)
  %4 = bitcast i8* %3 to [5 x i8*]*
  %5 = getelementptr [5 x i8*], [5 x i8*]* %4, i32 0, i32 0
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i32 0, i32 0), i8** %5
  %6 = getelementptr [5 x i8*], [5 x i8*]* %4, i32 0, i32 1
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i32 0, i32 0), i8** %6
  %7 = getelementptr [5 x i8*], [5 x i8*]* %4, i32 0, i32 2
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0), i8** %7
  %8 = getelementptr [5 x i8*], [5 x i8*]* %4, i32 0, i32 3
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.5, i32 0, i32 0), i8** %8
  %9 = getelementptr [5 x i8*], [5 x i8*]* %4, i32 0, i32 4
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i8** %9
  %10 = bitcast %struct.Config* %2 to i8*
  call void @llvm.memset.p0i8.i64(i8* %10, i8 0, i64 16, i32 8, i1 false)
  %11 = getelementptr inbounds [5 x i8*], [5 x i8*]* %1, i32 0, i32 0
  %12 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %13 = trunc i32 97 to i8
  %14 = sext i8 97 to i32
  %15 = icmp ne i32 97, -1
  br i1 true, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph.peel.begin

.lr.ph.peel.begin:                                ; preds = %.lr.ph.preheader
  br label %.lr.ph.peel

.lr.ph.peel:                                      ; preds = %.lr.ph.peel.begin
  %16 = sext i8 97 to i32
  switch i32 97, label %33 [
    i32 97, label %31
    i32 98, label %29
    i32 115, label %17
  ]

; <label>:17:                                     ; preds = %.lr.ph.peel
  %18 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %18, align 2
  %19 = load i8*, i8** @optarg, align 8
  %20 = call i64 @strlen(i8* %19) #5
  %21 = mul i64 1, %20
  %22 = call noalias i8* @malloc(i64 %21) #6
  %23 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %22, i8** %23, align 8
  %24 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %25 = load i8*, i8** %24, align 8
  %26 = load i8*, i8** @optarg, align 8
  %27 = load i8*, i8** @optarg, align 8
  %28 = call i64 @strlen(i8* %27) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %25, i8* %26, i64 %28, i32 1, i1 false)
  br label %33

; <label>:29:                                     ; preds = %.lr.ph.peel
  %30 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %30, align 1
  br label %33

; <label>:31:                                     ; preds = %.lr.ph.peel
  %32 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %32, align 8
  br label %33

; <label>:33:                                     ; preds = %31, %29, %17, %.lr.ph.peel
  %34 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %35 = trunc i32 98 to i8
  %36 = sext i8 98 to i32
  %37 = icmp ne i32 98, -1
  br i1 true, label %.lr.ph.peel.next, label %._crit_edge.loopexit

.lr.ph.peel.next:                                 ; preds = %33
  br label %.lr.ph.peel2

.lr.ph.peel2:                                     ; preds = %.lr.ph.peel.next
  %38 = sext i8 98 to i32
  switch i32 98, label %55 [
    i32 97, label %53
    i32 98, label %51
    i32 115, label %39
  ]

; <label>:39:                                     ; preds = %.lr.ph.peel2
  %40 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %40, align 2
  %41 = load i8*, i8** @optarg, align 8
  %42 = call i64 @strlen(i8* %41) #5
  %43 = mul i64 1, %42
  %44 = call noalias i8* @malloc(i64 %43) #6
  %45 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %44, i8** %45, align 8
  %46 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %47 = load i8*, i8** %46, align 8
  %48 = load i8*, i8** @optarg, align 8
  %49 = load i8*, i8** @optarg, align 8
  %50 = call i64 @strlen(i8* %49) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %47, i8* %48, i64 %50, i32 1, i1 false)
  br label %55

; <label>:51:                                     ; preds = %.lr.ph.peel2
  %52 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %52, align 1
  br label %55

; <label>:53:                                     ; preds = %.lr.ph.peel2
  %54 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %54, align 8
  br label %55

; <label>:55:                                     ; preds = %53, %51, %39, %.lr.ph.peel2
  %56 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %57 = trunc i32 115 to i8
  %58 = sext i8 115 to i32
  %59 = icmp ne i32 115, -1
  br i1 true, label %.lr.ph.peel.next1, label %._crit_edge.loopexit

.lr.ph.peel.next1:                                ; preds = %55
  br label %.lr.ph.peel4

.lr.ph.peel4:                                     ; preds = %.lr.ph.peel.next1
  %60 = sext i8 115 to i32
  switch i32 115, label %79 [
    i32 97, label %77
    i32 98, label %75
    i32 115, label %61
  ]

; <label>:61:                                     ; preds = %.lr.ph.peel4
  %62 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %62, align 2
  %63 = load i8*, i8** @optarg, align 8
  %64 = getelementptr [6 x i8], [6 x i8]* @2, i64 0, i64 0
  %65 = call i64 @strlen(i8* %64) #5
  %66 = mul i64 1, 5
  %67 = call noalias i8* @malloc(i64 5) #6
  %68 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %67, i8** %68, align 8
  %69 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %70 = load i8*, i8** %69, align 8
  %71 = load i8*, i8** @optarg, align 8
  %72 = load i8*, i8** @optarg, align 8
  %73 = getelementptr [6 x i8], [6 x i8]* @3, i64 0, i64 0
  %74 = call i64 @strlen(i8* %73) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %70, i8* %71, i64 5, i32 1, i1 false)
  br label %79

; <label>:75:                                     ; preds = %.lr.ph.peel4
  %76 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %76, align 1
  br label %79

; <label>:77:                                     ; preds = %.lr.ph.peel4
  %78 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %78, align 8
  br label %79

; <label>:79:                                     ; preds = %77, %75, %61, %.lr.ph.peel4
  %80 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %81 = trunc i32 -1 to i8
  %82 = sext i8 -1 to i32
  %83 = icmp ne i32 -1, -1
  br i1 false, label %.lr.ph.peel.next3, label %._crit_edge.loopexit

.lr.ph.peel.next3:                                ; preds = %79
  br label %.lr.ph.peel6

.lr.ph.peel6:                                     ; preds = %.lr.ph.peel.next3
  %84 = sext i8 -1 to i32
  switch i32 %84, label %101 [
    i32 97, label %99
    i32 98, label %97
    i32 115, label %85
  ]

; <label>:85:                                     ; preds = %.lr.ph.peel6
  %86 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %86, align 2
  %87 = load i8*, i8** @optarg, align 8
  %88 = call i64 @strlen(i8* %87) #5
  %89 = mul i64 1, %88
  %90 = call noalias i8* @malloc(i64 %89) #6
  %91 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %90, i8** %91, align 8
  %92 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %93 = load i8*, i8** %92, align 8
  %94 = load i8*, i8** @optarg, align 8
  %95 = load i8*, i8** @optarg, align 8
  %96 = call i64 @strlen(i8* %95) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %93, i8* %94, i64 %96, i32 1, i1 false)
  br label %101

; <label>:97:                                     ; preds = %.lr.ph.peel6
  %98 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %98, align 1
  br label %101

; <label>:99:                                     ; preds = %.lr.ph.peel6
  %100 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %100, align 8
  br label %101

; <label>:101:                                    ; preds = %99, %97, %85, %.lr.ph.peel6
  %102 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %103 = trunc i32 %102 to i8
  %104 = sext i8 %103 to i32
  %105 = icmp ne i32 %104, -1
  br i1 %105, label %.lr.ph.peel.next5, label %._crit_edge.loopexit

.lr.ph.peel.next5:                                ; preds = %101
  br label %.lr.ph.peel8

.lr.ph.peel8:                                     ; preds = %.lr.ph.peel.next5
  %106 = sext i8 %103 to i32
  switch i32 %106, label %123 [
    i32 97, label %121
    i32 98, label %119
    i32 115, label %107
  ]

; <label>:107:                                    ; preds = %.lr.ph.peel8
  %108 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %108, align 2
  %109 = load i8*, i8** @optarg, align 8
  %110 = call i64 @strlen(i8* %109) #5
  %111 = mul i64 1, %110
  %112 = call noalias i8* @malloc(i64 %111) #6
  %113 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %112, i8** %113, align 8
  %114 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %115 = load i8*, i8** %114, align 8
  %116 = load i8*, i8** @optarg, align 8
  %117 = load i8*, i8** @optarg, align 8
  %118 = call i64 @strlen(i8* %117) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %115, i8* %116, i64 %118, i32 1, i1 false)
  br label %123

; <label>:119:                                    ; preds = %.lr.ph.peel8
  %120 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %120, align 1
  br label %123

; <label>:121:                                    ; preds = %.lr.ph.peel8
  %122 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %122, align 8
  br label %123

; <label>:123:                                    ; preds = %121, %119, %107, %.lr.ph.peel8
  %124 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %125 = trunc i32 %124 to i8
  %126 = sext i8 %125 to i32
  %127 = icmp ne i32 %126, -1
  br i1 %127, label %.lr.ph.peel.next7, label %._crit_edge.loopexit

.lr.ph.peel.next7:                                ; preds = %123
  br label %.lr.ph.peel10

.lr.ph.peel10:                                    ; preds = %.lr.ph.peel.next7
  %128 = sext i8 %125 to i32
  switch i32 %128, label %145 [
    i32 97, label %143
    i32 98, label %141
    i32 115, label %129
  ]

; <label>:129:                                    ; preds = %.lr.ph.peel10
  %130 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %130, align 2
  %131 = load i8*, i8** @optarg, align 8
  %132 = call i64 @strlen(i8* %131) #5
  %133 = mul i64 1, %132
  %134 = call noalias i8* @malloc(i64 %133) #6
  %135 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %134, i8** %135, align 8
  %136 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %137 = load i8*, i8** %136, align 8
  %138 = load i8*, i8** @optarg, align 8
  %139 = load i8*, i8** @optarg, align 8
  %140 = call i64 @strlen(i8* %139) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %137, i8* %138, i64 %140, i32 1, i1 false)
  br label %145

; <label>:141:                                    ; preds = %.lr.ph.peel10
  %142 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %142, align 1
  br label %145

; <label>:143:                                    ; preds = %.lr.ph.peel10
  %144 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %144, align 8
  br label %145

; <label>:145:                                    ; preds = %143, %141, %129, %.lr.ph.peel10
  %146 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %147 = trunc i32 %146 to i8
  %148 = sext i8 %147 to i32
  %149 = icmp ne i32 %148, -1
  br i1 %149, label %.lr.ph.peel.next9, label %._crit_edge.loopexit

.lr.ph.peel.next9:                                ; preds = %145
  br label %.lr.ph.peel12

.lr.ph.peel12:                                    ; preds = %.lr.ph.peel.next9
  %150 = sext i8 %147 to i32
  switch i32 %150, label %167 [
    i32 97, label %165
    i32 98, label %163
    i32 115, label %151
  ]

; <label>:151:                                    ; preds = %.lr.ph.peel12
  %152 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %152, align 2
  %153 = load i8*, i8** @optarg, align 8
  %154 = call i64 @strlen(i8* %153) #5
  %155 = mul i64 1, %154
  %156 = call noalias i8* @malloc(i64 %155) #6
  %157 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %156, i8** %157, align 8
  %158 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %159 = load i8*, i8** %158, align 8
  %160 = load i8*, i8** @optarg, align 8
  %161 = load i8*, i8** @optarg, align 8
  %162 = call i64 @strlen(i8* %161) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %159, i8* %160, i64 %162, i32 1, i1 false)
  br label %167

; <label>:163:                                    ; preds = %.lr.ph.peel12
  %164 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %164, align 1
  br label %167

; <label>:165:                                    ; preds = %.lr.ph.peel12
  %166 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %166, align 8
  br label %167

; <label>:167:                                    ; preds = %165, %163, %151, %.lr.ph.peel12
  %168 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %169 = trunc i32 %168 to i8
  %170 = sext i8 %169 to i32
  %171 = icmp ne i32 %170, -1
  br i1 %171, label %.lr.ph.peel.next11, label %._crit_edge.loopexit

.lr.ph.peel.next11:                               ; preds = %167
  br label %.lr.ph.peel14

.lr.ph.peel14:                                    ; preds = %.lr.ph.peel.next11
  %172 = sext i8 %169 to i32
  switch i32 %172, label %189 [
    i32 97, label %187
    i32 98, label %185
    i32 115, label %173
  ]

; <label>:173:                                    ; preds = %.lr.ph.peel14
  %174 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %174, align 2
  %175 = load i8*, i8** @optarg, align 8
  %176 = call i64 @strlen(i8* %175) #5
  %177 = mul i64 1, %176
  %178 = call noalias i8* @malloc(i64 %177) #6
  %179 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %178, i8** %179, align 8
  %180 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %181 = load i8*, i8** %180, align 8
  %182 = load i8*, i8** @optarg, align 8
  %183 = load i8*, i8** @optarg, align 8
  %184 = call i64 @strlen(i8* %183) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %181, i8* %182, i64 %184, i32 1, i1 false)
  br label %189

; <label>:185:                                    ; preds = %.lr.ph.peel14
  %186 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %186, align 1
  br label %189

; <label>:187:                                    ; preds = %.lr.ph.peel14
  %188 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %188, align 8
  br label %189

; <label>:189:                                    ; preds = %187, %185, %173, %.lr.ph.peel14
  %190 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %191 = trunc i32 %190 to i8
  %192 = sext i8 %191 to i32
  %193 = icmp ne i32 %192, -1
  br i1 %193, label %.lr.ph.peel.next13, label %._crit_edge.loopexit

.lr.ph.peel.next13:                               ; preds = %189
  br label %.lr.ph.peel16

.lr.ph.peel16:                                    ; preds = %.lr.ph.peel.next13
  %194 = sext i8 %191 to i32
  switch i32 %194, label %211 [
    i32 97, label %209
    i32 98, label %207
    i32 115, label %195
  ]

; <label>:195:                                    ; preds = %.lr.ph.peel16
  %196 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %196, align 2
  %197 = load i8*, i8** @optarg, align 8
  %198 = call i64 @strlen(i8* %197) #5
  %199 = mul i64 1, %198
  %200 = call noalias i8* @malloc(i64 %199) #6
  %201 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %200, i8** %201, align 8
  %202 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %203 = load i8*, i8** %202, align 8
  %204 = load i8*, i8** @optarg, align 8
  %205 = load i8*, i8** @optarg, align 8
  %206 = call i64 @strlen(i8* %205) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %203, i8* %204, i64 %206, i32 1, i1 false)
  br label %211

; <label>:207:                                    ; preds = %.lr.ph.peel16
  %208 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %208, align 1
  br label %211

; <label>:209:                                    ; preds = %.lr.ph.peel16
  %210 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %210, align 8
  br label %211

; <label>:211:                                    ; preds = %209, %207, %195, %.lr.ph.peel16
  %212 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %213 = trunc i32 %212 to i8
  %214 = sext i8 %213 to i32
  %215 = icmp ne i32 %214, -1
  br i1 %215, label %.lr.ph.peel.next15, label %._crit_edge.loopexit

.lr.ph.peel.next15:                               ; preds = %211
  br label %.lr.ph.peel18

.lr.ph.peel18:                                    ; preds = %.lr.ph.peel.next15
  %216 = sext i8 %213 to i32
  switch i32 %216, label %233 [
    i32 97, label %231
    i32 98, label %229
    i32 115, label %217
  ]

; <label>:217:                                    ; preds = %.lr.ph.peel18
  %218 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %218, align 2
  %219 = load i8*, i8** @optarg, align 8
  %220 = call i64 @strlen(i8* %219) #5
  %221 = mul i64 1, %220
  %222 = call noalias i8* @malloc(i64 %221) #6
  %223 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %222, i8** %223, align 8
  %224 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %225 = load i8*, i8** %224, align 8
  %226 = load i8*, i8** @optarg, align 8
  %227 = load i8*, i8** @optarg, align 8
  %228 = call i64 @strlen(i8* %227) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %225, i8* %226, i64 %228, i32 1, i1 false)
  br label %233

; <label>:229:                                    ; preds = %.lr.ph.peel18
  %230 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %230, align 1
  br label %233

; <label>:231:                                    ; preds = %.lr.ph.peel18
  %232 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %232, align 8
  br label %233

; <label>:233:                                    ; preds = %231, %229, %217, %.lr.ph.peel18
  %234 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %235 = trunc i32 %234 to i8
  %236 = sext i8 %235 to i32
  %237 = icmp ne i32 %236, -1
  br i1 %237, label %.lr.ph.peel.next17, label %._crit_edge.loopexit

.lr.ph.peel.next17:                               ; preds = %233
  br label %.lr.ph.peel20

.lr.ph.peel20:                                    ; preds = %.lr.ph.peel.next17
  %238 = sext i8 %235 to i32
  switch i32 %238, label %255 [
    i32 97, label %253
    i32 98, label %251
    i32 115, label %239
  ]

; <label>:239:                                    ; preds = %.lr.ph.peel20
  %240 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %240, align 2
  %241 = load i8*, i8** @optarg, align 8
  %242 = call i64 @strlen(i8* %241) #5
  %243 = mul i64 1, %242
  %244 = call noalias i8* @malloc(i64 %243) #6
  %245 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %244, i8** %245, align 8
  %246 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %247 = load i8*, i8** %246, align 8
  %248 = load i8*, i8** @optarg, align 8
  %249 = load i8*, i8** @optarg, align 8
  %250 = call i64 @strlen(i8* %249) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %247, i8* %248, i64 %250, i32 1, i1 false)
  br label %255

; <label>:251:                                    ; preds = %.lr.ph.peel20
  %252 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %252, align 1
  br label %255

; <label>:253:                                    ; preds = %.lr.ph.peel20
  %254 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %254, align 8
  br label %255

; <label>:255:                                    ; preds = %253, %251, %239, %.lr.ph.peel20
  %256 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %257 = trunc i32 %256 to i8
  %258 = sext i8 %257 to i32
  %259 = icmp ne i32 %258, -1
  br i1 %259, label %.lr.ph.peel.next19, label %._crit_edge.loopexit

.lr.ph.peel.next19:                               ; preds = %255
  br label %.lr.ph.peel22

.lr.ph.peel22:                                    ; preds = %.lr.ph.peel.next19
  %260 = sext i8 %257 to i32
  switch i32 %260, label %277 [
    i32 97, label %275
    i32 98, label %273
    i32 115, label %261
  ]

; <label>:261:                                    ; preds = %.lr.ph.peel22
  %262 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %262, align 2
  %263 = load i8*, i8** @optarg, align 8
  %264 = call i64 @strlen(i8* %263) #5
  %265 = mul i64 1, %264
  %266 = call noalias i8* @malloc(i64 %265) #6
  %267 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %266, i8** %267, align 8
  %268 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %269 = load i8*, i8** %268, align 8
  %270 = load i8*, i8** @optarg, align 8
  %271 = load i8*, i8** @optarg, align 8
  %272 = call i64 @strlen(i8* %271) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %269, i8* %270, i64 %272, i32 1, i1 false)
  br label %277

; <label>:273:                                    ; preds = %.lr.ph.peel22
  %274 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %274, align 1
  br label %277

; <label>:275:                                    ; preds = %.lr.ph.peel22
  %276 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %276, align 8
  br label %277

; <label>:277:                                    ; preds = %275, %273, %261, %.lr.ph.peel22
  %278 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %279 = trunc i32 %278 to i8
  %280 = sext i8 %279 to i32
  %281 = icmp ne i32 %280, -1
  br i1 %281, label %.lr.ph.peel.next21, label %._crit_edge.loopexit

.lr.ph.peel.next21:                               ; preds = %277
  br label %.lr.ph.peel24

.lr.ph.peel24:                                    ; preds = %.lr.ph.peel.next21
  %282 = sext i8 %279 to i32
  switch i32 %282, label %299 [
    i32 97, label %297
    i32 98, label %295
    i32 115, label %283
  ]

; <label>:283:                                    ; preds = %.lr.ph.peel24
  %284 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %284, align 2
  %285 = load i8*, i8** @optarg, align 8
  %286 = call i64 @strlen(i8* %285) #5
  %287 = mul i64 1, %286
  %288 = call noalias i8* @malloc(i64 %287) #6
  %289 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %288, i8** %289, align 8
  %290 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %291 = load i8*, i8** %290, align 8
  %292 = load i8*, i8** @optarg, align 8
  %293 = load i8*, i8** @optarg, align 8
  %294 = call i64 @strlen(i8* %293) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %291, i8* %292, i64 %294, i32 1, i1 false)
  br label %299

; <label>:295:                                    ; preds = %.lr.ph.peel24
  %296 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %296, align 1
  br label %299

; <label>:297:                                    ; preds = %.lr.ph.peel24
  %298 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %298, align 8
  br label %299

; <label>:299:                                    ; preds = %297, %295, %283, %.lr.ph.peel24
  %300 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %301 = trunc i32 %300 to i8
  %302 = sext i8 %301 to i32
  %303 = icmp ne i32 %302, -1
  br i1 %303, label %.lr.ph.peel.next23, label %._crit_edge.loopexit

.lr.ph.peel.next23:                               ; preds = %299
  br label %.lr.ph.peel26

.lr.ph.peel26:                                    ; preds = %.lr.ph.peel.next23
  %304 = sext i8 %301 to i32
  switch i32 %304, label %321 [
    i32 97, label %319
    i32 98, label %317
    i32 115, label %305
  ]

; <label>:305:                                    ; preds = %.lr.ph.peel26
  %306 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %306, align 2
  %307 = load i8*, i8** @optarg, align 8
  %308 = call i64 @strlen(i8* %307) #5
  %309 = mul i64 1, %308
  %310 = call noalias i8* @malloc(i64 %309) #6
  %311 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %310, i8** %311, align 8
  %312 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %313 = load i8*, i8** %312, align 8
  %314 = load i8*, i8** @optarg, align 8
  %315 = load i8*, i8** @optarg, align 8
  %316 = call i64 @strlen(i8* %315) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %313, i8* %314, i64 %316, i32 1, i1 false)
  br label %321

; <label>:317:                                    ; preds = %.lr.ph.peel26
  %318 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %318, align 1
  br label %321

; <label>:319:                                    ; preds = %.lr.ph.peel26
  %320 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %320, align 8
  br label %321

; <label>:321:                                    ; preds = %319, %317, %305, %.lr.ph.peel26
  %322 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %323 = trunc i32 %322 to i8
  %324 = sext i8 %323 to i32
  %325 = icmp ne i32 %324, -1
  br i1 %325, label %.lr.ph.peel.next25, label %._crit_edge.loopexit

.lr.ph.peel.next25:                               ; preds = %321
  br label %.lr.ph.peel28

.lr.ph.peel28:                                    ; preds = %.lr.ph.peel.next25
  %326 = sext i8 %323 to i32
  switch i32 %326, label %343 [
    i32 97, label %341
    i32 98, label %339
    i32 115, label %327
  ]

; <label>:327:                                    ; preds = %.lr.ph.peel28
  %328 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %328, align 2
  %329 = load i8*, i8** @optarg, align 8
  %330 = call i64 @strlen(i8* %329) #5
  %331 = mul i64 1, %330
  %332 = call noalias i8* @malloc(i64 %331) #6
  %333 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %332, i8** %333, align 8
  %334 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %335 = load i8*, i8** %334, align 8
  %336 = load i8*, i8** @optarg, align 8
  %337 = load i8*, i8** @optarg, align 8
  %338 = call i64 @strlen(i8* %337) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %335, i8* %336, i64 %338, i32 1, i1 false)
  br label %343

; <label>:339:                                    ; preds = %.lr.ph.peel28
  %340 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %340, align 1
  br label %343

; <label>:341:                                    ; preds = %.lr.ph.peel28
  %342 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %342, align 8
  br label %343

; <label>:343:                                    ; preds = %341, %339, %327, %.lr.ph.peel28
  %344 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %345 = trunc i32 %344 to i8
  %346 = sext i8 %345 to i32
  %347 = icmp ne i32 %346, -1
  br i1 %347, label %.lr.ph.peel.next27, label %._crit_edge.loopexit

.lr.ph.peel.next27:                               ; preds = %343
  br label %.lr.ph.peel30

.lr.ph.peel30:                                    ; preds = %.lr.ph.peel.next27
  %348 = sext i8 %345 to i32
  switch i32 %348, label %365 [
    i32 97, label %363
    i32 98, label %361
    i32 115, label %349
  ]

; <label>:349:                                    ; preds = %.lr.ph.peel30
  %350 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %350, align 2
  %351 = load i8*, i8** @optarg, align 8
  %352 = call i64 @strlen(i8* %351) #5
  %353 = mul i64 1, %352
  %354 = call noalias i8* @malloc(i64 %353) #6
  %355 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %354, i8** %355, align 8
  %356 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %357 = load i8*, i8** %356, align 8
  %358 = load i8*, i8** @optarg, align 8
  %359 = load i8*, i8** @optarg, align 8
  %360 = call i64 @strlen(i8* %359) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %357, i8* %358, i64 %360, i32 1, i1 false)
  br label %365

; <label>:361:                                    ; preds = %.lr.ph.peel30
  %362 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %362, align 1
  br label %365

; <label>:363:                                    ; preds = %.lr.ph.peel30
  %364 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %364, align 8
  br label %365

; <label>:365:                                    ; preds = %363, %361, %349, %.lr.ph.peel30
  %366 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %367 = trunc i32 %366 to i8
  %368 = sext i8 %367 to i32
  %369 = icmp ne i32 %368, -1
  br i1 %369, label %.lr.ph.peel.next29, label %._crit_edge.loopexit

.lr.ph.peel.next29:                               ; preds = %365
  br label %.lr.ph.peel32

.lr.ph.peel32:                                    ; preds = %.lr.ph.peel.next29
  %370 = sext i8 %367 to i32
  switch i32 %370, label %387 [
    i32 97, label %385
    i32 98, label %383
    i32 115, label %371
  ]

; <label>:371:                                    ; preds = %.lr.ph.peel32
  %372 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %372, align 2
  %373 = load i8*, i8** @optarg, align 8
  %374 = call i64 @strlen(i8* %373) #5
  %375 = mul i64 1, %374
  %376 = call noalias i8* @malloc(i64 %375) #6
  %377 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %376, i8** %377, align 8
  %378 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %379 = load i8*, i8** %378, align 8
  %380 = load i8*, i8** @optarg, align 8
  %381 = load i8*, i8** @optarg, align 8
  %382 = call i64 @strlen(i8* %381) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %379, i8* %380, i64 %382, i32 1, i1 false)
  br label %387

; <label>:383:                                    ; preds = %.lr.ph.peel32
  %384 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %384, align 1
  br label %387

; <label>:385:                                    ; preds = %.lr.ph.peel32
  %386 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %386, align 8
  br label %387

; <label>:387:                                    ; preds = %385, %383, %371, %.lr.ph.peel32
  %388 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %389 = trunc i32 %388 to i8
  %390 = sext i8 %389 to i32
  %391 = icmp ne i32 %390, -1
  br i1 %391, label %.lr.ph.peel.next31, label %._crit_edge.loopexit

.lr.ph.peel.next31:                               ; preds = %387
  br label %.lr.ph.peel34

.lr.ph.peel34:                                    ; preds = %.lr.ph.peel.next31
  %392 = sext i8 %389 to i32
  switch i32 %392, label %409 [
    i32 97, label %407
    i32 98, label %405
    i32 115, label %393
  ]

; <label>:393:                                    ; preds = %.lr.ph.peel34
  %394 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %394, align 2
  %395 = load i8*, i8** @optarg, align 8
  %396 = call i64 @strlen(i8* %395) #5
  %397 = mul i64 1, %396
  %398 = call noalias i8* @malloc(i64 %397) #6
  %399 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %398, i8** %399, align 8
  %400 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %401 = load i8*, i8** %400, align 8
  %402 = load i8*, i8** @optarg, align 8
  %403 = load i8*, i8** @optarg, align 8
  %404 = call i64 @strlen(i8* %403) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %401, i8* %402, i64 %404, i32 1, i1 false)
  br label %409

; <label>:405:                                    ; preds = %.lr.ph.peel34
  %406 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %406, align 1
  br label %409

; <label>:407:                                    ; preds = %.lr.ph.peel34
  %408 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %408, align 8
  br label %409

; <label>:409:                                    ; preds = %407, %405, %393, %.lr.ph.peel34
  %410 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %411 = trunc i32 %410 to i8
  %412 = sext i8 %411 to i32
  %413 = icmp ne i32 %412, -1
  br i1 %413, label %.lr.ph.peel.next33, label %._crit_edge.loopexit

.lr.ph.peel.next33:                               ; preds = %409
  br label %.lr.ph.peel36

.lr.ph.peel36:                                    ; preds = %.lr.ph.peel.next33
  %414 = sext i8 %411 to i32
  switch i32 %414, label %431 [
    i32 97, label %429
    i32 98, label %427
    i32 115, label %415
  ]

; <label>:415:                                    ; preds = %.lr.ph.peel36
  %416 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %416, align 2
  %417 = load i8*, i8** @optarg, align 8
  %418 = call i64 @strlen(i8* %417) #5
  %419 = mul i64 1, %418
  %420 = call noalias i8* @malloc(i64 %419) #6
  %421 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %420, i8** %421, align 8
  %422 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %423 = load i8*, i8** %422, align 8
  %424 = load i8*, i8** @optarg, align 8
  %425 = load i8*, i8** @optarg, align 8
  %426 = call i64 @strlen(i8* %425) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %423, i8* %424, i64 %426, i32 1, i1 false)
  br label %431

; <label>:427:                                    ; preds = %.lr.ph.peel36
  %428 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %428, align 1
  br label %431

; <label>:429:                                    ; preds = %.lr.ph.peel36
  %430 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %430, align 8
  br label %431

; <label>:431:                                    ; preds = %429, %427, %415, %.lr.ph.peel36
  %432 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %433 = trunc i32 %432 to i8
  %434 = sext i8 %433 to i32
  %435 = icmp ne i32 %434, -1
  br i1 %435, label %.lr.ph.peel.next35, label %._crit_edge.loopexit

.lr.ph.peel.next35:                               ; preds = %431
  br label %.lr.ph.peel38

.lr.ph.peel38:                                    ; preds = %.lr.ph.peel.next35
  %436 = sext i8 %433 to i32
  switch i32 %436, label %453 [
    i32 97, label %451
    i32 98, label %449
    i32 115, label %437
  ]

; <label>:437:                                    ; preds = %.lr.ph.peel38
  %438 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %438, align 2
  %439 = load i8*, i8** @optarg, align 8
  %440 = call i64 @strlen(i8* %439) #5
  %441 = mul i64 1, %440
  %442 = call noalias i8* @malloc(i64 %441) #6
  %443 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %442, i8** %443, align 8
  %444 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %445 = load i8*, i8** %444, align 8
  %446 = load i8*, i8** @optarg, align 8
  %447 = load i8*, i8** @optarg, align 8
  %448 = call i64 @strlen(i8* %447) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %445, i8* %446, i64 %448, i32 1, i1 false)
  br label %453

; <label>:449:                                    ; preds = %.lr.ph.peel38
  %450 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %450, align 1
  br label %453

; <label>:451:                                    ; preds = %.lr.ph.peel38
  %452 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %452, align 8
  br label %453

; <label>:453:                                    ; preds = %451, %449, %437, %.lr.ph.peel38
  %454 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %455 = trunc i32 %454 to i8
  %456 = sext i8 %455 to i32
  %457 = icmp ne i32 %456, -1
  br i1 %457, label %.lr.ph.peel.next37, label %._crit_edge.loopexit

.lr.ph.peel.next37:                               ; preds = %453
  br label %.lr.ph.peel.next39

.lr.ph.peel.next39:                               ; preds = %.lr.ph.peel.next37
  br label %.lr.ph.preheader.peel.newph

.lr.ph.preheader.peel.newph:                      ; preds = %.lr.ph.peel.next39
  br label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph.preheader.peel.newph, %476
  %458 = phi i8 [ %478, %476 ], [ %455, %.lr.ph.preheader.peel.newph ]
  %459 = sext i8 %458 to i32
  switch i32 %459, label %476 [
    i32 97, label %460
    i32 98, label %462
    i32 115, label %464
  ]

; <label>:460:                                    ; preds = %.lr.ph
  %461 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %461, align 8
  br label %476

; <label>:462:                                    ; preds = %.lr.ph
  %463 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %463, align 1
  br label %476

; <label>:464:                                    ; preds = %.lr.ph
  %465 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %465, align 2
  %466 = load i8*, i8** @optarg, align 8
  %467 = call i64 @strlen(i8* %466) #5
  %468 = mul i64 1, %467
  %469 = call noalias i8* @malloc(i64 %468) #6
  %470 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %469, i8** %470, align 8
  %471 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %472 = load i8*, i8** %471, align 8
  %473 = load i8*, i8** @optarg, align 8
  %474 = load i8*, i8** @optarg, align 8
  %475 = call i64 @strlen(i8* %474) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %472, i8* %473, i64 %475, i32 1, i1 false)
  br label %476

; <label>:476:                                    ; preds = %.lr.ph, %464, %462, %460
  %477 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %478 = trunc i32 %477 to i8
  %479 = sext i8 %478 to i32
  %480 = icmp ne i32 %479, -1
  br i1 %480, label %.lr.ph, label %._crit_edge.loopexit.loopexit

._crit_edge.loopexit.loopexit:                    ; preds = %476
  br label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %._crit_edge.loopexit.loopexit, %453, %431, %409, %387, %365, %343, %321, %299, %277, %255, %233, %211, %189, %167, %145, %123, %101, %79, %55, %33
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %481 = bitcast %struct.Config* %2 to { i64, i8* }*
  %482 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %481, i32 0, i32 0
  %483 = load i64, i64* %482, align 8
  %484 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %481, i32 0, i32 1
  %485 = load i8*, i8** %484, align 8
  call void @branchPruned_clone(i64 65793, i8* %485)
  %486 = load i32, i32* @optind, align 4
  %487 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.7, i32 0, i32 0), i32 5)
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

; Function Attrs: noinline nounwind uwtable
define i32 @main_clone() #0 {
  %1 = alloca [5 x i8*], align 16
  %2 = alloca %struct.Config, align 8
  %3 = bitcast [5 x i8*]* %1 to i8*
  call void @llvm.memset.p0i8.i64(i8* %3, i8 0, i64 40, i32 16, i1 false)
  %4 = bitcast i8* %3 to [5 x i8*]*
  %5 = getelementptr [5 x i8*], [5 x i8*]* %4, i32 0, i32 0
  store i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i32 0, i32 0), i8** %5
  %6 = getelementptr [5 x i8*], [5 x i8*]* %4, i32 0, i32 1
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i32 0, i32 0), i8** %6
  %7 = getelementptr [5 x i8*], [5 x i8*]* %4, i32 0, i32 2
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0), i8** %7
  %8 = getelementptr [5 x i8*], [5 x i8*]* %4, i32 0, i32 3
  store i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.5, i32 0, i32 0), i8** %8
  %9 = getelementptr [5 x i8*], [5 x i8*]* %4, i32 0, i32 4
  store i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i8** %9
  %10 = bitcast %struct.Config* %2 to i8*
  call void @llvm.memset.p0i8.i64(i8* %10, i8 0, i64 16, i32 8, i1 false)
  %11 = getelementptr inbounds [5 x i8*], [5 x i8*]* %1, i32 0, i32 0
  %12 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %13 = trunc i32 97 to i8
  %14 = sext i8 97 to i32
  %15 = icmp ne i32 97, -1
  br i1 true, label %.lr.ph.preheader, label %._crit_edge

.lr.ph.preheader:                                 ; preds = %0
  br label %.lr.ph.peel.begin

.lr.ph.peel.begin:                                ; preds = %.lr.ph.preheader
  br label %.lr.ph.peel

.lr.ph.peel:                                      ; preds = %.lr.ph.peel.begin
  %16 = sext i8 97 to i32
  switch i32 97, label %33 [
    i32 97, label %31
    i32 98, label %29
    i32 115, label %17
  ]

; <label>:17:                                     ; preds = %.lr.ph.peel
  %18 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %18, align 2
  %19 = load i8*, i8** @optarg, align 8
  %20 = call i64 @strlen(i8* %19) #5
  %21 = mul i64 1, %20
  %22 = call noalias i8* @malloc(i64 %21) #6
  %23 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %22, i8** %23, align 8
  %24 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %25 = load i8*, i8** %24, align 8
  %26 = load i8*, i8** @optarg, align 8
  %27 = load i8*, i8** @optarg, align 8
  %28 = call i64 @strlen(i8* %27) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %25, i8* %26, i64 %28, i32 1, i1 false)
  br label %33

; <label>:29:                                     ; preds = %.lr.ph.peel
  %30 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %30, align 1
  br label %33

; <label>:31:                                     ; preds = %.lr.ph.peel
  %32 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %32, align 8
  br label %33

; <label>:33:                                     ; preds = %31, %29, %17, %.lr.ph.peel
  %34 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %35 = trunc i32 98 to i8
  %36 = sext i8 98 to i32
  %37 = icmp ne i32 98, -1
  br i1 true, label %.lr.ph.peel.next, label %._crit_edge.loopexit

.lr.ph.peel.next:                                 ; preds = %33
  br label %.lr.ph.peel2

.lr.ph.peel2:                                     ; preds = %.lr.ph.peel.next
  %38 = sext i8 98 to i32
  switch i32 98, label %55 [
    i32 97, label %53
    i32 98, label %51
    i32 115, label %39
  ]

; <label>:39:                                     ; preds = %.lr.ph.peel2
  %40 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %40, align 2
  %41 = load i8*, i8** @optarg, align 8
  %42 = call i64 @strlen(i8* %41) #5
  %43 = mul i64 1, %42
  %44 = call noalias i8* @malloc(i64 %43) #6
  %45 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %44, i8** %45, align 8
  %46 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %47 = load i8*, i8** %46, align 8
  %48 = load i8*, i8** @optarg, align 8
  %49 = load i8*, i8** @optarg, align 8
  %50 = call i64 @strlen(i8* %49) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %47, i8* %48, i64 %50, i32 1, i1 false)
  br label %55

; <label>:51:                                     ; preds = %.lr.ph.peel2
  %52 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %52, align 1
  br label %55

; <label>:53:                                     ; preds = %.lr.ph.peel2
  %54 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %54, align 8
  br label %55

; <label>:55:                                     ; preds = %53, %51, %39, %.lr.ph.peel2
  %56 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %57 = trunc i32 115 to i8
  %58 = sext i8 115 to i32
  %59 = icmp ne i32 115, -1
  br i1 true, label %.lr.ph.peel.next1, label %._crit_edge.loopexit

.lr.ph.peel.next1:                                ; preds = %55
  br label %.lr.ph.peel4

.lr.ph.peel4:                                     ; preds = %.lr.ph.peel.next1
  %60 = sext i8 115 to i32
  switch i32 115, label %79 [
    i32 97, label %77
    i32 98, label %75
    i32 115, label %61
  ]

; <label>:61:                                     ; preds = %.lr.ph.peel4
  %62 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %62, align 2
  %63 = load i8*, i8** @optarg, align 8
  %64 = getelementptr [6 x i8], [6 x i8]* @0, i64 0, i64 0
  %65 = call i64 @strlen(i8* %64) #5
  %66 = mul i64 1, 5
  %67 = call noalias i8* @malloc(i64 5) #6
  %68 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %67, i8** %68, align 8
  %69 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %70 = load i8*, i8** %69, align 8
  %71 = load i8*, i8** @optarg, align 8
  %72 = load i8*, i8** @optarg, align 8
  %73 = getelementptr [6 x i8], [6 x i8]* @1, i64 0, i64 0
  %74 = call i64 @strlen(i8* %73) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %70, i8* %71, i64 5, i32 1, i1 false)
  br label %79

; <label>:75:                                     ; preds = %.lr.ph.peel4
  %76 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %76, align 1
  br label %79

; <label>:77:                                     ; preds = %.lr.ph.peel4
  %78 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %78, align 8
  br label %79

; <label>:79:                                     ; preds = %77, %75, %61, %.lr.ph.peel4
  %80 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %81 = trunc i32 -1 to i8
  %82 = sext i8 -1 to i32
  %83 = icmp ne i32 -1, -1
  br i1 false, label %.lr.ph.peel.next3, label %._crit_edge.loopexit

.lr.ph.peel.next3:                                ; preds = %79
  br label %.lr.ph.peel6

.lr.ph.peel6:                                     ; preds = %.lr.ph.peel.next3
  %84 = sext i8 -1 to i32
  switch i32 %84, label %101 [
    i32 97, label %99
    i32 98, label %97
    i32 115, label %85
  ]

; <label>:85:                                     ; preds = %.lr.ph.peel6
  %86 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %86, align 2
  %87 = load i8*, i8** @optarg, align 8
  %88 = call i64 @strlen(i8* %87) #5
  %89 = mul i64 1, %88
  %90 = call noalias i8* @malloc(i64 %89) #6
  %91 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %90, i8** %91, align 8
  %92 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %93 = load i8*, i8** %92, align 8
  %94 = load i8*, i8** @optarg, align 8
  %95 = load i8*, i8** @optarg, align 8
  %96 = call i64 @strlen(i8* %95) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %93, i8* %94, i64 %96, i32 1, i1 false)
  br label %101

; <label>:97:                                     ; preds = %.lr.ph.peel6
  %98 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %98, align 1
  br label %101

; <label>:99:                                     ; preds = %.lr.ph.peel6
  %100 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %100, align 8
  br label %101

; <label>:101:                                    ; preds = %99, %97, %85, %.lr.ph.peel6
  %102 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %103 = trunc i32 %102 to i8
  %104 = sext i8 %103 to i32
  %105 = icmp ne i32 %104, -1
  br i1 %105, label %.lr.ph.peel.next5, label %._crit_edge.loopexit

.lr.ph.peel.next5:                                ; preds = %101
  br label %.lr.ph.peel8

.lr.ph.peel8:                                     ; preds = %.lr.ph.peel.next5
  %106 = sext i8 %103 to i32
  switch i32 %106, label %123 [
    i32 97, label %121
    i32 98, label %119
    i32 115, label %107
  ]

; <label>:107:                                    ; preds = %.lr.ph.peel8
  %108 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %108, align 2
  %109 = load i8*, i8** @optarg, align 8
  %110 = call i64 @strlen(i8* %109) #5
  %111 = mul i64 1, %110
  %112 = call noalias i8* @malloc(i64 %111) #6
  %113 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %112, i8** %113, align 8
  %114 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %115 = load i8*, i8** %114, align 8
  %116 = load i8*, i8** @optarg, align 8
  %117 = load i8*, i8** @optarg, align 8
  %118 = call i64 @strlen(i8* %117) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %115, i8* %116, i64 %118, i32 1, i1 false)
  br label %123

; <label>:119:                                    ; preds = %.lr.ph.peel8
  %120 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %120, align 1
  br label %123

; <label>:121:                                    ; preds = %.lr.ph.peel8
  %122 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %122, align 8
  br label %123

; <label>:123:                                    ; preds = %121, %119, %107, %.lr.ph.peel8
  %124 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %125 = trunc i32 %124 to i8
  %126 = sext i8 %125 to i32
  %127 = icmp ne i32 %126, -1
  br i1 %127, label %.lr.ph.peel.next7, label %._crit_edge.loopexit

.lr.ph.peel.next7:                                ; preds = %123
  br label %.lr.ph.peel10

.lr.ph.peel10:                                    ; preds = %.lr.ph.peel.next7
  %128 = sext i8 %125 to i32
  switch i32 %128, label %145 [
    i32 97, label %143
    i32 98, label %141
    i32 115, label %129
  ]

; <label>:129:                                    ; preds = %.lr.ph.peel10
  %130 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %130, align 2
  %131 = load i8*, i8** @optarg, align 8
  %132 = call i64 @strlen(i8* %131) #5
  %133 = mul i64 1, %132
  %134 = call noalias i8* @malloc(i64 %133) #6
  %135 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %134, i8** %135, align 8
  %136 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %137 = load i8*, i8** %136, align 8
  %138 = load i8*, i8** @optarg, align 8
  %139 = load i8*, i8** @optarg, align 8
  %140 = call i64 @strlen(i8* %139) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %137, i8* %138, i64 %140, i32 1, i1 false)
  br label %145

; <label>:141:                                    ; preds = %.lr.ph.peel10
  %142 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %142, align 1
  br label %145

; <label>:143:                                    ; preds = %.lr.ph.peel10
  %144 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %144, align 8
  br label %145

; <label>:145:                                    ; preds = %143, %141, %129, %.lr.ph.peel10
  %146 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %147 = trunc i32 %146 to i8
  %148 = sext i8 %147 to i32
  %149 = icmp ne i32 %148, -1
  br i1 %149, label %.lr.ph.peel.next9, label %._crit_edge.loopexit

.lr.ph.peel.next9:                                ; preds = %145
  br label %.lr.ph.peel12

.lr.ph.peel12:                                    ; preds = %.lr.ph.peel.next9
  %150 = sext i8 %147 to i32
  switch i32 %150, label %167 [
    i32 97, label %165
    i32 98, label %163
    i32 115, label %151
  ]

; <label>:151:                                    ; preds = %.lr.ph.peel12
  %152 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %152, align 2
  %153 = load i8*, i8** @optarg, align 8
  %154 = call i64 @strlen(i8* %153) #5
  %155 = mul i64 1, %154
  %156 = call noalias i8* @malloc(i64 %155) #6
  %157 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %156, i8** %157, align 8
  %158 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %159 = load i8*, i8** %158, align 8
  %160 = load i8*, i8** @optarg, align 8
  %161 = load i8*, i8** @optarg, align 8
  %162 = call i64 @strlen(i8* %161) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %159, i8* %160, i64 %162, i32 1, i1 false)
  br label %167

; <label>:163:                                    ; preds = %.lr.ph.peel12
  %164 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %164, align 1
  br label %167

; <label>:165:                                    ; preds = %.lr.ph.peel12
  %166 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %166, align 8
  br label %167

; <label>:167:                                    ; preds = %165, %163, %151, %.lr.ph.peel12
  %168 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %169 = trunc i32 %168 to i8
  %170 = sext i8 %169 to i32
  %171 = icmp ne i32 %170, -1
  br i1 %171, label %.lr.ph.peel.next11, label %._crit_edge.loopexit

.lr.ph.peel.next11:                               ; preds = %167
  br label %.lr.ph.peel14

.lr.ph.peel14:                                    ; preds = %.lr.ph.peel.next11
  %172 = sext i8 %169 to i32
  switch i32 %172, label %189 [
    i32 97, label %187
    i32 98, label %185
    i32 115, label %173
  ]

; <label>:173:                                    ; preds = %.lr.ph.peel14
  %174 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %174, align 2
  %175 = load i8*, i8** @optarg, align 8
  %176 = call i64 @strlen(i8* %175) #5
  %177 = mul i64 1, %176
  %178 = call noalias i8* @malloc(i64 %177) #6
  %179 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %178, i8** %179, align 8
  %180 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %181 = load i8*, i8** %180, align 8
  %182 = load i8*, i8** @optarg, align 8
  %183 = load i8*, i8** @optarg, align 8
  %184 = call i64 @strlen(i8* %183) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %181, i8* %182, i64 %184, i32 1, i1 false)
  br label %189

; <label>:185:                                    ; preds = %.lr.ph.peel14
  %186 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %186, align 1
  br label %189

; <label>:187:                                    ; preds = %.lr.ph.peel14
  %188 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %188, align 8
  br label %189

; <label>:189:                                    ; preds = %187, %185, %173, %.lr.ph.peel14
  %190 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %191 = trunc i32 %190 to i8
  %192 = sext i8 %191 to i32
  %193 = icmp ne i32 %192, -1
  br i1 %193, label %.lr.ph.peel.next13, label %._crit_edge.loopexit

.lr.ph.peel.next13:                               ; preds = %189
  br label %.lr.ph.peel16

.lr.ph.peel16:                                    ; preds = %.lr.ph.peel.next13
  %194 = sext i8 %191 to i32
  switch i32 %194, label %211 [
    i32 97, label %209
    i32 98, label %207
    i32 115, label %195
  ]

; <label>:195:                                    ; preds = %.lr.ph.peel16
  %196 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %196, align 2
  %197 = load i8*, i8** @optarg, align 8
  %198 = call i64 @strlen(i8* %197) #5
  %199 = mul i64 1, %198
  %200 = call noalias i8* @malloc(i64 %199) #6
  %201 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %200, i8** %201, align 8
  %202 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %203 = load i8*, i8** %202, align 8
  %204 = load i8*, i8** @optarg, align 8
  %205 = load i8*, i8** @optarg, align 8
  %206 = call i64 @strlen(i8* %205) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %203, i8* %204, i64 %206, i32 1, i1 false)
  br label %211

; <label>:207:                                    ; preds = %.lr.ph.peel16
  %208 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %208, align 1
  br label %211

; <label>:209:                                    ; preds = %.lr.ph.peel16
  %210 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %210, align 8
  br label %211

; <label>:211:                                    ; preds = %209, %207, %195, %.lr.ph.peel16
  %212 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %213 = trunc i32 %212 to i8
  %214 = sext i8 %213 to i32
  %215 = icmp ne i32 %214, -1
  br i1 %215, label %.lr.ph.peel.next15, label %._crit_edge.loopexit

.lr.ph.peel.next15:                               ; preds = %211
  br label %.lr.ph.peel18

.lr.ph.peel18:                                    ; preds = %.lr.ph.peel.next15
  %216 = sext i8 %213 to i32
  switch i32 %216, label %233 [
    i32 97, label %231
    i32 98, label %229
    i32 115, label %217
  ]

; <label>:217:                                    ; preds = %.lr.ph.peel18
  %218 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %218, align 2
  %219 = load i8*, i8** @optarg, align 8
  %220 = call i64 @strlen(i8* %219) #5
  %221 = mul i64 1, %220
  %222 = call noalias i8* @malloc(i64 %221) #6
  %223 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %222, i8** %223, align 8
  %224 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %225 = load i8*, i8** %224, align 8
  %226 = load i8*, i8** @optarg, align 8
  %227 = load i8*, i8** @optarg, align 8
  %228 = call i64 @strlen(i8* %227) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %225, i8* %226, i64 %228, i32 1, i1 false)
  br label %233

; <label>:229:                                    ; preds = %.lr.ph.peel18
  %230 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %230, align 1
  br label %233

; <label>:231:                                    ; preds = %.lr.ph.peel18
  %232 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %232, align 8
  br label %233

; <label>:233:                                    ; preds = %231, %229, %217, %.lr.ph.peel18
  %234 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %235 = trunc i32 %234 to i8
  %236 = sext i8 %235 to i32
  %237 = icmp ne i32 %236, -1
  br i1 %237, label %.lr.ph.peel.next17, label %._crit_edge.loopexit

.lr.ph.peel.next17:                               ; preds = %233
  br label %.lr.ph.peel20

.lr.ph.peel20:                                    ; preds = %.lr.ph.peel.next17
  %238 = sext i8 %235 to i32
  switch i32 %238, label %255 [
    i32 97, label %253
    i32 98, label %251
    i32 115, label %239
  ]

; <label>:239:                                    ; preds = %.lr.ph.peel20
  %240 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %240, align 2
  %241 = load i8*, i8** @optarg, align 8
  %242 = call i64 @strlen(i8* %241) #5
  %243 = mul i64 1, %242
  %244 = call noalias i8* @malloc(i64 %243) #6
  %245 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %244, i8** %245, align 8
  %246 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %247 = load i8*, i8** %246, align 8
  %248 = load i8*, i8** @optarg, align 8
  %249 = load i8*, i8** @optarg, align 8
  %250 = call i64 @strlen(i8* %249) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %247, i8* %248, i64 %250, i32 1, i1 false)
  br label %255

; <label>:251:                                    ; preds = %.lr.ph.peel20
  %252 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %252, align 1
  br label %255

; <label>:253:                                    ; preds = %.lr.ph.peel20
  %254 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %254, align 8
  br label %255

; <label>:255:                                    ; preds = %253, %251, %239, %.lr.ph.peel20
  %256 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %257 = trunc i32 %256 to i8
  %258 = sext i8 %257 to i32
  %259 = icmp ne i32 %258, -1
  br i1 %259, label %.lr.ph.peel.next19, label %._crit_edge.loopexit

.lr.ph.peel.next19:                               ; preds = %255
  br label %.lr.ph.peel22

.lr.ph.peel22:                                    ; preds = %.lr.ph.peel.next19
  %260 = sext i8 %257 to i32
  switch i32 %260, label %277 [
    i32 97, label %275
    i32 98, label %273
    i32 115, label %261
  ]

; <label>:261:                                    ; preds = %.lr.ph.peel22
  %262 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %262, align 2
  %263 = load i8*, i8** @optarg, align 8
  %264 = call i64 @strlen(i8* %263) #5
  %265 = mul i64 1, %264
  %266 = call noalias i8* @malloc(i64 %265) #6
  %267 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %266, i8** %267, align 8
  %268 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %269 = load i8*, i8** %268, align 8
  %270 = load i8*, i8** @optarg, align 8
  %271 = load i8*, i8** @optarg, align 8
  %272 = call i64 @strlen(i8* %271) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %269, i8* %270, i64 %272, i32 1, i1 false)
  br label %277

; <label>:273:                                    ; preds = %.lr.ph.peel22
  %274 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %274, align 1
  br label %277

; <label>:275:                                    ; preds = %.lr.ph.peel22
  %276 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %276, align 8
  br label %277

; <label>:277:                                    ; preds = %275, %273, %261, %.lr.ph.peel22
  %278 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %279 = trunc i32 %278 to i8
  %280 = sext i8 %279 to i32
  %281 = icmp ne i32 %280, -1
  br i1 %281, label %.lr.ph.peel.next21, label %._crit_edge.loopexit

.lr.ph.peel.next21:                               ; preds = %277
  br label %.lr.ph.peel24

.lr.ph.peel24:                                    ; preds = %.lr.ph.peel.next21
  %282 = sext i8 %279 to i32
  switch i32 %282, label %299 [
    i32 97, label %297
    i32 98, label %295
    i32 115, label %283
  ]

; <label>:283:                                    ; preds = %.lr.ph.peel24
  %284 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %284, align 2
  %285 = load i8*, i8** @optarg, align 8
  %286 = call i64 @strlen(i8* %285) #5
  %287 = mul i64 1, %286
  %288 = call noalias i8* @malloc(i64 %287) #6
  %289 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %288, i8** %289, align 8
  %290 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %291 = load i8*, i8** %290, align 8
  %292 = load i8*, i8** @optarg, align 8
  %293 = load i8*, i8** @optarg, align 8
  %294 = call i64 @strlen(i8* %293) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %291, i8* %292, i64 %294, i32 1, i1 false)
  br label %299

; <label>:295:                                    ; preds = %.lr.ph.peel24
  %296 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %296, align 1
  br label %299

; <label>:297:                                    ; preds = %.lr.ph.peel24
  %298 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %298, align 8
  br label %299

; <label>:299:                                    ; preds = %297, %295, %283, %.lr.ph.peel24
  %300 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %301 = trunc i32 %300 to i8
  %302 = sext i8 %301 to i32
  %303 = icmp ne i32 %302, -1
  br i1 %303, label %.lr.ph.peel.next23, label %._crit_edge.loopexit

.lr.ph.peel.next23:                               ; preds = %299
  br label %.lr.ph.peel26

.lr.ph.peel26:                                    ; preds = %.lr.ph.peel.next23
  %304 = sext i8 %301 to i32
  switch i32 %304, label %321 [
    i32 97, label %319
    i32 98, label %317
    i32 115, label %305
  ]

; <label>:305:                                    ; preds = %.lr.ph.peel26
  %306 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %306, align 2
  %307 = load i8*, i8** @optarg, align 8
  %308 = call i64 @strlen(i8* %307) #5
  %309 = mul i64 1, %308
  %310 = call noalias i8* @malloc(i64 %309) #6
  %311 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %310, i8** %311, align 8
  %312 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %313 = load i8*, i8** %312, align 8
  %314 = load i8*, i8** @optarg, align 8
  %315 = load i8*, i8** @optarg, align 8
  %316 = call i64 @strlen(i8* %315) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %313, i8* %314, i64 %316, i32 1, i1 false)
  br label %321

; <label>:317:                                    ; preds = %.lr.ph.peel26
  %318 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %318, align 1
  br label %321

; <label>:319:                                    ; preds = %.lr.ph.peel26
  %320 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %320, align 8
  br label %321

; <label>:321:                                    ; preds = %319, %317, %305, %.lr.ph.peel26
  %322 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %323 = trunc i32 %322 to i8
  %324 = sext i8 %323 to i32
  %325 = icmp ne i32 %324, -1
  br i1 %325, label %.lr.ph.peel.next25, label %._crit_edge.loopexit

.lr.ph.peel.next25:                               ; preds = %321
  br label %.lr.ph.peel28

.lr.ph.peel28:                                    ; preds = %.lr.ph.peel.next25
  %326 = sext i8 %323 to i32
  switch i32 %326, label %343 [
    i32 97, label %341
    i32 98, label %339
    i32 115, label %327
  ]

; <label>:327:                                    ; preds = %.lr.ph.peel28
  %328 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %328, align 2
  %329 = load i8*, i8** @optarg, align 8
  %330 = call i64 @strlen(i8* %329) #5
  %331 = mul i64 1, %330
  %332 = call noalias i8* @malloc(i64 %331) #6
  %333 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %332, i8** %333, align 8
  %334 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %335 = load i8*, i8** %334, align 8
  %336 = load i8*, i8** @optarg, align 8
  %337 = load i8*, i8** @optarg, align 8
  %338 = call i64 @strlen(i8* %337) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %335, i8* %336, i64 %338, i32 1, i1 false)
  br label %343

; <label>:339:                                    ; preds = %.lr.ph.peel28
  %340 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %340, align 1
  br label %343

; <label>:341:                                    ; preds = %.lr.ph.peel28
  %342 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %342, align 8
  br label %343

; <label>:343:                                    ; preds = %341, %339, %327, %.lr.ph.peel28
  %344 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %345 = trunc i32 %344 to i8
  %346 = sext i8 %345 to i32
  %347 = icmp ne i32 %346, -1
  br i1 %347, label %.lr.ph.peel.next27, label %._crit_edge.loopexit

.lr.ph.peel.next27:                               ; preds = %343
  br label %.lr.ph.peel30

.lr.ph.peel30:                                    ; preds = %.lr.ph.peel.next27
  %348 = sext i8 %345 to i32
  switch i32 %348, label %365 [
    i32 97, label %363
    i32 98, label %361
    i32 115, label %349
  ]

; <label>:349:                                    ; preds = %.lr.ph.peel30
  %350 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %350, align 2
  %351 = load i8*, i8** @optarg, align 8
  %352 = call i64 @strlen(i8* %351) #5
  %353 = mul i64 1, %352
  %354 = call noalias i8* @malloc(i64 %353) #6
  %355 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %354, i8** %355, align 8
  %356 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %357 = load i8*, i8** %356, align 8
  %358 = load i8*, i8** @optarg, align 8
  %359 = load i8*, i8** @optarg, align 8
  %360 = call i64 @strlen(i8* %359) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %357, i8* %358, i64 %360, i32 1, i1 false)
  br label %365

; <label>:361:                                    ; preds = %.lr.ph.peel30
  %362 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %362, align 1
  br label %365

; <label>:363:                                    ; preds = %.lr.ph.peel30
  %364 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %364, align 8
  br label %365

; <label>:365:                                    ; preds = %363, %361, %349, %.lr.ph.peel30
  %366 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %367 = trunc i32 %366 to i8
  %368 = sext i8 %367 to i32
  %369 = icmp ne i32 %368, -1
  br i1 %369, label %.lr.ph.peel.next29, label %._crit_edge.loopexit

.lr.ph.peel.next29:                               ; preds = %365
  br label %.lr.ph.peel32

.lr.ph.peel32:                                    ; preds = %.lr.ph.peel.next29
  %370 = sext i8 %367 to i32
  switch i32 %370, label %387 [
    i32 97, label %385
    i32 98, label %383
    i32 115, label %371
  ]

; <label>:371:                                    ; preds = %.lr.ph.peel32
  %372 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %372, align 2
  %373 = load i8*, i8** @optarg, align 8
  %374 = call i64 @strlen(i8* %373) #5
  %375 = mul i64 1, %374
  %376 = call noalias i8* @malloc(i64 %375) #6
  %377 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %376, i8** %377, align 8
  %378 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %379 = load i8*, i8** %378, align 8
  %380 = load i8*, i8** @optarg, align 8
  %381 = load i8*, i8** @optarg, align 8
  %382 = call i64 @strlen(i8* %381) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %379, i8* %380, i64 %382, i32 1, i1 false)
  br label %387

; <label>:383:                                    ; preds = %.lr.ph.peel32
  %384 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %384, align 1
  br label %387

; <label>:385:                                    ; preds = %.lr.ph.peel32
  %386 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %386, align 8
  br label %387

; <label>:387:                                    ; preds = %385, %383, %371, %.lr.ph.peel32
  %388 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %389 = trunc i32 %388 to i8
  %390 = sext i8 %389 to i32
  %391 = icmp ne i32 %390, -1
  br i1 %391, label %.lr.ph.peel.next31, label %._crit_edge.loopexit

.lr.ph.peel.next31:                               ; preds = %387
  br label %.lr.ph.peel34

.lr.ph.peel34:                                    ; preds = %.lr.ph.peel.next31
  %392 = sext i8 %389 to i32
  switch i32 %392, label %409 [
    i32 97, label %407
    i32 98, label %405
    i32 115, label %393
  ]

; <label>:393:                                    ; preds = %.lr.ph.peel34
  %394 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %394, align 2
  %395 = load i8*, i8** @optarg, align 8
  %396 = call i64 @strlen(i8* %395) #5
  %397 = mul i64 1, %396
  %398 = call noalias i8* @malloc(i64 %397) #6
  %399 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %398, i8** %399, align 8
  %400 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %401 = load i8*, i8** %400, align 8
  %402 = load i8*, i8** @optarg, align 8
  %403 = load i8*, i8** @optarg, align 8
  %404 = call i64 @strlen(i8* %403) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %401, i8* %402, i64 %404, i32 1, i1 false)
  br label %409

; <label>:405:                                    ; preds = %.lr.ph.peel34
  %406 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %406, align 1
  br label %409

; <label>:407:                                    ; preds = %.lr.ph.peel34
  %408 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %408, align 8
  br label %409

; <label>:409:                                    ; preds = %407, %405, %393, %.lr.ph.peel34
  %410 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %411 = trunc i32 %410 to i8
  %412 = sext i8 %411 to i32
  %413 = icmp ne i32 %412, -1
  br i1 %413, label %.lr.ph.peel.next33, label %._crit_edge.loopexit

.lr.ph.peel.next33:                               ; preds = %409
  br label %.lr.ph.peel36

.lr.ph.peel36:                                    ; preds = %.lr.ph.peel.next33
  %414 = sext i8 %411 to i32
  switch i32 %414, label %431 [
    i32 97, label %429
    i32 98, label %427
    i32 115, label %415
  ]

; <label>:415:                                    ; preds = %.lr.ph.peel36
  %416 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %416, align 2
  %417 = load i8*, i8** @optarg, align 8
  %418 = call i64 @strlen(i8* %417) #5
  %419 = mul i64 1, %418
  %420 = call noalias i8* @malloc(i64 %419) #6
  %421 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %420, i8** %421, align 8
  %422 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %423 = load i8*, i8** %422, align 8
  %424 = load i8*, i8** @optarg, align 8
  %425 = load i8*, i8** @optarg, align 8
  %426 = call i64 @strlen(i8* %425) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %423, i8* %424, i64 %426, i32 1, i1 false)
  br label %431

; <label>:427:                                    ; preds = %.lr.ph.peel36
  %428 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %428, align 1
  br label %431

; <label>:429:                                    ; preds = %.lr.ph.peel36
  %430 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %430, align 8
  br label %431

; <label>:431:                                    ; preds = %429, %427, %415, %.lr.ph.peel36
  %432 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %433 = trunc i32 %432 to i8
  %434 = sext i8 %433 to i32
  %435 = icmp ne i32 %434, -1
  br i1 %435, label %.lr.ph.peel.next35, label %._crit_edge.loopexit

.lr.ph.peel.next35:                               ; preds = %431
  br label %.lr.ph.peel38

.lr.ph.peel38:                                    ; preds = %.lr.ph.peel.next35
  %436 = sext i8 %433 to i32
  switch i32 %436, label %453 [
    i32 97, label %451
    i32 98, label %449
    i32 115, label %437
  ]

; <label>:437:                                    ; preds = %.lr.ph.peel38
  %438 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %438, align 2
  %439 = load i8*, i8** @optarg, align 8
  %440 = call i64 @strlen(i8* %439) #5
  %441 = mul i64 1, %440
  %442 = call noalias i8* @malloc(i64 %441) #6
  %443 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %442, i8** %443, align 8
  %444 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %445 = load i8*, i8** %444, align 8
  %446 = load i8*, i8** @optarg, align 8
  %447 = load i8*, i8** @optarg, align 8
  %448 = call i64 @strlen(i8* %447) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %445, i8* %446, i64 %448, i32 1, i1 false)
  br label %453

; <label>:449:                                    ; preds = %.lr.ph.peel38
  %450 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %450, align 1
  br label %453

; <label>:451:                                    ; preds = %.lr.ph.peel38
  %452 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %452, align 8
  br label %453

; <label>:453:                                    ; preds = %451, %449, %437, %.lr.ph.peel38
  %454 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %455 = trunc i32 %454 to i8
  %456 = sext i8 %455 to i32
  %457 = icmp ne i32 %456, -1
  br i1 %457, label %.lr.ph.peel.next37, label %._crit_edge.loopexit

.lr.ph.peel.next37:                               ; preds = %453
  br label %.lr.ph.peel.next39

.lr.ph.peel.next39:                               ; preds = %.lr.ph.peel.next37
  br label %.lr.ph.preheader.peel.newph

.lr.ph.preheader.peel.newph:                      ; preds = %.lr.ph.peel.next39
  br label %.lr.ph

.lr.ph:                                           ; preds = %476, %.lr.ph.preheader.peel.newph
  %458 = phi i8 [ %478, %476 ], [ %455, %.lr.ph.preheader.peel.newph ]
  %459 = sext i8 %458 to i32
  switch i32 %459, label %476 [
    i32 97, label %460
    i32 98, label %462
    i32 115, label %464
  ]

; <label>:460:                                    ; preds = %.lr.ph
  %461 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 0
  store i8 1, i8* %461, align 8
  br label %476

; <label>:462:                                    ; preds = %.lr.ph
  %463 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 1
  store i8 1, i8* %463, align 1
  br label %476

; <label>:464:                                    ; preds = %.lr.ph
  %465 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 2
  store i8 1, i8* %465, align 2
  %466 = load i8*, i8** @optarg, align 8
  %467 = call i64 @strlen(i8* %466) #5
  %468 = mul i64 1, %467
  %469 = call noalias i8* @malloc(i64 %468) #6
  %470 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  store i8* %469, i8** %470, align 8
  %471 = getelementptr inbounds %struct.Config, %struct.Config* %2, i32 0, i32 3
  %472 = load i8*, i8** %471, align 8
  %473 = load i8*, i8** @optarg, align 8
  %474 = load i8*, i8** @optarg, align 8
  %475 = call i64 @strlen(i8* %474) #5
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %472, i8* %473, i64 %475, i32 1, i1 false)
  br label %476

; <label>:476:                                    ; preds = %464, %462, %460, %.lr.ph
  %477 = call i32 @getopt(i32 5, i8** %11, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.6, i32 0, i32 0)) #6
  %478 = trunc i32 %477 to i8
  %479 = sext i8 %478 to i32
  %480 = icmp ne i32 %479, -1
  br i1 %480, label %.lr.ph, label %._crit_edge.loopexit.loopexit

._crit_edge.loopexit.loopexit:                    ; preds = %476
  br label %._crit_edge.loopexit

._crit_edge.loopexit:                             ; preds = %._crit_edge.loopexit.loopexit, %453, %431, %409, %387, %365, %343, %321, %299, %277, %255, %233, %211, %189, %167, %145, %123, %101, %79, %55, %33
  br label %._crit_edge

._crit_edge:                                      ; preds = %._crit_edge.loopexit, %0
  %481 = bitcast %struct.Config* %2 to { i64, i8* }*
  %482 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %481, i32 0, i32 0
  %483 = load i64, i64* %482, align 8
  %484 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %481, i32 0, i32 1
  %485 = load i8*, i8** %484, align 8
  call void @branchPruned(i64 %483, i8* %485)
  %486 = load i32, i32* @optind, align 4
  %487 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.7, i32 0, i32 0), i32 %486)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(i64, i8*) #0 {
  %3 = alloca %struct.Config, align 8
  %4 = bitcast %struct.Config* %3 to { i64, i8* }*
  %5 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %4, i32 0, i32 0
  store i64 65793, i64* %5, align 8
  %6 = getelementptr inbounds { i64, i8* }, { i64, i8* }* %4, i32 0, i32 1
  store i8* %1, i8** %6, align 8
  %7 = getelementptr inbounds %struct.Config, %struct.Config* %3, i32 0, i32 0
  %8 = load i8, i8* %7, align 8
  %9 = sext i8 1 to i32
  %10 = icmp eq i32 1, 1
  br i1 true, label %11, label %30

; <label>:11:                                     ; preds = %2
  %12 = getelementptr inbounds %struct.Config, %struct.Config* %3, i32 0, i32 1
  %13 = load i8, i8* %12, align 1
  %14 = sext i8 1 to i32
  %15 = icmp eq i32 1, 1
  br i1 true, label %16, label %30

; <label>:16:                                     ; preds = %11
  %17 = getelementptr inbounds %struct.Config, %struct.Config* %3, i32 0, i32 2
  %18 = load i8, i8* %17, align 2
  %19 = sext i8 1 to i32
  %20 = icmp eq i32 1, 1
  br i1 true, label %21, label %30

; <label>:21:                                     ; preds = %16
  %22 = getelementptr inbounds %struct.Config, %struct.Config* %3, i32 0, i32 3
  %23 = load i8*, i8** %22, align 8
  %24 = getelementptr [6 x i8], [6 x i8]* @4, i64 0, i64 0
  %25 = getelementptr [6 x i8], [6 x i8]* @5, i64 0, i64 0
  %26 = call i32 @strcmp(i8* %24, i8* %25) #5
  %27 = icmp ne i32 0, 0
  br i1 false, label %30, label %28

; <label>:28:                                     ; preds = %21
  %29 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i32 0, i32 0))
  br label %30

; <label>:30:                                     ; preds = %28, %21, %16, %11, %2
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
