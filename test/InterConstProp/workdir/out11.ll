; ModuleID = 'workdir/out11.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@str.2 = private unnamed_addr constant [18 x i8] c"*** Branch Taken \00"

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.stType** nocapture readonly %obj) #0 {
  %1 = load %struct.stType*, %struct.stType** %obj, align 8
  %2 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 0
  %3 = load %struct.COORD*, %struct.COORD** %2, align 8
  %4 = getelementptr inbounds %struct.COORD, %struct.COORD* %3, i64 0, i32 0
  %5 = load i32*, i32** %4, align 8
  %6 = load i32, i32* %5, align 4
  %7 = icmp eq i32 %6, 1
  br i1 %7, label %8, label %184

; <label>:8                                       ; preds = %0
  %9 = getelementptr inbounds %struct.COORD, %struct.COORD* %3, i64 0, i32 1
  %10 = load i32*, i32** %9, align 8
  %11 = load i32, i32* %10, align 4
  %12 = icmp eq i32 %11, 2
  br i1 %12, label %13, label %184

; <label>:13                                      ; preds = %8
  %14 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 2, i64 1
  %15 = load i32, i32* %14, align 4
  %16 = icmp eq i32 %15, 4
  br i1 %16, label %17, label %184

; <label>:17                                      ; preds = %13
  %18 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 1, i64 0
  %19 = tail call i32 @strcmp(i8* %18, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #4
  %20 = icmp eq i32 %19, 0
  br i1 %20, label %21, label %184

; <label>:21                                      ; preds = %17
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 1, i64 4
  %23 = load i8, i8* %22, align 4
  %24 = icmp eq i8 %23, 111
  br i1 %24, label %25, label %184

; <label>:25                                      ; preds = %21
  %26 = getelementptr inbounds %struct.stType, %struct.stType* %1, i64 0, i32 1, i64 9
  %27 = load i8, i8* %26, align 1
  %28 = icmp eq i8 %27, 100
  br i1 %28, label %29, label %184

; <label>:29                                      ; preds = %25
  %30 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 1
  %31 = load %struct.stType*, %struct.stType** %30, align 8
  %32 = getelementptr inbounds %struct.stType, %struct.stType* %31, i64 0, i32 0
  %33 = load %struct.COORD*, %struct.COORD** %32, align 8
  %34 = getelementptr inbounds %struct.COORD, %struct.COORD* %33, i64 0, i32 0
  %35 = load i32*, i32** %34, align 8
  %36 = load i32, i32* %35, align 4
  %37 = icmp eq i32 %36, 6
  br i1 %37, label %38, label %184

; <label>:38                                      ; preds = %29
  %39 = getelementptr inbounds %struct.COORD, %struct.COORD* %33, i64 0, i32 1
  %40 = load i32*, i32** %39, align 8
  %41 = load i32, i32* %40, align 4
  %42 = icmp eq i32 %41, 7
  br i1 %42, label %43, label %184

; <label>:43                                      ; preds = %38
  %44 = getelementptr inbounds %struct.stType, %struct.stType* %31, i64 0, i32 2, i64 1
  %45 = load i32, i32* %44, align 4
  %46 = icmp eq i32 %45, 9
  br i1 %46, label %47, label %184

; <label>:47                                      ; preds = %43
  %48 = getelementptr inbounds %struct.stType, %struct.stType* %31, i64 0, i32 1, i64 0
  %49 = tail call i32 @strcmp(i8* %48, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #4
  %50 = icmp eq i32 %49, 0
  br i1 %50, label %51, label %184

; <label>:51                                      ; preds = %47
  %52 = getelementptr inbounds %struct.stType, %struct.stType* %31, i64 0, i32 1, i64 4
  %53 = load i8, i8* %52, align 4
  %54 = icmp eq i8 %53, 111
  br i1 %54, label %55, label %184

; <label>:55                                      ; preds = %51
  %56 = getelementptr inbounds %struct.stType, %struct.stType* %31, i64 0, i32 1, i64 9
  %57 = load i8, i8* %56, align 1
  %58 = icmp eq i8 %57, 100
  br i1 %58, label %59, label %184

; <label>:59                                      ; preds = %55
  %60 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 2
  %61 = load %struct.stType*, %struct.stType** %60, align 8
  %62 = getelementptr inbounds %struct.stType, %struct.stType* %61, i64 0, i32 0
  %63 = load %struct.COORD*, %struct.COORD** %62, align 8
  %64 = getelementptr inbounds %struct.COORD, %struct.COORD* %63, i64 0, i32 0
  %65 = load i32*, i32** %64, align 8
  %66 = load i32, i32* %65, align 4
  %67 = icmp eq i32 %66, 11
  br i1 %67, label %68, label %184

; <label>:68                                      ; preds = %59
  %69 = getelementptr inbounds %struct.COORD, %struct.COORD* %63, i64 0, i32 1
  %70 = load i32*, i32** %69, align 8
  %71 = load i32, i32* %70, align 4
  %72 = icmp eq i32 %71, 12
  br i1 %72, label %73, label %184

; <label>:73                                      ; preds = %68
  %74 = getelementptr inbounds %struct.stType, %struct.stType* %61, i64 0, i32 2, i64 1
  %75 = load i32, i32* %74, align 4
  %76 = icmp eq i32 %75, 14
  br i1 %76, label %77, label %184

; <label>:77                                      ; preds = %73
  %78 = getelementptr inbounds %struct.stType, %struct.stType* %61, i64 0, i32 1, i64 0
  %79 = tail call i32 @strcmp(i8* %78, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #4
  %80 = icmp eq i32 %79, 0
  br i1 %80, label %81, label %184

; <label>:81                                      ; preds = %77
  %82 = getelementptr inbounds %struct.stType, %struct.stType* %61, i64 0, i32 1, i64 4
  %83 = load i8, i8* %82, align 4
  %84 = icmp eq i8 %83, 111
  br i1 %84, label %85, label %184

; <label>:85                                      ; preds = %81
  %86 = getelementptr inbounds %struct.stType, %struct.stType* %61, i64 0, i32 1, i64 9
  %87 = load i8, i8* %86, align 1
  %88 = icmp eq i8 %87, 100
  br i1 %88, label %89, label %184

; <label>:89                                      ; preds = %85
  %90 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 3
  %91 = load %struct.stType*, %struct.stType** %90, align 8
  %92 = getelementptr inbounds %struct.stType, %struct.stType* %91, i64 0, i32 0
  %93 = load %struct.COORD*, %struct.COORD** %92, align 8
  %94 = getelementptr inbounds %struct.COORD, %struct.COORD* %93, i64 0, i32 0
  %95 = load i32*, i32** %94, align 8
  %96 = load i32, i32* %95, align 4
  %97 = icmp eq i32 %96, 16
  br i1 %97, label %98, label %184

; <label>:98                                      ; preds = %89
  %99 = getelementptr inbounds %struct.COORD, %struct.COORD* %93, i64 0, i32 1
  %100 = load i32*, i32** %99, align 8
  %101 = load i32, i32* %100, align 4
  %102 = icmp eq i32 %101, 17
  br i1 %102, label %103, label %184

; <label>:103                                     ; preds = %98
  %104 = getelementptr inbounds %struct.stType, %struct.stType* %91, i64 0, i32 2, i64 1
  %105 = load i32, i32* %104, align 4
  %106 = icmp eq i32 %105, 19
  br i1 %106, label %107, label %184

; <label>:107                                     ; preds = %103
  %108 = getelementptr inbounds %struct.stType, %struct.stType* %91, i64 0, i32 1, i64 0
  %109 = tail call i32 @strcmp(i8* %108, i8* nonnull getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #4
  %110 = icmp eq i32 %109, 0
  br i1 %110, label %111, label %184

; <label>:111                                     ; preds = %107
  %112 = getelementptr inbounds %struct.stType, %struct.stType* %91, i64 0, i32 1, i64 4
  %113 = load i8, i8* %112, align 4
  %114 = icmp eq i8 %113, 111
  br i1 %114, label %115, label %184

; <label>:115                                     ; preds = %111
  %116 = getelementptr inbounds %struct.stType, %struct.stType* %91, i64 0, i32 1, i64 9
  %117 = load i8, i8* %116, align 1
  %118 = icmp eq i8 %117, 100
  br i1 %118, label %119, label %184

; <label>:119                                     ; preds = %115
  %120 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 4
  %121 = load %struct.stType*, %struct.stType** %120, align 8
  %122 = icmp eq %struct.stType* %121, null
  br i1 %122, label %123, label %184

; <label>:123                                     ; preds = %119
  %124 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 5
  %125 = load %struct.stType*, %struct.stType** %124, align 8
  %126 = icmp eq %struct.stType* %125, null
  br i1 %126, label %127, label %184

; <label>:127                                     ; preds = %123
  %128 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 6
  %129 = load %struct.stType*, %struct.stType** %128, align 8
  %130 = icmp eq %struct.stType* %129, null
  br i1 %130, label %131, label %184

; <label>:131                                     ; preds = %127
  %132 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 7
  %133 = load %struct.stType*, %struct.stType** %132, align 8
  %134 = icmp eq %struct.stType* %133, null
  br i1 %134, label %135, label %184

; <label>:135                                     ; preds = %131
  %136 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 8
  %137 = load %struct.stType*, %struct.stType** %136, align 8
  %138 = icmp eq %struct.stType* %137, null
  br i1 %138, label %139, label %184

; <label>:139                                     ; preds = %135
  %140 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 9
  %141 = load %struct.stType*, %struct.stType** %140, align 8
  %142 = icmp eq %struct.stType* %141, null
  br i1 %142, label %143, label %184

; <label>:143                                     ; preds = %139
  %144 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 10
  %145 = load %struct.stType*, %struct.stType** %144, align 8
  %146 = icmp eq %struct.stType* %145, null
  br i1 %146, label %147, label %184

; <label>:147                                     ; preds = %143
  %148 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 11
  %149 = load %struct.stType*, %struct.stType** %148, align 8
  %150 = icmp eq %struct.stType* %149, null
  br i1 %150, label %151, label %184

; <label>:151                                     ; preds = %147
  %152 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 12
  %153 = load %struct.stType*, %struct.stType** %152, align 8
  %154 = icmp eq %struct.stType* %153, null
  br i1 %154, label %155, label %184

; <label>:155                                     ; preds = %151
  %156 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 13
  %157 = load %struct.stType*, %struct.stType** %156, align 8
  %158 = icmp eq %struct.stType* %157, null
  br i1 %158, label %159, label %184

; <label>:159                                     ; preds = %155
  %160 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 14
  %161 = load %struct.stType*, %struct.stType** %160, align 8
  %162 = icmp eq %struct.stType* %161, null
  br i1 %162, label %163, label %184

; <label>:163                                     ; preds = %159
  %164 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 15
  %165 = load %struct.stType*, %struct.stType** %164, align 8
  %166 = icmp eq %struct.stType* %165, null
  br i1 %166, label %167, label %184

; <label>:167                                     ; preds = %163
  %168 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 16
  %169 = load %struct.stType*, %struct.stType** %168, align 8
  %170 = icmp eq %struct.stType* %169, null
  br i1 %170, label %171, label %184

; <label>:171                                     ; preds = %167
  %172 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 17
  %173 = load %struct.stType*, %struct.stType** %172, align 8
  %174 = icmp eq %struct.stType* %173, null
  br i1 %174, label %175, label %184

; <label>:175                                     ; preds = %171
  %176 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 18
  %177 = load %struct.stType*, %struct.stType** %176, align 8
  %178 = icmp eq %struct.stType* %177, null
  br i1 %178, label %179, label %184

; <label>:179                                     ; preds = %175
  %180 = getelementptr inbounds %struct.stType*, %struct.stType** %obj, i64 19
  %181 = load %struct.stType*, %struct.stType** %180, align 8
  %182 = icmp eq %struct.stType* %181, null
  br i1 %182, label %183, label %184

; <label>:183                                     ; preds = %179
  %puts = tail call i32 @puts(i8* nonnull getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0))
  br label %184

; <label>:184                                     ; preds = %107, %77, %47, %17, %183, %179, %175, %171, %167, %163, %159, %155, %151, %147, %143, %139, %135, %131, %127, %123, %119, %115, %111, %103, %98, %89, %85, %81, %73, %68, %59, %55, %51, %43, %38, %29, %25, %21, %13, %8, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #1

; Function Attrs: norecurse nounwind readnone uwtable
define void @initialize(%struct.stType** nocapture %obj) #2 {
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %puts.i = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0)) #3
  ret i32 0
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.stType** nocapture readnone %obj) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone_clone(%struct.stType** nocapture readnone %obj) #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.2, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #3

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { norecurse nounwind readnone uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
