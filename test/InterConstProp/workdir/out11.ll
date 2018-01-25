; ModuleID = 'workdir/out11.bc'
source_filename = "inter11.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.stType = type { %struct.COORD*, [100 x i8], [8 x i32] }
%struct.COORD = type { i32*, i32* }

@.str = private unnamed_addr constant [11 x i8] c"helloWorld\00", align 1
@.str.2 = private unnamed_addr constant [12 x i8] c"helloWorld\00\00", align 1
@str.1 = private unnamed_addr constant [18 x i8] c"*** Branch Taken \00"

; Function Attrs: noinline nounwind uwtable
define void @branchPruned(%struct.stType** nocapture readonly) local_unnamed_addr #0 {
  %2 = load %struct.stType*, %struct.stType** %0, align 8
  %3 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 0
  %4 = load %struct.COORD*, %struct.COORD** %3, align 8
  %5 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i64 0, i32 0
  %6 = load i32*, i32** %5, align 8
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 %7, 1
  br i1 %8, label %9, label %185

; <label>:9:                                      ; preds = %1
  %10 = getelementptr inbounds %struct.COORD, %struct.COORD* %4, i64 0, i32 1
  %11 = load i32*, i32** %10, align 8
  %12 = load i32, i32* %11, align 4
  %13 = icmp eq i32 %12, 2
  br i1 %13, label %14, label %185

; <label>:14:                                     ; preds = %9
  %15 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 2, i64 1
  %16 = load i32, i32* %15, align 4
  %17 = icmp eq i32 %16, 4
  br i1 %17, label %18, label %185

