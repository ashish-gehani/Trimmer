; ModuleID = 'workdir/inter8t3.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.HighType = type { %struct.LowTypeString, %struct.LowTypeInt }
%struct.LowTypeString = type { [1000 x i8], [1000 x i8] }
%struct.LowTypeInt = type { [1000 x i32], [1000 x i32] }

@.str = private unnamed_addr constant [4 x i8] c"ygx\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"afwik\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"xawjt\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"meaj\00", align 1
@.str.4 = private unnamed_addr constant [6 x i8] c"oqmop\00", align 1
@.str.5 = private unnamed_addr constant [16 x i8] c"*** branchTaken\00", align 1
@0 = constant [6 x i8] c"oqmop\00"
@1 = constant [6 x i8] c"oqmop\00"
@2 = constant [4 x i8] c"ygx\00"
@3 = constant [4 x i8] c"ygx\00"
@4 = constant [6 x i8] c"afwik\00"
@5 = constant [6 x i8] c"afwik\00"
@6 = constant [6 x i8] c"xawjt\00"
@7 = constant [6 x i8] c"xawjt\00"
@8 = constant [5 x i8] c"meaj\00"
@9 = constant [5 x i8] c"meaj\00"

; Function Attrs: nounwind uwtable
define void @initialize(%struct.HighType* %obj) #0 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %2 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %1, i32 0, i32 0
  %3 = getelementptr inbounds [1000 x i32], [1000 x i32]* %2, i64 0, i64 569
  store i32 122, i32* %3, align 4
  %4 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %5 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %4, i32 0, i32 1
  %6 = getelementptr inbounds [1000 x i32], [1000 x i32]* %5, i64 0, i64 335
  store i32 112, i32* %6, align 4
  %7 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %8 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %7, i32 0, i32 0
  %9 = getelementptr inbounds [1000 x i32], [1000 x i32]* %8, i64 0, i64 534
  store i32 106, i32* %9, align 4
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %11 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %10, i32 0, i32 0
  %12 = getelementptr inbounds [1000 x i8], [1000 x i8]* %11, i64 0, i64 645
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i64 3, i32 1, i1 false)
  %13 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %14 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %13, i32 0, i32 0
  %15 = getelementptr inbounds [1000 x i8], [1000 x i8]* %14, i64 0, i64 131
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %15, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i32 0, i32 0), i64 5, i32 1, i1 false)
  %16 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %17 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %16, i32 0, i32 0
  %18 = getelementptr inbounds [1000 x i32], [1000 x i32]* %17, i64 0, i64 987
  store i32 121, i32* %18, align 4
  %19 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %20 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %19, i32 0, i32 0
  %21 = getelementptr inbounds [1000 x i8], [1000 x i8]* %20, i64 0, i64 253
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %21, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i32 0, i32 0), i64 5, i32 1, i1 false)
  %22 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %23 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %22, i32 0, i32 0
  %24 = getelementptr inbounds [1000 x i32], [1000 x i32]* %23, i64 0, i64 649
  store i32 116, i32* %24, align 4
  %25 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %26 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %25, i32 0, i32 0
  %27 = getelementptr inbounds [1000 x i8], [1000 x i8]* %26, i64 0, i64 276
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i32 0, i32 0), i64 4, i32 1, i1 false)
  %28 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %29 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %28, i32 0, i32 1
  %30 = getelementptr inbounds [1000 x i8], [1000 x i8]* %29, i64 0, i64 225
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %30, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i32 0, i32 0), i64 5, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.HighType* byval align 8 %obj) #0 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %2 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %1, i32 0, i32 1
  %3 = getelementptr inbounds [1000 x i8], [1000 x i8]* %2, i64 0, i64 225
  %4 = load i8, i8* %3, align 1
  %5 = sext i8 %4 to i32
  %6 = icmp eq i32 %5, 111
  br i1 %6, label %7, label %216

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %9 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %8, i32 0, i32 1
  %10 = getelementptr inbounds [1000 x i8], [1000 x i8]* %9, i64 0, i64 226
  %11 = load i8, i8* %10, align 2
  %12 = sext i8 %11 to i32
  %13 = icmp eq i32 %12, 113
  br i1 %13, label %14, label %216

