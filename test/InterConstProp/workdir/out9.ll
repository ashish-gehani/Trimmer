; ModuleID = 'workdir/out9.bc'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.HighType = type { %struct.LowTypeString, %struct.LowTypeInt }
%struct.LowTypeString = type { [1000 x i8], [1000 x i8] }
%struct.LowTypeInt = type { [1000 x i32], [1000 x i32] }

@.str = private unnamed_addr constant [23 x i8] c"ygxxcdzafwiklhzyzdgzxa\00", align 1
@.str.1 = private unnamed_addr constant [14 x i8] c"gqtomhqmeajsw\00", align 1
@.str.2 = private unnamed_addr constant [8 x i8] c"mmnjzle\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"scopjbieaazzvnw\00", align 1
@.str.4 = private unnamed_addr constant [13 x i8] c"ysdsqcgxmmya\00", align 1
@.str.5 = private unnamed_addr constant [27 x i8] c"aufruuriyjqmaotagfqdmaxqve\00", align 1
@.str.6 = private unnamed_addr constant [9 x i8] c"dhmezuzq\00", align 1
@.str.7 = private unnamed_addr constant [22 x i8] c"ufbwlmtjwtspwbdhpwwat\00", align 1
@.str.8 = private unnamed_addr constant [25 x i8] c"tfdbkojwsyqsbmodersokpfu\00", align 1
@.str.9 = private unnamed_addr constant [16 x i8] c"*** branchTaken\00", align 1

; Function Attrs: norecurse nounwind uwtable
define void @initialize(%struct.HighType* %obj) #0 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 569
  store i32 122, i32* %1, align 4
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 335
  store i32 112, i32* %2, align 4
  %3 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 534
  store i32 106, i32* %3, align 4
  %4 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 645
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %4, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), i64 22, i32 1, i1 false)
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 760
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i64 13, i32 1, i1 false)
  %6 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 559
  store i32 113, i32* %6, align 4
  %7 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 608
  store i32 106, i32* %7, align 4
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 381
  store i32 102, i32* %8, align 4
  %9 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 398
  store i32 122, i32* %9, align 4
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 813
  store i32 110, i32* %10, align 4
  %11 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 305
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %11, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i64 0, i64 0), i64 7, i32 1, i1 false)
  %12 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 796
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0), i64 15, i32 1, i1 false)
  %13 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 662
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i64 0, i64 0), i64 12, i32 1, i1 false)
  %14 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 75
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %14, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.5, i64 0, i64 0), i64 26, i32 1, i1 false)
  %15 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 202
  store i32 97, i32* %15, align 4
  %16 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 40
  store i32 99, i32* %16, align 4
  %17 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 107
  %18 = bitcast i8* %17 to i64*
  store i64 8176977241992685668, i64* %18, align 1
  %19 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 511
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %19, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.7, i64 0, i64 0), i64 21, i32 1, i1 false)
  %20 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 587
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %20, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.8, i64 0, i64 0), i64 24, i32 1, i1 false)
  %21 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 427
  store i32 105, i32* %21, align 4
  %22 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 83
  store i32 117, i32* %22, align 4
  %23 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 644
  store i32 110, i32* %23, align 4
  %24 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 384
  store i32 97, i32* %24, align 4
  %25 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 784
  store i32 110, i32* %25, align 4
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.HighType* byval readonly align 8 %obj) #2 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 75
  %2 = load i8, i8* %1, align 1
  %3 = icmp eq i8 %2, 97
  br i1 %3, label %4, label %393

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 76
  %6 = bitcast i8* %5 to i32*
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 %7, 1970431605
  br i1 %8, label %9, label %393

; <label>:9                                       ; preds = %4
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 80
  %11 = bitcast i8* %10 to i32*
  %12 = load i32, i32* %11, align 8
  %13 = bitcast i8* %10 to i64*
  %14 = load i64, i64* %13, align 8
  %15 = trunc i64 %14 to i32
  %16 = lshr i32 %15, 16
  %17 = trunc i32 %16 to i8
  %18 = and i64 %14, 65535
  %19 = icmp eq i64 %18, 29301
  %20 = icmp eq i8 %17, 105
  %or.cond64 = and i1 %19, %20
  %.mask3 = and i32 %12, -16777216
  %21 = icmp eq i32 %.mask3, 2030043136
  %or.cond66 = and i1 %or.cond64, %21
  %22 = and i64 %14, -4294967296
  %23 = icmp eq i64 %22, 7020392094220943360
  %24 = and i1 %23, %or.cond66
  br i1 %24, label %25, label %393

