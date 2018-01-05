; ModuleID = 'workdir/out10.bc'
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
@.str.9 = private unnamed_addr constant [24 x i8] c"swdwtkybghtdbrwzepsotsd\00", align 1
@.str.10 = private unnamed_addr constant [34 x i8] c"swdwtkybghtdbrwzepsotsdbieaazzvnw\00", align 1
@.str.11 = private unnamed_addr constant [16 x i8] c"*** branchTaken\00", align 1

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
  %26 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 778
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %26, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.9, i64 0, i64 0), i64 23, i32 1, i1 false)
  ret void
}

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind uwtable
define void @branchPruned(%struct.HighType* byval readonly align 8 %obj) #2 {
  %1 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 75
  %2 = load i8, i8* %1, align 1
  %3 = icmp eq i8 %2, 97
  br i1 %3, label %4, label %430

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 76
  %6 = bitcast i8* %5 to i32*
  %7 = load i32, i32* %6, align 4
  %8 = icmp eq i32 %7, 1970431605
  br i1 %8, label %9, label %430

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
  %or.cond71 = and i1 %19, %20
  %.mask3 = and i32 %12, -16777216
  %21 = icmp eq i32 %.mask3, 2030043136
  %or.cond73 = and i1 %or.cond71, %21
  %22 = and i64 %14, -4294967296
  %23 = icmp eq i64 %22, 7020392094220943360
  %24 = and i1 %23, %or.cond73
  br i1 %24, label %25, label %430

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
  %or.cond84 = and i1 %35, %36
  %.mask6 = and i32 %28, -16777216
  %37 = icmp eq i32 %.mask6, 1728053248
  %or.cond86 = and i1 %or.cond84, %37
  %38 = and i64 %30, -4294967296
  %39 = icmp eq i64 %38, 7882549930705813504
  %40 = and i1 %39, %or.cond86
  br i1 %40, label %41, label %430

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
  %or.cond97 = and i1 %51, %52
  %.mask9 = and i32 %44, -16777216
  %53 = icmp eq i32 %.mask9, 1979711488
  %or.cond99 = and i1 %or.cond97, %53
  %54 = and i64 %46, 1095216660480
  %55 = icmp eq i64 %54, 433791696896
  %or.cond101 = and i1 %or.cond99, %55
  br i1 %or.cond101, label %56, label %430

; <label>:56                                      ; preds = %41
  %57 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 587
  %58 = load i8, i8* %57, align 1
  %59 = icmp eq i8 %58, 116
  br i1 %59, label %60, label %430

; <label>:60                                      ; preds = %56
  %61 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 588
  %62 = bitcast i8* %61 to i32*
  %63 = load i32, i32* %62, align 4
  %64 = icmp eq i32 %63, 1801610342
  br i1 %64, label %65, label %430

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
  %or.cond110 = and i1 %75, %76
  %.mask13 = and i32 %68, -16777216
  %77 = icmp eq i32 %.mask13, 1929379840
  %or.cond112 = and i1 %or.cond110, %77
  %78 = and i64 %70, -4294967296
  %79 = icmp eq i64 %78, 7094138602543644672
  %80 = and i1 %79, %or.cond112
  br i1 %80, label %81, label %430

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
  %or.cond123 = and i1 %91, %92
  %.mask16 = and i32 %84, -16777216
  %93 = icmp eq i32 %.mask16, 1694498816
  %or.cond125 = and i1 %or.cond123, %93
  %94 = and i64 %86, -4294967296
  %95 = icmp eq i64 %94, 7741533217936637952
  %96 = and i1 %95, %or.cond125
  br i1 %96, label %97, label %430

; <label>:97                                      ; preds = %81
  %98 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 608
  %99 = bitcast i8* %98 to i32*
  %100 = load i32, i32* %99, align 8
  %101 = and i32 %100, 16777215
  %102 = icmp eq i32 %101, 7693936
  br i1 %102, label %103, label %430