; <label>:18:                                     ; preds = %14
  %19 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 1, i64 0
  %20 = tail call i32 @strcmp(i8* %19, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #6
  %21 = icmp eq i32 %20, 0
  br i1 %21, label %22, label %185

; <label>:22:                                     ; preds = %18
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 1, i64 4
  %24 = load i8, i8* %23, align 4
  %25 = icmp eq i8 %24, 111
  br i1 %25, label %26, label %185

; <label>:26:                                     ; preds = %22
  %27 = getelementptr inbounds %struct.stType, %struct.stType* %2, i64 0, i32 1, i64 9
  %28 = load i8, i8* %27, align 1
  %29 = icmp eq i8 %28, 100
  br i1 %29, label %30, label %185

; <label>:30:                                     ; preds = %26
  %31 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 1
  %32 = load %struct.stType*, %struct.stType** %31, align 8
  %33 = getelementptr inbounds %struct.stType, %struct.stType* %32, i64 0, i32 0
  %34 = load %struct.COORD*, %struct.COORD** %33, align 8
  %35 = getelementptr inbounds %struct.COORD, %struct.COORD* %34, i64 0, i32 0
  %36 = load i32*, i32** %35, align 8
  %37 = load i32, i32* %36, align 4
  %38 = icmp eq i32 %37, 6
  br i1 %38, label %39, label %185

; <label>:39:                                     ; preds = %30
  %40 = getelementptr inbounds %struct.COORD, %struct.COORD* %34, i64 0, i32 1
  %41 = load i32*, i32** %40, align 8
  %42 = load i32, i32* %41, align 4
  %43 = icmp eq i32 %42, 7
  br i1 %43, label %44, label %185

; <label>:44:                                     ; preds = %39
  %45 = getelementptr inbounds %struct.stType, %struct.stType* %32, i64 0, i32 2, i64 1
  %46 = load i32, i32* %45, align 4
  %47 = icmp eq i32 %46, 9
  br i1 %47, label %48, label %185

; <label>:48:                                     ; preds = %44
  %49 = getelementptr inbounds %struct.stType, %struct.stType* %32, i64 0, i32 1, i64 0
  %50 = tail call i32 @strcmp(i8* %49, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #6
  %51 = icmp eq i32 %50, 0
  br i1 %51, label %52, label %185

; <label>:52:                                     ; preds = %48
  %53 = getelementptr inbounds %struct.stType, %struct.stType* %32, i64 0, i32 1, i64 4
  %54 = load i8, i8* %53, align 4
  %55 = icmp eq i8 %54, 111
  br i1 %55, label %56, label %185

; <label>:56:                                     ; preds = %52
  %57 = getelementptr inbounds %struct.stType, %struct.stType* %32, i64 0, i32 1, i64 9
  %58 = load i8, i8* %57, align 1
  %59 = icmp eq i8 %58, 100
  br i1 %59, label %60, label %185

; <label>:60:                                     ; preds = %56
  %61 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 2
  %62 = load %struct.stType*, %struct.stType** %61, align 8
  %63 = getelementptr inbounds %struct.stType, %struct.stType* %62, i64 0, i32 0
  %64 = load %struct.COORD*, %struct.COORD** %63, align 8
  %65 = getelementptr inbounds %struct.COORD, %struct.COORD* %64, i64 0, i32 0
  %66 = load i32*, i32** %65, align 8
  %67 = load i32, i32* %66, align 4
  %68 = icmp eq i32 %67, 11
  br i1 %68, label %69, label %185

; <label>:69:                                     ; preds = %60
  %70 = getelementptr inbounds %struct.COORD, %struct.COORD* %64, i64 0, i32 1
  %71 = load i32*, i32** %70, align 8
  %72 = load i32, i32* %71, align 4
  %73 = icmp eq i32 %72, 12
  br i1 %73, label %74, label %185

; <label>:74:                                     ; preds = %69
  %75 = getelementptr inbounds %struct.stType, %struct.stType* %62, i64 0, i32 2, i64 1
  %76 = load i32, i32* %75, align 4
  %77 = icmp eq i32 %76, 14
  br i1 %77, label %78, label %185

; <label>:78:                                     ; preds = %74
  %79 = getelementptr inbounds %struct.stType, %struct.stType* %62, i64 0, i32 1, i64 0
  %80 = tail call i32 @strcmp(i8* %79, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #6
  %81 = icmp eq i32 %80, 0
  br i1 %81, label %82, label %185

; <label>:82:                                     ; preds = %78
  %83 = getelementptr inbounds %struct.stType, %struct.stType* %62, i64 0, i32 1, i64 4
  %84 = load i8, i8* %83, align 4
  %85 = icmp eq i8 %84, 111
  br i1 %85, label %86, label %185

; <label>:86:                                     ; preds = %82
  %87 = getelementptr inbounds %struct.stType, %struct.stType* %62, i64 0, i32 1, i64 9
  %88 = load i8, i8* %87, align 1
  %89 = icmp eq i8 %88, 100
  br i1 %89, label %90, label %185

; <label>:90:                                     ; preds = %86
  %91 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 3
  %92 = load %struct.stType*, %struct.stType** %91, align 8
  %93 = getelementptr inbounds %struct.stType, %struct.stType* %92, i64 0, i32 0
  %94 = load %struct.COORD*, %struct.COORD** %93, align 8
  %95 = getelementptr inbounds %struct.COORD, %struct.COORD* %94, i64 0, i32 0
  %96 = load i32*, i32** %95, align 8
  %97 = load i32, i32* %96, align 4
  %98 = icmp eq i32 %97, 16
  br i1 %98, label %99, label %185

; <label>:99:                                     ; preds = %90
  %100 = getelementptr inbounds %struct.COORD, %struct.COORD* %94, i64 0, i32 1
  %101 = load i32*, i32** %100, align 8
  %102 = load i32, i32* %101, align 4
  %103 = icmp eq i32 %102, 17
  br i1 %103, label %104, label %185

; <label>:104:                                    ; preds = %99
  %105 = getelementptr inbounds %struct.stType, %struct.stType* %92, i64 0, i32 2, i64 1
  %106 = load i32, i32* %105, align 4
  %107 = icmp eq i32 %106, 19
  br i1 %107, label %108, label %185

; <label>:108:                                    ; preds = %104
  %109 = getelementptr inbounds %struct.stType, %struct.stType* %92, i64 0, i32 1, i64 0
  %110 = tail call i32 @strcmp(i8* %109, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i64 0, i64 0)) #6
  %111 = icmp eq i32 %110, 0
  br i1 %111, label %112, label %185

; <label>:112:                                    ; preds = %108
  %113 = getelementptr inbounds %struct.stType, %struct.stType* %92, i64 0, i32 1, i64 4
  %114 = load i8, i8* %113, align 4
  %115 = icmp eq i8 %114, 111
  br i1 %115, label %116, label %185

; <label>:116:                                    ; preds = %112
  %117 = getelementptr inbounds %struct.stType, %struct.stType* %92, i64 0, i32 1, i64 9
  %118 = load i8, i8* %117, align 1
  %119 = icmp eq i8 %118, 100
  br i1 %119, label %120, label %185

; <label>:120:                                    ; preds = %116
  %121 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 4
  %122 = load %struct.stType*, %struct.stType** %121, align 8
  %123 = icmp eq %struct.stType* %122, null
  br i1 %123, label %124, label %185

; <label>:124:                                    ; preds = %120
  %125 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 5
  %126 = load %struct.stType*, %struct.stType** %125, align 8
  %127 = icmp eq %struct.stType* %126, null
  br i1 %127, label %128, label %185

; <label>:128:                                    ; preds = %124
  %129 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 6
  %130 = load %struct.stType*, %struct.stType** %129, align 8
  %131 = icmp eq %struct.stType* %130, null
  br i1 %131, label %132, label %185

; <label>:132:                                    ; preds = %128
  %133 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 7
  %134 = load %struct.stType*, %struct.stType** %133, align 8
  %135 = icmp eq %struct.stType* %134, null
  br i1 %135, label %136, label %185

; <label>:136:                                    ; preds = %132
  %137 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 8
  %138 = load %struct.stType*, %struct.stType** %137, align 8
  %139 = icmp eq %struct.stType* %138, null
  br i1 %139, label %140, label %185

; <label>:140:                                    ; preds = %136
  %141 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 9
  %142 = load %struct.stType*, %struct.stType** %141, align 8
  %143 = icmp eq %struct.stType* %142, null
  br i1 %143, label %144, label %185

; <label>:144:                                    ; preds = %140
  %145 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 10
  %146 = load %struct.stType*, %struct.stType** %145, align 8
  %147 = icmp eq %struct.stType* %146, null
  br i1 %147, label %148, label %185

; <label>:148:                                    ; preds = %144
  %149 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 11
  %150 = load %struct.stType*, %struct.stType** %149, align 8
  %151 = icmp eq %struct.stType* %150, null
  br i1 %151, label %152, label %185

; <label>:152:                                    ; preds = %148
  %153 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 12
  %154 = load %struct.stType*, %struct.stType** %153, align 8
  %155 = icmp eq %struct.stType* %154, null
  br i1 %155, label %156, label %185

; <label>:156:                                    ; preds = %152
  %157 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 13
  %158 = load %struct.stType*, %struct.stType** %157, align 8
  %159 = icmp eq %struct.stType* %158, null
  br i1 %159, label %160, label %185

; <label>:160:                                    ; preds = %156
  %161 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 14
  %162 = load %struct.stType*, %struct.stType** %161, align 8
  %163 = icmp eq %struct.stType* %162, null
  br i1 %163, label %164, label %185

; <label>:164:                                    ; preds = %160
  %165 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 15
  %166 = load %struct.stType*, %struct.stType** %165, align 8
  %167 = icmp eq %struct.stType* %166, null
  br i1 %167, label %168, label %185

; <label>:168:                                    ; preds = %164
  %169 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 16
  %170 = load %struct.stType*, %struct.stType** %169, align 8
  %171 = icmp eq %struct.stType* %170, null
  br i1 %171, label %172, label %185

; <label>:172:                                    ; preds = %168
  %173 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 17
  %174 = load %struct.stType*, %struct.stType** %173, align 8
  %175 = icmp eq %struct.stType* %174, null
  br i1 %175, label %176, label %185

; <label>:176:                                    ; preds = %172
  %177 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 18
  %178 = load %struct.stType*, %struct.stType** %177, align 8
  %179 = icmp eq %struct.stType* %178, null
  br i1 %179, label %180, label %185

; <label>:180:                                    ; preds = %176
  %181 = getelementptr inbounds %struct.stType*, %struct.stType** %0, i64 19
  %182 = load %struct.stType*, %struct.stType** %181, align 8
  %183 = icmp eq %struct.stType* %182, null
  br i1 %183, label %184, label %185

; <label>:184:                                    ; preds = %180
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.1, i64 0, i64 0))
  br label %185