; <label>:25                                      ; preds = %9
  %26 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 88
  %27 = bitcast i8* %26 to i32*
  %28 = load i32, i32* %27, align 8
  %29 = bitcast i8* %26 to i64*
  %30 = load i64, i64* %29, align 8
  %31 = trunc i64 %30 to i32
  %32 = lshr i32 %31, 16
  %33 = trunc i32 %32 to i8
  %34 = and i64 %30, 65535
  %35 = icmp eq i64 %34, 29807
  %36 = icmp eq i8 %33, 97
  %or.cond77 = and i1 %35, %36
  %.mask6 = and i32 %28, -16777216
  %37 = icmp eq i32 %.mask6, 1728053248
  %or.cond79 = and i1 %or.cond77, %37
  %38 = and i64 %30, -4294967296
  %39 = icmp eq i64 %38, 7882549930705813504
  %40 = and i1 %39, %or.cond79
  br i1 %40, label %41, label %393

; <label>:41                                      ; preds = %25
  %42 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 96
  %43 = bitcast i8* %42 to i32*
  %44 = load i32, i32* %43, align 8
  %45 = bitcast i8* %42 to i64*
  %46 = load i64, i64* %45, align 8
  %47 = trunc i64 %46 to i32
  %48 = lshr i32 %47, 16
  %49 = trunc i32 %48 to i8
  %50 = and i64 %46, 65535
  %51 = icmp eq i64 %50, 30817
  %52 = icmp eq i8 %49, 113
  %or.cond90 = and i1 %51, %52
  %.mask9 = and i32 %44, -16777216
  %53 = icmp eq i32 %.mask9, 1979711488
  %or.cond92 = and i1 %or.cond90, %53
  %54 = and i64 %46, 1095216660480
  %55 = icmp eq i64 %54, 433791696896
  %or.cond94 = and i1 %or.cond92, %55
  br i1 %or.cond94, label %56, label %393

; <label>:56                                      ; preds = %41
  %57 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 587
  %58 = load i8, i8* %57, align 1
  %59 = icmp eq i8 %58, 116
  br i1 %59, label %60, label %393

; <label>:60                                      ; preds = %56
  %61 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 588
  %62 = bitcast i8* %61 to i32*
  %63 = load i32, i32* %62, align 4
  %64 = icmp eq i32 %63, 1801610342
  br i1 %64, label %65, label %393

; <label>:65                                      ; preds = %60
  %66 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 592
  %67 = bitcast i8* %66 to i32*
  %68 = load i32, i32* %67, align 8
  %69 = bitcast i8* %66 to i64*
  %70 = load i64, i64* %69, align 8
  %71 = trunc i64 %70 to i32
  %72 = lshr i32 %71, 16
  %73 = trunc i32 %72 to i8
  %74 = and i64 %70, 65535
  %75 = icmp eq i64 %74, 27247
  %76 = icmp eq i8 %73, 119
  %or.cond103 = and i1 %75, %76
  %.mask13 = and i32 %68, -16777216
  %77 = icmp eq i32 %.mask13, 1929379840
  %or.cond105 = and i1 %or.cond103, %77
  %78 = and i64 %70, -4294967296
  %79 = icmp eq i64 %78, 7094138602543644672
  %80 = and i1 %79, %or.cond105
  br i1 %80, label %81, label %393

; <label>:81                                      ; preds = %65
  %82 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 600
  %83 = bitcast i8* %82 to i32*
  %84 = load i32, i32* %83, align 8
  %85 = bitcast i8* %82 to i64*
  %86 = load i64, i64* %85, align 8
  %87 = trunc i64 %86 to i32
  %88 = lshr i32 %87, 16
  %89 = trunc i32 %88 to i8
  %90 = and i64 %86, 65535
  %91 = icmp eq i64 %90, 28525
  %92 = icmp eq i8 %89, 100
  %or.cond116 = and i1 %91, %92
  %.mask16 = and i32 %84, -16777216
  %93 = icmp eq i32 %.mask16, 1694498816
  %or.cond118 = and i1 %or.cond116, %93
  %94 = and i64 %86, -4294967296
  %95 = icmp eq i64 %94, 7741533217936637952
  %96 = and i1 %95, %or.cond118
  br i1 %96, label %97, label %393

