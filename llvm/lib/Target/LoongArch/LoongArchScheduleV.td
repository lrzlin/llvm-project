//===-- LoongArchScheduleV.td - LoongArch Scheduling Definitions ---*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

/// Define scheduler resources associated with def operands.

/// Vector instruction - LSX / LASX

/// Vector instruction - ALU MUL DIV ...
def WriteVALU128         : SchedWrite;   // 128-bit integer ALU
def WriteVALU256         : SchedWrite;   // 256-bit integer ALU
def ReadVALU128          : SchedRead;    // 128-bit integer ALU
def ReadVALU256          : SchedRead;    // 256-bit integer ALU
//===----------------------------------------------------------------------===//
// VADD.B/H/W/D/Q                        Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VSUB.B/H/W/D/Q                        Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVADD.B/H/W/D/Q                       Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVSUB.B/H/W/D/Q                       Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VADDI.BU/HU/WU/DU                     Sched<[WriteVALU128, ReadVALU128]>
// VSUBI.BU/HU/WU/DU                     Sched<[WriteVALU128, ReadVALU128]>
// XVADDI.BU/HU/WU/DU                    Sched<[WriteVALU256, ReadVALU256]>
// XVSUBI.BU/HU/WU/DU                    Sched<[WriteVALU256, ReadVALU256]>

// VNEG.B/H/W/D                          Sched<[WriteVALU128, ReadVALU128]>
// XVNEG.B/H/W/D                         Sched<[WriteVALU256, ReadVALU256]>

// VSADD.B/H/W/D                         Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VSSUB.B/H/W/D                         Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVSADD.B/H/W/D                        Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVSSUB.B/H/W/D                        Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VSADD.BU/HU/WU/DU                     Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VSSUB.BU/HU/WU/DU                     Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVSADD.BU/HU/WU/DU                    Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVSSUB.BU/HU/WU/DU                    Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VHADDW.H/W/D/Q.B/H/W/D                Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VHSUBW.H/W/D/Q.B/H/W/D                Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VHADDW.HU/WU/DU/QU.BU/HU/WU/DU        Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VHSUBW.HU/WU/DU/QU.BU/HU/WU/DU        Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVHADDW.H/W/D/Q.B/H/W/D               Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVHSUBW.H/W/D/Q.B/H/W/D               Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVHADDW.HU/WU/DU/QU.BU/HU/WU/DU       Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVHSUBW.HU/WU/DU/QU.BU/HU/WU/DU       Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VADDWEV.H/W/D/Q.B/H/W/D               Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VSUBWEV.H/W/D/Q.B/H/W/D               Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVADDWEV.H/W/D/Q.B/H/W/D              Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVSUBWEV.H/W/D/Q.B/H/W/D              Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VADDWOD.H/W/D/Q.B/H/W/D               Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VSUBWOD.H/W/D/Q.B/H/W/D               Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVADDWOD.H/W/D/Q.B/H/W/D              Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVSUBWOD.H/W/D/Q.B/H/W/D              Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VADDWEV.H/W/D/Q.BU/HU/WU/DU           Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VSUBWEV.H/W/D/Q.BU/HU/WU/DU           Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVADDWEV.H/W/D/Q.BU/HU/WU/DU          Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVSUBWEV.H/W/D/Q.BU/HU/WU/DU          Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VADDWOD.H/W/D/Q.BU/HU/WU/DU           Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VSUBWOD.H/W/D/Q.BU/HU/WU/DU           Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVADDWOD.H/W/D/Q.BU/HU/WU/DU          Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVSUBWOD.H/W/D/Q.BU/HU/WU/DU          Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VADDWEV.H/W/D/Q.BU/HU/WU/DU.B/H/W/D   Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VADDWOD.H/W/D/Q.BU/HU/WU/DU.B/H/W/D   Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVADDWEV.H/W/D/Q.BU/HU/WU/DU.B/H/W/D  Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVADDWOD.H/W/D/Q.BU/HU/WU/DU.B/H/W/D  Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VAVG.B/H/W/D                          Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VAVGR.B/H/W/D                         Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VAVG.BU/HU/WU/DU                      Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VAVGR.BU/HU/WU/DU                     Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVAVG.B/H/W/D                         Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVAVGR.B/H/W/D                        Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVAVG.BU/HU/WU/DU                     Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVAVGR.BU/HU/WU/DU                    Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VABSD.B/H/W/D                         Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VABSD.BU/HU/WU/DU                     Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVABSD.B/H/W/D                        Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVABSD.BU/HU/WU/DU                    Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VADDA.B/H/W/D                         Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVADDA.B/H/W/D                        Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VMAX.B/H/W/D                          Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VMIN.B/H/W/D                          Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VMAX.BU/HU/WU/DU                      Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// VMIN.BU/HU/WU/DU                      Sched<[WriteVALU128, ReadVALU128, ReadVALU128]>
// XVMAX.B/H/W/D                         Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVMIN.B/H/W/D                         Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVMAX.BU/HU/WU/DU                     Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>
// XVMIN.BU/HU/WU/DU                     Sched<[WriteVALU256, ReadVALU256, ReadVALU256]>