; <label>:103                                     ; preds = %97
  %104 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 662
  %105 = bitcast i8* %104 to i16*
  %106 = load i16, i16* %105, align 2
  %107 = icmp eq i16 %106, 29561
  br i1 %107, label %108, label %430

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
  %or.cond142 = and i1 %118, %119
  %.mask21 = and i32 %111, -16777216
  %120 = icmp eq i32 %.mask21, 1660944384
  %or.cond144 = and i1 %or.cond142, %120
  %121 = and i64 %113, -4294967296
  %122 = icmp eq i64 %121, 7885090906372571136
  %123 = and i1 %122, %or.cond144
  br i1 %123, label %124, label %430

; <label>:124                                     ; preds = %108
  %125 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 672
  %126 = bitcast i8* %125 to i16*
  %127 = load i16, i16* %126, align 8
  %128 = icmp eq i16 %127, 24953
  br i1 %128, label %129, label %430

; <label>:129                                     ; preds = %124
  %130 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 778
  %131 = bitcast i8* %130 to i16*
  %132 = load i16, i16* %131, align 2
  %133 = icmp eq i16 %132, 30579
  br i1 %133, label %134, label %430

; <label>:134                                     ; preds = %129
  %135 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 780
  %136 = bitcast i8* %135 to i32*
  %137 = load i32, i32* %136, align 4
  %138 = icmp eq i32 %137, 1802794852
  br i1 %138, label %139, label %430

; <label>:139                                     ; preds = %134
  %140 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 784
  %141 = bitcast i8* %140 to i32*
  %142 = load i32, i32* %141, align 8
  %143 = bitcast i8* %140 to i64*
  %144 = load i64, i64* %143, align 8
  %145 = trunc i64 %144 to i32
  %146 = lshr i32 %145, 16
  %147 = trunc i32 %146 to i8
  %148 = and i64 %144, 65535
  %149 = icmp eq i64 %148, 25209
  %150 = icmp eq i8 %147, 103
  %or.cond165 = and i1 %149, %150
  %.mask28 = and i32 %142, -16777216
  %151 = icmp eq i32 %.mask28, 1744830464
  %or.cond167 = and i1 %or.cond165, %151
  %152 = and i64 %144, -4294967296
  %153 = icmp eq i64 %152, 8242260717420412928
  %154 = and i1 %153, %or.cond167
  br i1 %154, label %155, label %430

; <label>:155                                     ; preds = %139
  %156 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 792
  %157 = bitcast i8* %156 to i32*
  %158 = load i32, i32* %157, align 8
  %159 = bitcast i8* %156 to i64*
  %160 = load i64, i64* %159, align 8
  %161 = trunc i64 %160 to i32
  %162 = lshr i32 %161, 16
  %163 = trunc i32 %162 to i8
  %164 = and i64 %160, 65535
  %165 = icmp eq i64 %164, 31351
  %166 = icmp eq i8 %163, 101
  %or.cond178 = and i1 %165, %166
  %.mask31 = and i32 %158, -16777216
  %167 = icmp eq i32 %.mask31, 1879048192
  %or.cond180 = and i1 %or.cond178, %167
  %168 = and i64 %160, -4294967296
  %169 = icmp eq i64 %168, 8319396951372070912
  %170 = and i1 %169, %or.cond180
  br i1 %170, label %171, label %430

; <label>:171                                     ; preds = %155
  %172 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 800
  %173 = bitcast i8* %172 to i32*
  %174 = load i32, i32* %173, align 8
  %175 = bitcast i8* %172 to i64*
  %176 = load i64, i64* %175, align 8
  %177 = trunc i64 %176 to i32
  %178 = lshr i32 %177, 16
  %179 = trunc i32 %178 to i8
  %180 = and i64 %176, 65535
  %181 = icmp eq i64 %180, 25188
  %182 = icmp eq i8 %179, 105
  %or.cond191 = and i1 %181, %182
  %.mask34 = and i32 %174, -16777216
  %183 = icmp eq i32 %.mask34, 1694498816
  %or.cond193 = and i1 %or.cond191, %183
  %184 = and i64 %176, -4294967296
  %185 = icmp eq i64 %184, 8825473489025630208
  %186 = and i1 %185, %or.cond193
  br i1 %186, label %187, label %430

