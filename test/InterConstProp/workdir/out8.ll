; ModuleID = 'workdir/out8.bc'
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
define void @initialize(%struct.HighType* nocapture) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 0, i64 569
  store i32 122, i32* %2, align 4
  %3 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 1, i64 335
  store i32 112, i32* %3, align 4
  %4 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 0, i64 534
  store i32 106, i32* %4, align 4
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 645
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i64 3, i32 1, i1 false)
  %6 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 131
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i64 5, i32 1, i1 false)
  %7 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 0, i64 987
  store i32 121, i32* %7, align 4
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 253
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i64 5, i32 1, i1 false)
  %9 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 0, i64 649
  store i32 116, i32* %9, align 4
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 276
  %11 = bitcast i8* %10 to i32*
  store i32 1784767853, i32* %11, align 1
  %12 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 1, i64 225
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), i64 5, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.HighType* byval readonly align 8) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 1, i64 225
  %3 = load i8, i8* %2, align 1
  %4 = icmp eq i8 %3, 111
  br i1 %4, label %5, label %126

; <label>:5:                                      ; preds = %1
  %6 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 1, i64 226
  %7 = load i8, i8* %6, align 2
  %8 = icmp eq i8 %7, 113
  br i1 %8, label %9, label %126

; <label>:9:                                      ; preds = %5
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 1, i64 227
  %11 = load i8, i8* %10, align 1
  %12 = icmp eq i8 %11, 109
  br i1 %12, label %13, label %126

; <label>:13:                                     ; preds = %9
  %14 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 1, i64 228
  %15 = load i8, i8* %14, align 4
  %16 = icmp eq i8 %15, 111
  br i1 %16, label %17, label %126

; <label>:17:                                     ; preds = %13
  %18 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 1, i64 229
  %19 = load i8, i8* %18, align 1
  %20 = icmp eq i8 %19, 112
  br i1 %20, label %21, label %126

; <label>:21:                                     ; preds = %17
  %22 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 131
  %23 = load i8, i8* %22, align 1
  %24 = icmp eq i8 %23, 97
  br i1 %24, label %25, label %126

; <label>:25:                                     ; preds = %21
  %26 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 132
  %27 = load i8, i8* %26, align 4
  %28 = icmp eq i8 %27, 102
  br i1 %28, label %29, label %126

; <label>:29:                                     ; preds = %25
  %30 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 133
  %31 = load i8, i8* %30, align 1
  %32 = icmp eq i8 %31, 119
  br i1 %32, label %33, label %126

; <label>:33:                                     ; preds = %29
  %34 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 134
  %35 = load i8, i8* %34, align 2
  %36 = icmp eq i8 %35, 105
  br i1 %36, label %37, label %126

; <label>:37:                                     ; preds = %33
  %38 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 135
  %39 = load i8, i8* %38, align 1
  %40 = icmp eq i8 %39, 107
  br i1 %40, label %41, label %126

; <label>:41:                                     ; preds = %37
  %42 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 253
  %43 = load i8, i8* %42, align 1
  %44 = icmp eq i8 %43, 120
  br i1 %44, label %45, label %126

; <label>:45:                                     ; preds = %41
  %46 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 254
  %47 = load i8, i8* %46, align 2
  %48 = icmp eq i8 %47, 97
  br i1 %48, label %49, label %126

; <label>:49:                                     ; preds = %45
  %50 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 255
  %51 = load i8, i8* %50, align 1
  %52 = icmp eq i8 %51, 119
  br i1 %52, label %53, label %126

; <label>:53:                                     ; preds = %49
  %54 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 256
  %55 = load i8, i8* %54, align 8
  %56 = icmp eq i8 %55, 106
  br i1 %56, label %57, label %126

; <label>:57:                                     ; preds = %53
  %58 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 257
  %59 = load i8, i8* %58, align 1
  %60 = icmp eq i8 %59, 116
  br i1 %60, label %61, label %126

; <label>:61:                                     ; preds = %57
  %62 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 276
  %63 = load i8, i8* %62, align 4
  %64 = icmp eq i8 %63, 109
  br i1 %64, label %65, label %126

; <label>:65:                                     ; preds = %61
  %66 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 277
  %67 = load i8, i8* %66, align 1
  %68 = icmp eq i8 %67, 101
  br i1 %68, label %69, label %126

; <label>:69:                                     ; preds = %65
  %70 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 278
  %71 = load i8, i8* %70, align 2
  %72 = icmp eq i8 %71, 97
  br i1 %72, label %73, label %126

; <label>:73:                                     ; preds = %69
  %74 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 279
  %75 = load i8, i8* %74, align 1
  %76 = icmp eq i8 %75, 106
  br i1 %76, label %77, label %126