; <label>:14                                      ; preds = %7
  %15 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %16 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %15, i32 0, i32 1
  %17 = getelementptr inbounds [1000 x i8], [1000 x i8]* %16, i64 0, i64 227
  %18 = load i8, i8* %17, align 1
  %19 = sext i8 %18 to i32
  %20 = icmp eq i32 %19, 109
  br i1 %20, label %21, label %216

; <label>:21                                      ; preds = %14
  %22 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %23 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %22, i32 0, i32 1
  %24 = getelementptr inbounds [1000 x i8], [1000 x i8]* %23, i64 0, i64 228
  %25 = load i8, i8* %24, align 4
  %26 = sext i8 %25 to i32
  %27 = icmp eq i32 %26, 111
  br i1 %27, label %28, label %216

; <label>:28                                      ; preds = %21
  %29 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %30 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %29, i32 0, i32 1
  %31 = getelementptr inbounds [1000 x i8], [1000 x i8]* %30, i64 0, i64 229
  %32 = load i8, i8* %31, align 1
  %33 = sext i8 %32 to i32
  %34 = icmp eq i32 %33, 112
  br i1 %34, label %35, label %216

; <label>:35                                      ; preds = %28
  %36 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %37 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %36, i32 0, i32 0
  %38 = getelementptr inbounds [1000 x i8], [1000 x i8]* %37, i64 0, i64 131
  %39 = load i8, i8* %38, align 1
  %40 = sext i8 %39 to i32
  %41 = icmp eq i32 %40, 97
  br i1 %41, label %42, label %216

; <label>:42                                      ; preds = %35
  %43 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %44 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %43, i32 0, i32 0
  %45 = getelementptr inbounds [1000 x i8], [1000 x i8]* %44, i64 0, i64 132
  %46 = load i8, i8* %45, align 4
  %47 = sext i8 %46 to i32
  %48 = icmp eq i32 %47, 102
  br i1 %48, label %49, label %216

; <label>:49                                      ; preds = %42
  %50 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %51 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %50, i32 0, i32 0
  %52 = getelementptr inbounds [1000 x i8], [1000 x i8]* %51, i64 0, i64 133
  %53 = load i8, i8* %52, align 1
  %54 = sext i8 %53 to i32
  %55 = icmp eq i32 %54, 119
  br i1 %55, label %56, label %216

; <label>:56                                      ; preds = %49
  %57 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %58 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %57, i32 0, i32 0
  %59 = getelementptr inbounds [1000 x i8], [1000 x i8]* %58, i64 0, i64 134
  %60 = load i8, i8* %59, align 2
  %61 = sext i8 %60 to i32
  %62 = icmp eq i32 %61, 105
  br i1 %62, label %63, label %216

; <label>:63                                      ; preds = %56
  %64 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %65 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %64, i32 0, i32 0
  %66 = getelementptr inbounds [1000 x i8], [1000 x i8]* %65, i64 0, i64 135
  %67 = load i8, i8* %66, align 1
  %68 = sext i8 %67 to i32
  %69 = icmp eq i32 %68, 107
  br i1 %69, label %70, label %216

; <label>:70                                      ; preds = %63
  %71 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %72 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %71, i32 0, i32 0
  %73 = getelementptr inbounds [1000 x i8], [1000 x i8]* %72, i64 0, i64 253
  %74 = load i8, i8* %73, align 1
  %75 = sext i8 %74 to i32
  %76 = icmp eq i32 %75, 120
  br i1 %76, label %77, label %216

; <label>:77                                      ; preds = %70
  %78 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %79 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %78, i32 0, i32 0
  %80 = getelementptr inbounds [1000 x i8], [1000 x i8]* %79, i64 0, i64 254
  %81 = load i8, i8* %80, align 2
  %82 = sext i8 %81 to i32
  %83 = icmp eq i32 %82, 97
  br i1 %83, label %84, label %216

