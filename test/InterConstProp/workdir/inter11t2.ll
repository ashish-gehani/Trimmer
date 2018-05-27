; ModuleID = 'workdir/inter11t2.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.1 = private unnamed_addr constant [19 x i8] c"*** Branch Taken \0A\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType** %obj) #0 {
  %1 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %2 = load %struct.stType*, %struct.stType** %1, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i32 0, i32 0
  %4 = load %struct.COORD*, %struct.COORD** %3, align 8
  %5 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i32 0, i32 0
  %6 = load i32*, i32** %5, align 8
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 %7, 1
  br i1 %8, label %9, label %258

; <label>:9                                       ; preds = %0
  %10 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %11 = load %struct.stType*, %struct.stType** %10, align 8
  %12 = getelementptr inbounds %struct.stType, %struct.stType* %11, i32 0, i32 0
  %13 = load %struct.COORD*, %struct.COORD** %12, align 8
  %14 = getelementptr inbounds %struct.COORD, %struct.COORD* %13, i32 0, i32 1
  %15 = load i32*, i32** %14, align 8
  %16 = load i32, i32* %15, align 4
  %17 = icmp eq i32 %16, 2
  br i1 %17, label %18, label %258

; <label>:18                                      ; preds = %9
  %19 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %20 = load %struct.stType*, %struct.stType** %19, align 8
  %21 = getelementptr inbounds %struct.stType, %struct.stType* %20, i32 0, i32 2
  %22 = getelementptr inbounds [8 x i32], [8 x i32]* %21, i64 0, i64 1
  %23 = load i32, i32* %22, align 4
  %24 = icmp eq i32 %23, 4
  br i1 %24, label %25, label %258

