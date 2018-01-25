; ModuleID = 'workdir/inter8t2.bc'
source_filename = "inter8.c"
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

; Function Attrs: noinline nounwind uwtable
define void @initialize(%struct.HighType*) #0 {
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 1
  %3 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %2, i32 0, i32 0
  %4 = getelementptr inbounds [1000 x i32], [1000 x i32]* %3, i64 0, i64 569
  store i32 122, i32* %4, align 4
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 1
  %6 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %5, i32 0, i32 1
  %7 = getelementptr inbounds [1000 x i32], [1000 x i32]* %6, i64 0, i64 335
  store i32 112, i32* %7, align 4
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 1
  %9 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %8, i32 0, i32 0
  %10 = getelementptr inbounds [1000 x i32], [1000 x i32]* %9, i64 0, i64 534
  store i32 106, i32* %10, align 4
  %11 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %12 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %11, i32 0, i32 0
  %13 = getelementptr inbounds [1000 x i8], [1000 x i8]* %12, i64 0, i64 645
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i64 3, i32 1, i1 false)
  %14 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %15 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %14, i32 0, i32 0
  %16 = getelementptr inbounds [1000 x i8], [1000 x i8]* %15, i64 0, i64 131
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %16, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i32 0, i32 0), i64 5, i32 1, i1 false)
  %17 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 1
  %18 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %17, i32 0, i32 0
  %19 = getelementptr inbounds [1000 x i32], [1000 x i32]* %18, i64 0, i64 987
  store i32 121, i32* %19, align 4
  %20 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %21 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %20, i32 0, i32 0
  %22 = getelementptr inbounds [1000 x i8], [1000 x i8]* %21, i64 0, i64 253
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %22, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i32 0, i32 0), i64 5, i32 1, i1 false)
  %23 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 1
  %24 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %23, i32 0, i32 0
  %25 = getelementptr inbounds [1000 x i32], [1000 x i32]* %24, i64 0, i64 649
  store i32 116, i32* %25, align 4
  %26 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %27 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %26, i32 0, i32 0
  %28 = getelementptr inbounds [1000 x i8], [1000 x i8]* %27, i64 0, i64 276
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %28, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i32 0, i32 0), i64 4, i32 1, i1 false)
  %29 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %30 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %29, i32 0, i32 1
  %31 = getelementptr inbounds [1000 x i8], [1000 x i8]* %30, i64 0, i64 225
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %31, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i32 0, i32 0), i64 5, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.HighType* byval align 8) #0 {
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %3 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %2, i32 0, i32 1
  %4 = getelementptr inbounds [1000 x i8], [1000 x i8]* %3, i64 0, i64 225
  %5 = load i8, i8* %4, align 1
  %6 = sext i8 %5 to i32
  %7 = icmp eq i32 %6, 111
  br i1 %7, label %8, label %217

; <label>:8:                                      ; preds = %1
  %9 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %10 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %9, i32 0, i32 1
  %11 = getelementptr inbounds [1000 x i8], [1000 x i8]* %10, i64 0, i64 226
  %12 = load i8, i8* %11, align 2
  %13 = sext i8 %12 to i32
  %14 = icmp eq i32 %13, 113
  br i1 %14, label %15, label %217

; <label>:15:                                     ; preds = %8
  %16 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %17 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %16, i32 0, i32 1
  %18 = getelementptr inbounds [1000 x i8], [1000 x i8]* %17, i64 0, i64 227
  %19 = load i8, i8* %18, align 1
  %20 = sext i8 %19 to i32
  %21 = icmp eq i32 %20, 109
  br i1 %21, label %22, label %217

; <label>:22:                                     ; preds = %15
  %23 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %24 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %23, i32 0, i32 1
  %25 = getelementptr inbounds [1000 x i8], [1000 x i8]* %24, i64 0, i64 228
  %26 = load i8, i8* %25, align 4
  %27 = sext i8 %26 to i32
  %28 = icmp eq i32 %27, 111
  br i1 %28, label %29, label %217