; <label>:84                                      ; preds = %77
  %85 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %86 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %85, i32 0, i32 0
  %87 = getelementptr inbounds [1000 x i8], [1000 x i8]* %86, i64 0, i64 255
  %88 = load i8, i8* %87, align 1
  %89 = sext i8 %88 to i32
  %90 = icmp eq i32 %89, 119
  br i1 %90, label %91, label %216

; <label>:91                                      ; preds = %84
  %92 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %93 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %92, i32 0, i32 0
  %94 = getelementptr inbounds [1000 x i8], [1000 x i8]* %93, i64 0, i64 256
  %95 = load i8, i8* %94, align 8
  %96 = sext i8 %95 to i32
  %97 = icmp eq i32 %96, 106
  br i1 %97, label %98, label %216

; <label>:98                                      ; preds = %91
  %99 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %100 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %99, i32 0, i32 0
  %101 = getelementptr inbounds [1000 x i8], [1000 x i8]* %100, i64 0, i64 257
  %102 = load i8, i8* %101, align 1
  %103 = sext i8 %102 to i32
  %104 = icmp eq i32 %103, 116
  br i1 %104, label %105, label %216

; <label>:105                                     ; preds = %98
  %106 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %107 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %106, i32 0, i32 0
  %108 = getelementptr inbounds [1000 x i8], [1000 x i8]* %107, i64 0, i64 276
  %109 = load i8, i8* %108, align 4
  %110 = sext i8 %109 to i32
  %111 = icmp eq i32 %110, 109
  br i1 %111, label %112, label %216

; <label>:112                                     ; preds = %105
  %113 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %114 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %113, i32 0, i32 0
  %115 = getelementptr inbounds [1000 x i8], [1000 x i8]* %114, i64 0, i64 277
  %116 = load i8, i8* %115, align 1
  %117 = sext i8 %116 to i32
  %118 = icmp eq i32 %117, 101
  br i1 %118, label %119, label %216

; <label>:119                                     ; preds = %112
  %120 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %121 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %120, i32 0, i32 0
  %122 = getelementptr inbounds [1000 x i8], [1000 x i8]* %121, i64 0, i64 278
  %123 = load i8, i8* %122, align 2
  %124 = sext i8 %123 to i32
  %125 = icmp eq i32 %124, 97
  br i1 %125, label %126, label %216

; <label>:126                                     ; preds = %119
  %127 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %128 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %127, i32 0, i32 0
  %129 = getelementptr inbounds [1000 x i8], [1000 x i8]* %128, i64 0, i64 279
  %130 = load i8, i8* %129, align 1
  %131 = sext i8 %130 to i32
  %132 = icmp eq i32 %131, 106
  br i1 %132, label %133, label %216

; <label>:133                                     ; preds = %126
  %134 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %135 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %134, i32 0, i32 0
  %136 = getelementptr inbounds [1000 x i8], [1000 x i8]* %135, i64 0, i64 645
  %137 = load i8, i8* %136, align 1
  %138 = sext i8 %137 to i32
  %139 = icmp eq i32 %138, 121
  br i1 %139, label %140, label %216

; <label>:140                                     ; preds = %133
  %141 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %142 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %141, i32 0, i32 0
  %143 = getelementptr inbounds [1000 x i8], [1000 x i8]* %142, i64 0, i64 646
  %144 = load i8, i8* %143, align 2
  %145 = sext i8 %144 to i32
  %146 = icmp eq i32 %145, 103
  br i1 %146, label %147, label %216

; <label>:147                                     ; preds = %140
  %148 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %149 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %148, i32 0, i32 0
  %150 = getelementptr inbounds [1000 x i8], [1000 x i8]* %149, i64 0, i64 647
  %151 = load i8, i8* %150, align 1
  %152 = sext i8 %151 to i32
  %153 = icmp eq i32 %152, 120
  br i1 %153, label %154, label %216

