; ModuleID = 'workdir/inter11t1.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"*** Branch Taken \0A\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType** %obj) #0 {
  %1 = alloca %struct.stType**, align 8
  store %struct.stType** %obj, %struct.stType*** %1, align 8
  %2 = load %struct.stType**, %struct.stType*** %1, align 8
  %3 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %4 = load %struct.stType*, %struct.stType** %3, align 8
  %5 = getelementptr inbounds %struct.stType, %struct.stType* %4, i32 0, i32 0
  %6 = load %struct.COORD*, %struct.COORD** %5, align 8
  %7 = getelementptr inbounds %struct.COORD, %struct.COORD* %6, i32 0, i32 0
  %8 = load i32*, i32** %7, align 8
  %9 = load i32, i32* %8, align 4
  %10 = icmp eq i32 %9, 1
  br i1 %10, label %11, label %299

; <label>:11                                      ; preds = %0
  %12 = load %struct.stType**, %struct.stType*** %1, align 8
  %13 = getelementptr inbounds %struct.stType*, %struct.stType** %12, i64 0
  %14 = load %struct.stType*, %struct.stType** %13, align 8
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %14, i32 0, i32 0
  %16 = load %struct.COORD*, %struct.COORD** %15, align 8
  %17 = getelementptr inbounds %struct.COORD, %struct.COORD* %16, i32 0, i32 1
  %18 = load i32*, i32** %17, align 8
  %19 = load i32, i32* %18, align 4
  %20 = icmp eq i32 %19, 2
  br i1 %20, label %21, label %299

; <label>:21                                      ; preds = %11
  %22 = load %struct.stType**, %struct.stType*** %1, align 8
  %23 = getelementptr inbounds %struct.stType*, %struct.stType** %22, i64 0
  %24 = load %struct.stType*, %struct.stType** %23, align 8
  %25 = getelementptr inbounds %struct.stType, %struct.stType* %24, i32 0, i32 2
  %26 = getelementptr inbounds [8 x i32], [8 x i32]* %25, i64 0, i64 1
  %27 = load i32, i32* %26, align 4
  %28 = icmp eq i32 %27, 4
  br i1 %28, label %29, label %299

