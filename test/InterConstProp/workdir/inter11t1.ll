; ModuleID = 'workdir/inter11t1.bc'
source_filename = "inter11.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"*** Branch Taken \0A\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType**) #0 {
  %2 = alloca %struct.stType**, align 8
  store %struct.stType** %0, %struct.stType*** %2, align 8
  %3 = load %struct.stType**, %struct.stType*** %2, align 8
  %4 = getelementptr inbounds %struct.stType*, %struct.stType** %3, i64 0
  %5 = load %struct.stType*, %struct.stType** %4, align 8
  %6 = getelementptr inbounds %struct.stType, %struct.stType* %5, i32 0, i32 0
  %7 = load %struct.COORD*, %struct.COORD** %6, align 8
  %8 = getelementptr inbounds %struct.COORD, %struct.COORD* %7, i32 0, i32 0
  %9 = load i32*, i32** %8, align 8
  %10 = load i32, i32* %9, align 4
  %11 = icmp eq i32 %10, 1
  br i1 %11, label %12, label %300

; <label>:12:                                     ; preds = %1
  %13 = load %struct.stType**, %struct.stType*** %2, align 8
  %14 = getelementptr inbounds %struct.stType*, %struct.stType** %13, i64 0
  %15 = load %struct.stType*, %struct.stType** %14, align 8
  %16 = getelementptr inbounds %struct.stType, %struct.stType* %15, i32 0, i32 0
  %17 = load %struct.COORD*, %struct.COORD** %16, align 8
  %18 = getelementptr inbounds %struct.COORD, %struct.COORD* %17, i32 0, i32 1
  %19 = load i32*, i32** %18, align 8
  %20 = load i32, i32* %19, align 4
  %21 = icmp eq i32 %20, 2
  br i1 %21, label %22, label %300

; <label>:22:                                     ; preds = %12
  %23 = load %struct.stType**, %struct.stType*** %2, align 8
  %24 = getelementptr inbounds %struct.stType*, %struct.stType** %23, i64 0
  %25 = load %struct.stType*, %struct.stType** %24, align 8
  %26 = getelementptr inbounds %struct.stType, %struct.stType* %25, i32 0, i32 2
  %27 = getelementptr inbounds [8 x i32], [8 x i32]* %26, i64 0, i64 1
  %28 = load i32, i32* %27, align 4
  %29 = icmp eq i32 %28, 4
  br i1 %29, label %30, label %300