// VMAXI.B/H/W/D                         Sched<[WriteVALU128, ReadVALU128]>
// VMINI.B/H/W/D                         Sched<[WriteVALU128, ReadVALU128]>
// VMAXI.BU/HU/WU/DU                     Sched<[WriteVALU128, ReadVALU128]>
// VMINI.BU/HU/WU/DU                     Sched<[WriteVALU128, ReadVALU128]>
// XVMAXI.B/H/W/D                        Sched<[WriteVALU256, ReadVALU256]>
// XVMINI.B/H/W/D                        Sched<[WriteVALU256, ReadVALU256]>
// XVMAXI.BU/HU/WU/DU                    Sched<[WriteVALU256, ReadVALU256]>
// XVMINI.BU/HU/WU/DU                    Sched<[WriteVALU256, ReadVALU256]>
//===----------------------------------------------------------------------===//

def WriteVMUL128         : SchedWrite;   // 128-bit integer MUL
def WriteVMUL256         : SchedWrite;   // 256-bit integer MUL
def ReadVMUL128          : SchedRead;    // 128-bit integer MUL
def ReadVMUL256          : SchedRead;    // 256-bit integer MUL
//===----------------------------------------------------------------------===//
// VMUL.B/H/W/D                          Sched<[WriteVMUL128, ReadVMUL128, ReadVMUL128]>
// VMUH.B/H/W/D                          Sched<[WriteVMUL128, ReadVMUL128, ReadVMUL128]>
// VMUH.BU/HU/WU/DU                      Sched<[WriteVMUL128, ReadVMUL128, ReadVMUL128]>
// XVMUL.B/H/W/D                         Sched<[WriteVMUL256, ReadVMUL256, ReadVMUL256]>
// XVMUH.B/H/W/D                         Sched<[WriteVMUL256, ReadVMUL256, ReadVMUL256]>
// XVMUH.BU/HU/WU/DU                     Sched<[WriteVMUL256, ReadVMUL256, ReadVMUL256]>

// VMULWEV.H/W/D/Q.B/H/W/D               Sched<[WriteVMUL128, ReadVMUL128, ReadVMUL128]>
// VMULWEV.H/W/D/Q.BU/HU/WU/DU           Sched<[WriteVMUL128, ReadVMUL128, ReadVMUL128]>
// VMULWEV.H/W/D/Q.BU/HU/WU/DU.B/H/W/D   Sched<[WriteVMUL128, ReadVMUL128, ReadVMUL128]>
// XVMULWEV.H/W/D/Q.B/H/W/D              Sched<[WriteVMUL256, ReadVMUL256, ReadVMUL256]>
// XVMULWEV.H/W/D/Q.BU/HU/WU/DU          Sched<[WriteVMUL256, ReadVMUL256, ReadVMUL256]>
// XVMULWEV.H/W/D/Q.BU/HU/WU/DU.B/H/W/D  Sched<[WriteVMUL256, ReadVMUL256, ReadVMUL256]>

// VMULWOD.H/W/D/Q.B/H/W/D               Sched<[WriteVMUL128, ReadVMUL128, ReadVMUL128]>
// VMULWOD.H/W/D/Q.BU/HU/WU/DU           Sched<[WriteVMUL128, ReadVMUL128, ReadVMUL128]>
// VMULWOD.H/W/D/Q.BU/HU/WU/DU.B/H/W/D   Sched<[WriteVMUL128, ReadVMUL128, ReadVMUL128]>
// XVMULWOD.H/W/D/Q.B/H/W/D              Sched<[WriteVMUL256, ReadVMUL256, ReadVMUL256]>
// XVMULWOD.H/W/D/Q.BU/HU/WU/DU          Sched<[WriteVMUL256, ReadVMUL256, ReadVMUL256]>
// XVMULWOD.H/W/D/Q.BU/HU/WU/DU.B/H/W/D  Sched<[WriteVMUL256, ReadVMUL256, ReadVMUL256]>
//===----------------------------------------------------------------------===//

def WriteVMADD128        : SchedWrite;   // 128-bit integer MADD
def WriteVMADD256        : SchedWrite;   // 256-bit integer MADD
def ReadVMADD128         : SchedRead;    // 128-bit integer MADD
def ReadVMADD256         : SchedRead;    // 256-bit integer MADD
//===----------------------------------------------------------------------===//
// VMADD.B/H/W/D                         Sched<[WriteVMADD128, ReadVMADD128, ReadVMADD128]>
// VMSUB.B/H/W/D                         Sched<[WriteVMADD128, ReadVMADD128, ReadVMADD128]>
// XVMADD.B/H/W/D                        Sched<[WriteVMADD256, ReadVMADD256, ReadVMADD256]>
// XVMSUB.B/H/W/D                        Sched<[WriteVMADD256, ReadVMADD256, ReadVMADD256]>