; <label>:29:                                     ; preds = %22
  %30 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %31 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %30, i32 0, i32 1
  %32 = getelementptr inbounds [1000 x i8], [1000 x i8]* %31, i64 0, i64 229
  %33 = load i8, i8* %32, align 1
  %34 = sext i8 %33 to i32
  %35 = icmp eq i32 %34, 112
  br i1 %35, label %36, label %217

; <label>:36:                                     ; preds = %29
  %37 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %38 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %37, i32 0, i32 0
  %39 = getelementptr inbounds [1000 x i8], [1000 x i8]* %38, i64 0, i64 131
  %40 = load i8, i8* %39, align 1
  %41 = sext i8 %40 to i32
  %42 = icmp eq i32 %41, 97
  br i1 %42, label %43, label %217

; <label>:43:                                     ; preds = %36
  %44 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %45 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %44, i32 0, i32 0
  %46 = getelementptr inbounds [1000 x i8], [1000 x i8]* %45, i64 0, i64 132
  %47 = load i8, i8* %46, align 4
  %48 = sext i8 %47 to i32
  %49 = icmp eq i32 %48, 102
  br i1 %49, label %50, label %217

; <label>:50:                                     ; preds = %43
  %51 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %52 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %51, i32 0, i32 0
  %53 = getelementptr inbounds [1000 x i8], [1000 x i8]* %52, i64 0, i64 133
  %54 = load i8, i8* %53, align 1
  %55 = sext i8 %54 to i32
  %56 = icmp eq i32 %55, 119
  br i1 %56, label %57, label %217

; <label>:57:                                     ; preds = %50
  %58 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %59 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %58, i32 0, i32 0
  %60 = getelementptr inbounds [1000 x i8], [1000 x i8]* %59, i64 0, i64 134
  %61 = load i8, i8* %60, align 2
  %62 = sext i8 %61 to i32
  %63 = icmp eq i32 %62, 105
  br i1 %63, label %64, label %217

; <label>:64:                                     ; preds = %57
  %65 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %66 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %65, i32 0, i32 0
  %67 = getelementptr inbounds [1000 x i8], [1000 x i8]* %66, i64 0, i64 135
  %68 = load i8, i8* %67, align 1
  %69 = sext i8 %68 to i32
  %70 = icmp eq i32 %69, 107
  br i1 %70, label %71, label %217

; <label>:71:                                     ; preds = %64
  %72 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %73 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %72, i32 0, i32 0
  %74 = getelementptr inbounds [1000 x i8], [1000 x i8]* %73, i64 0, i64 253
  %75 = load i8, i8* %74, align 1
  %76 = sext i8 %75 to i32
  %77 = icmp eq i32 %76, 120
  br i1 %77, label %78, label %217

; <label>:78:                                     ; preds = %71
  %79 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %80 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %79, i32 0, i32 0
  %81 = getelementptr inbounds [1000 x i8], [1000 x i8]* %80, i64 0, i64 254
  %82 = load i8, i8* %81, align 2
  %83 = sext i8 %82 to i32
  %84 = icmp eq i32 %83, 97
  br i1 %84, label %85, label %217

; <label>:85:                                     ; preds = %78
  %86 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %87 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %86, i32 0, i32 0
  %88 = getelementptr inbounds [1000 x i8], [1000 x i8]* %87, i64 0, i64 255
  %89 = load i8, i8* %88, align 1
  %90 = sext i8 %89 to i32
  %91 = icmp eq i32 %90, 119
  br i1 %91, label %92, label %217

; <label>:92:                                     ; preds = %85
  %93 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %94 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %93, i32 0, i32 0
  %95 = getelementptr inbounds [1000 x i8], [1000 x i8]* %94, i64 0, i64 256
  %96 = load i8, i8* %95, align 8
  %97 = sext i8 %96 to i32
  %98 = icmp eq i32 %97, 106
  br i1 %98, label %99, label %217