; <label>:30:                                     ; preds = %22
  %31 = load %struct.stType**, %struct.stType*** %2, align 8
  %32 = getelementptr inbounds %struct.stType*, %struct.stType** %31, i64 0
  %33 = load %struct.stType*, %struct.stType** %32, align 8
  %34 = getelementptr inbounds %struct.stType, %struct.stType* %33, i32 0, i32 1
  %35 = getelementptr inbounds [100 x i8], [100 x i8]* %34, i32 0, i32 0
  %36 = call i32 @strcmp(i8* %35, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %300, label %38

; <label>:38:                                     ; preds = %30
  %39 = load %struct.stType**, %struct.stType*** %2, align 8
  %40 = getelementptr inbounds %struct.stType*, %struct.stType** %39, i64 0
  %41 = load %struct.stType*, %struct.stType** %40, align 8
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %41, i32 0, i32 1
  %43 = getelementptr inbounds [100 x i8], [100 x i8]* %42, i64 0, i64 4
  %44 = load i8, i8* %43, align 4
  %45 = sext i8 %44 to i32
  %46 = icmp eq i32 %45, 111
  br i1 %46, label %47, label %300

; <label>:47:                                     ; preds = %38
  %48 = load %struct.stType**, %struct.stType*** %2, align 8
  %49 = getelementptr inbounds %struct.stType*, %struct.stType** %48, i64 0
  %50 = load %struct.stType*, %struct.stType** %49, align 8
  %51 = getelementptr inbounds %struct.stType, %struct.stType* %50, i32 0, i32 1
  %52 = getelementptr inbounds [100 x i8], [100 x i8]* %51, i64 0, i64 9
  %53 = load i8, i8* %52, align 1
  %54 = sext i8 %53 to i32
  %55 = icmp eq i32 %54, 100
  br i1 %55, label %56, label %300

; <label>:56:                                     ; preds = %47
  %57 = load %struct.stType**, %struct.stType*** %2, align 8
  %58 = getelementptr inbounds %struct.stType*, %struct.stType** %57, i64 1
  %59 = load %struct.stType*, %struct.stType** %58, align 8
  %60 = getelementptr inbounds %struct.stType, %struct.stType* %59, i32 0, i32 0
  %61 = load %struct.COORD*, %struct.COORD** %60, align 8
  %62 = getelementptr inbounds %struct.COORD, %struct.COORD* %61, i32 0, i32 0
  %63 = load i32*, i32** %62, align 8
  %64 = load i32, i32* %63, align 4
  %65 = icmp eq i32 %64, 6
  br i1 %65, label %66, label %300

; <label>:66:                                     ; preds = %56
  %67 = load %struct.stType**, %struct.stType*** %2, align 8
  %68 = getelementptr inbounds %struct.stType*, %struct.stType** %67, i64 1
  %69 = load %struct.stType*, %struct.stType** %68, align 8
  %70 = getelementptr inbounds %struct.stType, %struct.stType* %69, i32 0, i32 0
  %71 = load %struct.COORD*, %struct.COORD** %70, align 8
  %72 = getelementptr inbounds %struct.COORD, %struct.COORD* %71, i32 0, i32 1
  %73 = load i32*, i32** %72, align 8
  %74 = load i32, i32* %73, align 4
  %75 = icmp eq i32 %74, 7
  br i1 %75, label %76, label %300

; <label>:76:                                     ; preds = %66
  %77 = load %struct.stType**, %struct.stType*** %2, align 8
  %78 = getelementptr inbounds %struct.stType*, %struct.stType** %77, i64 1
  %79 = load %struct.stType*, %struct.stType** %78, align 8
  %80 = getelementptr inbounds %struct.stType, %struct.stType* %79, i32 0, i32 2
  %81 = getelementptr inbounds [8 x i32], [8 x i32]* %80, i64 0, i64 1
  %82 = load i32, i32* %81, align 4
  %83 = icmp eq i32 %82, 9
  br i1 %83, label %84, label %300

; <label>:84:                                     ; preds = %76
  %85 = load %struct.stType**, %struct.stType*** %2, align 8
  %86 = getelementptr inbounds %struct.stType*, %struct.stType** %85, i64 1
  %87 = load %struct.stType*, %struct.stType** %86, align 8
  %88 = getelementptr inbounds %struct.stType, %struct.stType* %87, i32 0, i32 1
  %89 = getelementptr inbounds [100 x i8], [100 x i8]* %88, i32 0, i32 0
  %90 = call i32 @strcmp(i8* %89, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %91 = icmp ne i32 %90, 0
  br i1 %91, label %300, label %92

; <label>:92:                                     ; preds = %84
  %93 = load %struct.stType**, %struct.stType*** %2, align 8
  %94 = getelementptr inbounds %struct.stType*, %struct.stType** %93, i64 1
  %95 = load %struct.stType*, %struct.stType** %94, align 8
  %96 = getelementptr inbounds %struct.stType, %struct.stType* %95, i32 0, i32 1
  %97 = getelementptr inbounds [100 x i8], [100 x i8]* %96, i64 0, i64 4
  %98 = load i8, i8* %97, align 4
  %99 = sext i8 %98 to i32
  %100 = icmp eq i32 %99, 111
  br i1 %100, label %101, label %300

; <label>:101:                                    ; preds = %92
  %102 = load %struct.stType**, %struct.stType*** %2, align 8
  %103 = getelementptr inbounds %struct.stType*, %struct.stType** %102, i64 1
  %104 = load %struct.stType*, %struct.stType** %103, align 8
  %105 = getelementptr inbounds %struct.stType, %struct.stType* %104, i32 0, i32 1
  %106 = getelementptr inbounds [100 x i8], [100 x i8]* %105, i64 0, i64 9
  %107 = load i8, i8* %106, align 1
  %108 = sext i8 %107 to i32
  %109 = icmp eq i32 %108, 100
  br i1 %109, label %110, label %300

; <label>:110:                                    ; preds = %101
  %111 = load %struct.stType**, %struct.stType*** %2, align 8
  %112 = getelementptr inbounds %struct.stType*, %struct.stType** %111, i64 2
  %113 = load %struct.stType*, %struct.stType** %112, align 8
  %114 = getelementptr inbounds %struct.stType, %struct.stType* %113, i32 0, i32 0
  %115 = load %struct.COORD*, %struct.COORD** %114, align 8
  %116 = getelementptr inbounds %struct.COORD, %struct.COORD* %115, i32 0, i32 0
  %117 = load i32*, i32** %116, align 8
  %118 = load i32, i32* %117, align 4
  %119 = icmp eq i32 %118, 11
  br i1 %119, label %120, label %300

; <label>:120:                                    ; preds = %110
  %121 = load %struct.stType**, %struct.stType*** %2, align 8
  %122 = getelementptr inbounds %struct.stType*, %struct.stType** %121, i64 2
  %123 = load %struct.stType*, %struct.stType** %122, align 8
  %124 = getelementptr inbounds %struct.stType, %struct.stType* %123, i32 0, i32 0
  %125 = load %struct.COORD*, %struct.COORD** %124, align 8
  %126 = getelementptr inbounds %struct.COORD, %struct.COORD* %125, i32 0, i32 1
  %127 = load i32*, i32** %126, align 8
  %128 = load i32, i32* %127, align 4
  %129 = icmp eq i32 %128, 12
  br i1 %129, label %130, label %300

; <label>:130:                                    ; preds = %120
  %131 = load %struct.stType**, %struct.stType*** %2, align 8
  %132 = getelementptr inbounds %struct.stType*, %struct.stType** %131, i64 2
  %133 = load %struct.stType*, %struct.stType** %132, align 8
  %134 = getelementptr inbounds %struct.stType, %struct.stType* %133, i32 0, i32 2
  %135 = getelementptr inbounds [8 x i32], [8 x i32]* %134, i64 0, i64 1
  %136 = load i32, i32* %135, align 4
  %137 = icmp eq i32 %136, 14
  br i1 %137, label %138, label %300

; <label>:138:                                    ; preds = %130
  %139 = load %struct.stType**, %struct.stType*** %2, align 8
  %140 = getelementptr inbounds %struct.stType*, %struct.stType** %139, i64 2
  %141 = load %struct.stType*, %struct.stType** %140, align 8
  %142 = getelementptr inbounds %struct.stType, %struct.stType* %141, i32 0, i32 1
  %143 = getelementptr inbounds [100 x i8], [100 x i8]* %142, i32 0, i32 0
  %144 = call i32 @strcmp(i8* %143, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %145 = icmp ne i32 %144, 0
  br i1 %145, label %300, label %146

; <label>:146:                                    ; preds = %138
  %147 = load %struct.stType**, %struct.stType*** %2, align 8
  %148 = getelementptr inbounds %struct.stType*, %struct.stType** %147, i64 2
  %149 = load %struct.stType*, %struct.stType** %148, align 8
  %150 = getelementptr inbounds %struct.stType, %struct.stType* %149, i32 0, i32 1
  %151 = getelementptr inbounds [100 x i8], [100 x i8]* %150, i64 0, i64 4
  %152 = load i8, i8* %151, align 4
  %153 = sext i8 %152 to i32
  %154 = icmp eq i32 %153, 111
  br i1 %154, label %155, label %300

; <label>:155:                                    ; preds = %146
  %156 = load %struct.stType**, %struct.stType*** %2, align 8
  %157 = getelementptr inbounds %struct.stType*, %struct.stType** %156, i64 2
  %158 = load %struct.stType*, %struct.stType** %157, align 8
  %159 = getelementptr inbounds %struct.stType, %struct.stType* %158, i32 0, i32 1
  %160 = getelementptr inbounds [100 x i8], [100 x i8]* %159, i64 0, i64 9
  %161 = load i8, i8* %160, align 1
  %162 = sext i8 %161 to i32
  %163 = icmp eq i32 %162, 100
  br i1 %163, label %164, label %300

; <label>:164:                                    ; preds = %155
  %165 = load %struct.stType**, %struct.stType*** %2, align 8
  %166 = getelementptr inbounds %struct.stType*, %struct.stType** %165, i64 3
  %167 = load %struct.stType*, %struct.stType** %166, align 8
  %168 = getelementptr inbounds %struct.stType, %struct.stType* %167, i32 0, i32 0
  %169 = load %struct.COORD*, %struct.COORD** %168, align 8
  %170 = getelementptr inbounds %struct.COORD, %struct.COORD* %169, i32 0, i32 0
  %171 = load i32*, i32** %170, align 8
  %172 = load i32, i32* %171, align 4
  %173 = icmp eq i32 %172, 16
  br i1 %173, label %174, label %300

; <label>:174:                                    ; preds = %164
  %175 = load %struct.stType**, %struct.stType*** %2, align 8
  %176 = getelementptr inbounds %struct.stType*, %struct.stType** %175, i64 3
  %177 = load %struct.stType*, %struct.stType** %176, align 8
  %178 = getelementptr inbounds %struct.stType, %struct.stType* %177, i32 0, i32 0
  %179 = load %struct.COORD*, %struct.COORD** %178, align 8
  %180 = getelementptr inbounds %struct.COORD, %struct.COORD* %179, i32 0, i32 1
  %181 = load i32*, i32** %180, align 8
  %182 = load i32, i32* %181, align 4
  %183 = icmp eq i32 %182, 17
  br i1 %183, label %184, label %300

; <label>:184:                                    ; preds = %174
  %185 = load %struct.stType**, %struct.stType*** %2, align 8
  %186 = getelementptr inbounds %struct.stType*, %struct.stType** %185, i64 3
  %187 = load %struct.stType*, %struct.stType** %186, align 8
  %188 = getelementptr inbounds %struct.stType, %struct.stType* %187, i32 0, i32 2
  %189 = getelementptr inbounds [8 x i32], [8 x i32]* %188, i64 0, i64 1
  %190 = load i32, i32* %189, align 4
  %191 = icmp eq i32 %190, 19
  br i1 %191, label %192, label %300

; <label>:192:                                    ; preds = %184
  %193 = load %struct.stType**, %struct.stType*** %2, align 8
  %194 = getelementptr inbounds %struct.stType*, %struct.stType** %193, i64 3
  %195 = load %struct.stType*, %struct.stType** %194, align 8
  %196 = getelementptr inbounds %struct.stType, %struct.stType* %195, i32 0, i32 1
  %197 = getelementptr inbounds [100 x i8], [100 x i8]* %196, i32 0, i32 0
  %198 = call i32 @strcmp(i8* %197, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %199 = icmp ne i32 %198, 0
  br i1 %199, label %300, label %200

; <label>:200:                                    ; preds = %192
  %201 = load %struct.stType**, %struct.stType*** %2, align 8
  %202 = getelementptr inbounds %struct.stType*, %struct.stType** %201, i64 3
  %203 = load %struct.stType*, %struct.stType** %202, align 8
  %204 = getelementptr inbounds %struct.stType, %struct.stType* %203, i32 0, i32 1
  %205 = getelementptr inbounds [100 x i8], [100 x i8]* %204, i64 0, i64 4
  %206 = load i8, i8* %205, align 4
  %207 = sext i8 %206 to i32
  %208 = icmp eq i32 %207, 111
  br i1 %208, label %209, label %300

; <label>:209:                                    ; preds = %200
  %210 = load %struct.stType**, %struct.stType*** %2, align 8
  %211 = getelementptr inbounds %struct.stType*, %struct.stType** %210, i64 3
  %212 = load %struct.stType*, %struct.stType** %211, align 8
  %213 = getelementptr inbounds %struct.stType, %struct.stType* %212, i32 0, i32 1
  %214 = getelementptr inbounds [100 x i8], [100 x i8]* %213, i64 0, i64 9
  %215 = load i8, i8* %214, align 1
  %216 = sext i8 %215 to i32
  %217 = icmp eq i32 %216, 100
  br i1 %217, label %218, label %300

; <label>:218:                                    ; preds = %209
  %219 = load %struct.stType**, %struct.stType*** %2, align 8
  %220 = getelementptr inbounds %struct.stType*, %struct.stType** %219, i64 4
  %221 = load %struct.stType*, %struct.stType** %220, align 8
  %222 = icmp eq %struct.stType* %221, null
  br i1 %222, label %223, label %300

; <label>:223:                                    ; preds = %218
  %224 = load %struct.stType**, %struct.stType*** %2, align 8
  %225 = getelementptr inbounds %struct.stType*, %struct.stType** %224, i64 5
  %226 = load %struct.stType*, %struct.stType** %225, align 8
  %227 = icmp eq %struct.stType* %226, null
  br i1 %227, label %228, label %300

; <label>:228:                                    ; preds = %223
  %229 = load %struct.stType**, %struct.stType*** %2, align 8
  %230 = getelementptr inbounds %struct.stType*, %struct.stType** %229, i64 6
  %231 = load %struct.stType*, %struct.stType** %230, align 8
  %232 = icmp eq %struct.stType* %231, null
  br i1 %232, label %233, label %300

; <label>:233:                                    ; preds = %228
  %234 = load %struct.stType**, %struct.stType*** %2, align 8
  %235 = getelementptr inbounds %struct.stType*, %struct.stType** %234, i64 7
  %236 = load %struct.stType*, %struct.stType** %235, align 8
  %237 = icmp eq %struct.stType* %236, null
  br i1 %237, label %238, label %300

; <label>:238:                                    ; preds = %233
  %239 = load %struct.stType**, %struct.stType*** %2, align 8
  %240 = getelementptr inbounds %struct.stType*, %struct.stType** %239, i64 8
  %241 = load %struct.stType*, %struct.stType** %240, align 8
  %242 = icmp eq %struct.stType* %241, null
  br i1 %242, label %243, label %300

; <label>:243:                                    ; preds = %238
  %244 = load %struct.stType**, %struct.stType*** %2, align 8
  %245 = getelementptr inbounds %struct.stType*, %struct.stType** %244, i64 9
  %246 = load %struct.stType*, %struct.stType** %245, align 8
  %247 = icmp eq %struct.stType* %246, null
  br i1 %247, label %248, label %300

; <label>:248:                                    ; preds = %243
  %249 = load %struct.stType**, %struct.stType*** %2, align 8
  %250 = getelementptr inbounds %struct.stType*, %struct.stType** %249, i64 10
  %251 = load %struct.stType*, %struct.stType** %250, align 8
  %252 = icmp eq %struct.stType* %251, null
  br i1 %252, label %253, label %300

; <label>:253:                                    ; preds = %248
  %254 = load %struct.stType**, %struct.stType*** %2, align 8
  %255 = getelementptr inbounds %struct.stType*, %struct.stType** %254, i64 11
  %256 = load %struct.stType*, %struct.stType** %255, align 8
  %257 = icmp eq %struct.stType* %256, null
  br i1 %257, label %258, label %300

; <label>:258:                                    ; preds = %253
  %259 = load %struct.stType**, %struct.stType*** %2, align 8
  %260 = getelementptr inbounds %struct.stType*, %struct.stType** %259, i64 12
  %261 = load %struct.stType*, %struct.stType** %260, align 8
  %262 = icmp eq %struct.stType* %261, null
  br i1 %262, label %263, label %300

; <label>:263:                                    ; preds = %258
  %264 = load %struct.stType**, %struct.stType*** %2, align 8
  %265 = getelementptr inbounds %struct.stType*, %struct.stType** %264, i64 13
  %266 = load %struct.stType*, %struct.stType** %265, align 8
  %267 = icmp eq %struct.stType* %266, null
  br i1 %267, label %268, label %300

; <label>:268:                                    ; preds = %263
  %269 = load %struct.stType**, %struct.stType*** %2, align 8
  %270 = getelementptr inbounds %struct.stType*, %struct.stType** %269, i64 14
  %271 = load %struct.stType*, %struct.stType** %270, align 8
  %272 = icmp eq %struct.stType* %271, null
  br i1 %272, label %273, label %300

; <label>:273:                                    ; preds = %268
  %274 = load %struct.stType**, %struct.stType*** %2, align 8
  %275 = getelementptr inbounds %struct.stType*, %struct.stType** %274, i64 15
  %276 = load %struct.stType*, %struct.stType** %275, align 8
  %277 = icmp eq %struct.stType* %276, null
  br i1 %277, label %278, label %300

; <label>:278:                                    ; preds = %273
  %279 = load %struct.stType**, %struct.stType*** %2, align 8
  %280 = getelementptr inbounds %struct.stType*, %struct.stType** %279, i64 16
  %281 = load %struct.stType*, %struct.stType** %280, align 8
  %282 = icmp eq %struct.stType* %281, null
  br i1 %282, label %283, label %300

; <label>:283:                                    ; preds = %278
  %284 = load %struct.stType**, %struct.stType*** %2, align 8
  %285 = getelementptr inbounds %struct.stType*, %struct.stType** %284, i64 17
  %286 = load %struct.stType*, %struct.stType** %285, align 8
  %287 = icmp eq %struct.stType* %286, null
  br i1 %287, label %288, label %300

; <label>:288:                                    ; preds = %283
  %289 = load %struct.stType**, %struct.stType*** %2, align 8
  %290 = getelementptr inbounds %struct.stType*, %struct.stType** %289, i64 18
  %291 = load %struct.stType*, %struct.stType** %290, align 8
  %292 = icmp eq %struct.stType* %291, null
  br i1 %292, label %293, label %300

; <label>:293:                                    ; preds = %288
  %294 = load %struct.stType**, %struct.stType*** %2, align 8
  %295 = getelementptr inbounds %struct.stType*, %struct.stType** %294, i64 19
  %296 = load %struct.stType*, %struct.stType** %295, align 8
  %297 = icmp eq %struct.stType* %296, null
  br i1 %297, label %298, label %300

; <label>:298:                                    ; preds = %293
  %299 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %300

; <label>:300:                                    ; preds = %298, %293, %288, %283, %278, %273, %268, %263, %258, %253, %248, %243, %238, %233, %228, %223, %218, %209, %200, %192, %184, %174, %164, %155, %146, %138, %130, %120, %110, %101, %92, %84, %76, %66, %56, %47, %38, %30, %22, %12, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define void @initialize(%struct.stType**) #0 {
  %2 = alloca %struct.stType**, align 8
  store %struct.stType** %0, %struct.stType*** %2, align 8
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.stType**, align 8
  store i32 0, i32* %1, align 4
  %3 = call noalias i8* @malloc(i64 160) #6
  %4 = bitcast i8* %3 to %struct.stType**
  store %struct.stType** %4, %struct.stType*** %2, align 8
  %5 = call noalias i8* @malloc(i64 144) #6
  %6 = bitcast i8* %5 to %struct.stType*
  %7 = load %struct.stType**, %struct.stType*** %2, align 8
  %8 = getelementptr inbounds %struct.stType*, %struct.stType** %7, i64 0
  store %struct.stType* %6, %struct.stType** %8, align 8
  %9 = call noalias i8* @malloc(i64 16) #6
  %10 = bitcast i8* %9 to %struct.COORD*
  %11 = load %struct.stType**, %struct.stType*** %2, align 8
  %12 = getelementptr inbounds %struct.stType*, %struct.stType** %11, i64 0
  %13 = load %struct.stType*, %struct.stType** %12, align 8
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %13, i32 0, i32 0
  store %struct.COORD* %10, %struct.COORD** %14, align 8
  %15 = call noalias i8* @malloc(i64 4) #6
  %16 = bitcast i8* %15 to i32*
  %17 = load %struct.stType**, %struct.stType*** %2, align 8
  %18 = getelementptr inbounds %struct.stType*, %struct.stType** %17, i64 0
  %19 = load %struct.stType*, %struct.stType** %18, align 8
  %20 = getelementptr inbounds %struct.stType, %struct.stType* %19, i32 0, i32 0
  %21 = load %struct.COORD*, %struct.COORD** %20, align 8
  %22 = getelementptr inbounds %struct.COORD, %struct.COORD* %21, i32 0, i32 0
  store i32* %16, i32** %22, align 8
  %23 = call noalias i8* @malloc(i64 4) #6
  %24 = bitcast i8* %23 to i32*
  %25 = load %struct.stType**, %struct.stType*** %2, align 8
  %26 = getelementptr inbounds %struct.stType*, %struct.stType** %25, i64 0
  %27 = load %struct.stType*, %struct.stType** %26, align 8
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i32 0, i32 0
  %29 = load %struct.COORD*, %struct.COORD** %28, align 8
  %30 = getelementptr inbounds %struct.COORD, %struct.COORD* %29, i32 0, i32 1
  store i32* %24, i32** %30, align 8
  %31 = load %struct.stType**, %struct.stType*** %2, align 8
  %32 = getelementptr inbounds %struct.stType*, %struct.stType** %31, i64 0
  %33 = load %struct.stType*, %struct.stType** %32, align 8
  %34 = getelementptr inbounds %struct.stType, %struct.stType* %33, i32 0, i32 0
  %35 = load %struct.COORD*, %struct.COORD** %34, align 8
  %36 = getelementptr inbounds %struct.COORD, %struct.COORD* %35, i32 0, i32 0
  %37 = load i32*, i32** %36, align 8
  %38 = getelementptr inbounds i32, i32* %37, i64 0
  store i32 1, i32* %38, align 4
  %39 = load %struct.stType**, %struct.stType*** %2, align 8
  %40 = getelementptr inbounds %struct.stType*, %struct.stType** %39, i64 0
  %41 = load %struct.stType*, %struct.stType** %40, align 8
  %42 = getelementptr inbounds %struct.stType, %struct.stType* %41, i32 0, i32 0
  %43 = load %struct.COORD*, %struct.COORD** %42, align 8
  %44 = getelementptr inbounds %struct.COORD, %struct.COORD* %43, i32 0, i32 1
  %45 = load i32*, i32** %44, align 8
  %46 = getelementptr inbounds i32, i32* %45, i64 0
  store i32 2, i32* %46, align 4
  %47 = load %struct.stType**, %struct.stType*** %2, align 8
  %48 = getelementptr inbounds %struct.stType*, %struct.stType** %47, i64 0
  %49 = load %struct.stType*, %struct.stType** %48, align 8
  %50 = getelementptr inbounds %struct.stType, %struct.stType* %49, i32 0, i32 2
  %51 = getelementptr inbounds [8 x i32], [8 x i32]* %50, i64 0, i64 0
  store i32 3, i32* %51, align 4
  %52 = load %struct.stType**, %struct.stType*** %2, align 8
  %53 = getelementptr inbounds %struct.stType*, %struct.stType** %52, i64 0
  %54 = load %struct.stType*, %struct.stType** %53, align 8
  %55 = getelementptr inbounds %struct.stType, %struct.stType* %54, i32 0, i32 2
  %56 = getelementptr inbounds [8 x i32], [8 x i32]* %55, i64 0, i64 1
  store i32 4, i32* %56, align 4
  %57 = load %struct.stType**, %struct.stType*** %2, align 8
  %58 = getelementptr inbounds %struct.stType*, %struct.stType** %57, i64 0
  %59 = load %struct.stType*, %struct.stType** %58, align 8
  %60 = getelementptr inbounds %struct.stType, %struct.stType* %59, i32 0, i32 2
  %61 = getelementptr inbounds [8 x i32], [8 x i32]* %60, i64 0, i64 2
  store i32 5, i32* %61, align 4
  %62 = load %struct.stType**, %struct.stType*** %2, align 8
  %63 = getelementptr inbounds %struct.stType*, %struct.stType** %62, i64 0
  %64 = load %struct.stType*, %struct.stType** %63, align 8
  %65 = getelementptr inbounds %struct.stType, %struct.stType* %64, i32 0, i32 1
  %66 = getelementptr inbounds [100 x i8], [100 x i8]* %65, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %66, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  %67 = call noalias i8* @malloc(i64 144) #6
  %68 = bitcast i8* %67 to %struct.stType*
  %69 = load %struct.stType**, %struct.stType*** %2, align 8
  %70 = getelementptr inbounds %struct.stType*, %struct.stType** %69, i64 1
  store %struct.stType* %68, %struct.stType** %70, align 8
  %71 = call noalias i8* @malloc(i64 16) #6
  %72 = bitcast i8* %71 to %struct.COORD*
  %73 = load %struct.stType**, %struct.stType*** %2, align 8
  %74 = getelementptr inbounds %struct.stType*, %struct.stType** %73, i64 1
  %75 = load %struct.stType*, %struct.stType** %74, align 8
  %76 = getelementptr inbounds %struct.stType, %struct.stType* %75, i32 0, i32 0
  store %struct.COORD* %72, %struct.COORD** %76, align 8
  %77 = call noalias i8* @malloc(i64 4) #6
  %78 = bitcast i8* %77 to i32*
  %79 = load %struct.stType**, %struct.stType*** %2, align 8
  %80 = getelementptr inbounds %struct.stType*, %struct.stType** %79, i64 1
  %81 = load %struct.stType*, %struct.stType** %80, align 8
  %82 = getelementptr inbounds %struct.stType, %struct.stType* %81, i32 0, i32 0
  %83 = load %struct.COORD*, %struct.COORD** %82, align 8
  %84 = getelementptr inbounds %struct.COORD, %struct.COORD* %83, i32 0, i32 0
  store i32* %78, i32** %84, align 8
  %85 = call noalias i8* @malloc(i64 4) #6
  %86 = bitcast i8* %85 to i32*
  %87 = load %struct.stType**, %struct.stType*** %2, align 8
  %88 = getelementptr inbounds %struct.stType*, %struct.stType** %87, i64 1
  %89 = load %struct.stType*, %struct.stType** %88, align 8
  %90 = getelementptr inbounds %struct.stType, %struct.stType* %89, i32 0, i32 0
  %91 = load %struct.COORD*, %struct.COORD** %90, align 8
  %92 = getelementptr inbounds %struct.COORD, %struct.COORD* %91, i32 0, i32 1
  store i32* %86, i32** %92, align 8
  %93 = load %struct.stType**, %struct.stType*** %2, align 8
  %94 = getelementptr inbounds %struct.stType*, %struct.stType** %93, i64 1
  %95 = load %struct.stType*, %struct.stType** %94, align 8
  %96 = getelementptr inbounds %struct.stType, %struct.stType* %95, i32 0, i32 0
  %97 = load %struct.COORD*, %struct.COORD** %96, align 8
  %98 = getelementptr inbounds %struct.COORD, %struct.COORD* %97, i32 0, i32 0
  %99 = load i32*, i32** %98, align 8
  %100 = getelementptr inbounds i32, i32* %99, i64 0
  store i32 6, i32* %100, align 4
  %101 = load %struct.stType**, %struct.stType*** %2, align 8
  %102 = getelementptr inbounds %struct.stType*, %struct.stType** %101, i64 1
  %103 = load %struct.stType*, %struct.stType** %102, align 8
  %104 = getelementptr inbounds %struct.stType, %struct.stType* %103, i32 0, i32 0
  %105 = load %struct.COORD*, %struct.COORD** %104, align 8
  %106 = getelementptr inbounds %struct.COORD, %struct.COORD* %105, i32 0, i32 1
  %107 = load i32*, i32** %106, align 8
  %108 = getelementptr inbounds i32, i32* %107, i64 0
  store i32 7, i32* %108, align 4
  %109 = load %struct.stType**, %struct.stType*** %2, align 8
  %110 = getelementptr inbounds %struct.stType*, %struct.stType** %109, i64 1
  %111 = load %struct.stType*, %struct.stType** %110, align 8
  %112 = getelementptr inbounds %struct.stType, %struct.stType* %111, i32 0, i32 2
  %113 = getelementptr inbounds [8 x i32], [8 x i32]* %112, i64 0, i64 0
  store i32 8, i32* %113, align 4
  %114 = load %struct.stType**, %struct.stType*** %2, align 8
  %115 = getelementptr inbounds %struct.stType*, %struct.stType** %114, i64 1
  %116 = load %struct.stType*, %struct.stType** %115, align 8
  %117 = getelementptr inbounds %struct.stType, %struct.stType* %116, i32 0, i32 2
  %118 = getelementptr inbounds [8 x i32], [8 x i32]* %117, i64 0, i64 1
  store i32 9, i32* %118, align 4
  %119 = load %struct.stType**, %struct.stType*** %2, align 8
  %120 = getelementptr inbounds %struct.stType*, %struct.stType** %119, i64 1
  %121 = load %struct.stType*, %struct.stType** %120, align 8
  %122 = getelementptr inbounds %struct.stType, %struct.stType* %121, i32 0, i32 2
  %123 = getelementptr inbounds [8 x i32], [8 x i32]* %122, i64 0, i64 2
  store i32 10, i32* %123, align 4
  %124 = load %struct.stType**, %struct.stType*** %2, align 8
  %125 = getelementptr inbounds %struct.stType*, %struct.stType** %124, i64 1
  %126 = load %struct.stType*, %struct.stType** %125, align 8
  %127 = getelementptr inbounds %struct.stType, %struct.stType* %126, i32 0, i32 1
  %128 = getelementptr inbounds [100 x i8], [100 x i8]* %127, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %128, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  %129 = call noalias i8* @malloc(i64 144) #6
  %130 = bitcast i8* %129 to %struct.stType*
  %131 = load %struct.stType**, %struct.stType*** %2, align 8
  %132 = getelementptr inbounds %struct.stType*, %struct.stType** %131, i64 2
  store %struct.stType* %130, %struct.stType** %132, align 8
  %133 = call noalias i8* @malloc(i64 16) #6
  %134 = bitcast i8* %133 to %struct.COORD*
  %135 = load %struct.stType**, %struct.stType*** %2, align 8
  %136 = getelementptr inbounds %struct.stType*, %struct.stType** %135, i64 2
  %137 = load %struct.stType*, %struct.stType** %136, align 8
  %138 = getelementptr inbounds %struct.stType, %struct.stType* %137, i32 0, i32 0
  store %struct.COORD* %134, %struct.COORD** %138, align 8
  %139 = call noalias i8* @malloc(i64 4) #6
  %140 = bitcast i8* %139 to i32*
  %141 = load %struct.stType**, %struct.stType*** %2, align 8
  %142 = getelementptr inbounds %struct.stType*, %struct.stType** %141, i64 2
  %143 = load %struct.stType*, %struct.stType** %142, align 8
  %144 = getelementptr inbounds %struct.stType, %struct.stType* %143, i32 0, i32 0
  %145 = load %struct.COORD*, %struct.COORD** %144, align 8
  %146 = getelementptr inbounds %struct.COORD, %struct.COORD* %145, i32 0, i32 0
  store i32* %140, i32** %146, align 8
  %147 = call noalias i8* @malloc(i64 4) #6
  %148 = bitcast i8* %147 to i32*
  %149 = load %struct.stType**, %struct.stType*** %2, align 8
  %150 = getelementptr inbounds %struct.stType*, %struct.stType** %149, i64 2
  %151 = load %struct.stType*, %struct.stType** %150, align 8
  %152 = getelementptr inbounds %struct.stType, %struct.stType* %151, i32 0, i32 0
  %153 = load %struct.COORD*, %struct.COORD** %152, align 8
  %154 = getelementptr inbounds %struct.COORD, %struct.COORD* %153, i32 0, i32 1
  store i32* %148, i32** %154, align 8
  %155 = load %struct.stType**, %struct.stType*** %2, align 8
  %156 = getelementptr inbounds %struct.stType*, %struct.stType** %155, i64 2
  %157 = load %struct.stType*, %struct.stType** %156, align 8
  %158 = getelementptr inbounds %struct.stType, %struct.stType* %157, i32 0, i32 0
  %159 = load %struct.COORD*, %struct.COORD** %158, align 8
  %160 = getelementptr inbounds %struct.COORD, %struct.COORD* %159, i32 0, i32 0
  %161 = load i32*, i32** %160, align 8
  %162 = getelementptr inbounds i32, i32* %161, i64 0
  store i32 11, i32* %162, align 4
  %163 = load %struct.stType**, %struct.stType*** %2, align 8
  %164 = getelementptr inbounds %struct.stType*, %struct.stType** %163, i64 2
  %165 = load %struct.stType*, %struct.stType** %164, align 8
  %166 = getelementptr inbounds %struct.stType, %struct.stType* %165, i32 0, i32 0
  %167 = load %struct.COORD*, %struct.COORD** %166, align 8
  %168 = getelementptr inbounds %struct.COORD, %struct.COORD* %167, i32 0, i32 1
  %169 = load i32*, i32** %168, align 8
  %170 = getelementptr inbounds i32, i32* %169, i64 0
  store i32 12, i32* %170, align 4
  %171 = load %struct.stType**, %struct.stType*** %2, align 8
  %172 = getelementptr inbounds %struct.stType*, %struct.stType** %171, i64 2
  %173 = load %struct.stType*, %struct.stType** %172, align 8
  %174 = getelementptr inbounds %struct.stType, %struct.stType* %173, i32 0, i32 2
  %175 = getelementptr inbounds [8 x i32], [8 x i32]* %174, i64 0, i64 0
  store i32 13, i32* %175, align 4
  %176 = load %struct.stType**, %struct.stType*** %2, align 8
  %177 = getelementptr inbounds %struct.stType*, %struct.stType** %176, i64 2
  %178 = load %struct.stType*, %struct.stType** %177, align 8
  %179 = getelementptr inbounds %struct.stType, %struct.stType* %178, i32 0, i32 2
  %180 = getelementptr inbounds [8 x i32], [8 x i32]* %179, i64 0, i64 1
  store i32 14, i32* %180, align 4
  %181 = load %struct.stType**, %struct.stType*** %2, align 8
  %182 = getelementptr inbounds %struct.stType*, %struct.stType** %181, i64 2
  %183 = load %struct.stType*, %struct.stType** %182, align 8
  %184 = getelementptr inbounds %struct.stType, %struct.stType* %183, i32 0, i32 2
  %185 = getelementptr inbounds [8 x i32], [8 x i32]* %184, i64 0, i64 2
  store i32 15, i32* %185, align 4
  %186 = load %struct.stType**, %struct.stType*** %2, align 8
  %187 = getelementptr inbounds %struct.stType*, %struct.stType** %186, i64 2
  %188 = load %struct.stType*, %struct.stType** %187, align 8
  %189 = getelementptr inbounds %struct.stType, %struct.stType* %188, i32 0, i32 1
  %190 = getelementptr inbounds [100 x i8], [100 x i8]* %189, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %190, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  %191 = call noalias i8* @malloc(i64 144) #6
  %192 = bitcast i8* %191 to %struct.stType*
  %193 = load %struct.stType**, %struct.stType*** %2, align 8
  %194 = getelementptr inbounds %struct.stType*, %struct.stType** %193, i64 3
  store %struct.stType* %192, %struct.stType** %194, align 8
  %195 = call noalias i8* @malloc(i64 16) #6
  %196 = bitcast i8* %195 to %struct.COORD*
  %197 = load %struct.stType**, %struct.stType*** %2, align 8
  %198 = getelementptr inbounds %struct.stType*, %struct.stType** %197, i64 3
  %199 = load %struct.stType*, %struct.stType** %198, align 8
  %200 = getelementptr inbounds %struct.stType, %struct.stType* %199, i32 0, i32 0
  store %struct.COORD* %196, %struct.COORD** %200, align 8
  %201 = call noalias i8* @malloc(i64 4) #6
  %202 = bitcast i8* %201 to i32*
  %203 = load %struct.stType**, %struct.stType*** %2, align 8
  %204 = getelementptr inbounds %struct.stType*, %struct.stType** %203, i64 3
  %205 = load %struct.stType*, %struct.stType** %204, align 8
  %206 = getelementptr inbounds %struct.stType, %struct.stType* %205, i32 0, i32 0
  %207 = load %struct.COORD*, %struct.COORD** %206, align 8
  %208 = getelementptr inbounds %struct.COORD, %struct.COORD* %207, i32 0, i32 0
  store i32* %202, i32** %208, align 8
  %209 = call noalias i8* @malloc(i64 4) #6
  %210 = bitcast i8* %209 to i32*
  %211 = load %struct.stType**, %struct.stType*** %2, align 8
  %212 = getelementptr inbounds %struct.stType*, %struct.stType** %211, i64 3
  %213 = load %struct.stType*, %struct.stType** %212, align 8
  %214 = getelementptr inbounds %struct.stType, %struct.stType* %213, i32 0, i32 0
  %215 = load %struct.COORD*, %struct.COORD** %214, align 8
  %216 = getelementptr inbounds %struct.COORD, %struct.COORD* %215, i32 0, i32 1
  store i32* %210, i32** %216, align 8
  %217 = load %struct.stType**, %struct.stType*** %2, align 8
  %218 = getelementptr inbounds %struct.stType*, %struct.stType** %217, i64 3
  %219 = load %struct.stType*, %struct.stType** %218, align 8
  %220 = getelementptr inbounds %struct.stType, %struct.stType* %219, i32 0, i32 0
  %221 = load %struct.COORD*, %struct.COORD** %220, align 8
  %222 = getelementptr inbounds %struct.COORD, %struct.COORD* %221, i32 0, i32 0
  %223 = load i32*, i32** %222, align 8
  %224 = getelementptr inbounds i32, i32* %223, i64 0
  store i32 16, i32* %224, align 4
  %225 = load %struct.stType**, %struct.stType*** %2, align 8
  %226 = getelementptr inbounds %struct.stType*, %struct.stType** %225, i64 3
  %227 = load %struct.stType*, %struct.stType** %226, align 8
  %228 = getelementptr inbounds %struct.stType, %struct.stType* %227, i32 0, i32 0
  %229 = load %struct.COORD*, %struct.COORD** %228, align 8
  %230 = getelementptr inbounds %struct.COORD, %struct.COORD* %229, i32 0, i32 1
  %231 = load i32*, i32** %230, align 8
  %232 = getelementptr inbounds i32, i32* %231, i64 0
  store i32 17, i32* %232, align 4
  %233 = load %struct.stType**, %struct.stType*** %2, align 8
  %234 = getelementptr inbounds %struct.stType*, %struct.stType** %233, i64 3
  %235 = load %struct.stType*, %struct.stType** %234, align 8
  %236 = getelementptr inbounds %struct.stType, %struct.stType* %235, i32 0, i32 2
  %237 = getelementptr inbounds [8 x i32], [8 x i32]* %236, i64 0, i64 0
  store i32 18, i32* %237, align 4
  %238 = load %struct.stType**, %struct.stType*** %2, align 8
  %239 = getelementptr inbounds %struct.stType*, %struct.stType** %238, i64 3
  %240 = load %struct.stType*, %struct.stType** %239, align 8
  %241 = getelementptr inbounds %struct.stType, %struct.stType* %240, i32 0, i32 2
  %242 = getelementptr inbounds [8 x i32], [8 x i32]* %241, i64 0, i64 1
  store i32 19, i32* %242, align 4
  %243 = load %struct.stType**, %struct.stType*** %2, align 8
  %244 = getelementptr inbounds %struct.stType*, %struct.stType** %243, i64 3
  %245 = load %struct.stType*, %struct.stType** %244, align 8
  %246 = getelementptr inbounds %struct.stType, %struct.stType* %245, i32 0, i32 2
  %247 = getelementptr inbounds [8 x i32], [8 x i32]* %246, i64 0, i64 2
  store i32 20, i32* %247, align 4
  %248 = load %struct.stType**, %struct.stType*** %2, align 8
  %249 = getelementptr inbounds %struct.stType*, %struct.stType** %248, i64 3
  %250 = load %struct.stType*, %struct.stType** %249, align 8
  %251 = getelementptr inbounds %struct.stType, %struct.stType* %250, i32 0, i32 1
  %252 = getelementptr inbounds [100 x i8], [100 x i8]* %251, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %252, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  %253 = load %struct.stType**, %struct.stType*** %2, align 8
  call void @branchPruned(%struct.stType** %253)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #4

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