; <label>:29                                      ; preds = %21
  %30 = load %struct.stType**, %struct.stType*** %1, align 8
  %31 = getelementptr inbounds %struct.stType*, %struct.stType** %30, i64 0
  %32 = load %struct.stType*, %struct.stType** %31, align 8
  %33 = getelementptr inbounds %struct.stType, %struct.stType* %32, i32 0, i32 1
  %34 = getelementptr inbounds [100 x i8], [100 x i8]* %33, i32 0, i32 0
  %35 = call i32 @strcmp(i8* %34, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %36 = icmp ne i32 %35, 0
  br i1 %36, label %299, label %37

; <label>:37                                      ; preds = %29
  %38 = load %struct.stType**, %struct.stType*** %1, align 8
  %39 = getelementptr inbounds %struct.stType*, %struct.stType** %38, i64 0
  %40 = load %struct.stType*, %struct.stType** %39, align 8
  %41 = getelementptr inbounds %struct.stType, %struct.stType* %40, i32 0, i32 1
  %42 = getelementptr inbounds [100 x i8], [100 x i8]* %41, i64 0, i64 4
  %43 = load i8, i8* %42, align 4
  %44 = sext i8 %43 to i32
  %45 = icmp eq i32 %44, 111
  br i1 %45, label %46, label %299

; <label>:46                                      ; preds = %37
  %47 = load %struct.stType**, %struct.stType*** %1, align 8
  %48 = getelementptr inbounds %struct.stType*, %struct.stType** %47, i64 0
  %49 = load %struct.stType*, %struct.stType** %48, align 8
  %50 = getelementptr inbounds %struct.stType, %struct.stType* %49, i32 0, i32 1
  %51 = getelementptr inbounds [100 x i8], [100 x i8]* %50, i64 0, i64 9
  %52 = load i8, i8* %51, align 1
  %53 = sext i8 %52 to i32
  %54 = icmp eq i32 %53, 100
  br i1 %54, label %55, label %299

; <label>:55                                      ; preds = %46
  %56 = load %struct.stType**, %struct.stType*** %1, align 8
  %57 = getelementptr inbounds %struct.stType*, %struct.stType** %56, i64 1
  %58 = load %struct.stType*, %struct.stType** %57, align 8
  %59 = getelementptr inbounds %struct.stType, %struct.stType* %58, i32 0, i32 0
  %60 = load %struct.COORD*, %struct.COORD** %59, align 8
  %61 = getelementptr inbounds %struct.COORD, %struct.COORD* %60, i32 0, i32 0
  %62 = load i32*, i32** %61, align 8
  %63 = load i32, i32* %62, align 4
  %64 = icmp eq i32 %63, 6
  br i1 %64, label %65, label %299

; <label>:65                                      ; preds = %55
  %66 = load %struct.stType**, %struct.stType*** %1, align 8
  %67 = getelementptr inbounds %struct.stType*, %struct.stType** %66, i64 1
  %68 = load %struct.stType*, %struct.stType** %67, align 8
  %69 = getelementptr inbounds %struct.stType, %struct.stType* %68, i32 0, i32 0
  %70 = load %struct.COORD*, %struct.COORD** %69, align 8
  %71 = getelementptr inbounds %struct.COORD, %struct.COORD* %70, i32 0, i32 1
  %72 = load i32*, i32** %71, align 8
  %73 = load i32, i32* %72, align 4
  %74 = icmp eq i32 %73, 7
  br i1 %74, label %75, label %299

; <label>:75                                      ; preds = %65
  %76 = load %struct.stType**, %struct.stType*** %1, align 8
  %77 = getelementptr inbounds %struct.stType*, %struct.stType** %76, i64 1
  %78 = load %struct.stType*, %struct.stType** %77, align 8
  %79 = getelementptr inbounds %struct.stType, %struct.stType* %78, i32 0, i32 2
  %80 = getelementptr inbounds [8 x i32], [8 x i32]* %79, i64 0, i64 1
  %81 = load i32, i32* %80, align 4
  %82 = icmp eq i32 %81, 9
  br i1 %82, label %83, label %299

; <label>:83                                      ; preds = %75
  %84 = load %struct.stType**, %struct.stType*** %1, align 8
  %85 = getelementptr inbounds %struct.stType*, %struct.stType** %84, i64 1
  %86 = load %struct.stType*, %struct.stType** %85, align 8
  %87 = getelementptr inbounds %struct.stType, %struct.stType* %86, i32 0, i32 1
  %88 = getelementptr inbounds [100 x i8], [100 x i8]* %87, i32 0, i32 0
  %89 = call i32 @strcmp(i8* %88, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %90 = icmp ne i32 %89, 0
  br i1 %90, label %299, label %91

; <label>:91                                      ; preds = %83
  %92 = load %struct.stType**, %struct.stType*** %1, align 8
  %93 = getelementptr inbounds %struct.stType*, %struct.stType** %92, i64 1
  %94 = load %struct.stType*, %struct.stType** %93, align 8
  %95 = getelementptr inbounds %struct.stType, %struct.stType* %94, i32 0, i32 1
  %96 = getelementptr inbounds [100 x i8], [100 x i8]* %95, i64 0, i64 4
  %97 = load i8, i8* %96, align 4
  %98 = sext i8 %97 to i32
  %99 = icmp eq i32 %98, 111
  br i1 %99, label %100, label %299

; <label>:100                                     ; preds = %91
  %101 = load %struct.stType**, %struct.stType*** %1, align 8
  %102 = getelementptr inbounds %struct.stType*, %struct.stType** %101, i64 1
  %103 = load %struct.stType*, %struct.stType** %102, align 8
  %104 = getelementptr inbounds %struct.stType, %struct.stType* %103, i32 0, i32 1
  %105 = getelementptr inbounds [100 x i8], [100 x i8]* %104, i64 0, i64 9
  %106 = load i8, i8* %105, align 1
  %107 = sext i8 %106 to i32
  %108 = icmp eq i32 %107, 100
  br i1 %108, label %109, label %299

; <label>:109                                     ; preds = %100
  %110 = load %struct.stType**, %struct.stType*** %1, align 8
  %111 = getelementptr inbounds %struct.stType*, %struct.stType** %110, i64 2
  %112 = load %struct.stType*, %struct.stType** %111, align 8
  %113 = getelementptr inbounds %struct.stType, %struct.stType* %112, i32 0, i32 0
  %114 = load %struct.COORD*, %struct.COORD** %113, align 8
  %115 = getelementptr inbounds %struct.COORD, %struct.COORD* %114, i32 0, i32 0
  %116 = load i32*, i32** %115, align 8
  %117 = load i32, i32* %116, align 4
  %118 = icmp eq i32 %117, 11
  br i1 %118, label %119, label %299

; <label>:119                                     ; preds = %109
  %120 = load %struct.stType**, %struct.stType*** %1, align 8
  %121 = getelementptr inbounds %struct.stType*, %struct.stType** %120, i64 2
  %122 = load %struct.stType*, %struct.stType** %121, align 8
  %123 = getelementptr inbounds %struct.stType, %struct.stType* %122, i32 0, i32 0
  %124 = load %struct.COORD*, %struct.COORD** %123, align 8
  %125 = getelementptr inbounds %struct.COORD, %struct.COORD* %124, i32 0, i32 1
  %126 = load i32*, i32** %125, align 8
  %127 = load i32, i32* %126, align 4
  %128 = icmp eq i32 %127, 12
  br i1 %128, label %129, label %299

; <label>:129                                     ; preds = %119
  %130 = load %struct.stType**, %struct.stType*** %1, align 8
  %131 = getelementptr inbounds %struct.stType*, %struct.stType** %130, i64 2
  %132 = load %struct.stType*, %struct.stType** %131, align 8
  %133 = getelementptr inbounds %struct.stType, %struct.stType* %132, i32 0, i32 2
  %134 = getelementptr inbounds [8 x i32], [8 x i32]* %133, i64 0, i64 1
  %135 = load i32, i32* %134, align 4
  %136 = icmp eq i32 %135, 14
  br i1 %136, label %137, label %299

; <label>:137                                     ; preds = %129
  %138 = load %struct.stType**, %struct.stType*** %1, align 8
  %139 = getelementptr inbounds %struct.stType*, %struct.stType** %138, i64 2
  %140 = load %struct.stType*, %struct.stType** %139, align 8
  %141 = getelementptr inbounds %struct.stType, %struct.stType* %140, i32 0, i32 1
  %142 = getelementptr inbounds [100 x i8], [100 x i8]* %141, i32 0, i32 0
  %143 = call i32 @strcmp(i8* %142, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %144 = icmp ne i32 %143, 0
  br i1 %144, label %299, label %145

; <label>:145                                     ; preds = %137
  %146 = load %struct.stType**, %struct.stType*** %1, align 8
  %147 = getelementptr inbounds %struct.stType*, %struct.stType** %146, i64 2
  %148 = load %struct.stType*, %struct.stType** %147, align 8
  %149 = getelementptr inbounds %struct.stType, %struct.stType* %148, i32 0, i32 1
  %150 = getelementptr inbounds [100 x i8], [100 x i8]* %149, i64 0, i64 4
  %151 = load i8, i8* %150, align 4
  %152 = sext i8 %151 to i32
  %153 = icmp eq i32 %152, 111
  br i1 %153, label %154, label %299

; <label>:154                                     ; preds = %145
  %155 = load %struct.stType**, %struct.stType*** %1, align 8
  %156 = getelementptr inbounds %struct.stType*, %struct.stType** %155, i64 2
  %157 = load %struct.stType*, %struct.stType** %156, align 8
  %158 = getelementptr inbounds %struct.stType, %struct.stType* %157, i32 0, i32 1
  %159 = getelementptr inbounds [100 x i8], [100 x i8]* %158, i64 0, i64 9
  %160 = load i8, i8* %159, align 1
  %161 = sext i8 %160 to i32
  %162 = icmp eq i32 %161, 100
  br i1 %162, label %163, label %299

; <label>:163                                     ; preds = %154
  %164 = load %struct.stType**, %struct.stType*** %1, align 8
  %165 = getelementptr inbounds %struct.stType*, %struct.stType** %164, i64 3
  %166 = load %struct.stType*, %struct.stType** %165, align 8
  %167 = getelementptr inbounds %struct.stType, %struct.stType* %166, i32 0, i32 0
  %168 = load %struct.COORD*, %struct.COORD** %167, align 8
  %169 = getelementptr inbounds %struct.COORD, %struct.COORD* %168, i32 0, i32 0
  %170 = load i32*, i32** %169, align 8
  %171 = load i32, i32* %170, align 4
  %172 = icmp eq i32 %171, 16
  br i1 %172, label %173, label %299

; <label>:173                                     ; preds = %163
  %174 = load %struct.stType**, %struct.stType*** %1, align 8
  %175 = getelementptr inbounds %struct.stType*, %struct.stType** %174, i64 3
  %176 = load %struct.stType*, %struct.stType** %175, align 8
  %177 = getelementptr inbounds %struct.stType, %struct.stType* %176, i32 0, i32 0
  %178 = load %struct.COORD*, %struct.COORD** %177, align 8
  %179 = getelementptr inbounds %struct.COORD, %struct.COORD* %178, i32 0, i32 1
  %180 = load i32*, i32** %179, align 8
  %181 = load i32, i32* %180, align 4
  %182 = icmp eq i32 %181, 17
  br i1 %182, label %183, label %299

; <label>:183                                     ; preds = %173
  %184 = load %struct.stType**, %struct.stType*** %1, align 8
  %185 = getelementptr inbounds %struct.stType*, %struct.stType** %184, i64 3
  %186 = load %struct.stType*, %struct.stType** %185, align 8
  %187 = getelementptr inbounds %struct.stType, %struct.stType* %186, i32 0, i32 2
  %188 = getelementptr inbounds [8 x i32], [8 x i32]* %187, i64 0, i64 1
  %189 = load i32, i32* %188, align 4
  %190 = icmp eq i32 %189, 19
  br i1 %190, label %191, label %299

; <label>:191                                     ; preds = %183
  %192 = load %struct.stType**, %struct.stType*** %1, align 8
  %193 = getelementptr inbounds %struct.stType*, %struct.stType** %192, i64 3
  %194 = load %struct.stType*, %struct.stType** %193, align 8
  %195 = getelementptr inbounds %struct.stType, %struct.stType* %194, i32 0, i32 1
  %196 = getelementptr inbounds [100 x i8], [100 x i8]* %195, i32 0, i32 0
  %197 = call i32 @strcmp(i8* %196, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %198 = icmp ne i32 %197, 0
  br i1 %198, label %299, label %199

; <label>:199                                     ; preds = %191
  %200 = load %struct.stType**, %struct.stType*** %1, align 8
  %201 = getelementptr inbounds %struct.stType*, %struct.stType** %200, i64 3
  %202 = load %struct.stType*, %struct.stType** %201, align 8
  %203 = getelementptr inbounds %struct.stType, %struct.stType* %202, i32 0, i32 1
  %204 = getelementptr inbounds [100 x i8], [100 x i8]* %203, i64 0, i64 4
  %205 = load i8, i8* %204, align 4
  %206 = sext i8 %205 to i32
  %207 = icmp eq i32 %206, 111
  br i1 %207, label %208, label %299

; <label>:208                                     ; preds = %199
  %209 = load %struct.stType**, %struct.stType*** %1, align 8
  %210 = getelementptr inbounds %struct.stType*, %struct.stType** %209, i64 3
  %211 = load %struct.stType*, %struct.stType** %210, align 8
  %212 = getelementptr inbounds %struct.stType, %struct.stType* %211, i32 0, i32 1
  %213 = getelementptr inbounds [100 x i8], [100 x i8]* %212, i64 0, i64 9
  %214 = load i8, i8* %213, align 1
  %215 = sext i8 %214 to i32
  %216 = icmp eq i32 %215, 100
  br i1 %216, label %217, label %299

; <label>:217                                     ; preds = %208
  %218 = load %struct.stType**, %struct.stType*** %1, align 8
  %219 = getelementptr inbounds %struct.stType*, %struct.stType** %218, i64 4
  %220 = load %struct.stType*, %struct.stType** %219, align 8
  %221 = icmp eq %struct.stType* %220, null
  br i1 %221, label %222, label %299

; <label>:222                                     ; preds = %217
  %223 = load %struct.stType**, %struct.stType*** %1, align 8
  %224 = getelementptr inbounds %struct.stType*, %struct.stType** %223, i64 5
  %225 = load %struct.stType*, %struct.stType** %224, align 8
  %226 = icmp eq %struct.stType* %225, null
  br i1 %226, label %227, label %299

; <label>:227                                     ; preds = %222
  %228 = load %struct.stType**, %struct.stType*** %1, align 8
  %229 = getelementptr inbounds %struct.stType*, %struct.stType** %228, i64 6
  %230 = load %struct.stType*, %struct.stType** %229, align 8
  %231 = icmp eq %struct.stType* %230, null
  br i1 %231, label %232, label %299

; <label>:232                                     ; preds = %227
  %233 = load %struct.stType**, %struct.stType*** %1, align 8
  %234 = getelementptr inbounds %struct.stType*, %struct.stType** %233, i64 7
  %235 = load %struct.stType*, %struct.stType** %234, align 8
  %236 = icmp eq %struct.stType* %235, null
  br i1 %236, label %237, label %299

; <label>:237                                     ; preds = %232
  %238 = load %struct.stType**, %struct.stType*** %1, align 8
  %239 = getelementptr inbounds %struct.stType*, %struct.stType** %238, i64 8
  %240 = load %struct.stType*, %struct.stType** %239, align 8
  %241 = icmp eq %struct.stType* %240, null
  br i1 %241, label %242, label %299

; <label>:242                                     ; preds = %237
  %243 = load %struct.stType**, %struct.stType*** %1, align 8
  %244 = getelementptr inbounds %struct.stType*, %struct.stType** %243, i64 9
  %245 = load %struct.stType*, %struct.stType** %244, align 8
  %246 = icmp eq %struct.stType* %245, null
  br i1 %246, label %247, label %299

; <label>:247                                     ; preds = %242
  %248 = load %struct.stType**, %struct.stType*** %1, align 8
  %249 = getelementptr inbounds %struct.stType*, %struct.stType** %248, i64 10
  %250 = load %struct.stType*, %struct.stType** %249, align 8
  %251 = icmp eq %struct.stType* %250, null
  br i1 %251, label %252, label %299

; <label>:252                                     ; preds = %247
  %253 = load %struct.stType**, %struct.stType*** %1, align 8
  %254 = getelementptr inbounds %struct.stType*, %struct.stType** %253, i64 11
  %255 = load %struct.stType*, %struct.stType** %254, align 8
  %256 = icmp eq %struct.stType* %255, null
  br i1 %256, label %257, label %299

; <label>:257                                     ; preds = %252
  %258 = load %struct.stType**, %struct.stType*** %1, align 8
  %259 = getelementptr inbounds %struct.stType*, %struct.stType** %258, i64 12
  %260 = load %struct.stType*, %struct.stType** %259, align 8
  %261 = icmp eq %struct.stType* %260, null
  br i1 %261, label %262, label %299

; <label>:262                                     ; preds = %257
  %263 = load %struct.stType**, %struct.stType*** %1, align 8
  %264 = getelementptr inbounds %struct.stType*, %struct.stType** %263, i64 13
  %265 = load %struct.stType*, %struct.stType** %264, align 8
  %266 = icmp eq %struct.stType* %265, null
  br i1 %266, label %267, label %299

; <label>:267                                     ; preds = %262
  %268 = load %struct.stType**, %struct.stType*** %1, align 8
  %269 = getelementptr inbounds %struct.stType*, %struct.stType** %268, i64 14
  %270 = load %struct.stType*, %struct.stType** %269, align 8
  %271 = icmp eq %struct.stType* %270, null
  br i1 %271, label %272, label %299

; <label>:272                                     ; preds = %267
  %273 = load %struct.stType**, %struct.stType*** %1, align 8
  %274 = getelementptr inbounds %struct.stType*, %struct.stType** %273, i64 15
  %275 = load %struct.stType*, %struct.stType** %274, align 8
  %276 = icmp eq %struct.stType* %275, null
  br i1 %276, label %277, label %299

; <label>:277                                     ; preds = %272
  %278 = load %struct.stType**, %struct.stType*** %1, align 8
  %279 = getelementptr inbounds %struct.stType*, %struct.stType** %278, i64 16
  %280 = load %struct.stType*, %struct.stType** %279, align 8
  %281 = icmp eq %struct.stType* %280, null
  br i1 %281, label %282, label %299

; <label>:282                                     ; preds = %277
  %283 = load %struct.stType**, %struct.stType*** %1, align 8
  %284 = getelementptr inbounds %struct.stType*, %struct.stType** %283, i64 17
  %285 = load %struct.stType*, %struct.stType** %284, align 8
  %286 = icmp eq %struct.stType* %285, null
  br i1 %286, label %287, label %299

; <label>:287                                     ; preds = %282
  %288 = load %struct.stType**, %struct.stType*** %1, align 8
  %289 = getelementptr inbounds %struct.stType*, %struct.stType** %288, i64 18
  %290 = load %struct.stType*, %struct.stType** %289, align 8
  %291 = icmp eq %struct.stType* %290, null
  br i1 %291, label %292, label %299

; <label>:292                                     ; preds = %287
  %293 = load %struct.stType**, %struct.stType*** %1, align 8
  %294 = getelementptr inbounds %struct.stType*, %struct.stType** %293, i64 19
  %295 = load %struct.stType*, %struct.stType** %294, align 8
  %296 = icmp eq %struct.stType* %295, null
  br i1 %296, label %297, label %299

; <label>:297                                     ; preds = %292
  %298 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %299

; <label>:299                                     ; preds = %297, %292, %287, %282, %277, %272, %267, %262, %257, %252, %247, %242, %237, %232, %227, %222, %217, %208, %199, %191, %183, %173, %163, %154, %145, %137, %129, %119, %109, %100, %91, %83, %75, %65, %55, %46, %37, %29, %21, %11, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define void @initialize(%struct.stType** %obj) #0 {
  %1 = alloca %struct.stType**, align 8
  store %struct.stType** %obj, %struct.stType*** %1, align 8
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %obj = alloca %struct.stType**, align 8
  store i32 0, i32* %1, align 4
  %2 = call noalias i8* @malloc(i64 160) #6
  %3 = bitcast i8* %2 to %struct.stType**
  store %struct.stType** %3, %struct.stType*** %obj, align 8
  %4 = call noalias i8* @malloc(i64 144) #6
  %5 = bitcast i8* %4 to %struct.stType*
  %6 = load %struct.stType**, %struct.stType*** %obj, align 8
  %7 = getelementptr inbounds %struct.stType*, %struct.stType** %6, i64 0
  store %struct.stType* %5, %struct.stType** %7, align 8
  %8 = call noalias i8* @malloc(i64 16) #6
  %9 = bitcast i8* %8 to %struct.COORD*
  %10 = load %struct.stType**, %struct.stType*** %obj, align 8
  %11 = getelementptr inbounds %struct.stType*, %struct.stType** %10, i64 0
  %12 = load %struct.stType*, %struct.stType** %11, align 8
  %13 = getelementptr inbounds %struct.stType, %struct.stType* %12, i32 0, i32 0
  store %struct.COORD* %9, %struct.COORD** %13, align 8
  %14 = call noalias i8* @malloc(i64 4) #6
  %15 = bitcast i8* %14 to i32*
  %16 = load %struct.stType**, %struct.stType*** %obj, align 8
  %17 = getelementptr inbounds %struct.stType*, %struct.stType** %16, i64 0
  %18 = load %struct.stType*, %struct.stType** %17, align 8
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %18, i32 0, i32 0
  %20 = load %struct.COORD*, %struct.COORD** %19, align 8
  %21 = getelementptr inbounds %struct.COORD, %struct.COORD* %20, i32 0, i32 0
  store i32* %15, i32** %21, align 8
  %22 = call noalias i8* @malloc(i64 4) #6
  %23 = bitcast i8* %22 to i32*
  %24 = load %struct.stType**, %struct.stType*** %obj, align 8
  %25 = getelementptr inbounds %struct.stType*, %struct.stType** %24, i64 0
  %26 = load %struct.stType*, %struct.stType** %25, align 8
  %27 = getelementptr inbounds %struct.stType, %struct.stType* %26, i32 0, i32 0
  %28 = load %struct.COORD*, %struct.COORD** %27, align 8
  %29 = getelementptr inbounds %struct.COORD, %struct.COORD* %28, i32 0, i32 1
  store i32* %23, i32** %29, align 8
  %30 = load %struct.stType**, %struct.stType*** %obj, align 8
  %31 = getelementptr inbounds %struct.stType*, %struct.stType** %30, i64 0
  %32 = load %struct.stType*, %struct.stType** %31, align 8
  %33 = getelementptr inbounds %struct.stType, %struct.stType* %32, i32 0, i32 0
  %34 = load %struct.COORD*, %struct.COORD** %33, align 8
  %35 = getelementptr inbounds %struct.COORD, %struct.COORD* %34, i32 0, i32 0
  %36 = load i32*, i32** %35, align 8
  %37 = getelementptr inbounds i32, i32* %36, i64 0
  store i32 1, i32* %37, align 4
  %38 = load %struct.stType**, %struct.stType*** %obj, align 8
  %39 = getelementptr inbounds %struct.stType*, %struct.stType** %38, i64 0
  %40 = load %struct.stType*, %struct.stType** %39, align 8
  %41 = getelementptr inbounds %struct.stType, %struct.stType* %40, i32 0, i32 0
  %42 = load %struct.COORD*, %struct.COORD** %41, align 8
  %43 = getelementptr inbounds %struct.COORD, %struct.COORD* %42, i32 0, i32 1
  %44 = load i32*, i32** %43, align 8
  %45 = getelementptr inbounds i32, i32* %44, i64 0
  store i32 2, i32* %45, align 4
  %46 = load %struct.stType**, %struct.stType*** %obj, align 8
  %47 = getelementptr inbounds %struct.stType*, %struct.stType** %46, i64 0
  %48 = load %struct.stType*, %struct.stType** %47, align 8
  %49 = getelementptr inbounds %struct.stType, %struct.stType* %48, i32 0, i32 2
  %50 = getelementptr inbounds [8 x i32], [8 x i32]* %49, i64 0, i64 0
  store i32 3, i32* %50, align 4
  %51 = load %struct.stType**, %struct.stType*** %obj, align 8
  %52 = getelementptr inbounds %struct.stType*, %struct.stType** %51, i64 0
  %53 = load %struct.stType*, %struct.stType** %52, align 8
  %54 = getelementptr inbounds %struct.stType, %struct.stType* %53, i32 0, i32 2
  %55 = getelementptr inbounds [8 x i32], [8 x i32]* %54, i64 0, i64 1
  store i32 4, i32* %55, align 4
  %56 = load %struct.stType**, %struct.stType*** %obj, align 8
  %57 = getelementptr inbounds %struct.stType*, %struct.stType** %56, i64 0
  %58 = load %struct.stType*, %struct.stType** %57, align 8
  %59 = getelementptr inbounds %struct.stType, %struct.stType* %58, i32 0, i32 2
  %60 = getelementptr inbounds [8 x i32], [8 x i32]* %59, i64 0, i64 2
  store i32 5, i32* %60, align 4
  %61 = load %struct.stType**, %struct.stType*** %obj, align 8
  %62 = getelementptr inbounds %struct.stType*, %struct.stType** %61, i64 0
  %63 = load %struct.stType*, %struct.stType** %62, align 8
  %64 = getelementptr inbounds %struct.stType, %struct.stType* %63, i32 0, i32 1
  %65 = getelementptr inbounds [100 x i8], [100 x i8]* %64, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %65, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  %66 = call noalias i8* @malloc(i64 144) #6
  %67 = bitcast i8* %66 to %struct.stType*
  %68 = load %struct.stType**, %struct.stType*** %obj, align 8
  %69 = getelementptr inbounds %struct.stType*, %struct.stType** %68, i64 1
  store %struct.stType* %67, %struct.stType** %69, align 8
  %70 = call noalias i8* @malloc(i64 16) #6
  %71 = bitcast i8* %70 to %struct.COORD*
  %72 = load %struct.stType**, %struct.stType*** %obj, align 8
  %73 = getelementptr inbounds %struct.stType*, %struct.stType** %72, i64 1
  %74 = load %struct.stType*, %struct.stType** %73, align 8
  %75 = getelementptr inbounds %struct.stType, %struct.stType* %74, i32 0, i32 0
  store %struct.COORD* %71, %struct.COORD** %75, align 8
  %76 = call noalias i8* @malloc(i64 4) #6
  %77 = bitcast i8* %76 to i32*
  %78 = load %struct.stType**, %struct.stType*** %obj, align 8
  %79 = getelementptr inbounds %struct.stType*, %struct.stType** %78, i64 1
  %80 = load %struct.stType*, %struct.stType** %79, align 8
  %81 = getelementptr inbounds %struct.stType, %struct.stType* %80, i32 0, i32 0
  %82 = load %struct.COORD*, %struct.COORD** %81, align 8
  %83 = getelementptr inbounds %struct.COORD, %struct.COORD* %82, i32 0, i32 0
  store i32* %77, i32** %83, align 8
  %84 = call noalias i8* @malloc(i64 4) #6
  %85 = bitcast i8* %84 to i32*
  %86 = load %struct.stType**, %struct.stType*** %obj, align 8
  %87 = getelementptr inbounds %struct.stType*, %struct.stType** %86, i64 1
  %88 = load %struct.stType*, %struct.stType** %87, align 8
  %89 = getelementptr inbounds %struct.stType, %struct.stType* %88, i32 0, i32 0
  %90 = load %struct.COORD*, %struct.COORD** %89, align 8
  %91 = getelementptr inbounds %struct.COORD, %struct.COORD* %90, i32 0, i32 1
  store i32* %85, i32** %91, align 8
  %92 = load %struct.stType**, %struct.stType*** %obj, align 8
  %93 = getelementptr inbounds %struct.stType*, %struct.stType** %92, i64 1
  %94 = load %struct.stType*, %struct.stType** %93, align 8
  %95 = getelementptr inbounds %struct.stType, %struct.stType* %94, i32 0, i32 0
  %96 = load %struct.COORD*, %struct.COORD** %95, align 8
  %97 = getelementptr inbounds %struct.COORD, %struct.COORD* %96, i32 0, i32 0
  %98 = load i32*, i32** %97, align 8
  %99 = getelementptr inbounds i32, i32* %98, i64 0
  store i32 6, i32* %99, align 4
  %100 = load %struct.stType**, %struct.stType*** %obj, align 8
  %101 = getelementptr inbounds %struct.stType*, %struct.stType** %100, i64 1
  %102 = load %struct.stType*, %struct.stType** %101, align 8
  %103 = getelementptr inbounds %struct.stType, %struct.stType* %102, i32 0, i32 0
  %104 = load %struct.COORD*, %struct.COORD** %103, align 8
  %105 = getelementptr inbounds %struct.COORD, %struct.COORD* %104, i32 0, i32 1
  %106 = load i32*, i32** %105, align 8
  %107 = getelementptr inbounds i32, i32* %106, i64 0
  store i32 7, i32* %107, align 4
  %108 = load %struct.stType**, %struct.stType*** %obj, align 8
  %109 = getelementptr inbounds %struct.stType*, %struct.stType** %108, i64 1
  %110 = load %struct.stType*, %struct.stType** %109, align 8
  %111 = getelementptr inbounds %struct.stType, %struct.stType* %110, i32 0, i32 2
  %112 = getelementptr inbounds [8 x i32], [8 x i32]* %111, i64 0, i64 0
  store i32 8, i32* %112, align 4
  %113 = load %struct.stType**, %struct.stType*** %obj, align 8
  %114 = getelementptr inbounds %struct.stType*, %struct.stType** %113, i64 1
  %115 = load %struct.stType*, %struct.stType** %114, align 8
  %116 = getelementptr inbounds %struct.stType, %struct.stType* %115, i32 0, i32 2
  %117 = getelementptr inbounds [8 x i32], [8 x i32]* %116, i64 0, i64 1
  store i32 9, i32* %117, align 4
  %118 = load %struct.stType**, %struct.stType*** %obj, align 8
  %119 = getelementptr inbounds %struct.stType*, %struct.stType** %118, i64 1
  %120 = load %struct.stType*, %struct.stType** %119, align 8
  %121 = getelementptr inbounds %struct.stType, %struct.stType* %120, i32 0, i32 2
  %122 = getelementptr inbounds [8 x i32], [8 x i32]* %121, i64 0, i64 2
  store i32 10, i32* %122, align 4
  %123 = load %struct.stType**, %struct.stType*** %obj, align 8
  %124 = getelementptr inbounds %struct.stType*, %struct.stType** %123, i64 1
  %125 = load %struct.stType*, %struct.stType** %124, align 8
  %126 = getelementptr inbounds %struct.stType, %struct.stType* %125, i32 0, i32 1
  %127 = getelementptr inbounds [100 x i8], [100 x i8]* %126, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %127, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  %128 = call noalias i8* @malloc(i64 144) #6
  %129 = bitcast i8* %128 to %struct.stType*
  %130 = load %struct.stType**, %struct.stType*** %obj, align 8
  %131 = getelementptr inbounds %struct.stType*, %struct.stType** %130, i64 2
  store %struct.stType* %129, %struct.stType** %131, align 8
  %132 = call noalias i8* @malloc(i64 16) #6
  %133 = bitcast i8* %132 to %struct.COORD*
  %134 = load %struct.stType**, %struct.stType*** %obj, align 8
  %135 = getelementptr inbounds %struct.stType*, %struct.stType** %134, i64 2
  %136 = load %struct.stType*, %struct.stType** %135, align 8
  %137 = getelementptr inbounds %struct.stType, %struct.stType* %136, i32 0, i32 0
  store %struct.COORD* %133, %struct.COORD** %137, align 8
  %138 = call noalias i8* @malloc(i64 4) #6
  %139 = bitcast i8* %138 to i32*
  %140 = load %struct.stType**, %struct.stType*** %obj, align 8
  %141 = getelementptr inbounds %struct.stType*, %struct.stType** %140, i64 2
  %142 = load %struct.stType*, %struct.stType** %141, align 8
  %143 = getelementptr inbounds %struct.stType, %struct.stType* %142, i32 0, i32 0
  %144 = load %struct.COORD*, %struct.COORD** %143, align 8
  %145 = getelementptr inbounds %struct.COORD, %struct.COORD* %144, i32 0, i32 0
  store i32* %139, i32** %145, align 8
  %146 = call noalias i8* @malloc(i64 4) #6
  %147 = bitcast i8* %146 to i32*
  %148 = load %struct.stType**, %struct.stType*** %obj, align 8
  %149 = getelementptr inbounds %struct.stType*, %struct.stType** %148, i64 2
  %150 = load %struct.stType*, %struct.stType** %149, align 8
  %151 = getelementptr inbounds %struct.stType, %struct.stType* %150, i32 0, i32 0
  %152 = load %struct.COORD*, %struct.COORD** %151, align 8
  %153 = getelementptr inbounds %struct.COORD, %struct.COORD* %152, i32 0, i32 1
  store i32* %147, i32** %153, align 8
  %154 = load %struct.stType**, %struct.stType*** %obj, align 8
  %155 = getelementptr inbounds %struct.stType*, %struct.stType** %154, i64 2
  %156 = load %struct.stType*, %struct.stType** %155, align 8
  %157 = getelementptr inbounds %struct.stType, %struct.stType* %156, i32 0, i32 0
  %158 = load %struct.COORD*, %struct.COORD** %157, align 8
  %159 = getelementptr inbounds %struct.COORD, %struct.COORD* %158, i32 0, i32 0
  %160 = load i32*, i32** %159, align 8
  %161 = getelementptr inbounds i32, i32* %160, i64 0
  store i32 11, i32* %161, align 4
  %162 = load %struct.stType**, %struct.stType*** %obj, align 8
  %163 = getelementptr inbounds %struct.stType*, %struct.stType** %162, i64 2
  %164 = load %struct.stType*, %struct.stType** %163, align 8
  %165 = getelementptr inbounds %struct.stType, %struct.stType* %164, i32 0, i32 0
  %166 = load %struct.COORD*, %struct.COORD** %165, align 8
  %167 = getelementptr inbounds %struct.COORD, %struct.COORD* %166, i32 0, i32 1
  %168 = load i32*, i32** %167, align 8
  %169 = getelementptr inbounds i32, i32* %168, i64 0
  store i32 12, i32* %169, align 4
  %170 = load %struct.stType**, %struct.stType*** %obj, align 8
  %171 = getelementptr inbounds %struct.stType*, %struct.stType** %170, i64 2
  %172 = load %struct.stType*, %struct.stType** %171, align 8
  %173 = getelementptr inbounds %struct.stType, %struct.stType* %172, i32 0, i32 2
  %174 = getelementptr inbounds [8 x i32], [8 x i32]* %173, i64 0, i64 0
  store i32 13, i32* %174, align 4
  %175 = load %struct.stType**, %struct.stType*** %obj, align 8
  %176 = getelementptr inbounds %struct.stType*, %struct.stType** %175, i64 2
  %177 = load %struct.stType*, %struct.stType** %176, align 8
  %178 = getelementptr inbounds %struct.stType, %struct.stType* %177, i32 0, i32 2
  %179 = getelementptr inbounds [8 x i32], [8 x i32]* %178, i64 0, i64 1
  store i32 14, i32* %179, align 4
  %180 = load %struct.stType**, %struct.stType*** %obj, align 8
  %181 = getelementptr inbounds %struct.stType*, %struct.stType** %180, i64 2
  %182 = load %struct.stType*, %struct.stType** %181, align 8
  %183 = getelementptr inbounds %struct.stType, %struct.stType* %182, i32 0, i32 2
  %184 = getelementptr inbounds [8 x i32], [8 x i32]* %183, i64 0, i64 2
  store i32 15, i32* %184, align 4
  %185 = load %struct.stType**, %struct.stType*** %obj, align 8
  %186 = getelementptr inbounds %struct.stType*, %struct.stType** %185, i64 2
  %187 = load %struct.stType*, %struct.stType** %186, align 8
  %188 = getelementptr inbounds %struct.stType, %struct.stType* %187, i32 0, i32 1
  %189 = getelementptr inbounds [100 x i8], [100 x i8]* %188, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %189, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  %190 = call noalias i8* @malloc(i64 144) #6
  %191 = bitcast i8* %190 to %struct.stType*
  %192 = load %struct.stType**, %struct.stType*** %obj, align 8
  %193 = getelementptr inbounds %struct.stType*, %struct.stType** %192, i64 3
  store %struct.stType* %191, %struct.stType** %193, align 8
  %194 = call noalias i8* @malloc(i64 16) #6
  %195 = bitcast i8* %194 to %struct.COORD*
  %196 = load %struct.stType**, %struct.stType*** %obj, align 8
  %197 = getelementptr inbounds %struct.stType*, %struct.stType** %196, i64 3
  %198 = load %struct.stType*, %struct.stType** %197, align 8
  %199 = getelementptr inbounds %struct.stType, %struct.stType* %198, i32 0, i32 0
  store %struct.COORD* %195, %struct.COORD** %199, align 8
  %200 = call noalias i8* @malloc(i64 4) #6
  %201 = bitcast i8* %200 to i32*
  %202 = load %struct.stType**, %struct.stType*** %obj, align 8
  %203 = getelementptr inbounds %struct.stType*, %struct.stType** %202, i64 3
  %204 = load %struct.stType*, %struct.stType** %203, align 8
  %205 = getelementptr inbounds %struct.stType, %struct.stType* %204, i32 0, i32 0
  %206 = load %struct.COORD*, %struct.COORD** %205, align 8
  %207 = getelementptr inbounds %struct.COORD, %struct.COORD* %206, i32 0, i32 0
  store i32* %201, i32** %207, align 8
  %208 = call noalias i8* @malloc(i64 4) #6
  %209 = bitcast i8* %208 to i32*
  %210 = load %struct.stType**, %struct.stType*** %obj, align 8
  %211 = getelementptr inbounds %struct.stType*, %struct.stType** %210, i64 3
  %212 = load %struct.stType*, %struct.stType** %211, align 8
  %213 = getelementptr inbounds %struct.stType, %struct.stType* %212, i32 0, i32 0
  %214 = load %struct.COORD*, %struct.COORD** %213, align 8
  %215 = getelementptr inbounds %struct.COORD, %struct.COORD* %214, i32 0, i32 1
  store i32* %209, i32** %215, align 8
  %216 = load %struct.stType**, %struct.stType*** %obj, align 8
  %217 = getelementptr inbounds %struct.stType*, %struct.stType** %216, i64 3
  %218 = load %struct.stType*, %struct.stType** %217, align 8
  %219 = getelementptr inbounds %struct.stType, %struct.stType* %218, i32 0, i32 0
  %220 = load %struct.COORD*, %struct.COORD** %219, align 8
  %221 = getelementptr inbounds %struct.COORD, %struct.COORD* %220, i32 0, i32 0
  %222 = load i32*, i32** %221, align 8
  %223 = getelementptr inbounds i32, i32* %222, i64 0
  store i32 16, i32* %223, align 4
  %224 = load %struct.stType**, %struct.stType*** %obj, align 8
  %225 = getelementptr inbounds %struct.stType*, %struct.stType** %224, i64 3
  %226 = load %struct.stType*, %struct.stType** %225, align 8
  %227 = getelementptr inbounds %struct.stType, %struct.stType* %226, i32 0, i32 0
  %228 = load %struct.COORD*, %struct.COORD** %227, align 8
  %229 = getelementptr inbounds %struct.COORD, %struct.COORD* %228, i32 0, i32 1
  %230 = load i32*, i32** %229, align 8
  %231 = getelementptr inbounds i32, i32* %230, i64 0
  store i32 17, i32* %231, align 4
  %232 = load %struct.stType**, %struct.stType*** %obj, align 8
  %233 = getelementptr inbounds %struct.stType*, %struct.stType** %232, i64 3
  %234 = load %struct.stType*, %struct.stType** %233, align 8
  %235 = getelementptr inbounds %struct.stType, %struct.stType* %234, i32 0, i32 2
  %236 = getelementptr inbounds [8 x i32], [8 x i32]* %235, i64 0, i64 0
  store i32 18, i32* %236, align 4
  %237 = load %struct.stType**, %struct.stType*** %obj, align 8
  %238 = getelementptr inbounds %struct.stType*, %struct.stType** %237, i64 3
  %239 = load %struct.stType*, %struct.stType** %238, align 8
  %240 = getelementptr inbounds %struct.stType, %struct.stType* %239, i32 0, i32 2
  %241 = getelementptr inbounds [8 x i32], [8 x i32]* %240, i64 0, i64 1
  store i32 19, i32* %241, align 4
  %242 = load %struct.stType**, %struct.stType*** %obj, align 8
  %243 = getelementptr inbounds %struct.stType*, %struct.stType** %242, i64 3
  %244 = load %struct.stType*, %struct.stType** %243, align 8
  %245 = getelementptr inbounds %struct.stType, %struct.stType* %244, i32 0, i32 2
  %246 = getelementptr inbounds [8 x i32], [8 x i32]* %245, i64 0, i64 2
  store i32 20, i32* %246, align 4
  %247 = load %struct.stType**, %struct.stType*** %obj, align 8
  %248 = getelementptr inbounds %struct.stType*, %struct.stType** %247, i64 3
  %249 = load %struct.stType*, %struct.stType** %248, align 8
  %250 = getelementptr inbounds %struct.stType, %struct.stType* %249, i32 0, i32 1
  %251 = getelementptr inbounds [100 x i8], [100 x i8]* %250, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %251, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  %252 = load %struct.stType**, %struct.stType*** %obj, align 8
  call void @branchPruned(%struct.stType** %252)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #4

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