// VMADDWEV.H/W/D.B/H/W                  Sched<[WriteVMADD128, ReadVMADD128, ReadVMADD128]>
// VMADDWEV.H/W/D.BU/HU/WU               Sched<[WriteVMADD128, ReadVMADD128, ReadVMADD128]>
// VMADDWEV.H/W/D.BU/HU/WU.B/H/W         Sched<[WriteVMADD128, ReadVMADD128, ReadVMADD128]>
// XVMADDWEV.H/W/D.B/H/W                 Sched<[WriteVMADD256, ReadVMADD256, ReadVMADD256]>
// XVMADDWEV.H/W/D.BU/HU/WU              Sched<[WriteVMADD256, ReadVMADD256, ReadVMADD256]>
// XVMADDWEV.H/W/D.BU/HU/WU.B/H/W        Sched<[WriteVMADD256, ReadVMADD256, ReadVMADD256]>

// VMADDWOD.H/W/D.B/H/W                  Sched<[WriteVMADD128, ReadVMADD128, ReadVMADD128]>
// VMADDWOD.H/W/D.BU/HU/WU               Sched<[WriteVMADD128, ReadVMADD128, ReadVMADD128]>
// VMADDWOD.H/W/D.BU/HU/WU.B/H/W         Sched<[WriteVMADD128, ReadVMADD128, ReadVMADD128]>
// XVMADDWOD.H/W/D.B/H/W                 Sched<[WriteVMADD256, ReadVMADD256, ReadVMADD256]>
// XVMADDWOD.H/W/D.BU/HU/WU              Sched<[WriteVMADD256, ReadVMADD256, ReadVMADD256]>
// XVMADDWOD.H/W/D.BU/HU/WU.B/H/W        Sched<[WriteVMADD256, ReadVMADD256, ReadVMADD256]>
//===----------------------------------------------------------------------===//

def WriteVMADDQ128       : SchedWrite;   // 128-bit integer MADDQ
def WriteVMADDQ256       : SchedWrite;   // 256-bit integer MADDQ
def ReadVMADDQ128        : SchedRead;    // 128-bit integer MADDQ
def ReadVMADDQ256        : SchedRead;    // 256-bit integer MADDQ
//===----------------------------------------------------------------------===//
// VMADDWEV.Q.D          Sched<[WriteVMADDQ128, ReadVMADDQ128, ReadVMADDQ128]>
// VMADDWEV.Q.DU         Sched<[WriteVMADDQ128, ReadVMADDQ128, ReadVMADDQ128]>
// VMADDWEV.Q.DU.D       Sched<[WriteVMADDQ128, ReadVMADDQ128, ReadVMADDQ128]>
// XVMADDWEV.Q.D         Sched<[WriteVMADDQ256, ReadVMADDQ256, ReadVMADDQ256]>
// XVMADDWEV.Q.DU        Sched<[WriteVMADDQ256, ReadVMADDQ256, ReadVMADDQ256]>
// XVMADDWEV.Q.DU.D      Sched<[WriteVMADDQ256, ReadVMADDQ256, ReadVMADDQ256]>

// VMADDWOD.Q.D          Sched<[WriteVMADDQ128, ReadVMADDQ128, ReadVMADDQ128]>
// VMADDWOD.Q.DU         Sched<[WriteVMADDQ128, ReadVMADDQ128, ReadVMADDQ128]>
// VMADDWOD.Q.DU.D       Sched<[WriteVMADDQ128, ReadVMADDQ128, ReadVMADDQ128]>
// XVMADDWOD.Q.D         Sched<[WriteVMADDQ256, ReadVMADDQ256, ReadVMADDQ256]>
// XVMADDWOD.Q.DU        Sched<[WriteVMADDQ256, ReadVMADDQ256, ReadVMADDQ256]>
// XVMADDWOD.Q.DU.D      Sched<[WriteVMADDQ256, ReadVMADDQ256, ReadVMADDQ256]>
//===----------------------------------------------------------------------===//

def WriteVDIV128B        : SchedWrite;   // 128-bit integer DIVB
def WriteVDIV256B        : SchedWrite;   // 256-bit integer DIVB
def ReadVDIV128B         : SchedRead;    // 128-bit integer DIVB
def ReadVDIV256B         : SchedRead;    // 256-bit integer DIVB
//===----------------------------------------------------------------------===//
// VDIV.B                Sched<[WriteVDIV128B, ReadVDIV128B, ReadVDIV128B]>
// VDIV.BU               Sched<[WriteVDIV128B, ReadVDIV128B, ReadVDIV128B]>
// VMOD.B                Sched<[WriteVDIV128B, ReadVDIV128B, ReadVDIV128B]>
// VMOD.BU               Sched<[WriteVDIV128B, ReadVDIV128B, ReadVDIV128B]>
// XVDIV.B               Sched<[WriteVDIV256B, ReadVDIV256B, ReadVDIV256B]>
// XVDIV.BU              Sched<[WriteVDIV256B, ReadVDIV256B, ReadVDIV256B]>
// XVMOD.B               Sched<[WriteVDIV256B, ReadVDIV256B, ReadVDIV256B]>
// XVMOD.BU              Sched<[WriteVDIV256B, ReadVDIV256B, ReadVDIV256B]>
//===----------------------------------------------------------------------===//