; <label>:99:                                     ; preds = %92
  %100 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %101 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %100, i32 0, i32 0
  %102 = getelementptr inbounds [1000 x i8], [1000 x i8]* %101, i64 0, i64 257
  %103 = load i8, i8* %102, align 1
  %104 = sext i8 %103 to i32
  %105 = icmp eq i32 %104, 116
  br i1 %105, label %106, label %217

; <label>:106:                                    ; preds = %99
  %107 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %108 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %107, i32 0, i32 0
  %109 = getelementptr inbounds [1000 x i8], [1000 x i8]* %108, i64 0, i64 276
  %110 = load i8, i8* %109, align 4
  %111 = sext i8 %110 to i32
  %112 = icmp eq i32 %111, 109
  br i1 %112, label %113, label %217

; <label>:113:                                    ; preds = %106
  %114 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %115 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %114, i32 0, i32 0
  %116 = getelementptr inbounds [1000 x i8], [1000 x i8]* %115, i64 0, i64 277
  %117 = load i8, i8* %116, align 1
  %118 = sext i8 %117 to i32
  %119 = icmp eq i32 %118, 101
  br i1 %119, label %120, label %217

; <label>:120:                                    ; preds = %113
  %121 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %122 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %121, i32 0, i32 0
  %123 = getelementptr inbounds [1000 x i8], [1000 x i8]* %122, i64 0, i64 278
  %124 = load i8, i8* %123, align 2
  %125 = sext i8 %124 to i32
  %126 = icmp eq i32 %125, 97
  br i1 %126, label %127, label %217

; <label>:127:                                    ; preds = %120
  %128 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %129 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %128, i32 0, i32 0
  %130 = getelementptr inbounds [1000 x i8], [1000 x i8]* %129, i64 0, i64 279
  %131 = load i8, i8* %130, align 1
  %132 = sext i8 %131 to i32
  %133 = icmp eq i32 %132, 106
  br i1 %133, label %134, label %217

; <label>:134:                                    ; preds = %127
  %135 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %136 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %135, i32 0, i32 0
  %137 = getelementptr inbounds [1000 x i8], [1000 x i8]* %136, i64 0, i64 645
  %138 = load i8, i8* %137, align 1
  %139 = sext i8 %138 to i32
  %140 = icmp eq i32 %139, 121
  br i1 %140, label %141, label %217

; <label>:141:                                    ; preds = %134
  %142 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %143 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %142, i32 0, i32 0
  %144 = getelementptr inbounds [1000 x i8], [1000 x i8]* %143, i64 0, i64 646
  %145 = load i8, i8* %144, align 2
  %146 = sext i8 %145 to i32
  %147 = icmp eq i32 %146, 103
  br i1 %147, label %148, label %217

; <label>:148:                                    ; preds = %141
  %149 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %150 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %149, i32 0, i32 0
  %151 = getelementptr inbounds [1000 x i8], [1000 x i8]* %150, i64 0, i64 647
  %152 = load i8, i8* %151, align 1
  %153 = sext i8 %152 to i32
  %154 = icmp eq i32 %153, 120
  br i1 %154, label %155, label %217

; <label>:155:                                    ; preds = %148
  %156 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 1
  %157 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %156, i32 0, i32 1
  %158 = getelementptr inbounds [1000 x i32], [1000 x i32]* %157, i64 0, i64 335
  %159 = load i32, i32* %158, align 4
  %160 = icmp eq i32 %159, 112
  br i1 %160, label %161, label %217

; <label>:161:                                    ; preds = %155
  %162 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 1
  %163 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %162, i32 0, i32 0
  %164 = getelementptr inbounds [1000 x i32], [1000 x i32]* %163, i64 0, i64 534
  %165 = load i32, i32* %164, align 8
  %166 = icmp eq i32 %165, 106
  br i1 %166, label %167, label %217