; <label>:154                                     ; preds = %147
  %155 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %156 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %155, i32 0, i32 1
  %157 = getelementptr inbounds [1000 x i32], [1000 x i32]* %156, i64 0, i64 335
  %158 = load i32, i32* %157, align 4
  %159 = icmp eq i32 %158, 112
  br i1 %159, label %160, label %216

; <label>:160                                     ; preds = %154
  %161 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %162 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %161, i32 0, i32 0
  %163 = getelementptr inbounds [1000 x i32], [1000 x i32]* %162, i64 0, i64 534
  %164 = load i32, i32* %163, align 8
  %165 = icmp eq i32 %164, 106
  br i1 %165, label %166, label %216

; <label>:166                                     ; preds = %160
  %167 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %168 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %167, i32 0, i32 0
  %169 = getelementptr inbounds [1000 x i32], [1000 x i32]* %168, i64 0, i64 569
  %170 = load i32, i32* %169, align 4
  %171 = icmp eq i32 %170, 122
  br i1 %171, label %172, label %216

; <label>:172                                     ; preds = %166
  %173 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %174 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %173, i32 0, i32 0
  %175 = getelementptr inbounds [1000 x i32], [1000 x i32]* %174, i64 0, i64 649
  %176 = load i32, i32* %175, align 4
  %177 = icmp eq i32 %176, 116
  br i1 %177, label %178, label %216

; <label>:178                                     ; preds = %172
  %179 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %180 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %179, i32 0, i32 0
  %181 = getelementptr inbounds [1000 x i32], [1000 x i32]* %180, i64 0, i64 987
  %182 = load i32, i32* %181, align 4
  %183 = icmp eq i32 %182, 121
  br i1 %183, label %184, label %216

; <label>:184                                     ; preds = %178
  %185 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %186 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %185, i32 0, i32 1
  %187 = getelementptr inbounds [1000 x i8], [1000 x i8]* %186, i64 0, i64 225
  %188 = call i32 @strcmp(i8* %187, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i32 0, i32 0)) #4
  %189 = icmp ne i32 %188, 0
  br i1 %189, label %216, label %190

; <label>:190                                     ; preds = %184
  %191 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %192 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %191, i32 0, i32 0
  %193 = getelementptr inbounds [1000 x i8], [1000 x i8]* %192, i64 0, i64 645
  %194 = call i32 @strcmp(i8* %193, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0)) #4
  %195 = icmp ne i32 %194, 0
  br i1 %195, label %216, label %196

; <label>:196                                     ; preds = %190
  %197 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %198 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %197, i32 0, i32 0
  %199 = getelementptr inbounds [1000 x i8], [1000 x i8]* %198, i64 0, i64 131
  %200 = call i32 @strcmp(i8* %199, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i32 0, i32 0)) #4
  %201 = icmp ne i32 %200, 0
  br i1 %201, label %216, label %202

; <label>:202                                     ; preds = %196
  %203 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %204 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %203, i32 0, i32 0
  %205 = getelementptr inbounds [1000 x i8], [1000 x i8]* %204, i64 0, i64 253
  %206 = call i32 @strcmp(i8* %205, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i32 0, i32 0)) #4
  %207 = icmp ne i32 %206, 0
  br i1 %207, label %216, label %208

; <label>:208                                     ; preds = %202
  %209 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %210 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %209, i32 0, i32 0
  %211 = getelementptr inbounds [1000 x i8], [1000 x i8]* %210, i64 0, i64 276
  %212 = call i32 @strcmp(i8* %211, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i32 0, i32 0)) #4
  %213 = icmp ne i32 %212, 0
  br i1 %213, label %216, label %214

; <label>:214                                     ; preds = %208
  %215 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i32 0, i32 0))
  br label %216

; <label>:216                                     ; preds = %214, %208, %202, %196, %190, %184, %178, %172, %166, %160, %154, %147, %140, %133, %126, %119, %112, %105, %98, %91, %84, %77, %70, %63, %56, %49, %42, %35, %28, %21, %14, %7, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