; <label>:187                                     ; preds = %171
  %188 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 808
  %189 = bitcast i8* %188 to i32*
  %190 = load i32, i32* %189, align 8
  %191 = and i32 %190, 16777215
  %192 = icmp eq i32 %191, 7827062
  br i1 %192, label %193, label %430

; <label>:193                                     ; preds = %187
  %194 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 107
  %195 = load i8, i8* %194, align 1
  %196 = icmp eq i8 %195, 100
  br i1 %196, label %197, label %430

; <label>:197                                     ; preds = %193
  %198 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 108
  %199 = bitcast i8* %198 to i32*
  %200 = load i32, i32* %199, align 4
  %201 = icmp eq i32 %200, 2053467496
  br i1 %201, label %202, label %430

; <label>:202                                     ; preds = %197
  %203 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 112
  %204 = bitcast i8* %203 to i32*
  %205 = load i32, i32* %204, align 8
  %206 = and i32 %205, 16777215
  %207 = icmp eq i32 %206, 7436917
  br i1 %207, label %208, label %430

; <label>:208                                     ; preds = %202
  %209 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 305
  %210 = load i8, i8* %209, align 1
  %211 = icmp eq i8 %210, 109
  br i1 %211, label %212, label %430

; <label>:212                                     ; preds = %208
  %213 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 306
  %214 = bitcast i8* %213 to i16*
  %215 = load i16, i16* %214, align 2
  %216 = icmp eq i16 %215, 28269
  br i1 %216, label %217, label %430

; <label>:217                                     ; preds = %212
  %218 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 308
  %219 = bitcast i8* %218 to i32*
  %220 = load i32, i32* %219, align 4
  %221 = icmp eq i32 %220, 1701608042
  br i1 %221, label %222, label %430

; <label>:222                                     ; preds = %217
  %223 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 511
  %224 = load i8, i8* %223, align 1
  %225 = icmp eq i8 %224, 117
  br i1 %225, label %226, label %430

; <label>:226                                     ; preds = %222
  %227 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 512
  %228 = bitcast i8* %227 to i32*
  %229 = load i32, i32* %228, align 8
  %230 = bitcast i8* %227 to i64*
  %231 = load i64, i64* %230, align 8
  %232 = trunc i64 %231 to i32
  %233 = lshr i32 %232, 16
  %234 = trunc i32 %233 to i8
  %235 = and i64 %231, 65535
  %236 = icmp eq i64 %235, 25190
  %237 = icmp eq i8 %234, 119
  %or.cond226 = and i1 %236, %237
  %.mask44 = and i32 %229, -16777216
  %238 = icmp eq i32 %.mask44, 1811939328
  %or.cond228 = and i1 %or.cond226, %238
  %239 = and i64 %231, -4294967296
  %240 = icmp eq i64 %239, 8604818049545011200
  %241 = and i1 %240, %or.cond228
  br i1 %241, label %242, label %430

; <label>:242                                     ; preds = %226
  %243 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 520
  %244 = bitcast i8* %243 to i32*
  %245 = load i32, i32* %244, align 8
  %246 = bitcast i8* %243 to i64*
  %247 = load i64, i64* %246, align 8
  %248 = trunc i64 %247 to i32
  %249 = lshr i32 %248, 16
  %250 = trunc i32 %249 to i8
  %251 = and i64 %247, 65535
  %252 = icmp eq i64 %251, 29556
  %253 = icmp eq i8 %250, 112
  %or.cond239 = and i1 %252, %253
  %.mask47 = and i32 %245, -16777216
  %254 = icmp eq i32 %.mask47, 1996488704
  %or.cond241 = and i1 %or.cond239, %254
  %255 = and i64 %247, -4294967296
  %256 = icmp eq i64 %255, 8099834301895409664
  %257 = and i1 %256, %or.cond241
  br i1 %257, label %258, label %430

; <label>:258                                     ; preds = %242
  %259 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 528
  %260 = bitcast i8* %259 to i32*
  %261 = load i32, i32* %260, align 8
  %262 = icmp eq i32 %261, 1952544631
  br i1 %262, label %263, label %430