; <label>:77:                                     ; preds = %73
  %78 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 645
  %79 = load i8, i8* %78, align 1
  %80 = icmp eq i8 %79, 121
  br i1 %80, label %81, label %126

; <label>:81:                                     ; preds = %77
  %82 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 646
  %83 = load i8, i8* %82, align 2
  %84 = icmp eq i8 %83, 103
  br i1 %84, label %85, label %126

; <label>:85:                                     ; preds = %81
  %86 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 647
  %87 = load i8, i8* %86, align 1
  %88 = icmp eq i8 %87, 120
  br i1 %88, label %89, label %126

; <label>:89:                                     ; preds = %85
  %90 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 1, i64 335
  %91 = load i32, i32* %90, align 4
  %92 = icmp eq i32 %91, 112
  br i1 %92, label %93, label %126

; <label>:93:                                     ; preds = %89
  %94 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 0, i64 534
  %95 = load i32, i32* %94, align 8
  %96 = icmp eq i32 %95, 106
  br i1 %96, label %97, label %126

; <label>:97:                                     ; preds = %93
  %98 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 0, i64 569
  %99 = load i32, i32* %98, align 4
  %100 = icmp eq i32 %99, 122
  br i1 %100, label %101, label %126

; <label>:101:                                    ; preds = %97
  %102 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 0, i64 649
  %103 = load i32, i32* %102, align 4
  %104 = icmp eq i32 %103, 116
  br i1 %104, label %105, label %126

; <label>:105:                                    ; preds = %101
  %106 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 0, i64 987
  %107 = load i32, i32* %106, align 4
  %108 = icmp eq i32 %107, 121
  br i1 %108, label %109, label %126

; <label>:109:                                    ; preds = %105
  %110 = call i32 @strcmp(i8* nonnull %2, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0)) #4
  %111 = icmp eq i32 %110, 0
  br i1 %111, label %112, label %126

; <label>:112:                                    ; preds = %109
  %113 = call i32 @strcmp(i8* nonnull %78, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0)) #4
  %114 = icmp eq i32 %113, 0
  br i1 %114, label %115, label %126

; <label>:115:                                    ; preds = %112
  %116 = call i32 @strcmp(i8* nonnull %22, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0)) #4
  %117 = icmp eq i32 %116, 0
  br i1 %117, label %118, label %126

; <label>:118:                                    ; preds = %115
  %119 = call i32 @strcmp(i8* nonnull %42, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)) #4
  %120 = icmp eq i32 %119, 0
  br i1 %120, label %121, label %126

; <label>:121:                                    ; preds = %118
  %122 = call i32 @strcmp(i8* nonnull %62, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i64 0, i64 0)) #4
  %123 = icmp eq i32 %122, 0
  br i1 %123, label %124, label %126

; <label>:124:                                    ; preds = %121
  %125 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0))
  br label %126

; <label>:126:                                    ; preds = %121, %118, %115, %112, %109, %124, %105, %101, %97, %93, %89, %85, %81, %77, %73, %69, %65, %61, %57, %53, %49, %45, %41, %37, %33, %29, %25, %21, %17, %13, %9, %5, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) local_unnamed_addr #3

; Function Attrs: noinline nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
  %1 = alloca %struct.HighType, align 8
  call void @initialize_clone(%struct.HighType* nonnull %1)
  call void @branchPruned_clone(%struct.HighType* nonnull %1)
  ret i32 0
}

; Function Attrs: noinline nounwind uwtable
define void @initialize_clone(%struct.HighType* nocapture) local_unnamed_addr #0 {
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 0, i64 569
  store i32 122, i32* %2, align 4
  %3 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 1, i64 335
  store i32 112, i32* %3, align 4
  %4 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 0, i64 534
  store i32 106, i32* %4, align 4
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 645
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i64 0, i64 0), i64 3, i32 1, i1 false)
  %6 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 131
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %6, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i64 5, i32 1, i1 false)
  %7 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 0, i64 987
  store i32 121, i32* %7, align 4
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 253
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %8, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0), i64 5, i32 1, i1 false)
  %9 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 1, i32 0, i64 649
  store i32 116, i32* %9, align 4
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 0, i64 276
  %11 = bitcast i8* %10 to i32*
  store i32 1784767853, i32* %11, align 1
  %12 = getelementptr inbounds %struct.HighType, %struct.HighType* %0, i64 0, i32 0, i32 1, i64 225
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.4, i64 0, i64 0), i64 5, i32 1, i1 false)
  ret void
}

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.HighType* byval nocapture readnone align 8) local_unnamed_addr #0 {
  %2 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.5, i64 0, i64 0))
  ret void
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