declare i32 @printf(i8*, ...) #3

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %ht = alloca %struct.HighType, align 8
  call void @initialize_clone(%struct.HighType* %ht)
  call void @branchPruned_clone(%struct.HighType* %ht)
  ret i32 0
}

; Function Attrs: nounwind uwtable
define void @initialize_clone(%struct.HighType* %obj) #0 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %2 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %1, i32 0, i32 0
  %3 = getelementptr inbounds [1000 x i32], [1000 x i32]* %2, i64 0, i64 569
  store i32 122, i32* %3, align 4
  %4 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %5 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %4, i32 0, i32 1
  %6 = getelementptr inbounds [1000 x i32], [1000 x i32]* %5, i64 0, i64 335
  store i32 112, i32* %6, align 4
  %7 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %8 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %7, i32 0, i32 0
  %9 = getelementptr inbounds [1000 x i32], [1000 x i32]* %8, i64 0, i64 534
  store i32 106, i32* %9, align 4
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %11 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %10, i32 0, i32 0
  %12 = getelementptr inbounds [1000 x i8], [1000 x i8]* %11, i64 0, i64 645
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i64 3, i32 1, i1 false)
  %13 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %14 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %13, i32 0, i32 0
  %15 = getelementptr inbounds [1000 x i8], [1000 x i8]* %14, i64 0, i64 131
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %15, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i32 0, i32 0), i64 5, i32 1, i1 false)
  %16 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %17 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %16, i32 0, i32 0
  %18 = getelementptr inbounds [1000 x i32], [1000 x i32]* %17, i64 0, i64 987
  store i32 121, i32* %18, align 4
  %19 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %20 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %19, i32 0, i32 0
  %21 = getelementptr inbounds [1000 x i8], [1000 x i8]* %20, i64 0, i64 253
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %21, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i32 0, i32 0), i64 5, i32 1, i1 false)
  %22 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %23 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %22, i32 0, i32 0
  %24 = getelementptr inbounds [1000 x i32], [1000 x i32]* %23, i64 0, i64 649
  store i32 116, i32* %24, align 4
  %25 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %26 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %25, i32 0, i32 0
  %27 = getelementptr inbounds [1000 x i8], [1000 x i8]* %26, i64 0, i64 276
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i32 0, i32 0), i64 4, i32 1, i1 false)
  %28 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %29 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %28, i32 0, i32 1
  %30 = getelementptr inbounds [1000 x i8], [1000 x i8]* %29, i64 0, i64 225
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %30, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i32 0, i32 0), i64 5, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.HighType* byval align 8 %obj) #0 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %2 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %1, i32 0, i32 1
  %3 = getelementptr inbounds [1000 x i8], [1000 x i8]* %2, i64 0, i64 225
  %4 = load i8, i8* %3, align 1
  %5 = sext i8 111 to i32
  %6 = icmp eq i32 111, 111
  br i1 true, label %7, label %226

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %9 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %8, i32 0, i32 1
  %10 = getelementptr inbounds [1000 x i8], [1000 x i8]* %9, i64 0, i64 226
  %11 = load i8, i8* %10, align 2
  %12 = sext i8 113 to i32
  %13 = icmp eq i32 113, 113
  br i1 true, label %14, label %226

; <label>:14                                      ; preds = %7
  %15 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %16 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %15, i32 0, i32 1
  %17 = getelementptr inbounds [1000 x i8], [1000 x i8]* %16, i64 0, i64 227
  %18 = load i8, i8* %17, align 1
  %19 = sext i8 109 to i32
  %20 = icmp eq i32 109, 109
  br i1 true, label %21, label %226

; <label>:21                                      ; preds = %14
  %22 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %23 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %22, i32 0, i32 1
  %24 = getelementptr inbounds [1000 x i8], [1000 x i8]* %23, i64 0, i64 228
  %25 = load i8, i8* %24, align 4
  %26 = sext i8 111 to i32
  %27 = icmp eq i32 111, 111
  br i1 true, label %28, label %226