; <label>:185:                                    ; preds = %108, %78, %48, %18, %184, %180, %176, %172, %168, %164, %160, %156, %152, %148, %144, %140, %136, %132, %128, %124, %120, %116, %112, %104, %99, %90, %86, %82, %74, %69, %60, %56, %52, %44, %39, %30, %26, %22, %14, %9, %1
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) local_unnamed_addr #1

; Function Attrs: noinline norecurse nounwind readnone uwtable
define void @initialize(%struct.stType** nocapture) local_unnamed_addr #2 {
  ret void
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() local_unnamed_addr #0 {
  %1 = tail call noalias i8* @malloc(i64 160) #5
  %2 = bitcast i8* %1 to %struct.stType**
  %3 = tail call noalias i8* @malloc(i64 144) #5
  %4 = bitcast i8* %1 to i8**
  store i8* %3, i8** %4, align 8
  %5 = tail call noalias i8* @malloc(i64 16) #5
  %6 = bitcast i8* %3 to i8**
  store i8* %5, i8** %6, align 8
  %7 = tail call noalias i8* @malloc(i64 4) #5
  %8 = bitcast i8* %5 to i8**
  store i8* %7, i8** %8, align 8
  %9 = tail call noalias i8* @malloc(i64 4) #5
  %10 = bitcast i8* %3 to %struct.COORD**
  %11 = getelementptr inbounds i8, i8* %5, i64 8
  %12 = bitcast i8* %11 to i8**
  store i8* %9, i8** %12, align 8
  %13 = load %struct.COORD*, %struct.COORD** %10, align 8
  %14 = getelementptr inbounds %struct.COORD, %struct.COORD* %13, i64 0, i32 0
  %15 = load i32*, i32** %14, align 8
  store i32 1, i32* %15, align 4
  %16 = load %struct.COORD*, %struct.COORD** %10, align 8
  %17 = getelementptr inbounds %struct.COORD, %struct.COORD* %16, i64 0, i32 1
  %18 = load i32*, i32** %17, align 8
  store i32 2, i32* %18, align 4
  %19 = getelementptr inbounds i8, i8* %3, i64 108
  %20 = bitcast i8* %19 to i32*
  store i32 3, i32* %20, align 4
  %21 = load %struct.stType*, %struct.stType** %2, align 8
  %22 = getelementptr inbounds %struct.stType, %struct.stType* %21, i64 0, i32 2, i64 1
  store i32 4, i32* %22, align 4
  %23 = getelementptr inbounds %struct.stType, %struct.stType* %21, i64 0, i32 2, i64 2
  store i32 5, i32* %23, align 4
  %24 = getelementptr inbounds %struct.stType, %struct.stType* %21, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %24, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0), i64 11, i32 1, i1 false)
  %25 = tail call noalias i8* @malloc(i64 144) #5
  %26 = getelementptr inbounds i8, i8* %1, i64 8
  %27 = bitcast i8* %26 to %struct.stType**
  %28 = bitcast i8* %26 to i8**
  store i8* %25, i8** %28, align 8
  %29 = tail call noalias i8* @malloc(i64 16) #5
  %30 = bitcast i8* %25 to i8**
  store i8* %29, i8** %30, align 8
  %31 = tail call noalias i8* @malloc(i64 4) #5
  %32 = bitcast i8* %29 to i8**
  store i8* %31, i8** %32, align 8
  %33 = tail call noalias i8* @malloc(i64 4) #5
  %34 = bitcast i8* %25 to %struct.COORD**
  %35 = getelementptr inbounds i8, i8* %29, i64 8
  %36 = bitcast i8* %35 to i8**
  store i8* %33, i8** %36, align 8
  %37 = load %struct.COORD*, %struct.COORD** %34, align 8
  %38 = getelementptr inbounds %struct.COORD, %struct.COORD* %37, i64 0, i32 0
  %39 = load i32*, i32** %38, align 8
  store i32 6, i32* %39, align 4
  %40 = load %struct.COORD*, %struct.COORD** %34, align 8
  %41 = getelementptr inbounds %struct.COORD, %struct.COORD* %40, i64 0, i32 1
  %42 = load i32*, i32** %41, align 8
  store i32 7, i32* %42, align 4
  %43 = getelementptr inbounds i8, i8* %25, i64 108
  %44 = bitcast i8* %43 to i32*
  store i32 8, i32* %44, align 4
  %45 = load %struct.stType*, %struct.stType** %27, align 8
  %46 = getelementptr inbounds %struct.stType, %struct.stType* %45, i64 0, i32 2, i64 1
  store i32 9, i32* %46, align 4
  %47 = getelementptr inbounds %struct.stType, %struct.stType* %45, i64 0, i32 2, i64 2
  store i32 10, i32* %47, align 4
  %48 = getelementptr inbounds %struct.stType, %struct.stType* %45, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %48, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0), i64 11, i32 1, i1 false)
  %49 = tail call noalias i8* @malloc(i64 144) #5
  %50 = getelementptr inbounds i8, i8* %1, i64 16
  %51 = bitcast i8* %50 to %struct.stType**
  %52 = bitcast i8* %50 to i8**
  store i8* %49, i8** %52, align 8
  %53 = tail call noalias i8* @malloc(i64 16) #5
  %54 = bitcast i8* %49 to i8**
  store i8* %53, i8** %54, align 8
  %55 = tail call noalias i8* @malloc(i64 4) #5
  %56 = bitcast i8* %53 to i8**
  store i8* %55, i8** %56, align 8
  %57 = tail call noalias i8* @malloc(i64 4) #5
  %58 = bitcast i8* %49 to %struct.COORD**
  %59 = getelementptr inbounds i8, i8* %53, i64 8
  %60 = bitcast i8* %59 to i8**
  store i8* %57, i8** %60, align 8
  %61 = load %struct.COORD*, %struct.COORD** %58, align 8
  %62 = getelementptr inbounds %struct.COORD, %struct.COORD* %61, i64 0, i32 0
  %63 = load i32*, i32** %62, align 8
  store i32 11, i32* %63, align 4
  %64 = load %struct.COORD*, %struct.COORD** %58, align 8
  %65 = getelementptr inbounds %struct.COORD, %struct.COORD* %64, i64 0, i32 1
  %66 = load i32*, i32** %65, align 8
  store i32 12, i32* %66, align 4
  %67 = getelementptr inbounds i8, i8* %49, i64 108
  %68 = bitcast i8* %67 to i32*
  store i32 13, i32* %68, align 4
  %69 = load %struct.stType*, %struct.stType** %51, align 8
  %70 = getelementptr inbounds %struct.stType, %struct.stType* %69, i64 0, i32 2, i64 1
  store i32 14, i32* %70, align 4
  %71 = getelementptr inbounds %struct.stType, %struct.stType* %69, i64 0, i32 2, i64 2
  store i32 15, i32* %71, align 4
  %72 = getelementptr inbounds %struct.stType, %struct.stType* %69, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %72, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0), i64 11, i32 1, i1 false)
  %73 = tail call noalias i8* @malloc(i64 144) #5
  %74 = getelementptr inbounds i8, i8* %1, i64 24
  %75 = bitcast i8* %74 to %struct.stType**
  %76 = bitcast i8* %74 to i8**
  store i8* %73, i8** %76, align 8
  %77 = tail call noalias i8* @malloc(i64 16) #5
  %78 = bitcast i8* %73 to i8**
  store i8* %77, i8** %78, align 8
  %79 = tail call noalias i8* @malloc(i64 4) #5
  %80 = bitcast i8* %77 to i8**
  store i8* %79, i8** %80, align 8
  %81 = tail call noalias i8* @malloc(i64 4) #5
  %82 = bitcast i8* %73 to %struct.COORD**
  %83 = getelementptr inbounds i8, i8* %77, i64 8
  %84 = bitcast i8* %83 to i8**
  store i8* %81, i8** %84, align 8
  %85 = load %struct.COORD*, %struct.COORD** %82, align 8
  %86 = getelementptr inbounds %struct.COORD, %struct.COORD* %85, i64 0, i32 0
  %87 = load i32*, i32** %86, align 8
  store i32 16, i32* %87, align 4
  %88 = load %struct.COORD*, %struct.COORD** %82, align 8
  %89 = getelementptr inbounds %struct.COORD, %struct.COORD* %88, i64 0, i32 1
  %90 = load i32*, i32** %89, align 8
  store i32 17, i32* %90, align 4
  %91 = getelementptr inbounds i8, i8* %73, i64 108
  %92 = bitcast i8* %91 to i32*
  store i32 18, i32* %92, align 4
  %93 = load %struct.stType*, %struct.stType** %75, align 8
  %94 = getelementptr inbounds %struct.stType, %struct.stType* %93, i64 0, i32 2, i64 1
  store i32 19, i32* %94, align 4
  %95 = getelementptr inbounds %struct.stType, %struct.stType* %93, i64 0, i32 2, i64 2
  store i32 20, i32* %95, align 4
  %96 = getelementptr inbounds %struct.stType, %struct.stType* %93, i64 0, i32 1, i64 0
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %96, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.2, i64 0, i64 0), i64 11, i32 1, i1 false)
  tail call void @branchPruned_clone(%struct.stType** %2)
  ret i32 0
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) local_unnamed_addr #3

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #4

; Function Attrs: noinline nounwind uwtable
define void @branchPruned_clone(%struct.stType** nocapture readnone) local_unnamed_addr #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8], [18 x i8]* @str.1, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #5

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline norecurse nounwind readnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { argmemonly nounwind }
attributes #5 = { nounwind }
attributes #6 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = !{!"clang version 4.0.1-svn305264-1~exp1 (branches/release_40)"}
