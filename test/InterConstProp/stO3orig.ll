; ModuleID = 'stO3orig.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.COORDS = type { %struct.PAIR }
%struct.PAIR = type { i32, i32 }

; Function Attrs: norecurse nounwind uwtable
define void @func(%struct.COORDS* nocapture %coords) #0 {
  %1 = getelementptr inbounds %struct.COORDS, %struct.COORDS* %coords, i64 0, i32 0, i32 0
  store i32 5, i32* %1, align 4
  %2 = getelementptr inbounds %struct.COORDS, %struct.COORDS* %coords, i64 0, i32 0, i32 1
  store i32 7, i32* %2, align 4
  ret void
}

; Function Attrs: norecurse nounwind readnone uwtable
define i32 @main() #1 {
  ret i32 12
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { norecurse nounwind readnone uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
