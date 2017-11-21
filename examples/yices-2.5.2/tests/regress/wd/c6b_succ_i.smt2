(set-logic QF_UFIDL)
(set-info :source |
These benchmarks were generated by Panagiotis Manolios and Sudarshan K. Srinivasan.
They were generated from experiments in microprocessor verification based on
refinement.

This benchmark was automatically translated into SMT-LIB format by Albert Oliveras.
|)
(set-info :smt-lib-version 2.0)
(set-info :category "industrial")
(set-info :status unsat)
(declare-fun pc0 () Int)
(declare-fun BPState0 () Int)
(declare-fun dmem0 () Int)
(declare-fun IMem0 (Int) Int)
(declare-fun GetImm (Int) Int)
(declare-fun DMem_Read (Int Int) Int)
(declare-fun PredictTarget (Int) Int)
(declare-fun NextBPState (Int) Int)
(declare-fun NextDMem (Int Int Int) Int)
(declare-fun dest (Int) Int)
(declare-fun alu (Int Int Int) Int)
(declare-fun SelectTargetPC (Int Int Int) Int)
(declare-fun op (Int) Int)
(declare-fun src1 (Int) Int)
(declare-fun rf0 (Int) Int)
(declare-fun src2 (Int) Int)
(declare-fun GetIsBranch (Int) Bool)
(declare-fun PredictDirection (Int) Bool)
(declare-fun GetRegWrite (Int) Bool)
(declare-fun GetMemToReg (Int) Bool)
(declare-fun GetMemWrite (Int) Bool)
(declare-fun GetuseImm (Int) Bool)
(declare-fun TakeBranch (Int Int Int) Bool)
(declare-fun Succ (Int) Int)
(assert (let ((?v_0 (IMem0 pc0))) (let ((?v_21 (GetIsBranch ?v_0))) (let ((?v_8 (and ?v_21 (PredictDirection BPState0))) (?v_23 (PredictTarget BPState0)) (?v_54 (Succ pc0))) (let ((?v_5 (ite ?v_8 ?v_23 ?v_54))) (let ((?v_1 (IMem0 ?v_5))) (let ((?v_173 (GetRegWrite ?v_1)) (?v_14 (GetRegWrite ?v_0)) (?v_26 (src1 ?v_1)) (?v_2 (dest ?v_0)) (?v_27 (src2 ?v_1))) (let ((?v_3 (and ?v_14 (or (= ?v_26 ?v_2) (= ?v_27 ?v_2))))) (let ((?v_9 (not ?v_3)) (?v_28 (GetIsBranch ?v_1)) (?v_4 (NextBPState BPState0))) (let ((?v_10 (and ?v_28 (PredictDirection ?v_4))) (?v_33 (PredictTarget ?v_4)) (?v_63 (Succ ?v_5))) (let ((?v_37 (ite ?v_10 ?v_33 ?v_63))) (let ((?v_12 (IMem0 ?v_37))) (let ((?v_6 (ite ?v_3 ?v_1 ?v_12))) (let ((?v_13 (src1 ?v_6)) (?v_7 (dest ?v_1)) (?v_16 (src2 ?v_6))) (let ((?v_11 (and (and ?v_173 ?v_9) (or (= ?v_13 ?v_7) (= ?v_16 ?v_7)))) (?v_29 (or (and ?v_3 ?v_8) (and ?v_9 ?v_10)))) (let ((?v_24 (not ?v_11)) (?v_44 (NextBPState ?v_4))) (let ((?v_47 (and (GetIsBranch ?v_12) (PredictDirection ?v_44)))) (let ((?v_101 (or (and ?v_3 ?v_10) (and ?v_9 ?v_47)))) (let ((?v_39 (or (and ?v_11 ?v_29) (and ?v_24 ?v_101))) (?v_25 (GetIsBranch ?v_6)) (?v_40 (op ?v_6)) (?v_18 (op ?v_0)) (?v_19 (rf0 (src1 ?v_0))) (?v_20 (rf0 (src2 ?v_0)))) (let ((?v_15 (alu ?v_18 ?v_19 (ite (GetuseImm ?v_0) (GetImm ?v_0) ?v_20)))) (let ((?v_17 (ite (GetMemToReg ?v_0) (DMem_Read dmem0 ?v_15) ?v_15))) (let ((?v_41 (ite (and (= ?v_13 ?v_2) ?v_14) ?v_17 (rf0 ?v_13))) (?v_84 (ite (and (= ?v_16 ?v_2) ?v_14) ?v_17 (rf0 ?v_16))) (?v_22 (and (TakeBranch ?v_18 ?v_19 ?v_20) ?v_21)) (?v_56 (SelectTargetPC ?v_18 ?v_19 pc0))) (let ((?v_55 (or (and ?v_22 (not ?v_8)) (and ?v_22 (not (= ?v_56 ?v_23))))) (?v_53 (and (and ?v_8 ?v_21) (not ?v_22)))) (let ((?v_34 (not (or ?v_55 ?v_53)))) (let ((?v_36 (and ?v_34 ?v_24))) (let ((?v_38 (and (and (TakeBranch ?v_40 ?v_41 ?v_84) ?v_36) ?v_25)) (?v_31 (op ?v_1)) (?v_32 (rf0 ?v_26)) (?v_82 (rf0 ?v_27))) (let ((?v_30 (and (and (TakeBranch ?v_31 ?v_32 ?v_82) ?v_9) ?v_28)) (?v_65 (SelectTargetPC ?v_31 ?v_32 ?v_5)) (?v_43 (ite ?v_3 ?v_23 ?v_33)) (?v_35 (and ?v_34 ?v_9))) (let ((?v_64 (and (or (and ?v_30 (not ?v_29)) (and ?v_30 (not (= ?v_65 ?v_43)))) ?v_35)) (?v_62 (and (and (and ?v_29 ?v_28) (not ?v_30)) ?v_35))) (let ((?v_49 (not (or ?v_64 ?v_62)))) (let ((?v_45 (and ?v_49 ?v_36))) (let ((?v_72 (and (and (and ?v_39 ?v_25) (not ?v_38)) ?v_45)) (?v_42 (ite ?v_3 ?v_5 ?v_37))) (let ((?v_46 (SelectTargetPC ?v_40 ?v_41 ?v_42)) (?v_48 (PredictTarget ?v_44))) (let ((?v_107 (ite ?v_3 ?v_33 ?v_48))) (let ((?v_126 (ite ?v_11 ?v_43 ?v_107))) (let ((?v_71 (and (or (and ?v_38 (not ?v_39)) (and ?v_38 (not (= ?v_46 ?v_126)))) ?v_45)) (?v_57 (ite ?v_3 ?v_37 (ite ?v_47 ?v_48 (Succ ?v_37))))) (let ((?v_58 (IMem0 ?v_57))) (let ((?v_50 (ite ?v_11 ?v_6 ?v_58))) (let ((?v_195 (GetRegWrite ?v_50)) (?v_253 (GetRegWrite ?v_6)) (?v_172 (src1 ?v_50)) (?v_51 (dest ?v_6)) (?v_180 (src2 ?v_50))) (let ((?v_52 (and (and ?v_253 ?v_36) (or (= ?v_172 ?v_51) (= ?v_180 ?v_51))))) (let ((?v_76 (not ?v_52))) (let ((?v_73 (and ?v_49 (and ?v_76 ?v_34))) (?v_59 (ite ?v_3 ?v_44 (NextBPState ?v_44)))) (let ((?v_102 (and (GetIsBranch ?v_58) (PredictDirection ?v_59))) (?v_108 (PredictTarget ?v_59))) (let ((?v_66 (ite ?v_53 ?v_54 (ite ?v_55 ?v_56 (ite ?v_11 ?v_57 (ite ?v_102 ?v_108 (Succ ?v_57))))))) (let ((?v_67 (IMem0 ?v_66))) (let ((?v_60 (ite ?v_52 ?v_50 ?v_67))) (let ((?v_129 (src1 ?v_60)) (?v_61 (dest ?v_50)) (?v_131 (src2 ?v_60))) (let ((?v_75 (and (and ?v_195 ?v_73) (or (= ?v_129 ?v_61) (= ?v_131 ?v_61)))) (?v_68 (ite ?v_11 ?v_59 (NextBPState ?v_59)))) (let ((?v_103 (and (GetIsBranch ?v_67) (PredictDirection ?v_68))) (?v_109 (PredictTarget ?v_68))) (let ((?v_69 (ite ?v_62 ?v_63 (ite ?v_64 ?v_65 (ite ?v_52 ?v_66 (ite ?v_103 ?v_109 (Succ ?v_66))))))) (let ((?v_112 (IMem0 ?v_69)) (?v_70 (ite ?v_52 ?v_68 (NextBPState ?v_68)))) (let ((?v_104 (and (GetIsBranch ?v_112) (PredictDirection ?v_70))) (?v_110 (PredictTarget ?v_70))) (let ((?v_81 (ite ?v_72 (Succ ?v_42) (ite ?v_71 ?v_46 (ite ?v_75 ?v_69 (ite ?v_104 ?v_110 (Succ ?v_69)))))) (?v_74 (not (or ?v_71 ?v_72)))) (let ((?v_90 (and ?v_74 ?v_73)) (?v_77 (ite ?v_11 ?v_42 ?v_57)) (?v_78 (not ?v_75)) (?v_79 (and ?v_49 (or ?v_76 ?v_34)))) (let ((?v_88 (and ?v_74 (and ?v_78 ?v_79))) (?v_80 (ite ?v_52 ?v_77 ?v_66)) (?v_86 (and ?v_74 (or ?v_78 ?v_79)))) (let ((?v_100 (ite ?v_75 ?v_80 ?v_69))) (let ((?v_94 (ite ?v_35 ?v_5 (ite ?v_45 ?v_42 (ite ?v_90 ?v_77 (ite ?v_88 ?v_80 (ite ?v_86 ?v_100 ?v_81)))))) (?v_83 (ite (GetMemWrite ?v_0) (NextDMem dmem0 ?v_15 ?v_20) dmem0)) (?v_174 (alu ?v_31 ?v_32 (ite (GetuseImm ?v_1) (GetImm ?v_1) ?v_82)))) (let ((?v_85 (ite (and ?v_35 (GetMemWrite ?v_1)) (NextDMem ?v_83 ?v_174 ?v_82) ?v_83)) (?v_252 (alu ?v_40 ?v_41 (ite (GetuseImm ?v_6) (GetImm ?v_6) ?v_84)))) (let ((?v_209 (ite (and ?v_45 (GetMemWrite ?v_6)) (NextDMem ?v_85 ?v_252 ?v_84) ?v_85))) (let ((?v_99 (= ?v_209 ?v_83)) (?v_87 (not ?v_86)) (?v_89 (not ?v_88)) (?v_91 (not ?v_90)) (?v_92 (not ?v_45)) (?v_93 (not ?v_35)) (?v_113 (IMem0 ?v_94))) (let ((?v_135 (GetIsBranch ?v_113)) (?v_95 (ite ?v_3 ?v_4 ?v_44))) (let ((?v_96 (ite ?v_11 ?v_95 ?v_59))) (let ((?v_97 (ite ?v_52 ?v_96 ?v_68))) (let ((?v_98 (ite ?v_35 ?v_4 (ite ?v_45 ?v_95 (ite ?v_90 ?v_96 (ite ?v_88 ?v_97 (ite ?v_86 (ite ?v_75 ?v_97 ?v_70) (ite ?v_75 ?v_70 (NextBPState ?v_70))))))))) (let ((?v_105 (and ?v_135 (PredictDirection ?v_98))) (?v_111 (PredictTarget ?v_98)) (?v_204 (Succ ?v_94))) (let ((?v_114 (ite ?v_105 ?v_111 ?v_204)) (?v_122 (or (and ?v_11 ?v_101) (and ?v_24 ?v_102)))) (let ((?v_123 (or (and ?v_52 ?v_122) (and ?v_76 ?v_103)))) (let ((?v_106 (or (and ?v_75 ?v_123) (and ?v_78 ?v_104)))) (let ((?v_116 (not ?v_106)) (?v_124 (not ?v_105)) (?v_127 (ite ?v_11 ?v_107 ?v_108))) (let ((?v_128 (ite ?v_52 ?v_127 ?v_109))) (let ((?v_118 (ite ?v_75 ?v_128 ?v_110)) (?v_120 (ite ?v_75 ?v_60 ?v_112)) (?v_121 (IMem0 ?v_114))) (let ((?v_165 (GetIsBranch ?v_121)) (?v_115 (NextBPState ?v_98))) (let ((?v_117 (and ?v_165 (PredictDirection ?v_115))) (?v_119 (PredictTarget ?v_115)) (?v_254 (Succ ?v_114))) (let ((?v_144 (ite ?v_117 ?v_119 ?v_254)) (?v_177 (or (and ?v_52 ?v_39) (and ?v_76 ?v_122)))) (let ((?v_125 (or (and ?v_75 ?v_177) (and ?v_78 ?v_123)))) (let ((?v_152 (not ?v_125)) (?v_188 (ite ?v_52 ?v_126 ?v_127))) (let ((?v_154 (ite ?v_75 ?v_188 ?v_128)) (?v_155 (op ?v_60)) (?v_175 (op ?v_113)) (?v_156 (ite (and (= ?v_129 ?v_2) ?v_14) ?v_17 (rf0 ?v_129))) (?v_130 (src1 ?v_113))) (let ((?v_176 (ite (and (= ?v_130 ?v_2) ?v_14) ?v_17 (rf0 ?v_130))) (?v_158 (ite (and (= ?v_131 ?v_2) ?v_14) ?v_17 (rf0 ?v_131))) (?v_132 (src2 ?v_113))) (let ((?v_183 (ite (and (= ?v_132 ?v_2) ?v_14) ?v_17 (rf0 ?v_132))) (?v_160 (dest ?v_60)) (?v_143 (dest ?v_113)) (?v_161 (GetImm ?v_60)) (?v_197 (GetImm ?v_113)) (?v_134 (GetuseImm ?v_60))) (let ((?v_162 (not ?v_134)) (?v_133 (GetuseImm ?v_113)) (?v_136 (GetIsBranch ?v_60))) (let ((?v_164 (not ?v_136)) (?v_138 (GetMemToReg ?v_60))) (let ((?v_166 (not ?v_138)) (?v_137 (GetMemToReg ?v_113))) (let ((?v_200 (not ?v_137)) (?v_140 (GetMemWrite ?v_60))) (let ((?v_168 (not ?v_140)) (?v_139 (GetMemWrite ?v_113))) (let ((?v_202 (not ?v_139)) (?v_142 (GetRegWrite ?v_60))) (let ((?v_170 (not ?v_142)) (?v_141 (GetRegWrite ?v_113))) (let ((?v_196 (not ?v_141)) (?v_157 (src1 ?v_121)) (?v_159 (src2 ?v_121))) (let ((?v_146 (and ?v_141 (or (= ?v_157 ?v_143) (= ?v_159 ?v_143)))) (?v_150 (IMem0 ?v_144)) (?v_145 (NextBPState ?v_115))) (let ((?v_147 (and (GetIsBranch ?v_150) (PredictDirection ?v_145))) (?v_149 (PredictTarget ?v_145))) (let ((?v_207 (ite ?v_146 ?v_144 (ite ?v_147 ?v_149 (Succ ?v_144)))) (?v_214 (ite ?v_146 ?v_114 ?v_144)) (?v_151 (not ?v_146))) (let ((?v_148 (or (and ?v_146 ?v_117) (and ?v_151 ?v_147))) (?v_217 (ite ?v_146 ?v_119 ?v_149)) (?v_205 (ite ?v_146 ?v_121 ?v_150)) (?v_153 (or (and ?v_146 ?v_105) (and ?v_151 ?v_117)))) (let ((?v_239 (not ?v_153)) (?v_223 (ite ?v_146 ?v_111 ?v_119)) (?v_232 (op ?v_121)) (?v_233 (ite (and (= ?v_157 ?v_2) ?v_14) ?v_17 (rf0 ?v_157))) (?v_235 (ite (and (= ?v_159 ?v_2) ?v_14) ?v_17 (rf0 ?v_159))) (?v_206 (dest ?v_121)) (?v_246 (GetImm ?v_121)) (?v_163 (GetuseImm ?v_121)) (?v_167 (GetMemToReg ?v_121))) (let ((?v_249 (not ?v_167)) (?v_169 (GetMemWrite ?v_121))) (let ((?v_251 (not ?v_169)) (?v_171 (GetRegWrite ?v_121))) (let ((?v_244 (not ?v_171)) (?v_178 (op ?v_50)) (?v_181 (ite (GetMemToReg ?v_1) (DMem_Read ?v_83 ?v_174) ?v_174))) (let ((?v_179 (ite (and (and ?v_35 (= ?v_172 ?v_7)) ?v_173) ?v_181 (ite (and (= ?v_172 ?v_2) ?v_14) ?v_17 (rf0 ?v_172))))) (let ((?v_187 (SelectTargetPC ?v_178 ?v_179 ?v_77)) (?v_190 (SelectTargetPC ?v_175 ?v_176 ?v_94))) (let ((?v_193 (= ?v_187 ?v_190)) (?v_182 (GetIsBranch ?v_50)) (?v_194 (ite (and (and ?v_35 (= ?v_180 ?v_7)) ?v_173) ?v_181 (ite (and (= ?v_180 ?v_2) ?v_14) ?v_17 (rf0 ?v_180))))) (let ((?v_186 (and (and (TakeBranch ?v_178 ?v_179 ?v_194) ?v_73) ?v_182))) (let ((?v_198 (not ?v_186))) (let ((?v_185 (and (and ?v_177 ?v_182) ?v_198))) (let ((?v_234 (not ?v_185)) (?v_189 (and (TakeBranch ?v_175 ?v_176 ?v_183) ?v_135))) (let ((?v_199 (not ?v_189))) (let ((?v_184 (and (and ?v_105 ?v_135) ?v_199)) (?v_192 (or (and ?v_186 (not ?v_177)) (and ?v_186 (not (= ?v_187 ?v_188)))))) (let ((?v_237 (not ?v_192)) (?v_191 (or (and ?v_189 ?v_124) (and ?v_189 (not (= ?v_190 ?v_111))))) (?v_243 (not ?v_195)) (?v_245 (alu ?v_178 ?v_179 (ite (GetuseImm ?v_50) (GetImm ?v_50) ?v_194))) (?v_210 (alu ?v_175 ?v_176 (ite ?v_133 ?v_197 ?v_183))) (?v_201 (GetMemToReg ?v_50))) (let ((?v_248 (not ?v_201)) (?v_203 (GetMemWrite ?v_50))) (let ((?v_250 (not ?v_203)) (?v_224 (src1 ?v_205)) (?v_225 (src2 ?v_205))) (let ((?v_213 (and (and ?v_171 ?v_151) (or (= ?v_224 ?v_206) (= ?v_225 ?v_206)))) (?v_219 (IMem0 ?v_207)) (?v_208 (ite ?v_146 ?v_145 (NextBPState ?v_145)))) (let ((?v_215 (and (GetIsBranch ?v_219) (PredictDirection ?v_208))) (?v_218 (PredictTarget ?v_208))) (let ((?v_257 (ite ?v_184 ?v_204 (ite ?v_191 ?v_190 (ite ?v_213 ?v_207 (ite ?v_215 ?v_218 (Succ ?v_207)))))) (?v_259 (ite ?v_139 (NextDMem ?v_83 ?v_210 ?v_183) ?v_83)) (?v_211 (or ?v_191 ?v_184))) (let ((?v_212 (not ?v_211)) (?v_265 (ite ?v_213 ?v_214 ?v_207)) (?v_220 (not ?v_213))) (let ((?v_216 (or (and ?v_213 ?v_148) (and ?v_220 ?v_215))) (?v_269 (ite ?v_213 ?v_217 ?v_218)) (?v_255 (ite ?v_213 ?v_205 ?v_219)) (?v_221 (and ?v_212 ?v_220)) (?v_222 (or (and ?v_213 ?v_153) (and ?v_220 ?v_148)))) (let ((?v_291 (not ?v_222)) (?v_275 (ite ?v_213 ?v_223 ?v_217)) (?v_284 (op ?v_205)) (?v_286 (ite (and (= ?v_224 ?v_2) ?v_14) ?v_17 (rf0 ?v_224))) (?v_288 (ite (and (= ?v_225 ?v_2) ?v_14) ?v_17 (rf0 ?v_225))) (?v_256 (dest ?v_205)) (?v_297 (GetImm ?v_205)) (?v_226 (GetuseImm ?v_205)) (?v_227 (GetIsBranch ?v_205)) (?v_228 (GetMemToReg ?v_205))) (let ((?v_299 (not ?v_228)) (?v_229 (GetMemWrite ?v_205))) (let ((?v_300 (not ?v_229)) (?v_230 (GetRegWrite ?v_205))) (let ((?v_296 (not ?v_230)) (?v_231 (and ?v_212 ?v_151))) (let ((?v_301 (not ?v_231)) (?v_240 (SelectTargetPC ?v_232 ?v_233 ?v_114))) (let ((?v_242 (= ?v_187 ?v_240)) (?v_238 (and (and (TakeBranch ?v_232 ?v_233 ?v_235) ?v_151) ?v_165))) (let ((?v_247 (not ?v_238))) (let ((?v_236 (and (and ?v_153 ?v_165) ?v_247)) (?v_241 (or (and ?v_238 ?v_239) (and ?v_238 (not (= ?v_240 ?v_223))))) (?v_260 (alu ?v_232 ?v_233 (ite ?v_163 ?v_246 ?v_235))) (?v_302 (ite (GetMemToReg ?v_6) (DMem_Read ?v_85 ?v_252) ?v_252)) (?v_285 (ite ?v_137 (DMem_Read ?v_83 ?v_210) ?v_210)) (?v_303 (not ?v_253))) (let ((?v_262 (and ?v_236 ?v_231)) (?v_261 (and ?v_241 ?v_231)) (?v_276 (src1 ?v_255)) (?v_277 (src2 ?v_255))) (let ((?v_263 (and (and ?v_230 ?v_221) (or (= ?v_276 ?v_256) (= ?v_277 ?v_256)))) (?v_271 (IMem0 ?v_257)) (?v_258 (ite ?v_213 ?v_208 (NextBPState ?v_208)))) (let ((?v_267 (and (GetIsBranch ?v_271) (PredictDirection ?v_258))) (?v_270 (PredictTarget ?v_258)) (?v_272 (not (or ?v_261 ?v_262))) (?v_266 (not ?v_263))) (let ((?v_264 (and ?v_272 (or ?v_266 ?v_212))) (?v_268 (or (and ?v_263 ?v_216) (and ?v_266 ?v_267))) (?v_273 (and ?v_272 (and ?v_266 ?v_212))) (?v_274 (or (and ?v_263 ?v_222) (and ?v_266 ?v_216))) (?v_278 (GetuseImm ?v_255)) (?v_279 (GetIsBranch ?v_255)) (?v_280 (GetMemToReg ?v_255)) (?v_281 (GetMemWrite ?v_255)) (?v_282 (GetRegWrite ?v_255)) (?v_283 (and ?v_272 ?v_221)) (?v_287 (ite (and (= ?v_224 ?v_143) ?v_141) ?v_285 ?v_286))) (let ((?v_292 (SelectTargetPC ?v_284 ?v_287 ?v_214))) (let ((?v_294 (= ?v_187 ?v_292)) (?v_295 (ite (and (= ?v_225 ?v_143) ?v_141) ?v_285 ?v_288))) (let ((?v_290 (and (and (TakeBranch ?v_284 ?v_287 ?v_295) ?v_221) ?v_227))) (let ((?v_298 (not ?v_290))) (let ((?v_289 (and (and ?v_222 ?v_227) ?v_298)) (?v_293 (or (and ?v_290 ?v_291) (and ?v_290 (not (= ?v_292 ?v_275)))))) (not (or (or (or (or (or (and (and (and (and (and (and (and (and (and (and (and (= ?v_81 ?v_94) ?v_99) ?v_87) ?v_87) ?v_89) ?v_89) ?v_91) ?v_91) ?v_92) ?v_92) ?v_93) ?v_93) (and (and (and (and (and (and (and (and (and (and (and (= ?v_81 ?v_114) ?v_99) ?v_86) (or ?v_87 (and (and (and (= ?v_100 ?v_94) (and (or ?v_116 ?v_105) (or ?v_124 ?v_106))) (= ?v_118 ?v_111)) (= ?v_120 ?v_113)))) ?v_89) ?v_89) ?v_91) ?v_91) ?v_92) ?v_92) ?v_93) ?v_93)) (and (and (and (and (and (and (and (and (and (and (and (= ?v_81 ?v_144) ?v_99) ?v_86) (or ?v_87 (and (and (and (= ?v_100 ?v_114) (and (or ?v_116 ?v_117) (or (not ?v_117) ?v_106))) (= ?v_118 ?v_119)) (= ?v_120 ?v_121)))) ?v_88) (or ?v_89 (and (and (and (and (and (and (and (and (and (and (and (and (and (and (= ?v_80 ?v_94) (and (or ?v_152 ?v_105) (or ?v_124 ?v_125))) (= ?v_154 ?v_111)) (= ?v_155 ?v_175)) (= ?v_156 ?v_176)) (= ?v_158 ?v_183)) (= ?v_160 ?v_143)) (= ?v_129 ?v_130)) (= ?v_131 ?v_132)) (= ?v_161 ?v_197)) (and (or ?v_162 ?v_133) (or (not ?v_133) ?v_134))) (and (or ?v_164 ?v_135) (or (not ?v_135) ?v_136))) (and (or ?v_166 ?v_137) (or ?v_200 ?v_138))) (and (or ?v_168 ?v_139) (or ?v_202 ?v_140))) (and (or ?v_170 ?v_141) (or ?v_196 ?v_142))))) ?v_91) ?v_91) ?v_92) ?v_92) ?v_93) ?v_93)) (and (and (and (and (and (and (and (and (and (and (and (= ?v_81 ?v_207) ?v_99) ?v_86) (or ?v_87 (and (and (and (= ?v_100 ?v_214) (and (or ?v_116 ?v_148) (or (not ?v_148) ?v_106))) (= ?v_118 ?v_217)) (= ?v_120 ?v_205)))) (and (or ?v_89 ?v_151) (or ?v_146 ?v_88))) (or ?v_89 (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and ?v_151 (= ?v_80 ?v_114)) (and (or ?v_152 ?v_153) (or ?v_239 ?v_125))) (= ?v_154 ?v_223)) (= ?v_155 ?v_232)) (= ?v_156 ?v_233)) (= ?v_158 ?v_235)) (= ?v_160 ?v_206)) (= ?v_129 ?v_157)) (= ?v_131 ?v_159)) (= ?v_161 ?v_246)) (and (or ?v_162 ?v_163) (or (not ?v_163) ?v_134))) (and (or ?v_164 ?v_165) (or (not ?v_165) ?v_136))) (and (or ?v_166 ?v_167) (or ?v_249 ?v_138))) (and (or ?v_168 ?v_169) (or ?v_251 ?v_140))) (and (or ?v_170 ?v_171) (or ?v_244 ?v_142))))) ?v_90) (or ?v_91 (and (and (and (and (and (and (and (and (and (and (and ?v_193 (and (or ?v_234 ?v_184) (or (not ?v_184) ?v_185))) (and (or ?v_237 ?v_191) (or (not ?v_191) ?v_192))) (= ?v_61 ?v_143)) (= ?v_77 ?v_94)) ?v_193) (= ?v_194 ?v_183)) (and (or ?v_243 ?v_141) (or ?v_196 ?v_195))) (= ?v_245 ?v_210)) (and (or ?v_198 ?v_189) (or ?v_199 ?v_186))) (and (or ?v_248 ?v_137) (or ?v_200 ?v_201))) (and (or ?v_250 ?v_139) (or ?v_202 ?v_203))))) ?v_92) ?v_92) ?v_93) ?v_93)) (and (and (and (and (and (and (and (and (and (and (and (= ?v_81 ?v_257) (= ?v_209 ?v_259)) (and (or ?v_87 ?v_212) (or ?v_211 ?v_86))) (or ?v_87 (and (and (and (and ?v_212 (= ?v_100 ?v_265)) (and (or ?v_116 ?v_216) (or (not ?v_216) ?v_106))) (= ?v_118 ?v_269)) (= ?v_120 ?v_255)))) (and (or ?v_89 ?v_221) (or (not ?v_221) ?v_88))) (or ?v_89 (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and ?v_221 (= ?v_80 ?v_214)) (and (or ?v_152 ?v_222) (or ?v_291 ?v_125))) (= ?v_154 ?v_275)) (= ?v_155 ?v_284)) (= ?v_156 ?v_286)) (= ?v_158 ?v_288)) (= ?v_160 ?v_256)) (= ?v_129 ?v_224)) (= ?v_131 ?v_225)) (= ?v_161 ?v_297)) (and (or ?v_162 ?v_226) (or (not ?v_226) ?v_134))) (and (or ?v_164 ?v_227) (or (not ?v_227) ?v_136))) (and (or ?v_166 ?v_228) (or ?v_299 ?v_138))) (and (or ?v_168 ?v_229) (or ?v_300 ?v_140))) (and (or ?v_170 ?v_230) (or ?v_296 ?v_142))))) (and (or ?v_91 ?v_231) (or ?v_301 ?v_90))) (or ?v_91 (and (and (and (and (and (and (and (and (and (and (and (and ?v_231 ?v_242) (and (or ?v_234 ?v_236) (or (not ?v_236) ?v_185))) (and (or ?v_237 ?v_241) (or (not ?v_241) ?v_192))) (= ?v_61 ?v_206)) (= ?v_77 ?v_114)) ?v_242) (= ?v_194 ?v_235)) (and (or ?v_243 ?v_171) (or ?v_244 ?v_195))) (= ?v_245 ?v_260)) (and (or ?v_198 ?v_238) (or ?v_247 ?v_186))) (and (or ?v_248 ?v_167) (or ?v_249 ?v_201))) (and (or ?v_250 ?v_169) (or ?v_251 ?v_203))))) ?v_45) (or ?v_92 (and (and (= ?v_302 ?v_285) (= ?v_51 ?v_143)) (and (or ?v_303 ?v_141) (or ?v_196 ?v_253))))) ?v_93) ?v_93)) (and (and (and (and (and (and (and (and (and (and (and (= ?v_81 (ite ?v_262 ?v_254 (ite ?v_261 ?v_240 (ite ?v_263 ?v_257 (ite ?v_267 ?v_270 (Succ ?v_257)))))) (= ?v_209 (ite (and ?v_231 ?v_169) (NextDMem ?v_259 ?v_260 ?v_235) ?v_259))) (and (or ?v_87 ?v_264) (or (not ?v_264) ?v_86))) (or ?v_87 (and (and (and (and ?v_264 (= ?v_100 (ite ?v_263 ?v_265 ?v_257))) (and (or ?v_116 ?v_268) (or (not ?v_268) ?v_106))) (= ?v_118 (ite ?v_263 ?v_269 ?v_270))) (= ?v_120 (ite ?v_263 ?v_255 ?v_271))))) (and (or ?v_89 ?v_273) (or (not ?v_273) ?v_88))) (or ?v_89 (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and ?v_273 (= ?v_80 ?v_265)) (and (or ?v_152 ?v_274) (or (not ?v_274) ?v_125))) (= ?v_154 (ite ?v_263 ?v_275 ?v_269))) (= ?v_155 (op ?v_255))) (= ?v_156 (ite (and (= ?v_276 ?v_2) ?v_14) ?v_17 (rf0 ?v_276)))) (= ?v_158 (ite (and (= ?v_277 ?v_2) ?v_14) ?v_17 (rf0 ?v_277)))) (= ?v_160 (dest ?v_255))) (= ?v_129 ?v_276)) (= ?v_131 ?v_277)) (= ?v_161 (GetImm ?v_255))) (and (or ?v_162 ?v_278) (or (not ?v_278) ?v_134))) (and (or ?v_164 ?v_279) (or (not ?v_279) ?v_136))) (and (or ?v_166 ?v_280) (or (not ?v_280) ?v_138))) (and (or ?v_168 ?v_281) (or (not ?v_281) ?v_140))) (and (or ?v_170 ?v_282) (or (not ?v_282) ?v_142))))) (and (or ?v_91 ?v_283) (or (not ?v_283) ?v_90))) (or ?v_91 (and (and (and (and (and (and (and (and (and (and (and (and ?v_283 ?v_294) (and (or ?v_234 ?v_289) (or (not ?v_289) ?v_185))) (and (or ?v_237 ?v_293) (or (not ?v_293) ?v_192))) (= ?v_61 ?v_256)) (= ?v_77 ?v_214)) ?v_294) (= ?v_194 ?v_295)) (and (or ?v_243 ?v_230) (or ?v_296 ?v_195))) (= ?v_245 (alu ?v_284 ?v_287 (ite ?v_226 ?v_297 ?v_295)))) (and (or ?v_198 ?v_290) (or ?v_298 ?v_186))) (and (or ?v_248 ?v_228) (or ?v_299 ?v_201))) (and (or ?v_250 ?v_229) (or ?v_300 ?v_203))))) (and (or ?v_92 ?v_231) (or ?v_301 ?v_45))) (or ?v_92 (and (and (and ?v_231 (= ?v_302 (ite ?v_167 (DMem_Read ?v_259 ?v_260) ?v_260))) (= ?v_51 ?v_206)) (and (or ?v_303 ?v_171) (or ?v_244 ?v_253))))) ?v_35) (or ?v_93 (and (and (= ?v_181 ?v_285) (= ?v_7 ?v_143)) (and (or (not ?v_173) ?v_141) (or ?v_196 ?v_173)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
(check-sat)
(exit)