; <label>:263                                     ; preds = %258
  %264 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 645
  %265 = load i8, i8* %264, align 1
  %266 = icmp eq i8 %265, 121
  br i1 %266, label %267, label %430

; <label>:267                                     ; preds = %263
  %268 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 646
  %269 = bitcast i8* %268 to i16*
  %270 = load i16, i16* %269, align 2
  %271 = icmp eq i16 %270, 30823
  br i1 %271, label %272, label %430

; <label>:272                                     ; preds = %267
  %273 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 648
  %274 = bitcast i8* %273 to i32*
  %275 = load i32, i32* %274, align 8
  %276 = bitcast i8* %273 to i64*
  %277 = load i64, i64* %276, align 8
  %278 = trunc i64 %277 to i32
  %279 = lshr i32 %278, 16
  %280 = trunc i32 %279 to i8
  %281 = and i64 %277, 65535
  %282 = icmp eq i64 %281, 25464
  %283 = icmp eq i8 %280, 100
  %or.cond260 = and i1 %282, %283
  %.mask53 = and i32 %275, -16777216
  %284 = icmp eq i32 %.mask53, 2046820352
  %or.cond262 = and i1 %or.cond260, %284
  %285 = and i64 %277, -4294967296
  %286 = icmp eq i64 %285, 7599655463008862208
  %287 = and i1 %286, %or.cond262
  br i1 %287, label %288, label %430

; <label>:288                                     ; preds = %272
  %289 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 656
  %290 = bitcast i8* %289 to i32*
  %291 = load i32, i32* %290, align 8
  %292 = bitcast i8* %289 to i64*
  %293 = load i64, i64* %292, align 8
  %294 = trunc i64 %293 to i32
  %295 = lshr i32 %294, 16
  %296 = trunc i32 %295 to i8
  %297 = and i64 %293, 65535
  %298 = icmp eq i64 %297, 27755
  %299 = icmp eq i8 %296, 104
  %or.cond273 = and i1 %298, %299
  %.mask56 = and i32 %291, -16777216
  %300 = icmp eq i32 %.mask56, 2046820352
  %or.cond275 = and i1 %or.cond273, %300
  %301 = and i64 %293, -4294967296
  %302 = icmp eq i64 %301, 7450214343687274496
  %303 = and i1 %302, %or.cond275
  br i1 %303, label %304, label %430

; <label>:304                                     ; preds = %288
  %305 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 664
  %306 = bitcast i8* %305 to i32*
  %307 = load i32, i32* %306, align 8
  %308 = and i32 %307, 16777215
  %309 = icmp eq i32 %308, 6387834
  br i1 %309, label %310, label %430

; <label>:310                                     ; preds = %304
  %311 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 760
  %312 = bitcast i8* %311 to i32*
  %313 = load i32, i32* %312, align 8
  %314 = bitcast i8* %311 to i64*
  %315 = load i64, i64* %314, align 8
  %316 = trunc i64 %315 to i32
  %317 = lshr i32 %316, 16
  %318 = trunc i32 %317 to i8
  %319 = and i64 %315, 65535
  %320 = icmp eq i64 %319, 29031
  %321 = icmp eq i8 %318, 116
  %or.cond290 = and i1 %320, %321
  %.mask60 = and i32 %313, -16777216
  %322 = icmp eq i32 %.mask60, 1862270976
  %or.cond292 = and i1 %or.cond290, %322
  %323 = and i64 %315, -4294967296
  %324 = icmp eq i64 %323, 7886199239863173120
  %325 = and i1 %324, %or.cond292
  br i1 %325, label %326, label %430

; <label>:326                                     ; preds = %310
  %327 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 0, i64 768
  %328 = bitcast i8* %327 to i32*
  %329 = load i32, i32* %328, align 8
  %330 = bitcast i8* %327 to i64*
  %331 = load i64, i64* %330, align 8
  %332 = trunc i64 %331 to i32
  %333 = lshr i32 %332, 16
  %334 = trunc i32 %333 to i8
  %335 = and i64 %331, 65535
  %336 = icmp eq i64 %335, 24933
  %337 = icmp eq i8 %334, 106
  %or.cond303 = and i1 %336, %337
  %.mask63 = and i32 %329, -16777216
  %338 = icmp eq i32 %.mask63, 1929379840
  %or.cond305 = and i1 %or.cond303, %338
  %339 = and i64 %331, 1095216660480
  %340 = icmp eq i64 %339, 511101108224
  %or.cond307 = and i1 %or.cond305, %340
  br i1 %or.cond307, label %341, label %430