def WriteVDIV128H        : SchedWrite;   // 128-bit integer DIVH
def WriteVDIV256H        : SchedWrite;   // 256-bit integer DIVH
def ReadVDIV128H         : SchedRead;    // 128-bit integer DIVH
def ReadVDIV256H         : SchedRead;    // 256-bit integer DIVH
//===----------------------------------------------------------------------===//
// VDIV.H                Sched<[WriteVDIV128H, ReadVDIV128H, ReadVDIV128H]>
// VDIV.HU               Sched<[WriteVDIV128H, ReadVDIV128H, ReadVDIV128H]>
// VMOD.H                Sched<[WriteVDIV128H, ReadVDIV128H, ReadVDIV128H]>
// VMOD.HU               Sched<[WriteVDIV128H, ReadVDIV128H, ReadVDIV128H]>
// XVDIV.H               Sched<[WriteVDIV256H, ReadVDIV256H, ReadVDIV256H]>
// XVDIV.HU              Sched<[WriteVDIV256H, ReadVDIV256H, ReadVDIV256H]>
// XVMOD.H               Sched<[WriteVDIV256H, ReadVDIV256H, ReadVDIV256H]>
// XVMOD.HU              Sched<[WriteVDIV256H, ReadVDIV256H, ReadVDIV256H]>
//===----------------------------------------------------------------------===//

def WriteVDIV128W        : SchedWrite;   // 128-bit integer DIVW
def WriteVDIV256W        : SchedWrite;   // 256-bit integer DIVW
def ReadVDIV128W         : SchedRead;    // 128-bit integer DIVW
def ReadVDIV256W         : SchedRead;    // 256-bit integer DIVW
//===----------------------------------------------------------------------===//
// VDIV.W                Sched<[WriteVDIV128W, ReadVDIV128W, ReadVDIV128W]>
// VDIV.WU               Sched<[WriteVDIV128W, ReadVDIV128W, ReadVDIV128W]>
// VMOD.W                Sched<[WriteVDIV128W, ReadVDIV128W, ReadVDIV128W]>
// VMOD.WU               Sched<[WriteVDIV128W, ReadVDIV128W, ReadVDIV128W]>
// XVDIV.W               Sched<[WriteVDIV256W, ReadVDIV256W, ReadVDIV256W]>
// XVDIV.WU              Sched<[WriteVDIV256W, ReadVDIV256W, ReadVDIV256W]>
// XVMOD.W               Sched<[WriteVDIV256W, ReadVDIV256W, ReadVDIV256W]>
// XVMOD.WU              Sched<[WriteVDIV256W, ReadVDIV256W, ReadVDIV256W]>
//===----------------------------------------------------------------------===//

def WriteVDIV128D        : SchedWrite;   // 128-bit integer DIVD
def WriteVDIV256D        : SchedWrite;   // 256-bit integer DIVD
def ReadVDIV128D         : SchedRead;    // 128-bit integer DIVD
def ReadVDIV256D         : SchedRead;    // 256-bit integer DIVD
//===----------------------------------------------------------------------===//
// VDIV.D                Sched<[WriteVDIV128D, ReadVDIV128D, ReadVDIV128D]>
// VDIV.DU               Sched<[WriteVDIV128D, ReadVDIV128D, ReadVDIV128D]>
// VMOD.D                Sched<[WriteVDIV128D, ReadVDIV128D, ReadVDIV128D]>
// VMOD.DU               Sched<[WriteVDIV128D, ReadVDIV128D, ReadVDIV128D]>
// XVDIV.D               Sched<[WriteVDIV256D, ReadVDIV256D, ReadVDIV256D]>
// XVDIV.DU              Sched<[WriteVDIV256D, ReadVDIV256D, ReadVDIV256D]>
// XVMOD.D               Sched<[WriteVDIV256D, ReadVDIV256D, ReadVDIV256D]>
// XVMOD.DU              Sched<[WriteVDIV256D, ReadVDIV256D, ReadVDIV256D]>
//===----------------------------------------------------------------------===//

def WriteVSAT128         : SchedWrite;   // 128-bit integer SAT
def WriteVSAT256         : SchedWrite;   // 256-bit integer SAT
def ReadVSAT128          : SchedRead;    // 128-bit integer SAT
def ReadVSAT256          : SchedRead;    // 256-bit integer SAT
//===----------------------------------------------------------------------===//
// VSAT.B/H/W/D          Sched<[WriteVSAT128, ReadVSAT128]>
// VSAT.BU/HU/WU/DU      Sched<[WriteVSAT128, ReadVSAT128]>
// XVSAT.B/H/W/D         Sched<[WriteVSAT256, ReadVSAT256]>
// XVSAT.BU/HU/WU/DU     Sched<[WriteVSAT256, ReadVSAT256]>
//===----------------------------------------------------------------------===//

