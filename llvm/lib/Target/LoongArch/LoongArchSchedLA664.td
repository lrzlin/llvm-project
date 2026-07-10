//==- LoongArchSchedLA664.td - LA664 Scheduling Defs -*- tablegen -*-=//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the machine model for LA664 to support instruction
// scheduling and other instruction cost heuristics.
// Based on:
//  * Loongson 3A6000: A Star among Chinese CPUs, by Chips and Cheese
//    https://chipsandcheese.com/p/loongson-3a6000-a-star-among-chinese-cpus/
//===----------------------------------------------------------------------===//

def LA664Model : SchedMachineModel {
  let IssueWidth = 6;             // 6-way decode and dispatch
  let MicroOpBufferSize = 256;    // Reorder Buffer size
  let LoadLatency = 4;
  let MispredictPenalty = 14;     // Estimated value
  let PostRAScheduler = true;
  let CompleteModel = 0;
}

let SchedModel = LA664Model in {
// Integer Execution Unit
//
// Execution Pipes
def LA664ALU0 : ProcResource<1>; // ALU, MUL, Branch
def LA664ALU1 : ProcResource<1>; // ALU, MUL, Branch
def LA664ALU2 : ProcResource<1>; // ALU
def LA664ALU3 : ProcResource<1>; // ALU

def LA664AGU0 : ProcResource<1>; // Load
def LA664AGU1 : ProcResource<1>; // Load
def LA664AGU2 : ProcResource<1>; // Store
def LA664AGU3 : ProcResource<1>; // Store

// Execution Units
//
// Integer division issued on port 0. (Estimiated)
def LA664Div : ProcResource<1>;

// ALU0 and ALU1 additionally have branch execution capability.
defvar LA664Branch0 = LA664ALU0;
defvar LA664Branch1 = LA664ALU1;

// ALU0 and ALU1 have Integer multiplication execution capability.
defvar LA664Mul0 = LA664ALU0;
defvar LA664Mul1 = LA664ALU1;

defvar LA664LoadAGU0 = LA664AGU0;
defvar LA664LoadAGU1 = LA664AGU1;
defvar LA664StoreAGU0 = LA664AGU2;
defvar LA664StoreAGU1 = LA664AGU3;

// Execution pipeline grouping
//
def LA664Branch : ProcResGroup<[LA664Branch0, LA664Branch1]>;
def LA664Mul: ProcResGroup<[LA664Mul0, LA664Mul1]>;
def LA664LoadAGU : ProcResGroup<[LA664LoadAGU0, LA664LoadAGU1]>;
def LA664StoreAGU : ProcResGroup<[LA664StoreAGU0, LA664StoreAGU1]>;

// Scheduling
//
// LA664 has an unified 48 entry Integer scheduler
def LA664ALU : ProcResGroup<[LA664ALU0, LA664ALU1, LA664ALU2, LA664ALU3]> {
  let BufferSize=48;
}

// LA664 has an unified 48 entry AGU scheduler
def LA664AGU : ProcResGroup<[LA664AGU0, LA664AGU1, LA664AGU2, LA664AGU3]> {
  let BufferSize=48;
}

// Floating-Point Unit
//
// Execution pipes
// There are four floating point/vector execution pipes.
def LA664FPU0 : ProcResource<1>; // FMUL, VALU, VFADD
def LA664FPU1 : ProcResource<1>; // FMUL, VALU, VFADD
def LA664FPU2 : ProcResource<1>; // FMUL, VALU, VFADD, VFMUL
def LA664FPU3 : ProcResource<1>; // FMUL, VALU, VFADD, VFMUL

// Execution Units
//
// All four FPUs have float add execution capability. (Infer by throughput)
defvar LA664VALU0 = LA664FPU0;
defvar LA664VALU1 = LA664FPU1;
defvar LA664VALU2 = LA664FPU2;
defvar LA664VALU3 = LA664FPU3;
// FPU0 and FPU1 have float multiplication execution capability.
defvar LA664FMul0 = LA664FPU0;
defvar LA664FMul1 = LA664FPU1;

// FP division/sqrt on port 0. (Estimated)
def LA664FDiv : ProcResource<1>;

// Only FPU0 has float move execution capability. (Estimated)
defvar LA664FMov = LA664FPU0;

// FPU0 and FPU1 have float FMA execution capability. (Estimated)
defvar LA664FMA0 = LA664FPU0;
defvar LA664FMA1 = LA664FPU1;

// FPU0 and FPU1 have float compare execution capability. (Estimated)
defvar LA664FCmp0 = LA664FPU0;
defvar LA664FCmp1 = LA664FPU1;

// FPU2 and FPU3 have vector multiplication execution capability. (Estimated)
defvar LA664VMul0 = LA664FPU2;
defvar LA664VMul1 = LA664FPU3;

// FPU0 and FPU1 have vector FMA execution capability. (Estimated)
defvar LA664VFMA0 = LA664FPU0;
defvar LA664VFMA1 = LA664FPU1;

// Execution pipeline grouping
//
// Scalar FP multiplies appear to use different pipes than vector ones.
def LA664VALU : ProcResGroup<[LA664VALU0, LA664VALU1, LA664VALU2, LA664VALU3]>;
def LA664FMul : ProcResGroup<[LA664FMul0, LA664FMul1]>;
def LA664FMA : ProcResGroup<[LA664FMA0, LA664FMA1]>;
def LA664FCmp : ProcResGroup<[LA664FCmp0, LA664FCmp1]>;
def LA664VMul : ProcResGroup<[LA664VMul0, LA664VMul1]>;
def LA664VFMA : ProcResGroup<[LA664VFMA0, LA664VFMA1]>;

// Scheduling
//
// LA664 has an unified 48 entry vector/fp scheduler
def LA664FPU : ProcResGroup<[LA664FPU0, LA664FPU1, LA664FPU2, LA664FPU3]> {
  let BufferSize=48;
}

// Load-Store Unit
//
// The LS unit contains four pipelines, two for load and two for store.
// LA664 can handle two 256-bit vector accesses per cycle.
// These can be any combination of loads and stores.
def LA664Load : ProcResource<2> {
  // The LS unit utilizes a 80-entry store queue (STQ).
  let BufferSize = 80;
}

def LA664Store : ProcResource<2> {
  // The LS unit utilizes a 64-entry store queue (STQ).
  let BufferSize = 64;
}

//===----------------------------------------------------------------------===//

// Base Instruction
// Integer arithmetic and logic, default latency is 1
def : WriteRes<WriteIALU, [LA664ALU]>;
def : WriteRes<WriteIALU32, [LA664ALU]>;

def : ReadAdvance<ReadIALU, 0>;
def : ReadAdvance<ReadIALU32, 0>;

// Integer instruction latency ALSL
def : WriteRes<WriteIALSL, [LA664ALU]>;
def : WriteRes<WriteIALSL32, [LA664ALU]>;

def : ReadAdvance<ReadIALSL, 0>;
def : ReadAdvance<ReadIALSL32, 0>;

// Integer instruction latency MUL
let Latency = 4 in {
  def : WriteRes<WriteIMUL, [LA664Mul]>;
  def : WriteRes<WriteIMUL32, [LA664Mul]>;
}
def : ReadAdvance<ReadIMUL, 0>;
def : ReadAdvance<ReadIMUL32, 0>;

// Integer instruction latency DIV
// Latency 4-19, pick the worst case.
let Latency = 19, ReleaseAtCycles = [1,12] in {
  def : WriteRes<WriteIDIV32, [LA664ALU0, LA664Div]>;
}
// Latency 4-32, pick the worst case.
let Latency = 32, ReleaseAtCycles = [1,19] in {
  def : WriteRes<WriteIDIV, [LA664ALU0, LA664Div]>;
}
def : ReadAdvance<ReadIDIV, 0>;
def : ReadAdvance<ReadIDIV32, 0>;

// Integer instruction latency SHIFT
def : WriteRes<WriteIShift, [LA664ALU]>;
def : WriteRes<WriteIShift32, [LA664ALU]>;

def : ReadAdvance<ReadIShift, 0>;
def : ReadAdvance<ReadIShift32, 0>;

// Integer instruction latency EXT
def : WriteRes<WriteIEXT, [LA664ALU]>;

def : ReadAdvance<ReadIEXT, 0>;

// Integer instruction latency CLO / CLZ / CTO / CTZ
let Latency = 1 in {
  def : WriteRes<WriteICL, [LA664ALU]>;
  def : WriteRes<WriteICL32, [LA664ALU]>;
  def : WriteRes<WriteICT, [LA664ALU]>;
  def : WriteRes<WriteICT32, [LA664ALU]>;
}
def : ReadAdvance<ReadICL, 0>;
def : ReadAdvance<ReadICL32, 0>;
def : ReadAdvance<ReadICT, 0>;
def : ReadAdvance<ReadICT32, 0>;

// Integer instruction latency BytePick
def : WriteRes<WriteIBytePick, [LA664ALU]>;
def : WriteRes<WriteIBytePick32, [LA664ALU]>;

def : ReadAdvance<ReadIBytePick, 0>;
def : ReadAdvance<ReadIBytePick32, 0>;

// Integer instruction latency REV
def : WriteRes<WriteIRev, [LA664ALU]>;
def : WriteRes<WriteIRev32, [LA664ALU]>;

def : ReadAdvance<ReadIRev, 0>;
def : ReadAdvance<ReadIRev32, 0>;

// Integer instruction latency BitRev
def : WriteRes<WriteIBitRev, [LA664ALU]>;
def : WriteRes<WriteIBitRev32, [LA664ALU]>;

def : ReadAdvance<ReadIBitRev, 0>;
def : ReadAdvance<ReadIBitRev32, 0>;

// Integer instruction latency BSTRINS
def : WriteRes<WriteIBstrins, [LA664ALU]>;
def : WriteRes<WriteIBstrins32, [LA664ALU]>;

def : ReadAdvance<ReadIBstrins, 0>;
def : ReadAdvance<ReadIBstrins32, 0>;

// Integer instruction latency BSTRPICK
def : WriteRes<WriteIBstrPick, [LA664ALU]>;
def : WriteRes<WriteIBstrPick32, [LA664ALU]>;

def : ReadAdvance<ReadIBstrPick, 0>;
def : ReadAdvance<ReadIBstrPick32, 0>;

// Integer instruction latency SELECT
def : WriteRes<WriteIMASK, [LA664ALU]>;

def : ReadAdvance<ReadIMASK, 0>;

// Integer instruction latency Jump
def : WriteRes<WriteIJump, [LA664Branch]>;

def : ReadAdvance<ReadIJump, 0>;

// Integer instruction latency LD ST LDX STX
let Latency = 4 in {
  def : WriteRes<WriteLD, [LA664LoadAGU, LA664Load]>;
  def : WriteRes<WriteST, [LA664StoreAGU, LA664Store]>;
  def : WriteRes<WriteLDX, [LA664LoadAGU, LA664Load]>;
  def : WriteRes<WriteSTX, [LA664StoreAGU, LA664Store]>;
}
def : ReadAdvance<ReadSTData, 0>;
def : ReadAdvance<ReadMemBase, 0>;
def : ReadAdvance<ReadMemOffset, 0>;

// Integer instruction latency LDPTR STPTR
let Latency = 4 in {
  def : WriteRes<WriteLDPTR, [LA664LoadAGU, LA664Load]>;
  def : WriteRes<WriteSTPTR, [LA664StoreAGU, LA664Store]>;
}

// Integer instruction latency LDGT LDLE STGT STLE
let Latency = 4 in {
  def : WriteRes<WriteLDGT, [LA664LoadAGU, LA664Load]>;
  def : WriteRes<WriteLDLE, [LA664LoadAGU, LA664Load]>;
  def : WriteRes<WriteSTGT, [LA664StoreAGU, LA664Store]>;
  def : WriteRes<WriteSTLE, [LA664StoreAGU, LA664Store]>;
}
def : ReadAdvance<ReadMemCmp, 0>;

// Floating-point instruction latency FADD FSUB FMUL FDIV FMADD FMINMAX
let Latency = 3 in {
  def : WriteRes<WriteFADD, [LA664FPU]>;
}
let Latency = 5 in {
  def : WriteRes<WriteFMUL, [LA664FMul]>;
  def : WriteRes<WriteFMADD, [LA664FMA]>;
}
let Latency = 2 in {
  def : WriteRes<WriteFMinMax, [LA664FPU]>;
}
def : ReadAdvance<ReadFADD, 0>;
def : ReadAdvance<ReadFMUL, 0>;
def : ReadAdvance<ReadFMADD, 0>;
def : ReadAdvance<ReadFMinMax, 0>;
// Latency is 6-13, pick the worst case.
let Latency = 13, ReleaseAtCycles = [1, 3] in {
  def : WriteRes<WriteFDIV32, [LA664FPU0, LA664FDiv]>;
}
// Latency is 6-19, pick the worst case.
let Latency = 19, ReleaseAtCycles = [1, 4] in {
  def : WriteRes<WriteFDIV, [LA664FPU0, LA664FDiv]>;
}
def : ReadAdvance<ReadFDIV32, 0>;
def : ReadAdvance<ReadFDIV, 0>;

// Floating-point instruction latency FABS FNEG FSQRT FRECIP FRSQRT FSCALEB FLOGB FCOPYSIGN FCLASS FCMP
def : WriteRes<WriteFABS, [LA664FPU]>;
def : WriteRes<WriteFNEG, [LA664FPU]>;
def : WriteRes<WriteFCOPYSIGN, [LA664FPU]>;
let Latency = 2 in {
  def : WriteRes<WriteFCLASS, [LA664FPU]>;
  def : WriteRes<WriteFCMP, [LA664FCmp]>;
}
let Latency = 4 in {
  def : WriteRes<WriteFSCALEB, [LA664FPU]>;
  def : WriteRes<WriteFLOGB, [LA664FPU]>;
}
def : ReadAdvance<ReadFABS, 0>;
def : ReadAdvance<ReadFNEG, 0>;
def : ReadAdvance<ReadFSCALEB, 0>;
def : ReadAdvance<ReadFLOGB, 0>;
def : ReadAdvance<ReadFCOPYSIGN, 0>;
def : ReadAdvance<ReadFCLASS, 0>;
def : ReadAdvance<ReadFCMP, 0>;
// Latency is 8-16, pick the worst case.
let Latency = 16, ReleaseAtCycles = [1, 3] in {
  def : WriteRes<WriteFRECIP32, [LA664FPU0, LA664FDiv]>;
}
// Latency is 8-23, pick the worst case.
let Latency = 23, ReleaseAtCycles = [1, 4] in {
  def : WriteRes<WriteFRECIP, [LA664FPU0, LA664FDiv]>;
}
// Latency is 8-22, pick the worst case.
let Latency = 22, ReleaseAtCycles = [1, 4] in {
  def : WriteRes<WriteFSQRT32, [LA664FPU0, LA664FDiv]>;
}
// Latency is 8-36, pick the worst case.
let Latency = 36, ReleaseAtCycles = [1, 7] in {
  def : WriteRes<WriteFSQRT, [LA664FPU0, LA664FDiv]>;
}
def : ReadAdvance<ReadFSQRT32, 0>;
def : ReadAdvance<ReadFSQRT, 0>;
def : ReadAdvance<ReadFRECIP32, 0>;
def : ReadAdvance<ReadFRECIP, 0>;
// Latency is 11-33, pick the worst case.
let Latency = 33, ReleaseAtCycles = [1, 7] in {
  def : WriteRes<WriteFRSQRT32, [LA664FPU0, LA664FDiv]>;
}
// Latency is 11-54, pick the worst case.
let Latency = 54, ReleaseAtCycles = [1, 12] in {
  def : WriteRes<WriteFRSQRT, [LA664FPU0, LA664FDiv]>;
}
def : ReadAdvance<ReadFRSQRT32, 0>;
def : ReadAdvance<ReadFRSQRT, 0>;

// Floating-point instruction latency FCVT FSEL
let Latency = 2 in {
  def : WriteRes<WriteFCvtStoD, [LA664FPU]>;
  def : WriteRes<WriteFCvtDtoS, [LA664FPU]>;
}
let Latency = 4 in {
  def : WriteRes<WriteFCvtStoW, [LA664FPU]>;
  def : WriteRes<WriteFCvtStoL, [LA664FPU]>;
  def : WriteRes<WriteFCvtDtoW, [LA664FPU]>;
  def : WriteRes<WriteFCvtDtoL, [LA664FPU]>;

  def : WriteRes<WriteFCvtWtoS, [LA664FPU]>;
  def : WriteRes<WriteFCvtWtoD, [LA664FPU]>;
  def : WriteRes<WriteFCvtLtoS, [LA664FPU]>;
  def : WriteRes<WriteFCvtLtoD, [LA664FPU]>;

  def : WriteRes<WriteFCvtWtoS_RM, [LA664FPU]>;
  def : WriteRes<WriteFCvtWtoD_RM, [LA664FPU]>;
  def : WriteRes<WriteFCvtLtoS_RM, [LA664FPU]>;
  def : WriteRes<WriteFCvtLtoD_RM, [LA664FPU]>;

  def : WriteRes<WriteFCvtWtoS_RP, [LA664FPU]>;
  def : WriteRes<WriteFCvtWtoD_RP, [LA664FPU]>;
  def : WriteRes<WriteFCvtLtoS_RP, [LA664FPU]>;
  def : WriteRes<WriteFCvtLtoD_RP, [LA664FPU]>;

  def : WriteRes<WriteFCvtWtoS_RZ, [LA664FPU]>;
  def : WriteRes<WriteFCvtWtoD_RZ, [LA664FPU]>;
  def : WriteRes<WriteFCvtLtoS_RZ, [LA664FPU]>;
  def : WriteRes<WriteFCvtLtoD_RZ, [LA664FPU]>;

  def : WriteRes<WriteFCvtWtoS_RNE, [LA664FPU]>;
  def : WriteRes<WriteFCvtWtoD_RNE, [LA664FPU]>;
  def : WriteRes<WriteFCvtLtoS_RNE, [LA664FPU]>;
  def : WriteRes<WriteFCvtLtoD_RNE, [LA664FPU]>;

  def : WriteRes<WriteFCvtFStoIS, [LA664FPU]>;
  def : WriteRes<WriteFCvtFDtoID, [LA664FPU]>;
}
def : ReadAdvance<ReadFCvtStoD, 0>;
def : ReadAdvance<ReadFCvtDtoS, 0>;

def : ReadAdvance<ReadFCvtStoW, 0>;
def : ReadAdvance<ReadFCvtStoL, 0>;
def : ReadAdvance<ReadFCvtDtoW, 0>;
def : ReadAdvance<ReadFCvtDtoL, 0>;

def : ReadAdvance<ReadFCvtWtoS, 0>;
def : ReadAdvance<ReadFCvtWtoD, 0>;
def : ReadAdvance<ReadFCvtLtoS, 0>;
def : ReadAdvance<ReadFCvtLtoD, 0>;

def : ReadAdvance<ReadFCvtWtoS_RM, 0>;
def : ReadAdvance<ReadFCvtWtoD_RM, 0>;
def : ReadAdvance<ReadFCvtLtoS_RM, 0>;
def : ReadAdvance<ReadFCvtLtoD_RM, 0>;

def : ReadAdvance<ReadFCvtWtoS_RP, 0>;
def : ReadAdvance<ReadFCvtWtoD_RP, 0>;
def : ReadAdvance<ReadFCvtLtoS_RP, 0>;
def : ReadAdvance<ReadFCvtLtoD_RP, 0>;

def : ReadAdvance<ReadFCvtWtoS_RZ, 0>;
def : ReadAdvance<ReadFCvtWtoD_RZ, 0>;
def : ReadAdvance<ReadFCvtLtoS_RZ, 0>;
def : ReadAdvance<ReadFCvtLtoD_RZ, 0>;

def : ReadAdvance<ReadFCvtWtoS_RNE, 0>;
def : ReadAdvance<ReadFCvtWtoD_RNE, 0>;
def : ReadAdvance<ReadFCvtLtoS_RNE, 0>;
def : ReadAdvance<ReadFCvtLtoD_RNE, 0>;

def : ReadAdvance<ReadFCvtFStoIS, 0>;
def : ReadAdvance<ReadFCvtFDtoID, 0>;

def : WriteRes<WriteFSEL, [LA664FCmp]>;
def : ReadAdvance<ReadFSEL, 0>;

// Floating-point instruction latency FMOV
def : WriteRes<WriteFMovS, [LA664FPU]>;
def : WriteRes<WriteFMovD, [LA664FPU]>;
def : WriteRes<WriteFMoveFRtoCF, [LA664FCmp]>;
def : WriteRes<WriteFMoveCFtoFR, [LA664FCmp]>;

def : ReadAdvance<ReadFMovS, 0>;
def : ReadAdvance<ReadFMovD, 0>;
def : ReadAdvance<ReadFMoveFRtoCF, 0>;
def : ReadAdvance<ReadFMoveCFtoFR, 0>;
let Latency = 2 in {
  def : WriteRes<WriteFMovGRtoFRW, [LA664FMov]>;
  def : WriteRes<WriteFMovGRtoFRD, [LA664FMov]>;
  def : WriteRes<WriteFMovFRtoGRS, [LA664FMov]>;
  def : WriteRes<WriteFMovFRHtoGRS, [LA664FMov]>;
  def : WriteRes<WriteFMovFRtoGRD, [LA664FMov]>;
}
let Latency = 3 in {
  def : WriteRes<WriteFMovGRtoFRHW, [LA664FMov]>;
}
def : ReadAdvance<ReadFMovGRtoFRW, 0>;
def : ReadAdvance<ReadFMovGRtoFRHW, 0>;
def : ReadAdvance<ReadFMovGRtoFRD, 0>;
def : ReadAdvance<ReadFMovFRtoGRS, 0>;
def : ReadAdvance<ReadFMovFRHtoGRS, 0>;
def : ReadAdvance<ReadFMovFRtoGRD, 0>;
let Latency = 2 in {
  def : WriteRes<WriteFMoveCFtoGR, [LA664FMov]>;
  def : WriteRes<WriteFMoveGRtoCF, [LA664FMov]>;
}
def : ReadAdvance<ReadFMoveCFtoGR, 0>;
def : ReadAdvance<ReadFMoveGRtoCF, 0>;
let Latency = 7 in {
  def : WriteRes<WriteFMovFCSRtoGR, [LA664FMov]>;
}
def : ReadAdvance<ReadFMovFCSRtoGR, 0>;
let Latency = 15 in {
  def : WriteRes<WriteFMovGRtoFCSR, [LA664FMov]>;
}
def : ReadAdvance<ReadFMovGRtoFCSR, 0>;

// Floating-point instruction latency FJUMP
def : WriteRes<WriteFJump, [LA664Branch]>;

def : ReadAdvance<ReadFJump, 0>;

// Floating-point instruction latency FLD FST FLDX FSTX
let Latency = 5 in {
  def : WriteRes<WriteFLD, [LA664LoadAGU, LA664Load]>;
  def : WriteRes<WriteFST, [LA664StoreAGU, LA664Store]>;
  def : WriteRes<WriteFLDX, [LA664LoadAGU, LA664Load]>;
  def : WriteRes<WriteFSTX, [LA664StoreAGU, LA664Store]>;
}
def : ReadAdvance<ReadFSTData, 0>;
def : ReadAdvance<ReadFMemBase, 0>;
def : ReadAdvance<ReadFMemOffset, 0>;

// Floating-point instruction latency FLDGT FLDLE FSTGT FSTLE
let Latency = 5 in {
  def : WriteRes<WriteFLDGT, [LA664LoadAGU, LA664Load, LA664FCmp]>;
  def : WriteRes<WriteFLDLE, [LA664LoadAGU, LA664Load, LA664FCmp]>;
  def : WriteRes<WriteFSTGT, [LA664StoreAGU, LA664Store, LA664FCmp]>;
  def : WriteRes<WriteFSTLE, [LA664StoreAGU, LA664Store, LA664FCmp]>;
}
def : ReadAdvance<ReadFMemCmp, 0>;

// Floating-point instruction latency FRECIPE/FRSQRTE
let Latency = 5 in {
  def : WriteRes<WriteFRECIPE, [LA664FMul]>;
  def : WriteRes<WriteFRSQRTE, [LA664FMul]>;
}
def : ReadAdvance<ReadFRECIPE, 0>;
def : ReadAdvance<ReadFRSQRTE, 0>;

// Integer instruction latency PCADD
let Latency = 1 in {
  def : WriteRes<WriteIPCAdd, [LA664LoadAGU]>;
}
def : ReadAdvance<ReadIPCAdd, 0>;

let Unsupported = true in {
  def : WriteRes<WriteAtomic, []>;
  def : ReadAdvance<ReadAtomic, 0>;
}

let Unsupported = true in {
  def : WriteRes<WritePseudo, []>;
  def : ReadAdvance<ReadPseudo, 0>;
}

let Unsupported = true in {
  def : WriteRes<WriteOthers, []>;
  def : ReadAdvance<ReadOthers, 0>;
}

} // SchedModel