; <label>:97                                      ; preds = %81
  %98 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 608
  %99 = bitcast i8* %98 to i32*
  %100 = load i32, i32* %99, align 8
  %101 = and i32 %100, 16777215
  %102 = icmp eq i32 %101, 7693936
  br i1 %102, label %103, label %393

; <label>:103                                     ; preds = %97
  %104 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 662
  %105 = bitcast i8* %104 to i16*
  %106 = load i16, i16* %105, align 2
  %107 = icmp eq i16 %106, 29561
  br i1 %107, label %108, label %393

; <label>:108                                     ; preds = %103
  %109 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 664
  %110 = bitcast i8* %109 to i32*
  %111 = load i32, i32* %110, align 8
  %112 = bitcast i8* %109 to i64*
  %113 = load i64, i64* %112, align 8
  %114 = trunc i64 %113 to i32
  %115 = lshr i32 %114, 16
  %116 = trunc i32 %115 to i8
  %117 = and i64 %113, 65535
  %118 = icmp eq i64 %117, 29540
  %119 = icmp eq i8 %116, 113
  %or.cond135 = and i1 %118, %119
  %.mask21 = and i32 %111, -16777216
  %120 = icmp eq i32 %.mask21, 1660944384
  %or.cond137 = and i1 %or.cond135, %120
  %121 = and i64 %113, -4294967296
  %122 = icmp eq i64 %121, 7885090906372571136
  %123 = and i1 %122, %or.cond137
  br i1 %123, label %124, label %393

; <label>:124                                     ; preds = %108
  %125 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 672
  %126 = bitcast i8* %125 to i16*
  %127 = load i16, i16* %126, align 8
  %128 = icmp eq i16 %127, 24953
  br i1 %128, label %129, label %393

; <label>:129                                     ; preds = %124
  %130 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 796
  %131 = bitcast i8* %130 to i32*
  %132 = load i32, i32* %131, align 4
  %133 = icmp eq i32 %132, 1886348147
  br i1 %133, label %134, label %393

; <label>:134                                     ; preds = %129
  %135 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 800
  %136 = bitcast i8* %135 to i32*
  %137 = load i32, i32* %136, align 8
  %138 = bitcast i8* %135 to i64*
  %139 = load i64, i64* %138, align 8
  %140 = trunc i64 %139 to i32
  %141 = lshr i32 %140, 16
  %142 = trunc i32 %141 to i8
  %143 = and i64 %139, 65535
  %144 = icmp eq i64 %143, 25194
  %145 = icmp eq i8 %142, 105
  %or.cond156 = and i1 %144, %145
  %.mask27 = and i32 %137, -16777216
  %146 = icmp eq i32 %.mask27, 1694498816
  %or.cond158 = and i1 %or.cond156, %146
  %147 = and i64 %139, -4294967296
  %148 = icmp eq i64 %147, 8825473489025630208
  %149 = and i1 %148, %or.cond158
  br i1 %149, label %150, label %393

; <label>:150                                     ; preds = %134
  %151 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 808
  %152 = bitcast i8* %151 to i32*
  %153 = load i32, i32* %152, align 8
  %154 = and i32 %153, 16777215
  %155 = icmp eq i32 %154, 7827062
  br i1 %155, label %156, label %393

; <label>:156                                     ; preds = %150
  %157 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 107
  %158 = load i8, i8* %157, align 1
  %159 = icmp eq i8 %158, 100
  br i1 %159, label %160, label %393

; <label>:160                                     ; preds = %156
  %161 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 108
  %162 = bitcast i8* %161 to i32*
  %163 = load i32, i32* %162, align 4
  %164 = icmp eq i32 %163, 2053467496
  br i1 %164, label %165, label %393

; <label>:165                                     ; preds = %160
  %166 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 112
  %167 = bitcast i8* %166 to i32*
  %168 = load i32, i32* %167, align 8
  %169 = and i32 %168, 16777215
  %170 = icmp eq i32 %169, 7436917
  br i1 %170, label %171, label %393

; <label>:171                                     ; preds = %165
  %172 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 305
  %173 = load i8, i8* %172, align 1
  %174 = icmp eq i8 %173, 109
  br i1 %174, label %175, label %393

; <label>:175                                     ; preds = %171
  %176 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 306
  %177 = bitcast i8* %176 to i16*
  %178 = load i16, i16* %177, align 2
  %179 = icmp eq i16 %178, 28269
  br i1 %179, label %180, label %393