def WriteVEXT128         : SchedWrite;   // 128-bit integer EXT
def WriteVEXT256         : SchedWrite;   // 256-bit integer EXT
def ReadVEXT128          : SchedRead;    // 128-bit integer EXT
def ReadVEXT256          : SchedRead;    // 256-bit integer EXT
//===----------------------------------------------------------------------===//
// VEXTH.H/W/D/Q.B/H/W/D                 Sched<[WriteVEXT128, ReadVEXT128]>
// VEXTH.HU/WU/DU/QU.BU/HU/WU/DU         Sched<[WriteVEXT128, ReadVEXT128]>
// XVEXTH.H/W/D/Q.B/H/W/D                Sched<[WriteVEXT256, ReadVEXT256]>
// XVEXTH.HU/WU/DU/QU.BU/HU/WU/DU        Sched<[WriteVEXT256, ReadVEXT256]>

// VEXTXV.H/W/D.B        Sched<[WriteVEXT128, ReadVEXT128]>
// VEXTXV.W/D.H          Sched<[WriteVEXT128, ReadVEXT128]>
// VEXTXV.D.W            Sched<[WriteVEXT128, ReadVEXT128]>
// XVEXTXV.H/W/D.B       Sched<[WriteVEXT256, ReadVEXT256]>
// XVEXTXV.W/D.H         Sched<[WriteVEXT256, ReadVEXT256]>
// XVEXTXV.D.W           Sched<[WriteVEXT256, ReadVEXT256]>
//===----------------------------------------------------------------------===//

def WriteVSIGNCOV128     : SchedWrite;   // 128-bit integer SIGNCOV
def WriteVSIGNCOV256     : SchedWrite;   // 256-bit integer SIGNCOV
def ReadVSIGNCOV128      : SchedRead;    // 128-bit integer SIGNCOV
def ReadVSIGNCOV256      : SchedRead;    // 256-bit integer SIGNCOV
//===----------------------------------------------------------------------===//
// VSIGNCOV.B/H/W/D      Sched<[WriteVSIGNCOV128, ReadVSIGNCOV128, ReadVSIGNCOV128]>
// XVSIGNCOV.B/H/W/D     Sched<[WriteVSIGNCOV256, ReadVSIGNCOV256, ReadVSIGNCOV256]>
//===----------------------------------------------------------------------===//

def WriteVMSK128         : SchedWrite;   // 128-bit integer MSK
def WriteVMSK256         : SchedWrite;   // 256-bit integer MSK
def ReadVMSK128          : SchedRead;    // 128-bit integer MSK
def ReadVMSK256          : SchedRead;    // 256-bit integer MSK
//===----------------------------------------------------------------------===//
// VMSKLTZ.B/H/W/D       Sched<[WriteVMSK128, ReadVMSK128]>
// XVMSKLTZ.B/H/W/D      Sched<[WriteVMSK256, ReadVMSK256]>
// VMSKGEZ.B             Sched<[WriteVMSK128, ReadVMSK128]>
// VMSKNZ.B              Sched<[WriteVMSK128, ReadVMSK128]>
// XVMSKGEZ.B            Sched<[WriteVMSK256, ReadVMSK256]>
// XVMSKNZ.B             Sched<[WriteVMSK256, ReadVMSK256]>
//===----------------------------------------------------------------------===//

def WriteVLDI128         : SchedWrite;   // 128-bit integer LDI
def WriteVLDI256         : SchedWrite;   // 256-bit integer LDI
def ReadVLDI128          : SchedRead;    // 128-bit integer LDI
def ReadVLDI256          : SchedRead;    // 256-bit integer LDI
//===----------------------------------------------------------------------===//
// VLDI                  Sched<[WriteVLDI128]>
// XVLDI                 Sched<[WriteVLDI256]>
//===----------------------------------------------------------------------===//

/// Vector instruction - BIT ...
def WriteVBIT128         : SchedWrite;   // 128-bit integer BIT
def WriteVBIT256         : SchedWrite;   // 256-bit integer BIT
def ReadVBIT128          : SchedRead;    // 128-bit integer BIT
def ReadVBIT256          : SchedRead;    // 256-bit integer BIT
//===----------------------------------------------------------------------===//
// VAND.V                Sched<[WriteVBIT128, ReadVBIT128, ReadVBIT128]>
// VANDN.V               Sched<[WriteVBIT128, ReadVBIT128, ReadVBIT128]>
// VOR.V                 Sched<[WriteVBIT128, ReadVBIT128, ReadVBIT128]>
// VXOR.V                Sched<[WriteVBIT128, ReadVBIT128, ReadVBIT128]>
// VNOR.V                Sched<[WriteVBIT128, ReadVBIT128, ReadVBIT128]>
// VORN.V                Sched<[WriteVBIT128, ReadVBIT128, ReadVBIT128]>
// XVAND.V               Sched<[WriteVBIT256, ReadVBIT256, ReadVBIT256]>
// XVANDN.V              Sched<[WriteVBIT256, ReadVBIT256, ReadVBIT256]>
// XVOR.V                Sched<[WriteVBIT256, ReadVBIT256, ReadVBIT256]>
// XVXOR.V               Sched<[WriteVBIT256, ReadVBIT256, ReadVBIT256]>
// XVNOR.V               Sched<[WriteVBIT256, ReadVBIT256, ReadVBIT256]>
// XVORN.V               Sched<[WriteVBIT256, ReadVBIT256, ReadVBIT256]>

