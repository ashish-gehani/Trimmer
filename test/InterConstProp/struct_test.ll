; ModuleID = 'struct_test.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.COORDS = type { %struct.PAIR }
%struct.PAIR = type { i32, i32 }

; Function Attrs: nounwind uwtable
define void @func(%struct.COORDS* %coords) #0 {
  %1 = alloca %struct.COORDS*, align 8
  store %struct.COORDS* %coords, %struct.COORDS** %1, align 8
  %2 = load %struct.COORDS*, %struct.COORDS** %1, align 8
  %3 = getelementptr inbounds %struct.COORDS, %struct.COORDS* %2, i32 0, i32 0
  %4 = getelementptr inbounds %struct.PAIR, %struct.PAIR* %3, i32 0, i32 0
  store i32 5, i32* %4, align 4
  %5 = load %struct.COORDS*, %struct.COORDS** %1, align 8
  %6 = getelementptr inbounds %struct.COORDS, %struct.COORDS* %5, i32 0, i32 0
  %7 = getelementptr inbounds %struct.PAIR, %struct.PAIR* %6, i32 0, i32 1
  store i32 7, i32* %7, align 4
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %coords = alloca %struct.COORDS, align 4
  store i32 0, i32* %1, align 4
  call void @func(%struct.COORDS* %coords)
  %2 = getelementptr inbounds %struct.COORDS, %struct.COORDS* %coords, i32 0, i32 0
  %3 = getelementptr inbounds %struct.PAIR, %struct.PAIR* %2, i32 0, i32 0
  %4 = load i32, i32* %3, align 4
  %5 = getelementptr inbounds %struct.COORDS, %struct.COORDS* %coords, i32 0, i32 0
  %6 = getelementptr inbounds %struct.PAIR, %struct.PAIR* %5, i32 0, i32 1
  %7 = load i32, i32* %6, align 4
  %8 = add nsw i32 %4, %7
  ret i32 %8
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