; <label>:341                                     ; preds = %326
  %342 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 202
  %343 = load i32, i32* %342, align 8
  %344 = icmp eq i32 %343, 97
  br i1 %344, label %345, label %430

; <label>:345                                     ; preds = %341
  %346 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 335
  %347 = load i32, i32* %346, align 4
  %348 = icmp eq i32 %347, 112
  br i1 %348, label %349, label %430

; <label>:349                                     ; preds = %345
  %350 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 381
  %351 = load i32, i32* %350, align 4
  %352 = icmp eq i32 %351, 102
  br i1 %352, label %353, label %430

; <label>:353                                     ; preds = %349
  %354 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 384
  %355 = load i32, i32* %354, align 8
  %356 = icmp eq i32 %355, 97
  br i1 %356, label %357, label %430

; <label>:357                                     ; preds = %353
  %358 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 427
  %359 = load i32, i32* %358, align 4
  %360 = icmp eq i32 %359, 105
  br i1 %360, label %361, label %430

; <label>:361                                     ; preds = %357
  %362 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 559
  %363 = load i32, i32* %362, align 4
  %364 = icmp eq i32 %363, 113
  br i1 %364, label %365, label %430

; <label>:365                                     ; preds = %361
  %366 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 608
  %367 = load i32, i32* %366, align 8
  %368 = icmp eq i32 %367, 106
  br i1 %368, label %369, label %430

; <label>:369                                     ; preds = %365
  %370 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 1, i64 813
  %371 = load i32, i32* %370, align 4
  %372 = icmp eq i32 %371, 110
  br i1 %372, label %373, label %430

; <label>:373                                     ; preds = %369
  %374 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 40
  %375 = load i32, i32* %374, align 8
  %376 = icmp eq i32 %375, 99
  br i1 %376, label %377, label %430

; <label>:377                                     ; preds = %373
  %378 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 83
  %379 = load i32, i32* %378, align 4
  %380 = icmp eq i32 %379, 117
  br i1 %380, label %381, label %430

; <label>:381                                     ; preds = %377
  %382 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 398
  %383 = load i32, i32* %382, align 8
  %384 = icmp eq i32 %383, 122
  br i1 %384, label %385, label %430

; <label>:385                                     ; preds = %381
  %386 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 534
  %387 = load i32, i32* %386, align 8
  %388 = icmp eq i32 %387, 106
  br i1 %388, label %389, label %430

; <label>:389                                     ; preds = %385
  %390 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 569
  %391 = load i32, i32* %390, align 4
  %392 = icmp eq i32 %391, 122
  br i1 %392, label %393, label %430

; <label>:393                                     ; preds = %389
  %394 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 644
  %395 = load i32, i32* %394, align 8
  %396 = icmp eq i32 %395, 110
  br i1 %396, label %397, label %430

; <label>:397                                     ; preds = %393
  %398 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 1, i32 0, i64 784
  %399 = load i32, i32* %398, align 8
  %400 = icmp eq i32 %399, 110
  br i1 %400, label %401, label %430

; <label>:401                                     ; preds = %397
  %402 = call i32 @strcmp(i8* nonnull %104, i8* nonnull getelementptr inbounds ([13 x i8], [13 x i8]* @.str.4, i64 0, i64 0)) #5
  %403 = icmp eq i32 %402, 0
  br i1 %403, label %404, label %430

; <label>:404                                     ; preds = %401
  %405 = call i32 @strcmp(i8* nonnull %1, i8* nonnull getelementptr inbounds ([27 x i8], [27 x i8]* @.str.5, i64 0, i64 0)) #5
  %406 = icmp eq i32 %405, 0
  br i1 %406, label %407, label %430