// VANDI.B               Sched<[WriteVBIT128, ReadVBIT128]>
// VORI.B                Sched<[WriteVBIT128, ReadVBIT128]>
// VXORI.B               Sched<[WriteVBIT128, ReadVBIT128]>
// VNORI.B               Sched<[WriteVBIT128, ReadVBIT128]>
// XVANDI.B              Sched<[WriteVBIT256, ReadVBIT256]>
// XVORI.B               Sched<[WriteVBIT256, ReadVBIT256]>
// XVXORI.B              Sched<[WriteVBIT256, ReadVBIT256]>
// XVNORI.B              Sched<[WriteVBIT256, ReadVBIT256]>
//===----------------------------------------------------------------------===//

/// Vector instruction - SHIFT ...
def WriteVSHIFT128       : SchedWrite;   // 128-bit integer SHIFT
def WriteVSHIFT256       : SchedWrite;   // 256-bit integer SHIFT
def ReadVSHIFT128        : SchedRead;    // 128-bit integer SHIFT
def ReadVSHIFT256        : SchedRead;    // 256-bit integer SHIFT
//===----------------------------------------------------------------------===//
// VSLL.B/H/W/D          Sched<[WriteVSHIFT128, ReadVSHIFT128, ReadVSHIFT128]>
// VSRL.B/H/W/D          Sched<[WriteVSHIFT128, ReadVSHIFT128, ReadVSHIFT128]>
// VSRA.B/H/W/D          Sched<[WriteVSHIFT128, ReadVSHIFT128, ReadVSHIFT128]>
// VROTR.B/H/W/D         Sched<[WriteVSHIFT128, ReadVSHIFT128, ReadVSHIFT128]>

// XVSLL.B/H/W/D         Sched<[WriteVSHIFT256, ReadVSHIFT256, ReadVSHIFT256]>
// XVSRL.B/H/W/D         Sched<[WriteVSHIFT256, ReadVSHIFT256, ReadVSHIFT256]>
// XVSRA.B/H/W/D         Sched<[WriteVSHIFT256, ReadVSHIFT256, ReadVSHIFT256]>
// XVROTR.B/H/W/D        Sched<[WriteVSHIFT256, ReadVSHIFT256, ReadVSHIFT256]>

// VSLLI.B/H/W/D         Sched<[WriteVSHIFT128, ReadVSHIFT128]>
// VSRLI.B/H/W/D         Sched<[WriteVSHIFT128, ReadVSHIFT128]>
// VSRAI.B/H/W/D         Sched<[WriteVSHIFT128, ReadVSHIFT128]>
// VROTRI.B/H/W/D        Sched<[WriteVSHIFT128, ReadVSHIFT128]>

// XVSLLI.B/H/W/D        Sched<[WriteVSHIFT256, ReadVSHIFT256]>
// XVSRLI.B/H/W/D        Sched<[WriteVSHIFT256, ReadVSHIFT256]>
// XVSRAI.B/H/W/D        Sched<[WriteVSHIFT256, ReadVSHIFT256]>
// XVROTRI.B/H/W/D       Sched<[WriteVSHIFT256, ReadVSHIFT256]>
//===----------------------------------------------------------------------===//

def WriteVSLLWIL128      : SchedWrite;   // 128-bit integer SLLWIL
def WriteVSLLWIL256      : SchedWrite;   // 256-bit integer SLLWIL
def ReadVSLLWIL128       : SchedRead;    // 128-bit integer SLLWIL
def ReadVSLLWIL256       : SchedRead;    // 256-bit integer SLLWIL
def WriteVEXTL128        : SchedWrite;   // 128-bit integer EXTL
def WriteVEXTL256        : SchedWrite;   // 256-bit integer EXTL
def ReadVEXTL128         : SchedRead;    // 128-bit integer EXTL
def ReadVEXTL256         : SchedRead;    // 256-bit integer EXTL
//===----------------------------------------------------------------------===//
// VSLLWIL.H/W/D.B/H/W              Sched<[WriteVSLLWIL128, ReadVSLLWIL128]>
// VEXTL.Q.D                        Sched<[WriteVEXTL128, ReadVEXTL128]>
// VSLLWIL.HU/WU/DU.BU/HU/WU        Sched<[WriteVSLLWIL128, ReadVSLLWIL128]>
// VEXTL.QU.DU                      Sched<[WriteVEXTL128, ReadVEXTL128]>
// XVSLLWIL.H/W/D.B/H/W             Sched<[WriteVSLLWIL256, ReadVSLLWIL256]>
// XVEXTL.Q.D                       Sched<[WriteVEXTL256, ReadVEXTL256]>
// XVSLLWIL.HU/WU/DU.BU/HU/WU       Sched<[WriteVSLLWIL256, ReadVSLLWIL256]>
// XVEXTL.QU.DU                     Sched<[WriteVEXTL256, ReadVEXTL256]>
//===----------------------------------------------------------------------===//