; <label>:180                                     ; preds = %175
  %181 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 308
  %182 = bitcast i8* %181 to i32*
  %183 = load i32, i32* %182, align 4
  %184 = icmp eq i32 %183, 1701608042
  br i1 %184, label %185, label %393

; <label>:185                                     ; preds = %180
  %186 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 511
  %187 = load i8, i8* %186, align 1
  %188 = icmp eq i8 %187, 117
  br i1 %188, label %189, label %393

; <label>:189                                     ; preds = %185
  %190 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 512
  %191 = bitcast i8* %190 to i32*
  %192 = load i32, i32* %191, align 8
  %193 = bitcast i8* %190 to i64*
  %194 = load i64, i64* %193, align 8
  %195 = trunc i64 %194 to i32
  %196 = lshr i32 %195, 16
  %197 = trunc i32 %196 to i8
  %198 = and i64 %194, 65535
  %199 = icmp eq i64 %198, 25190
  %200 = icmp eq i8 %197, 119
  %or.cond191 = and i1 %199, %200
  %.mask37 = and i32 %192, -16777216
  %201 = icmp eq i32 %.mask37, 1811939328
  %or.cond193 = and i1 %or.cond191, %201
  %202 = and i64 %194, -4294967296
  %203 = icmp eq i64 %202, 8604818049545011200
  %204 = and i1 %203, %or.cond193
  br i1 %204, label %205, label %393

; <label>:205                                     ; preds = %189
  %206 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 520
  %207 = bitcast i8* %206 to i32*
  %208 = load i32, i32* %207, align 8
  %209 = bitcast i8* %206 to i64*
  %210 = load i64, i64* %209, align 8
  %211 = trunc i64 %210 to i32
  %212 = lshr i32 %211, 16
  %213 = trunc i32 %212 to i8
  %214 = and i64 %210, 65535
  %215 = icmp eq i64 %214, 29556
  %216 = icmp eq i8 %213, 112
  %or.cond204 = and i1 %215, %216
  %.mask40 = and i32 %208, -16777216
  %217 = icmp eq i32 %.mask40, 1996488704
  %or.cond206 = and i1 %or.cond204, %217
  %218 = and i64 %210, -4294967296
  %219 = icmp eq i64 %218, 8099834301895409664
  %220 = and i1 %219, %or.cond206
  br i1 %220, label %221, label %393

; <label>:221                                     ; preds = %205
  %222 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 528
  %223 = bitcast i8* %222 to i32*
  %224 = load i32, i32* %223, align 8
  %225 = icmp eq i32 %224, 1952544631
  br i1 %225, label %226, label %393

; <label>:226                                     ; preds = %221
  %227 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 645
  %228 = load i8, i8* %227, align 1
  %229 = icmp eq i8 %228, 121
  br i1 %229, label %230, label %393

; <label>:230                                     ; preds = %226
  %231 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 646
  %232 = bitcast i8* %231 to i16*
  %233 = load i16, i16* %232, align 2
  %234 = icmp eq i16 %233, 30823
  br i1 %234, label %235, label %393

; <label>:235                                     ; preds = %230
  %236 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 648
  %237 = bitcast i8* %236 to i32*
  %238 = load i32, i32* %237, align 8
  %239 = bitcast i8* %236 to i64*
  %240 = load i64, i64* %239, align 8
  %241 = trunc i64 %240 to i32
  %242 = lshr i32 %241, 16
  %243 = trunc i32 %242 to i8
  %244 = and i64 %240, 65535
  %245 = icmp eq i64 %244, 25464
  %246 = icmp eq i8 %243, 100
  %or.cond225 = and i1 %245, %246
  %.mask46 = and i32 %238, -16777216
  %247 = icmp eq i32 %.mask46, 2046820352
  %or.cond227 = and i1 %or.cond225, %247
  %248 = and i64 %240, -4294967296
  %249 = icmp eq i64 %248, 7599655463008862208
  %250 = and i1 %249, %or.cond227
  br i1 %250, label %251, label %393