; <label>:167:                                    ; preds = %161
  %168 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 1
  %169 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %168, i32 0, i32 0
  %170 = getelementptr inbounds [1000 x i32], [1000 x i32]* %169, i64 0, i64 569
  %171 = load i32, i32* %170, align 4
  %172 = icmp eq i32 %171, 122
  br i1 %172, label %173, label %217

; <label>:173:                                    ; preds = %167
  %174 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 1
  %175 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %174, i32 0, i32 0
  %176 = getelementptr inbounds [1000 x i32], [1000 x i32]* %175, i64 0, i64 649
  %177 = load i32, i32* %176, align 4
  %178 = icmp eq i32 %177, 116
  br i1 %178, label %179, label %217

; <label>:179:                                    ; preds = %173
  %180 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 1
  %181 = getelementptr inbounds %struct.LowTypeInt, %struct.LowTypeInt* %180, i32 0, i32 0
  %182 = getelementptr inbounds [1000 x i32], [1000 x i32]* %181, i64 0, i64 987
  %183 = load i32, i32* %182, align 4
  %184 = icmp eq i32 %183, 121
  br i1 %184, label %185, label %217

; <label>:185:                                    ; preds = %179
  %186 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %187 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %186, i32 0, i32 1
  %188 = getelementptr inbounds [1000 x i8], [1000 x i8]* %187, i64 0, i64 225
  %189 = call i32 @strcmp(i8* %188, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i32 0, i32 0)) #4
  %190 = icmp ne i32 %189, 0
  br i1 %190, label %217, label %191

; <label>:191:                                    ; preds = %185
  %192 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %193 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %192, i32 0, i32 0
  %194 = getelementptr inbounds [1000 x i8], [1000 x i8]* %193, i64 0, i64 645
  %195 = call i32 @strcmp(i8* %194, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0)) #4
  %196 = icmp ne i32 %195, 0
  br i1 %196, label %217, label %197

; <label>:197:                                    ; preds = %191
  %198 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %199 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %198, i32 0, i32 0
  %200 = getelementptr inbounds [1000 x i8], [1000 x i8]* %199, i64 0, i64 131
  %201 = call i32 @strcmp(i8* %200, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i32 0, i32 0)) #4
  %202 = icmp ne i32 %201, 0
  br i1 %202, label %217, label %203

; <label>:203:                                    ; preds = %197
  %204 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %205 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %204, i32 0, i32 0
  %206 = getelementptr inbounds [1000 x i8], [1000 x i8]* %205, i64 0, i64 253
  %207 = call i32 @strcmp(i8* %206, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i32 0, i32 0)) #4
  %208 = icmp ne i32 %207, 0
  br i1 %208, label %217, label %209

; <label>:209:                                    ; preds = %203
  %210 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i32 0, i32 0
  %211 = getelementptr inbounds %struct.LowTypeString, %struct.LowTypeString* %210, i32 0, i32 0
  %212 = getelementptr inbounds [1000 x i8], [1000 x i8]* %211, i64 0, i64 276
  %213 = call i32 @strcmp(i8* %212, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i32 0, i32 0)) #4
  %214 = icmp ne i32 %213, 0
  br i1 %214, label %217, label %215

; <label>:215:                                    ; preds = %209
  %216 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i32 0, i32 0))
  br label %217

; <label>:217:                                    ; preds = %215, %209, %203, %197, %191, %185, %179, %173, %167, %161, %155, %148, %141, %134, %127, %120, %113, %106, %99, %92, %85, %78, %71, %64, %57, %50, %43, %36, %29, %22, %15, %8, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

declare i32 @printf(i8*, ...) #3

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca %struct.HighType, align 8
  call void @initialize(%struct.HighType* %1)
  call void @branchPruned(%struct.HighType* byval align 8 %1)
  ret i32 0
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