def WriteVSHIFTR128      : SchedWrite;   // 128-bit integer SRLR / SRAR
def WriteVSHIFTR256      : SchedWrite;   // 256-bit integer SRLR / SRAR
def ReadVSHIFTR128       : SchedRead;    // 128-bit integer SRLR / SRAR
def ReadVSHIFTR256       : SchedRead;    // 256-bit integer SRLR / SRAR
//===----------------------------------------------------------------------===//
// VSRLR.B/H/W/D      Sched<[WriteVSHIFTR128, ReadVSHIFTR128, ReadVSHIFTR128]>
// VSRAR.B/H/W/D      Sched<[WriteVSHIFTR128, ReadVSHIFTR128, ReadVSHIFTR128]>
// XVSRLR.B/H/W/D     Sched<[WriteVSHIFTR256, ReadVSHIFTR256, ReadVSHIFTR256]>
// XVSRAR.B/H/W/D     Sched<[WriteVSHIFTR256, ReadVSHIFTR256, ReadVSHIFTR256]>
// VSRLRI.B/H/W/D     Sched<[WriteVSHIFTR128, ReadVSHIFTR128]>
// VSRARI.B/H/W/D     Sched<[WriteVSHIFTR128, ReadVSHIFTR128]>
// XVSRLRI.B/H/W/D    Sched<[WriteVSHIFTR256, ReadVSHIFTR256]>
// XVSRARI.B/H/W/D    Sched<[WriteVSHIFTR256, ReadVSHIFTR256]>
//===----------------------------------------------------------------------===//

def WriteVSHIFTN128      : SchedWrite;   // 128-bit integer SRLN / SRAN
def WriteVSHIFTN256      : SchedWrite;   // 256-bit integer SRLN / SRAN
def ReadVSHIFTN128       : SchedRead;    // 128-bit integer SRLN / SRAN
def ReadVSHIFTN256       : SchedRead;    // 256-bit integer SRLN / SRAN
//===----------------------------------------------------------------------===//
// VSRLN.B/H/W.H/W/D   Sched<[WriteVSHIFTN128, ReadVSHIFTN128, ReadVSHIFTN128]>
// VSRAN.B/H/W.H/W/D   Sched<[WriteVSHIFTN128, ReadVSHIFTN128, ReadVSHIFTN128]>
// XVSRLN.B/H/W.H/W/D  Sched<[WriteVSHIFTN256, ReadVSHIFTN256, ReadVSHIFTN256]> 
// XVSRAN.B/H/W.H/W/D  Sched<[WriteVSHIFTN256, ReadVSHIFTN256, ReadVSHIFTN256]>
//===----------------------------------------------------------------------===//

def WriteVSHIFTNI128     : SchedWrite;   // 128-bit integer SRLNI / SRANI
def WriteVSHIFTNI256     : SchedWrite;   // 256-bit integer SRLNI / SRANI
def ReadVSHIFTNI128      : SchedRead;    // 128-bit integer SRLNI / SRANI
def ReadVSHIFTNI256      : SchedRead;    // 256-bit integer SRLNI / SRANI
//===----------------------------------------------------------------------===//
// VSRLNI.B/H/W.H/W/D    Sched<[WriteVSHIFTNI128, ReadVSHIFTNI128]>
// VSRANI.B/H/W.H/W/D    Sched<[WriteVSHIFTNI128, ReadVSHIFTNI128]>
// XVSRLNI.B/H/W.H/W/D   Sched<[WriteVSHIFTNI256, ReadVSHIFTNI256]>
// XVSRANI.B/H/W.H/W/D   Sched<[WriteVSHIFTNI256, ReadVSHIFTNI256]>
 //===----------------------------------------------------------------------===//
def WriteVSHIFTNI128Q    : SchedWrite;   // 128-bit integer SRLNI / SRANI
def WriteVSHIFTNI256Q    : SchedWrite;   // 256-bit integer SRLNI / SRANI
def ReadVSHIFTNI128Q     : SchedRead;    // 128-bit integer SRLNI / SRANI
def ReadVSHIFTNI256Q     : SchedRead;    // 256-bit integer SRLNI / SRANI
//===----------------------------------------------------------------------===//
// VSRLNI.D.Q            Sched<[WriteVSHIFTNI128Q, ReadVSHIFTNI128Q]>
// VSRANI.D.Q            Sched<[WriteVSHIFTNI128Q, ReadVSHIFTNI128Q]>
// XVSRLNI.D.Q           Sched<[WriteVSHIFTNI256Q, ReadVSHIFTNI256Q]>
// XVSRANI.D.Q           Sched<[WriteVSHIFTNI256Q, ReadVSHIFTNI256Q]>
//===----------------------------------------------------------------------===//