; <label>:28                                      ; preds = %21
  %29 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %30 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %29, i32 0, i32 1
  %31 = getelementptr inbounds [1000 x i8], [1000 x i8]* %30, i64 0, i64 229
  %32 = load i8, i8* %31, align 1
  %33 = sext i8 112 to i32
  %34 = icmp eq i32 112, 112
  br i1 true, label %35, label %226

; <label>:35                                      ; preds = %28
  %36 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %37 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %36, i32 0, i32 0
  %38 = getelementptr inbounds [1000 x i8], [1000 x i8]* %37, i64 0, i64 131
  %39 = load i8, i8* %38, align 1
  %40 = sext i8 97 to i32
  %41 = icmp eq i32 97, 97
  br i1 true, label %42, label %226

; <label>:42                                      ; preds = %35
  %43 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %44 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %43, i32 0, i32 0
  %45 = getelementptr inbounds [1000 x i8], [1000 x i8]* %44, i64 0, i64 132
  %46 = load i8, i8* %45, align 4
  %47 = sext i8 102 to i32
  %48 = icmp eq i32 102, 102
  br i1 true, label %49, label %226

; <label>:49                                      ; preds = %42
  %50 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %51 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %50, i32 0, i32 0
  %52 = getelementptr inbounds [1000 x i8], [1000 x i8]* %51, i64 0, i64 133
  %53 = load i8, i8* %52, align 1
  %54 = sext i8 119 to i32
  %55 = icmp eq i32 119, 119
  br i1 true, label %56, label %226

; <label>:56                                      ; preds = %49
  %57 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %58 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %57, i32 0, i32 0
  %59 = getelementptr inbounds [1000 x i8], [1000 x i8]* %58, i64 0, i64 134
  %60 = load i8, i8* %59, align 2
  %61 = sext i8 105 to i32
  %62 = icmp eq i32 105, 105
  br i1 true, label %63, label %226

; <label>:63                                      ; preds = %56
  %64 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %65 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %64, i32 0, i32 0
  %66 = getelementptr inbounds [1000 x i8], [1000 x i8]* %65, i64 0, i64 135
  %67 = load i8, i8* %66, align 1
  %68 = sext i8 107 to i32
  %69 = icmp eq i32 107, 107
  br i1 true, label %70, label %226

; <label>:70                                      ; preds = %63
  %71 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %72 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %71, i32 0, i32 0
  %73 = getelementptr inbounds [1000 x i8], [1000 x i8]* %72, i64 0, i64 253
  %74 = load i8, i8* %73, align 1
  %75 = sext i8 120 to i32
  %76 = icmp eq i32 120, 120
  br i1 true, label %77, label %226

; <label>:77                                      ; preds = %70
  %78 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %79 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %78, i32 0, i32 0
  %80 = getelementptr inbounds [1000 x i8], [1000 x i8]* %79, i64 0, i64 254
  %81 = load i8, i8* %80, align 2
  %82 = sext i8 97 to i32
  %83 = icmp eq i32 97, 97
  br i1 true, label %84, label %226

; <label>:84                                      ; preds = %77
  %85 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %86 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %85, i32 0, i32 0
  %87 = getelementptr inbounds [1000 x i8], [1000 x i8]* %86, i64 0, i64 255
  %88 = load i8, i8* %87, align 1
  %89 = sext i8 119 to i32
  %90 = icmp eq i32 119, 119
  br i1 true, label %91, label %226

; <label>:91                                      ; preds = %84
  %92 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %93 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %92, i32 0, i32 0
  %94 = getelementptr inbounds [1000 x i8], [1000 x i8]* %93, i64 0, i64 256
  %95 = load i8, i8* %94, align 8
  %96 = sext i8 106 to i32
  %97 = icmp eq i32 106, 106
  br i1 true, label %98, label %226

