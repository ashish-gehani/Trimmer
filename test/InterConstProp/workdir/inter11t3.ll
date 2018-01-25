; ModuleID = 'workdir/inter11t3.bc'
source_filename = "inter11.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"*** Branch Taken \0A\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@0 = constant [11 x i8] c"helloWorld\00"
@1 = constant [11 x i8] c"helloWorld\00"
@2 = constant [11 x i8] c"helloWorld\00"
@3 = constant [11 x i8] c"helloWorld\00"
@4 = constant [11 x i8] c"helloWorld\00"
@5 = constant [11 x i8] c"helloWorld\00"
@6 = constant [11 x i8] c"helloWorld\00"
@7 = constant [11 x i8] c"helloWorld\00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType**) #0 {
  %2 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %3 = load %struct.stType*, %struct.stType** %2, align 8
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 0
  %5 = load %struct.COORD*, %struct.COORD** %4, align 8
  %6 = getelementptr inbounds %struct.COORD, %struct.COORD* %5, i32 0, i32 0
  %7 = load i32*, i32** %6, align 8
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 %8, 1
  br i1 %9, label %10, label %259

; <label>:10:                                     ; preds = %1
  %11 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %12 = load %struct.stType*, %struct.stType** %11, align 8
  %13 = getelementptr inbounds %struct.stType, %struct.stType* %12, i32 0, i32 0
  %14 = load %struct.COORD*, %struct.COORD** %13, align 8
  %15 = getelementptr inbounds %struct.COORD, %struct.COORD* %14, i32 0, i32 1
  %16 = load i32*, i32** %15, align 8
  %17 = load i32, i32* %16, align 4
  %18 = icmp eq i32 %17, 2
  br i1 %18, label %19, label %259

; <label>:19:                                     ; preds = %10
  %20 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %21 = load %struct.stType*, %struct.stType** %20, align 8
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %21, i32 0, i32 2
  %23 = getelementptr inbounds [8 x i32], [8 x i32]* %22, i64 0, i64 1
  %24 = load i32, i32* %23, align 4
  %25 = icmp eq i32 %24, 4
  br i1 %25, label %26, label %259