; <label>:251                                     ; preds = %235
  %252 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 656
  %253 = bitcast i8* %252 to i32*
  %254 = load i32, i32* %253, align 8
  %255 = bitcast i8* %252 to i64*
  %256 = load i64, i64* %255, align 8
  %257 = trunc i64 %256 to i32
  %258 = lshr i32 %257, 16
  %259 = trunc i32 %258 to i8
  %260 = and i64 %256, 65535
  %261 = icmp eq i64 %260, 27755
  %262 = icmp eq i8 %259, 104
  %or.cond238 = and i1 %261, %262
  %.mask49 = and i32 %254, -16777216
  %263 = icmp eq i32 %.mask49, 2046820352
  %or.cond240 = and i1 %or.cond238, %263
  %264 = and i64 %256, -4294967296
  %265 = icmp eq i64 %264, 7450214343687274496
  %266 = and i1 %265, %or.cond240
  br i1 %266, label %267, label %393

; <label>:267                                     ; preds = %251
  %268 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 664
  %269 = bitcast i8* %268 to i32*
  %270 = load i32, i32* %269, align 8
  %271 = and i32 %270, 16777215
  %272 = icmp eq i32 %271, 6387834
  br i1 %272, label %273, label %393

; <label>:273                                     ; preds = %267
  %274 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 760
  %275 = bitcast i8* %274 to i32*
  %276 = load i32, i32* %275, align 8
  %277 = bitcast i8* %274 to i64*
  %278 = load i64, i64* %277, align 8
  %279 = trunc i64 %278 to i32
  %280 = lshr i32 %279, 16
  %281 = trunc i32 %280 to i8
  %282 = and i64 %278, 65535
  %283 = icmp eq i64 %282, 29031
  %284 = icmp eq i8 %281, 116
  %or.cond255 = and i1 %283, %284
  %.mask53 = and i32 %276, -16777216
  %285 = icmp eq i32 %.mask53, 1862270976
  %or.cond257 = and i1 %or.cond255, %285
  %286 = and i64 %278, -4294967296
  %287 = icmp eq i64 %286, 7886199239863173120
  %288 = and i1 %287, %or.cond257
  br i1 %288, label %289, label %393

; <label>:289                                     ; preds = %273
  %290 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 768
  %291 = bitcast i8* %290 to i32*
  %292 = load i32, i32* %291, align 8
  %293 = bitcast i8* %290 to i64*
  %294 = load i64, i64* %293, align 8
  %295 = trunc i64 %294 to i32
  %296 = lshr i32 %295, 16
  %297 = trunc i32 %296 to i8
  %298 = and i64 %294, 65535
  %299 = icmp eq i64 %298, 24933
  %300 = icmp eq i8 %297, 106
  %or.cond268 = and i1 %299, %300
  %.mask56 = and i32 %292, -16777216
  %301 = icmp eq i32 %.mask56, 1929379840
  %or.cond270 = and i1 %or.cond268, %301
  %302 = and i64 %294, 1095216660480
  %303 = icmp eq i64 %302, 511101108224
  %or.cond272 = and i1 %or.cond270, %303
  br i1 %or.cond272, label %304, label %393

; <label>:304                                     ; preds = %289
  %305 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 202
  %306 = load i32, i32* %305, align 8
  %307 = icmp eq i32 %306, 97
  br i1 %307, label %308, label %393

; <label>:308                                     ; preds = %304
  %309 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 335
  %310 = load i32, i32* %309, align 4
  %311 = icmp eq i32 %310, 112
  br i1 %311, label %312, label %393

; <label>:312                                     ; preds = %308
  %313 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 381
  %314 = load i32, i32* %313, align 4
  %315 = icmp eq i32 %314, 102
  br i1 %315, label %316, label %393

; <label>:316                                     ; preds = %312
  %317 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 384
  %318 = load i32, i32* %317, align 8
  %319 = icmp eq i32 %318, 97
  br i1 %319, label %320, label %393

; <label>:320                                     ; preds = %316
  %321 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 427
  %322 = load i32, i32* %321, align 4
  %323 = icmp eq i32 %322, 105
  br i1 %323, label %324, label %393

; <label>:324                                     ; preds = %320
  %325 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 559
  %326 = load i32, i32* %325, align 4
  %327 = icmp eq i32 %326, 113
  br i1 %327, label %328, label %393

; <label>:328                                     ; preds = %324
  %329 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 608
  %330 = load i32, i32* %329, align 8
  %331 = icmp eq i32 %330, 106
  br i1 %331, label %332, label %393

; <label>:332                                     ; preds = %328
  %333 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 813
  %334 = load i32, i32* %333, align 4
  %335 = icmp eq i32 %334, 110
  br i1 %335, label %336, label %393