; <label>:98                                      ; preds = %91
  %99 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %100 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %99, i32 0, i32 0
  %101 = getelementptr inbounds [1000 x i8], [1000 x i8]* %100, i64 0, i64 257
  %102 = load i8, i8* %101, align 1
  %103 = sext i8 116 to i32
  %104 = icmp eq i32 116, 116
  br i1 true, label %105, label %226

; <label>:105                                     ; preds = %98
  %106 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %107 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %106, i32 0, i32 0
  %108 = getelementptr inbounds [1000 x i8], [1000 x i8]* %107, i64 0, i64 276
  %109 = load i8, i8* %108, align 4
  %110 = sext i8 109 to i32
  %111 = icmp eq i32 109, 109
  br i1 true, label %112, label %226

; <label>:112                                     ; preds = %105
  %113 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %114 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %113, i32 0, i32 0
  %115 = getelementptr inbounds [1000 x i8], [1000 x i8]* %114, i64 0, i64 277
  %116 = load i8, i8* %115, align 1
  %117 = sext i8 101 to i32
  %118 = icmp eq i32 101, 101
  br i1 true, label %119, label %226

; <label>:119                                     ; preds = %112
  %120 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %121 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %120, i32 0, i32 0
  %122 = getelementptr inbounds [1000 x i8], [1000 x i8]* %121, i64 0, i64 278
  %123 = load i8, i8* %122, align 2
  %124 = sext i8 97 to i32
  %125 = icmp eq i32 97, 97
  br i1 true, label %126, label %226

; <label>:126                                     ; preds = %119
  %127 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %128 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %127, i32 0, i32 0
  %129 = getelementptr inbounds [1000 x i8], [1000 x i8]* %128, i64 0, i64 279
  %130 = load i8, i8* %129, align 1
  %131 = sext i8 106 to i32
  %132 = icmp eq i32 106, 106
  br i1 true, label %133, label %226

; <label>:133                                     ; preds = %126
  %134 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %135 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %134, i32 0, i32 0
  %136 = getelementptr inbounds [1000 x i8], [1000 x i8]* %135, i64 0, i64 645
  %137 = load i8, i8* %136, align 1
  %138 = sext i8 121 to i32
  %139 = icmp eq i32 121, 121
  br i1 true, label %140, label %226

; <label>:140                                     ; preds = %133
  %141 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %142 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %141, i32 0, i32 0
  %143 = getelementptr inbounds [1000 x i8], [1000 x i8]* %142, i64 0, i64 646
  %144 = load i8, i8* %143, align 2
  %145 = sext i8 103 to i32
  %146 = icmp eq i32 103, 103
  br i1 true, label %147, label %226

; <label>:147                                     ; preds = %140
  %148 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %149 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %148, i32 0, i32 0
  %150 = getelementptr inbounds [1000 x i8], [1000 x i8]* %149, i64 0, i64 647
  %151 = load i8, i8* %150, align 1
  %152 = sext i8 120 to i32
  %153 = icmp eq i32 120, 120
  br i1 true, label %154, label %226

; <label>:154                                     ; preds = %147
  %155 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %156 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %155, i32 0, i32 1
  %157 = getelementptr inbounds [1000 x i32], [1000 x i32]* %156, i64 0, i64 335
  %158 = load i32, i32* %157, align 4
  %159 = icmp eq i32 112, 112
  br i1 true, label %160, label %226

; <label>:160                                     ; preds = %154
  %161 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %162 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %161, i32 0, i32 0
  %163 = getelementptr inbounds [1000 x i32], [1000 x i32]* %162, i64 0, i64 534
  %164 = load i32, i32* %163, align 8
  %165 = icmp eq i32 106, 106
  br i1 true, label %166, label %226

; <label>:166                                     ; preds = %160
  %167 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %168 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %167, i32 0, i32 0
  %169 = getelementptr inbounds [1000 x i32], [1000 x i32]* %168, i64 0, i64 569
  %170 = load i32, i32* %169, align 4
  %171 = icmp eq i32 122, 122
  br i1 true, label %172, label %226