; <label>:26:                                     ; preds = %19
  %27 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %28 = load %struct.stType*, %struct.stType** %27, align 8
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i32 0, i32 1
  %30 = getelementptr inbounds [100 x i8], [100 x i8]* %29, i32 0, i32 0
  %31 = call i32 @strcmp(i8* %30, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %32 = icmp ne i32 %31, 0
  br i1 %32, label %259, label %33

; <label>:33:                                     ; preds = %26
  %34 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %35 = load %struct.stType*, %struct.stType** %34, align 8
  %36 = getelementptr inbounds %struct.stType, %struct.stType* %35, i32 0, i32 1
  %37 = getelementptr inbounds [100 x i8], [100 x i8]* %36, i64 0, i64 4
  %38 = load i8, i8* %37, align 4
  %39 = sext i8 %38 to i32
  %40 = icmp eq i32 %39, 111
  br i1 %40, label %41, label %259

; <label>:41:                                     ; preds = %33
  %42 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %43 = load %struct.stType*, %struct.stType** %42, align 8
  %44 = getelementptr inbounds %struct.stType, %struct.stType* %43, i32 0, i32 1
  %45 = getelementptr inbounds [100 x i8], [100 x i8]* %44, i64 0, i64 9
  %46 = load i8, i8* %45, align 1
  %47 = sext i8 %46 to i32
  %48 = icmp eq i32 %47, 100
  br i1 %48, label %49, label %259

; <label>:49:                                     ; preds = %41
  %50 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %51 = load %struct.stType*, %struct.stType** %50, align 8
  %52 = getelementptr inbounds %struct.stType, %struct.stType* %51, i32 0, i32 0
  %53 = load %struct.COORD*, %struct.COORD** %52, align 8
  %54 = getelementptr inbounds %struct.COORD, %struct.COORD* %53, i32 0, i32 0
  %55 = load i32*, i32** %54, align 8
  %56 = load i32, i32* %55, align 4
  %57 = icmp eq i32 %56, 6
  br i1 %57, label %58, label %259

; <label>:58:                                     ; preds = %49
  %59 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %60 = load %struct.stType*, %struct.stType** %59, align 8
  %61 = getelementptr inbounds %struct.stType, %struct.stType* %60, i32 0, i32 0
  %62 = load %struct.COORD*, %struct.COORD** %61, align 8
  %63 = getelementptr inbounds %struct.COORD, %struct.COORD* %62, i32 0, i32 1
  %64 = load i32*, i32** %63, align 8
  %65 = load i32, i32* %64, align 4
  %66 = icmp eq i32 %65, 7
  br i1 %66, label %67, label %259

; <label>:67:                                     ; preds = %58
  %68 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %69 = load %struct.stType*, %struct.stType** %68, align 8
  %70 = getelementptr inbounds %struct.stType, %struct.stType* %69, i32 0, i32 2
  %71 = getelementptr inbounds [8 x i32], [8 x i32]* %70, i64 0, i64 1
  %72 = load i32, i32* %71, align 4
  %73 = icmp eq i32 %72, 9
  br i1 %73, label %74, label %259

; <label>:74:                                     ; preds = %67
  %75 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %76 = load %struct.stType*, %struct.stType** %75, align 8
  %77 = getelementptr inbounds %struct.stType, %struct.stType* %76, i32 0, i32 1
  %78 = getelementptr inbounds [100 x i8], [100 x i8]* %77, i32 0, i32 0
  %79 = call i32 @strcmp(i8* %78, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %80 = icmp ne i32 %79, 0
  br i1 %80, label %259, label %81

; <label>:81:                                     ; preds = %74
  %82 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %83 = load %struct.stType*, %struct.stType** %82, align 8
  %84 = getelementptr inbounds %struct.stType, %struct.stType* %83, i32 0, i32 1
  %85 = getelementptr inbounds [100 x i8], [100 x i8]* %84, i64 0, i64 4
  %86 = load i8, i8* %85, align 4
  %87 = sext i8 %86 to i32
  %88 = icmp eq i32 %87, 111
  br i1 %88, label %89, label %259

; <label>:89:                                     ; preds = %81
  %90 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %91 = load %struct.stType*, %struct.stType** %90, align 8
  %92 = getelementptr inbounds %struct.stType, %struct.stType* %91, i32 0, i32 1
  %93 = getelementptr inbounds [100 x i8], [100 x i8]* %92, i64 0, i64 9
  %94 = load i8, i8* %93, align 1
  %95 = sext i8 %94 to i32
  %96 = icmp eq i32 %95, 100
  br i1 %96, label %97, label %259

; <label>:97:                                     ; preds = %89
  %98 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %99 = load %struct.stType*, %struct.stType** %98, align 8
  %100 = getelementptr inbounds %struct.stType, %struct.stType* %99, i32 0, i32 0
  %101 = load %struct.COORD*, %struct.COORD** %100, align 8
  %102 = getelementptr inbounds %struct.COORD, %struct.COORD* %101, i32 0, i32 0
  %103 = load i32*, i32** %102, align 8
  %104 = load i32, i32* %103, align 4
  %105 = icmp eq i32 %104, 11
  br i1 %105, label %106, label %259

; <label>:106:                                    ; preds = %97
  %107 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %108 = load %struct.stType*, %struct.stType** %107, align 8
  %109 = getelementptr inbounds %struct.stType, %struct.stType* %108, i32 0, i32 0
  %110 = load %struct.COORD*, %struct.COORD** %109, align 8
  %111 = getelementptr inbounds %struct.COORD, %struct.COORD* %110, i32 0, i32 1
  %112 = load i32*, i32** %111, align 8
  %113 = load i32, i32* %112, align 4
  %114 = icmp eq i32 %113, 12
  br i1 %114, label %115, label %259

; <label>:115:                                    ; preds = %106
  %116 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %117 = load %struct.stType*, %struct.stType** %116, align 8
  %118 = getelementptr inbounds %struct.stType, %struct.stType* %117, i32 0, i32 2
  %119 = getelementptr inbounds [8 x i32], [8 x i32]* %118, i64 0, i64 1
  %120 = load i32, i32* %119, align 4
  %121 = icmp eq i32 %120, 14
  br i1 %121, label %122, label %259

; <label>:122:                                    ; preds = %115
  %123 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %124 = load %struct.stType*, %struct.stType** %123, align 8
  %125 = getelementptr inbounds %struct.stType, %struct.stType* %124, i32 0, i32 1
  %126 = getelementptr inbounds [100 x i8], [100 x i8]* %125, i32 0, i32 0
  %127 = call i32 @strcmp(i8* %126, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %128 = icmp ne i32 %127, 0
  br i1 %128, label %259, label %129

; <label>:129:                                    ; preds = %122
  %130 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %131 = load %struct.stType*, %struct.stType** %130, align 8
  %132 = getelementptr inbounds %struct.stType, %struct.stType* %131, i32 0, i32 1
  %133 = getelementptr inbounds [100 x i8], [100 x i8]* %132, i64 0, i64 4
  %134 = load i8, i8* %133, align 4
  %135 = sext i8 %134 to i32
  %136 = icmp eq i32 %135, 111
  br i1 %136, label %137, label %259

; <label>:137:                                    ; preds = %129
  %138 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %139 = load %struct.stType*, %struct.stType** %138, align 8
  %140 = getelementptr inbounds %struct.stType, %struct.stType* %139, i32 0, i32 1
  %141 = getelementptr inbounds [100 x i8], [100 x i8]* %140, i64 0, i64 9
  %142 = load i8, i8* %141, align 1
  %143 = sext i8 %142 to i32
  %144 = icmp eq i32 %143, 100
  br i1 %144, label %145, label %259

; <label>:145:                                    ; preds = %137
  %146 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %147 = load %struct.stType*, %struct.stType** %146, align 8
  %148 = getelementptr inbounds %struct.stType, %struct.stType* %147, i32 0, i32 0
  %149 = load %struct.COORD*, %struct.COORD** %148, align 8
  %150 = getelementptr inbounds %struct.COORD, %struct.COORD* %149, i32 0, i32 0
  %151 = load i32*, i32** %150, align 8
  %152 = load i32, i32* %151, align 4
  %153 = icmp eq i32 %152, 16
  br i1 %153, label %154, label %259

; <label>:154:                                    ; preds = %145
  %155 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %156 = load %struct.stType*, %struct.stType** %155, align 8
  %157 = getelementptr inbounds %struct.stType, %struct.stType* %156, i32 0, i32 0
  %158 = load %struct.COORD*, %struct.COORD** %157, align 8
  %159 = getelementptr inbounds %struct.COORD, %struct.COORD* %158, i32 0, i32 1
  %160 = load i32*, i32** %159, align 8
  %161 = load i32, i32* %160, align 4
  %162 = icmp eq i32 %161, 17
  br i1 %162, label %163, label %259

; <label>:163:                                    ; preds = %154
  %164 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %165 = load %struct.stType*, %struct.stType** %164, align 8
  %166 = getelementptr inbounds %struct.stType, %struct.stType* %165, i32 0, i32 2
  %167 = getelementptr inbounds [8 x i32], [8 x i32]* %166, i64 0, i64 1
  %168 = load i32, i32* %167, align 4
  %169 = icmp eq i32 %168, 19
  br i1 %169, label %170, label %259

; <label>:170:                                    ; preds = %163
  %171 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %172 = load %struct.stType*, %struct.stType** %171, align 8
  %173 = getelementptr inbounds %struct.stType, %struct.stType* %172, i32 0, i32 1
  %174 = getelementptr inbounds [100 x i8], [100 x i8]* %173, i32 0, i32 0
  %175 = call i32 @strcmp(i8* %174, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %176 = icmp ne i32 %175, 0
  br i1 %176, label %259, label %177

; <label>:177:                                    ; preds = %170
  %178 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %179 = load %struct.stType*, %struct.stType** %178, align 8
  %180 = getelementptr inbounds %struct.stType, %struct.stType* %179, i32 0, i32 1
  %181 = getelementptr inbounds [100 x i8], [100 x i8]* %180, i64 0, i64 4
  %182 = load i8, i8* %181, align 4
  %183 = sext i8 %182 to i32
  %184 = icmp eq i32 %183, 111
  br i1 %184, label %185, label %259

; <label>:185:                                    ; preds = %177
  %186 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %187 = load %struct.stType*, %struct.stType** %186, align 8
  %188 = getelementptr inbounds %struct.stType, %struct.stType* %187, i32 0, i32 1
  %189 = getelementptr inbounds [100 x i8], [100 x i8]* %188, i64 0, i64 9
  %190 = load i8, i8* %189, align 1
  %191 = sext i8 %190 to i32
  %192 = icmp eq i32 %191, 100
  br i1 %192, label %193, label %259

; <label>:193:                                    ; preds = %185
  %194 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 4
  %195 = load %struct.stType*, %struct.stType** %194, align 8
  %196 = icmp eq %struct.stType* %195, null
  br i1 %196, label %197, label %259

; <label>:197:                                    ; preds = %193
  %198 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 5
  %199 = load %struct.stType*, %struct.stType** %198, align 8
  %200 = icmp eq %struct.stType* %199, null
  br i1 %200, label %201, label %259

; <label>:201:                                    ; preds = %197
  %202 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 6
  %203 = load %struct.stType*, %struct.stType** %202, align 8
  %204 = icmp eq %struct.stType* %203, null
  br i1 %204, label %205, label %259

; <label>:205:                                    ; preds = %201
  %206 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 7
  %207 = load %struct.stType*, %struct.stType** %206, align 8
  %208 = icmp eq %struct.stType* %207, null
  br i1 %208, label %209, label %259

; <label>:209:                                    ; preds = %205
  %210 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 8
  %211 = load %struct.stType*, %struct.stType** %210, align 8
  %212 = icmp eq %struct.stType* %211, null
  br i1 %212, label %213, label %259

; <label>:213:                                    ; preds = %209
  %214 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 9
  %215 = load %struct.stType*, %struct.stType** %214, align 8
  %216 = icmp eq %struct.stType* %215, null
  br i1 %216, label %217, label %259

; <label>:217:                                    ; preds = %213
  %218 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 10
  %219 = load %struct.stType*, %struct.stType** %218, align 8
  %220 = icmp eq %struct.stType* %219, null
  br i1 %220, label %221, label %259

; <label>:221:                                    ; preds = %217
  %222 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 11
  %223 = load %struct.stType*, %struct.stType** %222, align 8
  %224 = icmp eq %struct.stType* %223, null
  br i1 %224, label %225, label %259

; <label>:225:                                    ; preds = %221
  %226 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 12
  %227 = load %struct.stType*, %struct.stType** %226, align 8
  %228 = icmp eq %struct.stType* %227, null
  br i1 %228, label %229, label %259

; <label>:229:                                    ; preds = %225
  %230 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 13
  %231 = load %struct.stType*, %struct.stType** %230, align 8
  %232 = icmp eq %struct.stType* %231, null
  br i1 %232, label %233, label %259

; <label>:233:                                    ; preds = %229
  %234 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 14
  %235 = load %struct.stType*, %struct.stType** %234, align 8
  %236 = icmp eq %struct.stType* %235, null
  br i1 %236, label %237, label %259

; <label>:237:                                    ; preds = %233
  %238 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 15
  %239 = load %struct.stType*, %struct.stType** %238, align 8
  %240 = icmp eq %struct.stType* %239, null
  br i1 %240, label %241, label %259

; <label>:241:                                    ; preds = %237
  %242 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 16
  %243 = load %struct.stType*, %struct.stType** %242, align 8
  %244 = icmp eq %struct.stType* %243, null
  br i1 %244, label %245, label %259

; <label>:245:                                    ; preds = %241
  %246 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 17
  %247 = load %struct.stType*, %struct.stType** %246, align 8
  %248 = icmp eq %struct.stType* %247, null
  br i1 %248, label %249, label %259

; <label>:249:                                    ; preds = %245
  %250 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 18
  %251 = load %struct.stType*, %struct.stType** %250, align 8
  %252 = icmp eq %struct.stType* %251, null
  br i1 %252, label %253, label %259

; <label>:253:                                    ; preds = %249
  %254 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 19
  %255 = load %struct.stType*, %struct.stType** %254, align 8
  %256 = icmp eq %struct.stType* %255, null
  br i1 %256, label %257, label %259

; <label>:257:                                    ; preds = %253
  %258 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %259

; <label>:259:                                    ; preds = %257, %253, %249, %245, %241, %237, %233, %229, %225, %221, %217, %213, %209, %205, %201, %197, %193, %185, %177, %170, %163, %154, %145, %137, %129, %122, %115, %106, %97, %89, %81, %74, %67, %58, %49, %41, %33, %26, %19, %10, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind uwtable
define void @initialize(%struct.stType**) #0 {
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 {
  %1 = call noalias i8* @malloc(i64 160) #6
  %2 = bitcast i8* %1 to %struct.stType**
  %3 = call noalias i8* @malloc(i64 144) #6
  %4 = bitcast i8* %3 to %struct.stType*
  %5 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  store %struct.stType* %4, %struct.stType** %5, align 8
  %6 = call noalias i8* @malloc(i64 16) #6
  %7 = bitcast i8* %6 to %struct.COORD*
  %8 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %9 = load %struct.stType*, %struct.stType** %8, align 8
  %10 = getelementptr inbounds %struct.stType, %struct.stType* %9, i32 0, i32 0
  store %struct.COORD* %7, %struct.COORD** %10, align 8
  %11 = call noalias i8* @malloc(i64 4) #6
  %12 = bitcast i8* %11 to i32*
  %13 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %14 = load %struct.stType*, %struct.stType** %13, align 8
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %14, i32 0, i32 0
  %16 = load %struct.COORD*, %struct.COORD** %15, align 8
  %17 = getelementptr inbounds %struct.COORD, %struct.COORD* %16, i32 0, i32 0
  store i32* %12, i32** %17, align 8
  %18 = call noalias i8* @malloc(i64 4) #6
  %19 = bitcast i8* %18 to i32*
  %20 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %21 = load %struct.stType*, %struct.stType** %20, align 8
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %21, i32 0, i32 0
  %23 = load %struct.COORD*, %struct.COORD** %22, align 8
  %24 = getelementptr inbounds %struct.COORD, %struct.COORD* %23, i32 0, i32 1
  store i32* %19, i32** %24, align 8
  %25 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %26 = load %struct.stType*, %struct.stType** %25, align 8
  %27 = getelementptr inbounds %struct.stType, %struct.stType* %26, i32 0, i32 0
  %28 = load %struct.COORD*, %struct.COORD** %27, align 8
  %29 = getelementptr inbounds %struct.COORD, %struct.COORD* %28, i32 0, i32 0
  %30 = load i32*, i32** %29, align 8
  %31 = getelementptr inbounds i32, i32* %30, i64 0
  store i32 1, i32* %31, align 4
  %32 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %33 = load %struct.stType*, %struct.stType** %32, align 8
  %34 = getelementptr inbounds %struct.stType, %struct.stType* %33, i32 0, i32 0
  %35 = load %struct.COORD*, %struct.COORD** %34, align 8
  %36 = getelementptr inbounds %struct.COORD, %struct.COORD* %35, i32 0, i32 1
  %37 = load i32*, i32** %36, align 8
  %38 = getelementptr inbounds i32, i32* %37, i64 0
  store i32 2, i32* %38, align 4
  %39 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %40 = load %struct.stType*, %struct.stType** %39, align 8
  %41 = getelementptr inbounds %struct.stType, %struct.stType* %40, i32 0, i32 2
  %42 = getelementptr inbounds [8 x i32], [8 x i32]* %41, i64 0, i64 0
  store i32 3, i32* %42, align 4
  %43 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %44 = load %struct.stType*, %struct.stType** %43, align 8
  %45 = getelementptr inbounds %struct.stType, %struct.stType* %44, i32 0, i32 2
  %46 = getelementptr inbounds [8 x i32], [8 x i32]* %45, i64 0, i64 1
  store i32 4, i32* %46, align 4
  %47 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %48 = load %struct.stType*, %struct.stType** %47, align 8
  %49 = getelementptr inbounds %struct.stType, %struct.stType* %48, i32 0, i32 2
  %50 = getelementptr inbounds [8 x i32], [8 x i32]* %49, i64 0, i64 2
  store i32 5, i32* %50, align 4
  %51 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 0
  %52 = load %struct.stType*, %struct.stType** %51, align 8
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %52, i32 0, i32 1
  %54 = getelementptr inbounds [100 x i8], [100 x i8]* %53, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %54, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  %55 = call noalias i8* @malloc(i64 144) #6
  %56 = bitcast i8* %55 to %struct.stType*
  %57 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  store %struct.stType* %56, %struct.stType** %57, align 8
  %58 = call noalias i8* @malloc(i64 16) #6
  %59 = bitcast i8* %58 to %struct.COORD*
  %60 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %61 = load %struct.stType*, %struct.stType** %60, align 8
  %62 = getelementptr inbounds %struct.stType, %struct.stType* %61, i32 0, i32 0
  store %struct.COORD* %59, %struct.COORD** %62, align 8
  %63 = call noalias i8* @malloc(i64 4) #6
  %64 = bitcast i8* %63 to i32*
  %65 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %66 = load %struct.stType*, %struct.stType** %65, align 8
  %67 = getelementptr inbounds %struct.stType, %struct.stType* %66, i32 0, i32 0
  %68 = load %struct.COORD*, %struct.COORD** %67, align 8
  %69 = getelementptr inbounds %struct.COORD, %struct.COORD* %68, i32 0, i32 0
  store i32* %64, i32** %69, align 8
  %70 = call noalias i8* @malloc(i64 4) #6
  %71 = bitcast i8* %70 to i32*
  %72 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %73 = load %struct.stType*, %struct.stType** %72, align 8
  %74 = getelementptr inbounds %struct.stType, %struct.stType* %73, i32 0, i32 0
  %75 = load %struct.COORD*, %struct.COORD** %74, align 8
  %76 = getelementptr inbounds %struct.COORD, %struct.COORD* %75, i32 0, i32 1
  store i32* %71, i32** %76, align 8
  %77 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %78 = load %struct.stType*, %struct.stType** %77, align 8
  %79 = getelementptr inbounds %struct.stType, %struct.stType* %78, i32 0, i32 0
  %80 = load %struct.COORD*, %struct.COORD** %79, align 8
  %81 = getelementptr inbounds %struct.COORD, %struct.COORD* %80, i32 0, i32 0
  %82 = load i32*, i32** %81, align 8
  %83 = getelementptr inbounds i32, i32* %82, i64 0
  store i32 6, i32* %83, align 4
  %84 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %85 = load %struct.stType*, %struct.stType** %84, align 8
  %86 = getelementptr inbounds %struct.stType, %struct.stType* %85, i32 0, i32 0
  %87 = load %struct.COORD*, %struct.COORD** %86, align 8
  %88 = getelementptr inbounds %struct.COORD, %struct.COORD* %87, i32 0, i32 1
  %89 = load i32*, i32** %88, align 8
  %90 = getelementptr inbounds i32, i32* %89, i64 0
  store i32 7, i32* %90, align 4
  %91 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %92 = load %struct.stType*, %struct.stType** %91, align 8
  %93 = getelementptr inbounds %struct.stType, %struct.stType* %92, i32 0, i32 2
  %94 = getelementptr inbounds [8 x i32], [8 x i32]* %93, i64 0, i64 0
  store i32 8, i32* %94, align 4
  %95 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %96 = load %struct.stType*, %struct.stType** %95, align 8
  %97 = getelementptr inbounds %struct.stType, %struct.stType* %96, i32 0, i32 2
  %98 = getelementptr inbounds [8 x i32], [8 x i32]* %97, i64 0, i64 1
  store i32 9, i32* %98, align 4
  %99 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %100 = load %struct.stType*, %struct.stType** %99, align 8
  %101 = getelementptr inbounds %struct.stType, %struct.stType* %100, i32 0, i32 2
  %102 = getelementptr inbounds [8 x i32], [8 x i32]* %101, i64 0, i64 2
  store i32 10, i32* %102, align 4
  %103 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 1
  %104 = load %struct.stType*, %struct.stType** %103, align 8
  %105 = getelementptr inbounds %struct.stType, %struct.stType* %104, i32 0, i32 1
  %106 = getelementptr inbounds [100 x i8], [100 x i8]* %105, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %106, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  %107 = call noalias i8* @malloc(i64 144) #6
  %108 = bitcast i8* %107 to %struct.stType*
  %109 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  store %struct.stType* %108, %struct.stType** %109, align 8
  %110 = call noalias i8* @malloc(i64 16) #6
  %111 = bitcast i8* %110 to %struct.COORD*
  %112 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %113 = load %struct.stType*, %struct.stType** %112, align 8
  %114 = getelementptr inbounds %struct.stType, %struct.stType* %113, i32 0, i32 0
  store %struct.COORD* %111, %struct.COORD** %114, align 8
  %115 = call noalias i8* @malloc(i64 4) #6
  %116 = bitcast i8* %115 to i32*
  %117 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %118 = load %struct.stType*, %struct.stType** %117, align 8
  %119 = getelementptr inbounds %struct.stType, %struct.stType* %118, i32 0, i32 0
  %120 = load %struct.COORD*, %struct.COORD** %119, align 8
  %121 = getelementptr inbounds %struct.COORD, %struct.COORD* %120, i32 0, i32 0
  store i32* %116, i32** %121, align 8
  %122 = call noalias i8* @malloc(i64 4) #6
  %123 = bitcast i8* %122 to i32*
  %124 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %125 = load %struct.stType*, %struct.stType** %124, align 8
  %126 = getelementptr inbounds %struct.stType, %struct.stType* %125, i32 0, i32 0
  %127 = load %struct.COORD*, %struct.COORD** %126, align 8
  %128 = getelementptr inbounds %struct.COORD, %struct.COORD* %127, i32 0, i32 1
  store i32* %123, i32** %128, align 8
  %129 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %130 = load %struct.stType*, %struct.stType** %129, align 8
  %131 = getelementptr inbounds %struct.stType, %struct.stType* %130, i32 0, i32 0
  %132 = load %struct.COORD*, %struct.COORD** %131, align 8
  %133 = getelementptr inbounds %struct.COORD, %struct.COORD* %132, i32 0, i32 0
  %134 = load i32*, i32** %133, align 8
  %135 = getelementptr inbounds i32, i32* %134, i64 0
  store i32 11, i32* %135, align 4
  %136 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %137 = load %struct.stType*, %struct.stType** %136, align 8
  %138 = getelementptr inbounds %struct.stType, %struct.stType* %137, i32 0, i32 0
  %139 = load %struct.COORD*, %struct.COORD** %138, align 8
  %140 = getelementptr inbounds %struct.COORD, %struct.COORD* %139, i32 0, i32 1
  %141 = load i32*, i32** %140, align 8
  %142 = getelementptr inbounds i32, i32* %141, i64 0
  store i32 12, i32* %142, align 4
  %143 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %144 = load %struct.stType*, %struct.stType** %143, align 8
  %145 = getelementptr inbounds %struct.stType, %struct.stType* %144, i32 0, i32 2
  %146 = getelementptr inbounds [8 x i32], [8 x i32]* %145, i64 0, i64 0
  store i32 13, i32* %146, align 4
  %147 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %148 = load %struct.stType*, %struct.stType** %147, align 8
  %149 = getelementptr inbounds %struct.stType, %struct.stType* %148, i32 0, i32 2
  %150 = getelementptr inbounds [8 x i32], [8 x i32]* %149, i64 0, i64 1
  store i32 14, i32* %150, align 4
  %151 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %152 = load %struct.stType*, %struct.stType** %151, align 8
  %153 = getelementptr inbounds %struct.stType, %struct.stType* %152, i32 0, i32 2
  %154 = getelementptr inbounds [8 x i32], [8 x i32]* %153, i64 0, i64 2
  store i32 15, i32* %154, align 4
  %155 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 2
  %156 = load %struct.stType*, %struct.stType** %155, align 8
  %157 = getelementptr inbounds %struct.stType, %struct.stType* %156, i32 0, i32 1
  %158 = getelementptr inbounds [100 x i8], [100 x i8]* %157, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %158, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  %159 = call noalias i8* @malloc(i64 144) #6
  %160 = bitcast i8* %159 to %struct.stType*
  %161 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  store %struct.stType* %160, %struct.stType** %161, align 8
  %162 = call noalias i8* @malloc(i64 16) #6
  %163 = bitcast i8* %162 to %struct.COORD*
  %164 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %165 = load %struct.stType*, %struct.stType** %164, align 8
  %166 = getelementptr inbounds %struct.stType, %struct.stType* %165, i32 0, i32 0
  store %struct.COORD* %163, %struct.COORD** %166, align 8
  %167 = call noalias i8* @malloc(i64 4) #6
  %168 = bitcast i8* %167 to i32*
  %169 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %170 = load %struct.stType*, %struct.stType** %169, align 8
  %171 = getelementptr inbounds %struct.stType, %struct.stType* %170, i32 0, i32 0
  %172 = load %struct.COORD*, %struct.COORD** %171, align 8
  %173 = getelementptr inbounds %struct.COORD, %struct.COORD* %172, i32 0, i32 0
  store i32* %168, i32** %173, align 8
  %174 = call noalias i8* @malloc(i64 4) #6
  %175 = bitcast i8* %174 to i32*
  %176 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %177 = load %struct.stType*, %struct.stType** %176, align 8
  %178 = getelementptr inbounds %struct.stType, %struct.stType* %177, i32 0, i32 0
  %179 = load %struct.COORD*, %struct.COORD** %178, align 8
  %180 = getelementptr inbounds %struct.COORD, %struct.COORD* %179, i32 0, i32 1
  store i32* %175, i32** %180, align 8
  %181 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %182 = load %struct.stType*, %struct.stType** %181, align 8
  %183 = getelementptr inbounds %struct.stType, %struct.stType* %182, i32 0, i32 0
  %184 = load %struct.COORD*, %struct.COORD** %183, align 8
  %185 = getelementptr inbounds %struct.COORD, %struct.COORD* %184, i32 0, i32 0
  %186 = load i32*, i32** %185, align 8
  %187 = getelementptr inbounds i32, i32* %186, i64 0
  store i32 16, i32* %187, align 4
  %188 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %189 = load %struct.stType*, %struct.stType** %188, align 8
  %190 = getelementptr inbounds %struct.stType, %struct.stType* %189, i32 0, i32 0
  %191 = load %struct.COORD*, %struct.COORD** %190, align 8
  %192 = getelementptr inbounds %struct.COORD, %struct.COORD* %191, i32 0, i32 1
  %193 = load i32*, i32** %192, align 8
  %194 = getelementptr inbounds i32, i32* %193, i64 0
  store i32 17, i32* %194, align 4
  %195 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %196 = load %struct.stType*, %struct.stType** %195, align 8
  %197 = getelementptr inbounds %struct.stType, %struct.stType* %196, i32 0, i32 2
  %198 = getelementptr inbounds [8 x i32], [8 x i32]* %197, i64 0, i64 0
  store i32 18, i32* %198, align 4
  %199 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %200 = load %struct.stType*, %struct.stType** %199, align 8
  %201 = getelementptr inbounds %struct.stType, %struct.stType* %200, i32 0, i32 2
  %202 = getelementptr inbounds [8 x i32], [8 x i32]* %201, i64 0, i64 1
  store i32 19, i32* %202, align 4
  %203 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %204 = load %struct.stType*, %struct.stType** %203, align 8
  %205 = getelementptr inbounds %struct.stType, %struct.stType* %204, i32 0, i32 2
  %206 = getelementptr inbounds [8 x i32], [8 x i32]* %205, i64 0, i64 2
  store i32 20, i32* %206, align 4
  %207 = getelementptr inbounds %struct.stType*, %struct.stType** %2, i64 3
  %208 = load %struct.stType*, %struct.stType** %207, align 8
  %209 = getelementptr inbounds %struct.stType, %struct.stType* %208, i32 0, i32 1
  %210 = getelementptr inbounds [100 x i8], [100 x i8]* %209, i32 0, i32 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %210, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i32 0, i32 0), i64 11, i32 1, i1 false)
  call void @branchPruned_clone(%struct.stType** %2)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #4

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.stType**) #0 {
  %2 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %3 = load %struct.stType*, %struct.stType** %2, align 8
  %4 = getelementptr inbounds %struct.stType, %struct.stType* %3, i32 0, i32 0
  %5 = load %struct.COORD*, %struct.COORD** %4, align 8
  %6 = getelementptr inbounds %struct.COORD, %struct.COORD* %5, i32 0, i32 0
  %7 = load i32*, i32** %6, align 8
  %8 = load i32, i32* %7, align 4
  %9 = icmp eq i32 1, 1
  br i1 true, label %10, label %283

; <label>:10:                                     ; preds = %1
  %11 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %12 = load %struct.stType*, %struct.stType** %11, align 8
  %13 = getelementptr inbounds %struct.stType, %struct.stType* %12, i32 0, i32 0
  %14 = load %struct.COORD*, %struct.COORD** %13, align 8
  %15 = getelementptr inbounds %struct.COORD, %struct.COORD* %14, i32 0, i32 1
  %16 = load i32*, i32** %15, align 8
  %17 = load i32, i32* %16, align 4
  %18 = icmp eq i32 2, 2
  br i1 true, label %19, label %283

; <label>:19:                                     ; preds = %10
  %20 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %21 = load %struct.stType*, %struct.stType** %20, align 8
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %21, i32 0, i32 2
  %23 = getelementptr inbounds [8 x i32], [8 x i32]* %22, i64 0, i64 1
  %24 = load i32, i32* %23, align 4
  %25 = icmp eq i32 4, 4
  br i1 true, label %26, label %283

; <label>:26:                                     ; preds = %19
  %27 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %28 = load %struct.stType*, %struct.stType** %27, align 8
  %29 = getelementptr inbounds %struct.stType, %struct.stType* %28, i32 0, i32 1
  %30 = getelementptr inbounds [100 x i8], [100 x i8]* %29, i32 0, i32 0
  %31 = getelementptr [11 x i8], [11 x i8]* @0, i64 0, i64 0
  %32 = getelementptr [11 x i8], [11 x i8]* @1, i64 0, i64 0
  %33 = call i32 @strcmp(i8* %31, i8* %32) #5
  %34 = icmp ne i32 0, 0
  br i1 false, label %283, label %35

; <label>:35:                                     ; preds = %26
  %36 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %37 = load %struct.stType*, %struct.stType** %36, align 8
  %38 = getelementptr inbounds %struct.stType, %struct.stType* %37, i32 0, i32 1
  %39 = getelementptr inbounds [100 x i8], [100 x i8]* %38, i64 0, i64 4
  %40 = load i8, i8* %39, align 4
  %41 = sext i8 111 to i32
  %42 = icmp eq i32 111, 111
  br i1 true, label %43, label %283

; <label>:43:                                     ; preds = %35
  %44 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 0
  %45 = load %struct.stType*, %struct.stType** %44, align 8
  %46 = getelementptr inbounds %struct.stType, %struct.stType* %45, i32 0, i32 1
  %47 = getelementptr inbounds [100 x i8], [100 x i8]* %46, i64 0, i64 9
  %48 = load i8, i8* %47, align 1
  %49 = sext i8 100 to i32
  %50 = icmp eq i32 100, 100
  br i1 true, label %51, label %283

; <label>:51:                                     ; preds = %43
  %52 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %53 = load %struct.stType*, %struct.stType** %52, align 8
  %54 = getelementptr inbounds %struct.stType, %struct.stType* %53, i32 0, i32 0
  %55 = load %struct.COORD*, %struct.COORD** %54, align 8
  %56 = getelementptr inbounds %struct.COORD, %struct.COORD* %55, i32 0, i32 0
  %57 = load i32*, i32** %56, align 8
  %58 = load i32, i32* %57, align 4
  %59 = icmp eq i32 6, 6
  br i1 true, label %60, label %283

; <label>:60:                                     ; preds = %51
  %61 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %62 = load %struct.stType*, %struct.stType** %61, align 8
  %63 = getelementptr inbounds %struct.stType, %struct.stType* %62, i32 0, i32 0
  %64 = load %struct.COORD*, %struct.COORD** %63, align 8
  %65 = getelementptr inbounds %struct.COORD, %struct.COORD* %64, i32 0, i32 1
  %66 = load i32*, i32** %65, align 8
  %67 = load i32, i32* %66, align 4
  %68 = icmp eq i32 7, 7
  br i1 true, label %69, label %283

; <label>:69:                                     ; preds = %60
  %70 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %71 = load %struct.stType*, %struct.stType** %70, align 8
  %72 = getelementptr inbounds %struct.stType, %struct.stType* %71, i32 0, i32 2
  %73 = getelementptr inbounds [8 x i32], [8 x i32]* %72, i64 0, i64 1
  %74 = load i32, i32* %73, align 4
  %75 = icmp eq i32 9, 9
  br i1 true, label %76, label %283

; <label>:76:                                     ; preds = %69
  %77 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %78 = load %struct.stType*, %struct.stType** %77, align 8
  %79 = getelementptr inbounds %struct.stType, %struct.stType* %78, i32 0, i32 1
  %80 = getelementptr inbounds [100 x i8], [100 x i8]* %79, i32 0, i32 0
  %81 = getelementptr [11 x i8], [11 x i8]* @2, i64 0, i64 0
  %82 = getelementptr [11 x i8], [11 x i8]* @3, i64 0, i64 0
  %83 = call i32 @strcmp(i8* %81, i8* %82) #5
  %84 = icmp ne i32 0, 0
  br i1 false, label %283, label %85

; <label>:85:                                     ; preds = %76
  %86 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %87 = load %struct.stType*, %struct.stType** %86, align 8
  %88 = getelementptr inbounds %struct.stType, %struct.stType* %87, i32 0, i32 1
  %89 = getelementptr inbounds [100 x i8], [100 x i8]* %88, i64 0, i64 4
  %90 = load i8, i8* %89, align 4
  %91 = sext i8 111 to i32
  %92 = icmp eq i32 111, 111
  br i1 true, label %93, label %283

; <label>:93:                                     ; preds = %85
  %94 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %95 = load %struct.stType*, %struct.stType** %94, align 8
  %96 = getelementptr inbounds %struct.stType, %struct.stType* %95, i32 0, i32 1
  %97 = getelementptr inbounds [100 x i8], [100 x i8]* %96, i64 0, i64 9
  %98 = load i8, i8* %97, align 1
  %99 = sext i8 100 to i32
  %100 = icmp eq i32 100, 100
  br i1 true, label %101, label %283

; <label>:101:                                    ; preds = %93
  %102 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %103 = load %struct.stType*, %struct.stType** %102, align 8
  %104 = getelementptr inbounds %struct.stType, %struct.stType* %103, i32 0, i32 0
  %105 = load %struct.COORD*, %struct.COORD** %104, align 8
  %106 = getelementptr inbounds %struct.COORD, %struct.COORD* %105, i32 0, i32 0
  %107 = load i32*, i32** %106, align 8
  %108 = load i32, i32* %107, align 4
  %109 = icmp eq i32 11, 11
  br i1 true, label %110, label %283

; <label>:110:                                    ; preds = %101
  %111 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %112 = load %struct.stType*, %struct.stType** %111, align 8
  %113 = getelementptr inbounds %struct.stType, %struct.stType* %112, i32 0, i32 0
  %114 = load %struct.COORD*, %struct.COORD** %113, align 8
  %115 = getelementptr inbounds %struct.COORD, %struct.COORD* %114, i32 0, i32 1
  %116 = load i32*, i32** %115, align 8
  %117 = load i32, i32* %116, align 4
  %118 = icmp eq i32 12, 12
  br i1 true, label %119, label %283

; <label>:119:                                    ; preds = %110
  %120 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %121 = load %struct.stType*, %struct.stType** %120, align 8
  %122 = getelementptr inbounds %struct.stType, %struct.stType* %121, i32 0, i32 2
  %123 = getelementptr inbounds [8 x i32], [8 x i32]* %122, i64 0, i64 1
  %124 = load i32, i32* %123, align 4
  %125 = icmp eq i32 14, 14
  br i1 true, label %126, label %283

; <label>:126:                                    ; preds = %119
  %127 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %128 = load %struct.stType*, %struct.stType** %127, align 8
  %129 = getelementptr inbounds %struct.stType, %struct.stType* %128, i32 0, i32 1
  %130 = getelementptr inbounds [100 x i8], [100 x i8]* %129, i32 0, i32 0
  %131 = getelementptr [11 x i8], [11 x i8]* @4, i64 0, i64 0
  %132 = getelementptr [11 x i8], [11 x i8]* @5, i64 0, i64 0
  %133 = call i32 @strcmp(i8* %131, i8* %132) #5
  %134 = icmp ne i32 0, 0
  br i1 false, label %283, label %135

; <label>:135:                                    ; preds = %126
  %136 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %137 = load %struct.stType*, %struct.stType** %136, align 8
  %138 = getelementptr inbounds %struct.stType, %struct.stType* %137, i32 0, i32 1
  %139 = getelementptr inbounds [100 x i8], [100 x i8]* %138, i64 0, i64 4
  %140 = load i8, i8* %139, align 4
  %141 = sext i8 111 to i32
  %142 = icmp eq i32 111, 111
  br i1 true, label %143, label %283

; <label>:143:                                    ; preds = %135
  %144 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %145 = load %struct.stType*, %struct.stType** %144, align 8
  %146 = getelementptr inbounds %struct.stType, %struct.stType* %145, i32 0, i32 1
  %147 = getelementptr inbounds [100 x i8], [100 x i8]* %146, i64 0, i64 9
  %148 = load i8, i8* %147, align 1
  %149 = sext i8 100 to i32
  %150 = icmp eq i32 100, 100
  br i1 true, label %151, label %283

; <label>:151:                                    ; preds = %143
  %152 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %153 = load %struct.stType*, %struct.stType** %152, align 8
  %154 = getelementptr inbounds %struct.stType, %struct.stType* %153, i32 0, i32 0
  %155 = load %struct.COORD*, %struct.COORD** %154, align 8
  %156 = getelementptr inbounds %struct.COORD, %struct.COORD* %155, i32 0, i32 0
  %157 = load i32*, i32** %156, align 8
  %158 = load i32, i32* %157, align 4
  %159 = icmp eq i32 16, 16
  br i1 true, label %160, label %283

; <label>:160:                                    ; preds = %151
  %161 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %162 = load %struct.stType*, %struct.stType** %161, align 8
  %163 = getelementptr inbounds %struct.stType, %struct.stType* %162, i32 0, i32 0
  %164 = load %struct.COORD*, %struct.COORD** %163, align 8
  %165 = getelementptr inbounds %struct.COORD, %struct.COORD* %164, i32 0, i32 1
  %166 = load i32*, i32** %165, align 8
  %167 = load i32, i32* %166, align 4
  %168 = icmp eq i32 17, 17
  br i1 true, label %169, label %283

; <label>:169:                                    ; preds = %160
  %170 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %171 = load %struct.stType*, %struct.stType** %170, align 8
  %172 = getelementptr inbounds %struct.stType, %struct.stType* %171, i32 0, i32 2
  %173 = getelementptr inbounds [8 x i32], [8 x i32]* %172, i64 0, i64 1
  %174 = load i32, i32* %173, align 4
  %175 = icmp eq i32 19, 19
  br i1 true, label %176, label %283

; <label>:176:                                    ; preds = %169
  %177 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %178 = load %struct.stType*, %struct.stType** %177, align 8
  %179 = getelementptr inbounds %struct.stType, %struct.stType* %178, i32 0, i32 1
  %180 = getelementptr inbounds [100 x i8], [100 x i8]* %179, i32 0, i32 0
  %181 = getelementptr [11 x i8], [11 x i8]* @6, i64 0, i64 0
  %182 = getelementptr [11 x i8], [11 x i8]* @7, i64 0, i64 0
  %183 = call i32 @strcmp(i8* %181, i8* %182) #5
  %184 = icmp ne i32 0, 0
  br i1 false, label %283, label %185

; <label>:185:                                    ; preds = %176
  %186 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %187 = load %struct.stType*, %struct.stType** %186, align 8
  %188 = getelementptr inbounds %struct.stType, %struct.stType* %187, i32 0, i32 1
  %189 = getelementptr inbounds [100 x i8], [100 x i8]* %188, i64 0, i64 4
  %190 = load i8, i8* %189, align 4
  %191 = sext i8 111 to i32
  %192 = icmp eq i32 111, 111
  br i1 true, label %193, label %283

; <label>:193:                                    ; preds = %185
  %194 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %195 = load %struct.stType*, %struct.stType** %194, align 8
  %196 = getelementptr inbounds %struct.stType, %struct.stType* %195, i32 0, i32 1
  %197 = getelementptr inbounds [100 x i8], [100 x i8]* %196, i64 0, i64 9
  %198 = load i8, i8* %197, align 1
  %199 = sext i8 100 to i32
  %200 = icmp eq i32 100, 100
  br i1 true, label %201, label %283

; <label>:201:                                    ; preds = %193
  %202 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 4
  %203 = load %struct.stType*, %struct.stType** %202, align 8
  %204 = icmp eq i1 false, false
  %205 = icmp eq %struct.stType* null, null
  br i1 true, label %206, label %283

; <label>:206:                                    ; preds = %201
  %207 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 5
  %208 = load %struct.stType*, %struct.stType** %207, align 8
  %209 = icmp eq i1 false, false
  %210 = icmp eq %struct.stType* null, null
  br i1 true, label %211, label %283

; <label>:211:                                    ; preds = %206
  %212 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 6
  %213 = load %struct.stType*, %struct.stType** %212, align 8
  %214 = icmp eq i1 false, false
  %215 = icmp eq %struct.stType* null, null
  br i1 true, label %216, label %283

; <label>:216:                                    ; preds = %211
  %217 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 7
  %218 = load %struct.stType*, %struct.stType** %217, align 8
  %219 = icmp eq i1 false, false
  %220 = icmp eq %struct.stType* null, null
  br i1 true, label %221, label %283

; <label>:221:                                    ; preds = %216
  %222 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 8
  %223 = load %struct.stType*, %struct.stType** %222, align 8
  %224 = icmp eq i1 false, false
  %225 = icmp eq %struct.stType* null, null
  br i1 true, label %226, label %283

; <label>:226:                                    ; preds = %221
  %227 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 9
  %228 = load %struct.stType*, %struct.stType** %227, align 8
  %229 = icmp eq i1 false, false
  %230 = icmp eq %struct.stType* null, null
  br i1 true, label %231, label %283

; <label>:231:                                    ; preds = %226
  %232 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 10
  %233 = load %struct.stType*, %struct.stType** %232, align 8
  %234 = icmp eq i1 false, false
  %235 = icmp eq %struct.stType* null, null
  br i1 true, label %236, label %283

; <label>:236:                                    ; preds = %231
  %237 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 11
  %238 = load %struct.stType*, %struct.stType** %237, align 8
  %239 = icmp eq i1 false, false
  %240 = icmp eq %struct.stType* null, null
  br i1 true, label %241, label %283

; <label>:241:                                    ; preds = %236
  %242 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 12
  %243 = load %struct.stType*, %struct.stType** %242, align 8
  %244 = icmp eq i1 false, false
  %245 = icmp eq %struct.stType* null, null
  br i1 true, label %246, label %283

; <label>:246:                                    ; preds = %241
  %247 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 13
  %248 = load %struct.stType*, %struct.stType** %247, align 8
  %249 = icmp eq i1 false, false
  %250 = icmp eq %struct.stType* null, null
  br i1 true, label %251, label %283

; <label>:251:                                    ; preds = %246
  %252 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 14
  %253 = load %struct.stType*, %struct.stType** %252, align 8
  %254 = icmp eq i1 false, false
  %255 = icmp eq %struct.stType* null, null
  br i1 true, label %256, label %283

; <label>:256:                                    ; preds = %251
  %257 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 15
  %258 = load %struct.stType*, %struct.stType** %257, align 8
  %259 = icmp eq i1 false, false
  %260 = icmp eq %struct.stType* null, null
  br i1 true, label %261, label %283

; <label>:261:                                    ; preds = %256
  %262 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 16
  %263 = load %struct.stType*, %struct.stType** %262, align 8
  %264 = icmp eq i1 false, false
  %265 = icmp eq %struct.stType* null, null
  br i1 true, label %266, label %283

; <label>:266:                                    ; preds = %261
  %267 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 17
  %268 = load %struct.stType*, %struct.stType** %267, align 8
  %269 = icmp eq i1 false, false
  %270 = icmp eq %struct.stType* null, null
  br i1 true, label %271, label %283

; <label>:271:                                    ; preds = %266
  %272 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 18
  %273 = load %struct.stType*, %struct.stType** %272, align 8
  %274 = icmp eq i1 false, false
  %275 = icmp eq %struct.stType* null, null
  br i1 true, label %276, label %283

; <label>:276:                                    ; preds = %271
  %277 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 19
  %278 = load %struct.stType*, %struct.stType** %277, align 8
  %279 = icmp eq i1 false, false
  %280 = icmp eq %struct.stType* null, null
  br i1 true, label %281, label %283

; <label>:281:                                    ; preds = %276
  %282 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %283

; <label>:283:                                    ; preds = %281, %276, %271, %266, %261, %256, %251, %246, %241, %236, %231, %226, %221, %216, %211, %206, %201, %193, %185, %176, %169, %160, %151, %143, %135, %126, %119, %110, %101, %93, %85, %76, %69, %60, %51, %43, %35, %26, %19, %10, %1
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