; <label>:336                                     ; preds = %332
  %337 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 40
  %338 = load i32, i32* %337, align 8
  %339 = icmp eq i32 %338, 99
  br i1 %339, label %340, label %393

; <label>:340                                     ; preds = %336
  %341 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 83
  %342 = load i32, i32* %341, align 4
  %343 = icmp eq i32 %342, 117
  br i1 %343, label %344, label %393

; <label>:344                                     ; preds = %340
  %345 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 398
  %346 = load i32, i32* %345, align 8
  %347 = icmp eq i32 %346, 122
  br i1 %347, label %348, label %393

; <label>:348                                     ; preds = %344
  %349 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 534
  %350 = load i32, i32* %349, align 8
  %351 = icmp eq i32 %350, 106
  br i1 %351, label %352, label %393

; <label>:352                                     ; preds = %348
  %353 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 569
  %354 = load i32, i32* %353, align 4
  %355 = icmp eq i32 %354, 122
  br i1 %355, label %356, label %393

; <label>:356                                     ; preds = %352
  %357 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 644
  %358 = load i32, i32* %357, align 8
  %359 = icmp eq i32 %358, 110
  br i1 %359, label %360, label %393

; <label>:360                                     ; preds = %356
  %361 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 784
  %362 = load i32, i32* %361, align 8
  %363 = icmp eq i32 %362, 110
  br i1 %363, label %364, label %393

; <label>:364                                     ; preds = %360
  %365 = call i32 @strcmp(i8* nonnull %130, i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0)) #5
  %366 = icmp eq i32 %365, 0
  br i1 %366, label %367, label %393

; <label>:367                                     ; preds = %364
  %368 = call i32 @strcmp(i8* nonnull %104, i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i64 0, i64 0)) #5
  %369 = icmp eq i32 %368, 0
  br i1 %369, label %370, label %393

; <label>:370                                     ; preds = %367
  %371 = call i32 @strcmp(i8* nonnull %1, i8* nonnull getelementptr inbounds ([27 x i8], [27 x i8]* @.str.5, i64 0, i64 0)) #5
  %372 = icmp eq i32 %371, 0
  br i1 %372, label %373, label %393

; <label>:373                                     ; preds = %370
  %374 = call i32 @strcmp(i8* nonnull %57, i8* nonnull getelementptr inbounds ([25 x i8], [25 x i8]* @.str.8, i64 0, i64 0)) #5
  %375 = icmp eq i32 %374, 0
  br i1 %375, label %376, label %393

; <label>:376                                     ; preds = %373
  %377 = call i32 @strcmp(i8* nonnull %227, i8* nonnull getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0)) #5
  %378 = icmp eq i32 %377, 0
  br i1 %378, label %379, label %393

; <label>:379                                     ; preds = %376
  %380 = call i32 @strcmp(i8* nonnull %274, i8* nonnull getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0)) #5
  %381 = icmp eq i32 %380, 0
  br i1 %381, label %382, label %393

; <label>:382                                     ; preds = %379
  %383 = call i32 @strcmp(i8* nonnull %172, i8* nonnull getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i64 0, i64 0)) #5
  %384 = icmp eq i32 %383, 0
  br i1 %384, label %385, label %393

; <label>:385                                     ; preds = %382
  %386 = call i32 @strcmp(i8* nonnull %157, i8* nonnull getelementptr inbounds ([9 x i8], [9 x i8]* @.str.6, i64 0, i64 0)) #5
  %387 = icmp eq i32 %386, 0
  br i1 %387, label %388, label %393

; <label>:388                                     ; preds = %385
  %389 = call i32 @strcmp(i8* nonnull %186, i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @.str.7, i64 0, i64 0)) #5
  %390 = icmp eq i32 %389, 0
  br i1 %390, label %391, label %393

; <label>:391                                     ; preds = %388
  %392 = tail call i32 (i8*, ...) @printf(i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.9, i64 0, i64 0))
  br label %393

; <label>:393                                     ; preds = %388, %385, %382, %379, %376, %373, %370, %367, %364, %391, %360, %356, %352, %348, %344, %340, %336, %332, %328, %324, %320, %316, %312, %308, %304, %289, %273, %267, %251, %235, %230, %226, %221, %205, %189, %185, %180, %175, %171, %165, %160, %156, %150, %134, %129, %124, %108, %103, %97, %81, %65, %60, %56, %41, %25, %9, %4, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #3

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #4