; <label>:25                                      ; preds = %18
  %26 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %27 = load %struct.stType*, %struct.stType** %26, align 8
  %28 = getelementptr inbounds %struct.stType, %struct.stType* %27, i32 0, i32 1
  %29 = getelementptr inbounds [100 x i8], [100 x i8]* %28, i32 0, i32 0
  %30 = call i32 @strcmp(i8* %29, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %31 = icmp ne i32 %30, 0
  br i1 %31, label %258, label %32

; <label>:32                                      ; preds = %25
  %33 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %34 = load %struct.stType*, %struct.stType** %33, align 8
  %35 = getelementptr inbounds %struct.stType, %struct.stType* %34, i32 0, i32 1
  %36 = getelementptr inbounds [100 x i8], [100 x i8]* %35, i64 0, i64 4
  %37 = load i8, i8* %36, align 4
  %38 = sext i8 %37 to i32
  %39 = icmp eq i32 %38, 111
  br i1 %39, label %40, label %258

; <label>:40                                      ; preds = %32
  %41 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 0
  %42 = load %struct.stType*, %struct.stType** %41, align 8
  %43 = getelementptr inbounds %struct.stType, %struct.stType* %42, i32 0, i32 1
  %44 = getelementptr inbounds [100 x i8], [100 x i8]* %43, i64 0, i64 9
  %45 = load i8, i8* %44, align 1
  %46 = sext i8 %45 to i32
  %47 = icmp eq i32 %46, 100
  br i1 %47, label %48, label %258

; <label>:48                                      ; preds = %40
  %49 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 1
  %50 = load %struct.stType*, %struct.stType** %49, align 8
  %51 = getelementptr inbounds %struct.stType, %struct.stType* %50, i32 0, i32 0
  %52 = load %struct.COORD*, %struct.COORD** %51, align 8
  %53 = getelementptr inbounds %struct.COORD, %struct.COORD* %52, i32 0, i32 0
  %54 = load i32*, i32** %53, align 8
  %55 = load i32, i32* %54, align 4
  %56 = icmp eq i32 %55, 6
  br i1 %56, label %57, label %258

; <label>:57                                      ; preds = %48
  %58 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 1
  %59 = load %struct.stType*, %struct.stType** %58, align 8
  %60 = getelementptr inbounds %struct.stType, %struct.stType* %59, i32 0, i32 0
  %61 = load %struct.COORD*, %struct.COORD** %60, align 8
  %62 = getelementptr inbounds %struct.COORD, %struct.COORD* %61, i32 0, i32 1
  %63 = load i32*, i32** %62, align 8
  %64 = load i32, i32* %63, align 4
  %65 = icmp eq i32 %64, 7
  br i1 %65, label %66, label %258

; <label>:66                                      ; preds = %57
  %67 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 1
  %68 = load %struct.stType*, %struct.stType** %67, align 8
  %69 = getelementptr inbounds %struct.stType, %struct.stType* %68, i32 0, i32 2
  %70 = getelementptr inbounds [8 x i32], [8 x i32]* %69, i64 0, i64 1
  %71 = load i32, i32* %70, align 4
  %72 = icmp eq i32 %71, 9
  br i1 %72, label %73, label %258

; <label>:73                                      ; preds = %66
  %74 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 1
  %75 = load %struct.stType*, %struct.stType** %74, align 8
  %76 = getelementptr inbounds %struct.stType, %struct.stType* %75, i32 0, i32 1
  %77 = getelementptr inbounds [100 x i8], [100 x i8]* %76, i32 0, i32 0
  %78 = call i32 @strcmp(i8* %77, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %79 = icmp ne i32 %78, 0
  br i1 %79, label %258, label %80

; <label>:80                                      ; preds = %73
  %81 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 1
  %82 = load %struct.stType*, %struct.stType** %81, align 8
  %83 = getelementptr inbounds %struct.stType, %struct.stType* %82, i32 0, i32 1
  %84 = getelementptr inbounds [100 x i8], [100 x i8]* %83, i64 0, i64 4
  %85 = load i8, i8* %84, align 4
  %86 = sext i8 %85 to i32
  %87 = icmp eq i32 %86, 111
  br i1 %87, label %88, label %258

; <label>:88                                      ; preds = %80
  %89 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 1
  %90 = load %struct.stType*, %struct.stType** %89, align 8
  %91 = getelementptr inbounds %struct.stType, %struct.stType* %90, i32 0, i32 1
  %92 = getelementptr inbounds [100 x i8], [100 x i8]* %91, i64 0, i64 9
  %93 = load i8, i8* %92, align 1
  %94 = sext i8 %93 to i32
  %95 = icmp eq i32 %94, 100
  br i1 %95, label %96, label %258

; <label>:96                                      ; preds = %88
  %97 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %98 = load %struct.stType*, %struct.stType** %97, align 8
  %99 = getelementptr inbounds %struct.stType, %struct.stType* %98, i32 0, i32 0
  %100 = load %struct.COORD*, %struct.COORD** %99, align 8
  %101 = getelementptr inbounds %struct.COORD, %struct.COORD* %100, i32 0, i32 0
  %102 = load i32*, i32** %101, align 8
  %103 = load i32, i32* %102, align 4
  %104 = icmp eq i32 %103, 11
  br i1 %104, label %105, label %258

; <label>:105                                     ; preds = %96
  %106 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %107 = load %struct.stType*, %struct.stType** %106, align 8
  %108 = getelementptr inbounds %struct.stType, %struct.stType* %107, i32 0, i32 0
  %109 = load %struct.COORD*, %struct.COORD** %108, align 8
  %110 = getelementptr inbounds %struct.COORD, %struct.COORD* %109, i32 0, i32 1
  %111 = load i32*, i32** %110, align 8
  %112 = load i32, i32* %111, align 4
  %113 = icmp eq i32 %112, 12
  br i1 %113, label %114, label %258

; <label>:114                                     ; preds = %105
  %115 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %116 = load %struct.stType*, %struct.stType** %115, align 8
  %117 = getelementptr inbounds %struct.stType, %struct.stType* %116, i32 0, i32 2
  %118 = getelementptr inbounds [8 x i32], [8 x i32]* %117, i64 0, i64 1
  %119 = load i32, i32* %118, align 4
  %120 = icmp eq i32 %119, 14
  br i1 %120, label %121, label %258

; <label>:121                                     ; preds = %114
  %122 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %123 = load %struct.stType*, %struct.stType** %122, align 8
  %124 = getelementptr inbounds %struct.stType, %struct.stType* %123, i32 0, i32 1
  %125 = getelementptr inbounds [100 x i8], [100 x i8]* %124, i32 0, i32 0
  %126 = call i32 @strcmp(i8* %125, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %127 = icmp ne i32 %126, 0
  br i1 %127, label %258, label %128

; <label>:128                                     ; preds = %121
  %129 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %130 = load %struct.stType*, %struct.stType** %129, align 8
  %131 = getelementptr inbounds %struct.stType, %struct.stType* %130, i32 0, i32 1
  %132 = getelementptr inbounds [100 x i8], [100 x i8]* %131, i64 0, i64 4
  %133 = load i8, i8* %132, align 4
  %134 = sext i8 %133 to i32
  %135 = icmp eq i32 %134, 111
  br i1 %135, label %136, label %258

; <label>:136                                     ; preds = %128
  %137 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %138 = load %struct.stType*, %struct.stType** %137, align 8
  %139 = getelementptr inbounds %struct.stType, %struct.stType* %138, i32 0, i32 1
  %140 = getelementptr inbounds [100 x i8], [100 x i8]* %139, i64 0, i64 9
  %141 = load i8, i8* %140, align 1
  %142 = sext i8 %141 to i32
  %143 = icmp eq i32 %142, 100
  br i1 %143, label %144, label %258

; <label>:144                                     ; preds = %136
  %145 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %146 = load %struct.stType*, %struct.stType** %145, align 8
  %147 = getelementptr inbounds %struct.stType, %struct.stType* %146, i32 0, i32 0
  %148 = load %struct.COORD*, %struct.COORD** %147, align 8
  %149 = getelementptr inbounds %struct.COORD, %struct.COORD* %148, i32 0, i32 0
  %150 = load i32*, i32** %149, align 8
  %151 = load i32, i32* %150, align 4
  %152 = icmp eq i32 %151, 16
  br i1 %152, label %153, label %258

; <label>:153                                     ; preds = %144
  %154 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %155 = load %struct.stType*, %struct.stType** %154, align 8
  %156 = getelementptr inbounds %struct.stType, %struct.stType* %155, i32 0, i32 0
  %157 = load %struct.COORD*, %struct.COORD** %156, align 8
  %158 = getelementptr inbounds %struct.COORD, %struct.COORD* %157, i32 0, i32 1
  %159 = load i32*, i32** %158, align 8
  %160 = load i32, i32* %159, align 4
  %161 = icmp eq i32 %160, 17
  br i1 %161, label %162, label %258

; <label>:162                                     ; preds = %153
  %163 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %164 = load %struct.stType*, %struct.stType** %163, align 8
  %165 = getelementptr inbounds %struct.stType, %struct.stType* %164, i32 0, i32 2
  %166 = getelementptr inbounds [8 x i32], [8 x i32]* %165, i64 0, i64 1
  %167 = load i32, i32* %166, align 4
  %168 = icmp eq i32 %167, 19
  br i1 %168, label %169, label %258

; <label>:169                                     ; preds = %162
  %170 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %171 = load %struct.stType*, %struct.stType** %170, align 8
  %172 = getelementptr inbounds %struct.stType, %struct.stType* %171, i32 0, i32 1
  %173 = getelementptr inbounds [100 x i8], [100 x i8]* %172, i32 0, i32 0
  %174 = call i32 @strcmp(i8* %173, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0)) #5
  %175 = icmp ne i32 %174, 0
  br i1 %175, label %258, label %176

; <label>:176                                     ; preds = %169
  %177 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %178 = load %struct.stType*, %struct.stType** %177, align 8
  %179 = getelementptr inbounds %struct.stType, %struct.stType* %178, i32 0, i32 1
  %180 = getelementptr inbounds [100 x i8], [100 x i8]* %179, i64 0, i64 4
  %181 = load i8, i8* %180, align 4
  %182 = sext i8 %181 to i32
  %183 = icmp eq i32 %182, 111
  br i1 %183, label %184, label %258

; <label>:184                                     ; preds = %176
  %185 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %186 = load %struct.stType*, %struct.stType** %185, align 8
  %187 = getelementptr inbounds %struct.stType, %struct.stType* %186, i32 0, i32 1
  %188 = getelementptr inbounds [100 x i8], [100 x i8]* %187, i64 0, i64 9
  %189 = load i8, i8* %188, align 1
  %190 = sext i8 %189 to i32
  %191 = icmp eq i32 %190, 100
  br i1 %191, label %192, label %258

; <label>:192                                     ; preds = %184
  %193 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 4
  %194 = load %struct.stType*, %struct.stType** %193, align 8
  %195 = icmp eq %struct.stType* %194, null
  br i1 %195, label %196, label %258

; <label>:196                                     ; preds = %192
  %197 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 5
  %198 = load %struct.stType*, %struct.stType** %197, align 8
  %199 = icmp eq %struct.stType* %198, null
  br i1 %199, label %200, label %258

; <label>:200                                     ; preds = %196
  %201 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 6
  %202 = load %struct.stType*, %struct.stType** %201, align 8
  %203 = icmp eq %struct.stType* %202, null
  br i1 %203, label %204, label %258

; <label>:204                                     ; preds = %200
  %205 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 7
  %206 = load %struct.stType*, %struct.stType** %205, align 8
  %207 = icmp eq %struct.stType* %206, null
  br i1 %207, label %208, label %258

; <label>:208                                     ; preds = %204
  %209 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 8
  %210 = load %struct.stType*, %struct.stType** %209, align 8
  %211 = icmp eq %struct.stType* %210, null
  br i1 %211, label %212, label %258

; <label>:212                                     ; preds = %208
  %213 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 9
  %214 = load %struct.stType*, %struct.stType** %213, align 8
  %215 = icmp eq %struct.stType* %214, null
  br i1 %215, label %216, label %258

; <label>:216                                     ; preds = %212
  %217 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 10
  %218 = load %struct.stType*, %struct.stType** %217, align 8
  %219 = icmp eq %struct.stType* %218, null
  br i1 %219, label %220, label %258

; <label>:220                                     ; preds = %216
  %221 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 11
  %222 = load %struct.stType*, %struct.stType** %221, align 8
  %223 = icmp eq %struct.stType* %222, null
  br i1 %223, label %224, label %258

; <label>:224                                     ; preds = %220
  %225 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 12
  %226 = load %struct.stType*, %struct.stType** %225, align 8
  %227 = icmp eq %struct.stType* %226, null
  br i1 %227, label %228, label %258

; <label>:228                                     ; preds = %224
  %229 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 13
  %230 = load %struct.stType*, %struct.stType** %229, align 8
  %231 = icmp eq %struct.stType* %230, null
  br i1 %231, label %232, label %258

; <label>:232                                     ; preds = %228
  %233 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 14
  %234 = load %struct.stType*, %struct.stType** %233, align 8
  %235 = icmp eq %struct.stType* %234, null
  br i1 %235, label %236, label %258

; <label>:236                                     ; preds = %232
  %237 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 15
  %238 = load %struct.stType*, %struct.stType** %237, align 8
  %239 = icmp eq %struct.stType* %238, null
  br i1 %239, label %240, label %258

; <label>:240                                     ; preds = %236
  %241 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 16
  %242 = load %struct.stType*, %struct.stType** %241, align 8
  %243 = icmp eq %struct.stType* %242, null
  br i1 %243, label %244, label %258

; <label>:244                                     ; preds = %240
  %245 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 17
  %246 = load %struct.stType*, %struct.stType** %245, align 8
  %247 = icmp eq %struct.stType* %246, null
  br i1 %247, label %248, label %258

; <label>:248                                     ; preds = %244
  %249 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 18
  %250 = load %struct.stType*, %struct.stType** %249, align 8
  %251 = icmp eq %struct.stType* %250, null
  br i1 %251, label %252, label %258

; <label>:252                                     ; preds = %248
  %253 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 19
  %254 = load %struct.stType*, %struct.stType** %253, align 8
  %255 = icmp eq %struct.stType* %254, null
  br i1 %255, label %256, label %258

; <label>:256                                     ; preds = %252
  %257 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([19 x i8], [19 x i8]* @.str.1, i32 0, i32 0))
  br label %258

; <label>:258                                     ; preds = %256, %252, %248, %244, %240, %236, %232, %228, %224, %220, %216, %212, %208, %204, %200, %196, %192, %184, %176, %169, %162, %153, %144, %136, %128, %121, %114, %105, %96, %88, %80, %73, %66, %57, %48, %40, %32, %25, %18, %9, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #1

declare i32 @printf(i8*, ...) #2

; Function Attrs: nounwind uwtable
define void @initialize(%struct.stType** %obj) #0 {
  ret void
}

; Function Attrs: nounwind uwtable
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
  call void @branchPruned(%struct.stType** %2)
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