def WriteVSHIFTRN128     : SchedWrite;   // 128-bit integer SRLRN / SRARN
def WriteVSHIFTRN256     : SchedWrite;   // 256-bit integer SRLRN / SRARN
def ReadVSHIFTRN128      : SchedRead;    // 128-bit integer SRLRN / SRARN
def ReadVSHIFTRN256      : SchedRead;    // 256-bit integer SRLRN / SRARN
//===----------------------------------------------------------------------===//
// VSRLRN.B/H/W.H/W/D   Sched<[WriteVSHIFTRN128, ReadVSHIFTRN128, ReadVSHIFTRN128]>
// VSRARN.B/H/W.H/W/D   Sched<[WriteVSHIFTRN128, ReadVSHIFTRN128, ReadVSHIFTRN128]>
// XVSRLRN.B/H/W.H/W/D  Sched<[WriteVSHIFTRN256, ReadVSHIFTRN256, ReadVSHIFTRN256]>
// XVSRARN.B/H/W.H/W/D  Sched<[WriteVSHIFTRN256, ReadVSHIFTRN256, ReadVSHIFTRN256]>
//===----------------------------------------------------------------------===//

def WriteVSHIFTRNI128    : SchedWrite;   // 128-bit integer SRLRNI / SRARNI
def WriteVSHIFTRNI256    : SchedWrite;   // 256-bit integer SRLRNI / SRARNI
def ReadVSHIFTRNI128     : SchedRead;    // 128-bit integer SRLRNI / SRARNI
def ReadVSHIFTRNI256     : SchedRead;    // 256-bit integer SRLRNI / SRARNI
//===----------------------------------------------------------------------===//
// VSRLRNI.B/H/W.H/W/D   Sched<[WriteVSHIFTRNI128, ReadVSHIFTRNI128]>
// VSRARNI.B/H/W.H/W/D   Sched<[WriteVSHIFTRNI128, ReadVSHIFTRNI128]>
// XVSRLRNI.B/H/W.H/W/D  Sched<[WriteVSHIFTRNI256, ReadVSHIFTRNI256]>
// XVSRARNI.B/H/W.H/W/D  Sched<[WriteVSHIFTRNI256, ReadVSHIFTRNI256]>
 //===----------------------------------------------------------------------===//
def WriteVSHIFTRNI128Q   : SchedWrite;   // 128-bit integer SRLRNI / SRARNI
def WriteVSHIFTRNI256Q   : SchedWrite;   // 256-bit integer SRLRNI / SRARNI
def ReadVSHIFTRNI128Q    : SchedRead;    // 128-bit integer SRLRNI / SRARNI
def ReadVSHIFTRNI256Q    : SchedRead;    // 256-bit integer SRLRNI / SRARNI
//===----------------------------------------------------------------------===//
// VSRLRNI.D.Q           Sched<[WriteVSHIFTRNI128Q, ReadVSHIFTRNI128Q]>
// VSRARNI.D.Q           Sched<[WriteVSHIFTRNI128Q, ReadVSHIFTRNI128Q]>
// XVSRLRNI.D.Q          Sched<[WriteVSHIFTRNI256Q, ReadVSHIFTRNI256Q]>
// XVSRARNI.D.Q          Sched<[WriteVSHIFTRNI256Q, ReadVSHIFTRNI256Q]>
//===----------------------------------------------------------------------===//

def WriteVSHIFTNS128     : SchedWrite;   // 128-bit integer SSRLN / SSRAN
def WriteVSHIFTNS256     : SchedWrite;   // 256-bit integer SSRLN / SSRAN
def ReadVSHIFTNS128      : SchedRead;    // 128-bit integer SSRLN / SSRAN
def ReadVSHIFTNS256      : SchedRead;    // 256-bit integer SSRLN / SSRAN
//===----------------------------------------------------------------------===//
// VSSRLN.B/H/W.H/W/D      Sched<[WriteVSHIFTNS128, ReadVSHIFTNS128, ReadVSHIFTNS128]>
// VSSRAN.B/H/W.H/W/D      Sched<[WriteVSHIFTNS128, ReadVSHIFTNS128, ReadVSHIFTNS128]>
// XVSSRLN.B/H/W.H/W/D     Sched<[WriteVSHIFTNS256, ReadVSHIFTNS256, ReadVSHIFTNS256]>
// XVSSRAN.B/H/W.H/W/D     Sched<[WriteVSHIFTNS256, ReadVSHIFTNS256, ReadVSHIFTNS256]>
// VSSRLN.BU/HU/WU.H/W/D   Sched<[WriteVSHIFTNS128, ReadVSHIFTNS128, ReadVSHIFTNS128]>
// VSSRAN.BU/HU/WU.H/W/D   Sched<[WriteVSHIFTNS128, ReadVSHIFTNS128, ReadVSHIFTNS128]>
// XVSSRLN.BU/HU/WU.H/W/D  Sched<[WriteVSHIFTNS256, ReadVSHIFTNS256, ReadVSHIFTNS256]>
// XVSSRAN.BU/HU/WU.H/W/D  Sched<[WriteVSHIFTNS256, ReadVSHIFTNS256, ReadVSHIFTNS256]>
 //===----------------------------------------------------------------------===//