; Function Attrs: nounwind uwtable
define i32 @main() #2 {
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.9, i64 0, i64 0)) #6
  ret i32 0
}

; Function Attrs: norecurse nounwind uwtable
define void @initialize_clone(%struct.HighType* %obj) #0 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 569
  store i32 122, i32* %1, align 4
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 335
  store i32 112, i32* %2, align 4
  %3 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 534
  store i32 106, i32* %3, align 4
  %4 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 645
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %4, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), i64 22, i32 1, i1 false)
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 760
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i64 13, i32 1, i1 false)
  %6 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 559
  store i32 113, i32* %6, align 4
  %7 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 608
  store i32 106, i32* %7, align 4
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 381
  store i32 102, i32* %8, align 4
  %9 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 398
  store i32 122, i32* %9, align 4
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 813
  store i32 110, i32* %10, align 4
  %11 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 305
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %11, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i64 0, i64 0), i64 7, i32 1, i1 false)
  %12 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 796
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0), i64 15, i32 1, i1 false)
  %13 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 662
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i64 0, i64 0), i64 12, i32 1, i1 false)
  %14 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 75
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %14, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.5, i64 0, i64 0), i64 26, i32 1, i1 false)
  %15 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 202
  store i32 97, i32* %15, align 4
  %16 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 40
  store i32 99, i32* %16, align 4
  %17 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 107
  %18 = bitcast i8* %17 to i64*
  store i64 8176977241992685668, i64* %18, align 1
  %19 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 511
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %19, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.7, i64 0, i64 0), i64 21, i32 1, i1 false)
  %20 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 587
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %20, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.8, i64 0, i64 0), i64 24, i32 1, i1 false)
  %21 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 427
  store i32 105, i32* %21, align 4
  %22 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 83
  store i32 117, i32* %22, align 4
  %23 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 644
  store i32 110, i32* %23, align 4
  %24 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 384
  store i32 97, i32* %24, align 4
  %25 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 784
  store i32 110, i32* %25, align 4
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.HighType* byval nocapture readnone align 8 %obj) #2 {
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.9, i64 0, i64 0))
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define void @initialize_clone.1(%struct.HighType* %obj) #0 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 569
  store i32 122, i32* %1, align 4
  %2 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 335
  store i32 112, i32* %2, align 4
  %3 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 534
  store i32 106, i32* %3, align 4
  %4 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 645
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %4, i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0), i64 22, i32 1, i1 false)
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 760
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0), i64 13, i32 1, i1 false)
  %6 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 559
  store i32 113, i32* %6, align 4
  %7 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 608
  store i32 106, i32* %7, align 4
  %8 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 381
  store i32 102, i32* %8, align 4
  %9 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 398
  store i32 122, i32* %9, align 4
  %10 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 813
  store i32 110, i32* %10, align 4
  %11 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 305
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %11, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i64 0, i64 0), i64 7, i32 1, i1 false)
  %12 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 796
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %12, i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i64 0, i64 0), i64 15, i32 1, i1 false)
  %13 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 662
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %13, i8* getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i64 0, i64 0), i64 12, i32 1, i1 false)
  %14 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 75
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %14, i8* getelementptr inbounds ([27 x i8], [27 x i8]* @.str.5, i64 0, i64 0), i64 26, i32 1, i1 false)
  %15 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 202
  store i32 97, i32* %15, align 4
  %16 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 40
  store i32 99, i32* %16, align 4
  %17 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 107
  %18 = bitcast i8* %17 to i64*
  store i64 8176977241992685668, i64* %18, align 1
  %19 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 511
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %19, i8* getelementptr inbounds ([22 x i8], [22 x i8]* @.str.7, i64 0, i64 0), i64 21, i32 1, i1 false)
  %20 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 587
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %20, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.8, i64 0, i64 0), i64 24, i32 1, i1 false)
  %21 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 427
  store i32 105, i32* %21, align 4
  %22 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 83
  store i32 117, i32* %22, align 4
  %23 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 644
  store i32 110, i32* %23, align 4
  %24 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 384
  store i32 97, i32* %24, align 4
  %25 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 784
  store i32 110, i32* %25, align 4
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone_clone(%struct.HighType* byval nocapture readnone align 8 %obj) #2 {
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.9, i64 0, i64 0))
  ret void
}

attributes #0 = { norecurse nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind }
attributes #2 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)"}