; <label>:172                                     ; preds = %166
  %173 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %174 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %173, i32 0, i32 0
  %175 = getelementptr inbounds [1000 x i32], [1000 x i32]* %174, i64 0, i64 649
  %176 = load i32, i32* %175, align 4
  %177 = icmp eq i32 116, 116
  br i1 true, label %178, label %226

; <label>:178                                     ; preds = %172
  %179 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 1
  %180 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %179, i32 0, i32 0
  %181 = getelementptr inbounds [1000 x i32], [1000 x i32]* %180, i64 0, i64 987
  %182 = load i32, i32* %181, align 4
  %183 = icmp eq i32 121, 121
  br i1 true, label %184, label %226

; <label>:184                                     ; preds = %178
  %185 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %186 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %185, i32 0, i32 1
  %187 = getelementptr inbounds [1000 x i8], [1000 x i8]* %186, i64 0, i64 225
  %188 = getelementptr [6 x i8], [6 x i8]* @0, i64 0, i64 0
  %189 = getelementptr [6 x i8], [6 x i8]* @1, i64 0, i64 0
  %190 = call i32 @strcmp(i8* %188, i8* %189) #4
  %191 = icmp ne i32 0, 0
  br i1 false, label %226, label %192

; <label>:192                                     ; preds = %184
  %193 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %194 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %193, i32 0, i32 0
  %195 = getelementptr inbounds [1000 x i8], [1000 x i8]* %194, i64 0, i64 645
  %196 = getelementptr [4 x i8], [4 x i8]* @2, i64 0, i64 0
  %197 = getelementptr [4 x i8], [4 x i8]* @3, i64 0, i64 0
  %198 = call i32 @strcmp(i8* %196, i8* %197) #4
  %199 = icmp ne i32 0, 0
  br i1 false, label %226, label %200

; <label>:200                                     ; preds = %192
  %201 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %202 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %201, i32 0, i32 0
  %203 = getelementptr inbounds [1000 x i8], [1000 x i8]* %202, i64 0, i64 131
  %204 = getelementptr [6 x i8], [6 x i8]* @4, i64 0, i64 0
  %205 = getelementptr [6 x i8], [6 x i8]* @5, i64 0, i64 0
  %206 = call i32 @strcmp(i8* %204, i8* %205) #4
  %207 = icmp ne i32 0, 0
  br i1 false, label %226, label %208

; <label>:208                                     ; preds = %200
  %209 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %210 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %209, i32 0, i32 0
  %211 = getelementptr inbounds [1000 x i8], [1000 x i8]* %210, i64 0, i64 253
  %212 = getelementptr [6 x i8], [6 x i8]* @6, i64 0, i64 0
  %213 = getelementptr [6 x i8], [6 x i8]* @7, i64 0, i64 0
  %214 = call i32 @strcmp(i8* %212, i8* %213) #4
  %215 = icmp ne i32 0, 0
  br i1 false, label %226, label %216

; <label>:216                                     ; preds = %208
  %217 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i32 0, i32 0
  %218 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %217, i32 0, i32 0
  %219 = getelementptr inbounds [1000 x i8], [1000 x i8]* %218, i64 0, i64 276
  %220 = getelementptr [5 x i8], [5 x i8]* @8, i64 0, i64 0
  %221 = getelementptr [5 x i8], [5 x i8]* @9, i64 0, i64 0
  %222 = call i32 @strcmp(i8* %220, i8* %221) #4
  %223 = icmp ne i32 0, 0
  br i1 false, label %226, label %224

; <label>:224                                     ; preds = %216
  %225 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i32 0, i32 0))
  br label %226

; <label>:226                                     ; preds = %224, %216, %208, %200, %192, %184, %178, %172, %166, %160, %154, %147, %140, %133, %126, %119, %112, %105, %98, %91, %84, %77, %70, %63, %56, %49, %42, %35, %28, %21, %14, %7, %0
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
