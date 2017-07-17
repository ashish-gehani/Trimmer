; ModuleID = 'workdir/struct.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.COORDS = type { [100 x i32], [100 x i32] }

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %coords = alloca %struct.COORDS*, align 8
  %i = alloca i32, align 4
  store i32 0, i32* %1, align 4
  store i32 0, i32* %i, align 4
  br label %2

; <label>:2                                       ; preds = %16, %0
  %3 = load i32, i32* %i, align 4
  %4 = icmp slt i32 %3, 10
  br i1 %4, label %5, label %19

; <label>:5                                       ; preds = %2
  %6 = load i32, i32* %i, align 4
  %7 = sext i32 %6 to i64
  %8 = load %struct.COORDS*, %struct.COORDS** %coords, align 8
  %9 = getelementptr inbounds %struct.COORDS, %struct.COORDS* %8, i32 0, i32 0
  %10 = getelementptr inbounds [100 x i32], [100 x i32]* %9, i64 0, i64 %7
  store i32 1, i32* %10, align 4
  %11 = load i32, i32* %i, align 4
  %12 = sext i32 %11 to i64
  %13 = load %struct.COORDS*, %struct.COORDS** %coords, align 8
  %14 = getelementptr inbounds %struct.COORDS, %struct.COORDS* %13, i32 0, i32 1
  %15 = getelementptr inbounds [100 x i32], [100 x i32]* %14, i64 0, i64 %12
  store i32 2, i32* %15, align 4
  br label %16

; <label>:16                                      ; preds = %5
  %17 = load i32, i32* %i, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, i32* %i, align 4
  br label %2

; <label>:19                                      ; preds = %2
  %20 = load %struct.COORDS*, %struct.COORDS** %coords, align 8
  %21 = getelementptr inbounds %struct.COORDS, %struct.COORDS* %20, i32 0, i32 0
  %22 = getelementptr inbounds [100 x i32], [100 x i32]* %21, i64 0, i64 12
  %23 = load i32, i32* %22, align 4
  %24 = load %struct.COORDS*, %struct.COORDS** %coords, align 8
  %25 = getelementptr inbounds %struct.COORDS, %struct.COORDS* %24, i32 0, i32 1
  %26 = getelementptr inbounds [100 x i32], [100 x i32]* %25, i64 0, i64 2
  %27 = load i32, i32* %26, align 4
  %28 = add nsw i32 %23, %27
  ret i32 %28
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