; <label>:407                                     ; preds = %404
  %408 = call i32 @strcmp(i8* nonnull %57, i8* nonnull getelementptr inbounds ([25 x i8], [25 x i8]* @.str.8, i64 0, i64 0)) #5
  %409 = icmp eq i32 %408, 0
  br i1 %409, label %410, label %430

; <label>:410                                     ; preds = %407
  %411 = call i32 @strcmp(i8* nonnull %130, i8* nonnull getelementptr inbounds ([34 x i8], [34 x i8]* @.str.10, i64 0, i64 0)) #5
  %412 = icmp eq i32 %411, 0
  br i1 %412, label %413, label %430

; <label>:413                                     ; preds = %410
  %414 = call i32 @strcmp(i8* nonnull %264, i8* nonnull getelementptr inbounds ([23 x i8], [23 x i8]* @.str, i64 0, i64 0)) #5
  %415 = icmp eq i32 %414, 0
  br i1 %415, label %416, label %430

; <label>:416                                     ; preds = %413
  %417 = call i32 @strcmp(i8* nonnull %311, i8* nonnull getelementptr inbounds ([14 x i8], [14 x i8]* @.str.1, i64 0, i64 0)) #5
  %418 = icmp eq i32 %417, 0
  br i1 %418, label %419, label %430

; <label>:419                                     ; preds = %416
  %420 = call i32 @strcmp(i8* nonnull %209, i8* nonnull getelementptr inbounds ([8 x i8], [8 x i8]* @.str.2, i64 0, i64 0)) #5
  %421 = icmp eq i32 %420, 0
  br i1 %421, label %422, label %430

; <label>:422                                     ; preds = %419
  %423 = call i32 @strcmp(i8* nonnull %194, i8* nonnull getelementptr inbounds ([9 x i8], [9 x i8]* @.str.6, i64 0, i64 0)) #5
  %424 = icmp eq i32 %423, 0
  br i1 %424, label %425, label %430

; <label>:425                                     ; preds = %422
  %426 = call i32 @strcmp(i8* nonnull %223, i8* nonnull getelementptr inbounds ([22 x i8], [22 x i8]* @.str.7, i64 0, i64 0)) #5
  %427 = icmp eq i32 %426, 0
  br i1 %427, label %428, label %430

; <label>:428                                     ; preds = %425
  %429 = tail call i32 (i8*, ...) @printf(i8* nonnull getelementptr inbounds ([16 x i8], [16 x i8]* @.str.11, i64 0, i64 0))
  br label %430

; <label>:430                                     ; preds = %425, %422, %419, %416, %413, %410, %407, %404, %401, %428, %397, %393, %389, %385, %381, %377, %373, %369, %365, %361, %357, %353, %349, %345, %341, %326, %310, %304, %288, %272, %267, %263, %258, %242, %226, %222, %217, %212, %208, %202, %197, %193, %187, %171, %155, %139, %134, %129, %124, %108, %103, %97, %81, %65, %60, %56, %41, %25, %9, %4, %0
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8* nocapture, i8* nocapture) #3

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #4

; Function Attrs: nounwind uwtable
define i32 @main() #2 {
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.11, i64 0, i64 0)) #6
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
  %26 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 778
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %26, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.9, i64 0, i64 0), i64 23, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone(%struct.HighType* byval nocapture readnone align 8 %obj) #2 {
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.11, i64 0, i64 0))
  ret void
}

; Function Attrs: norecurse nounwind uwtable
define void @initialize_clone_clone(%struct.HighType* %obj) #0 {
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
  %26 = getelementptr inbounds %struct.HighType, %struct.HighType* %obj, i64 0, i32 0, i32 1, i64 778
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %26, i8* getelementptr inbounds ([24 x i8], [24 x i8]* @.str.9, i64 0, i64 0), i64 23, i32 1, i1 false)
  ret void
}

; Function Attrs: nounwind uwtable
define void @branchPruned_clone_clone(%struct.HighType* byval nocapture readnone align 8 %obj) #2 {
  %1 = tail call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.11, i64 0, i64 0))
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
