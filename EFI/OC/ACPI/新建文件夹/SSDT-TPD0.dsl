/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20210331 (32-bit version)
 * Copyright (c) 2000 - 2021 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of E:/封存/黑苹果hackintosh/小米air可用收藏EFI/opencore0.7.4/Xiaomi-Air-i5-7200U-20210923-0.7.4beta/Xiaomi-Air-i5-7200U-20210921-0.7.4beta/OC/ACPI/SSDT-TPD0.aml, Thu Sep 23 19:33:39 2021
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000316 (790)
 *     Revision         0x02
 *     Checksum         0xB4
 *     OEM ID           "ACDT"
 *     OEM Table ID     "I2C-TPDX"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200110 (538968336)
 */
DefinitionBlock ("", "SSDT", 2, "ACDT", "I2C-TPDX", 0x00000000)
{
    External (_SB_.GNUM, MethodObj)    // 1 Arguments
    External (_SB_.HIDD, MethodObj)    // 5 Arguments
    External (_SB_.INUM, MethodObj)    // 1 Arguments
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.LPCB.EC0_.TPTP, MethodObj)    // 0 Arguments
    External (_SB_.SHPO, MethodObj)    // 2 Arguments
    External (_SB_.TP7D, MethodObj)    // 6 Arguments
    External (GPDI, FieldUnitObj)
    External (HIDG, UnknownObj)
    External (I2CD, UnknownObj)
    External (SDS0, FieldUnitObj)
    External (TP7G, UnknownObj)
    External (TPDD, FieldUnitObj)
    External (TPDF, FieldUnitObj)
    External (TPMD, FieldUnitObj)

    Scope (\)
    {
        If (_OSI ("Darwin"))
        {
            TPMD = Zero
            SDS0 = Zero
        }
    }

    Scope (_SB.PCI0.I2C1)
    {
        Name (SSCN, Package (0x03)
        {
            0x0210, 
            0x0280, 
            0x1E
        })
        Name (FMCN, Package (0x03)
        {
            0x80, 
            0xA0, 
            0x1E
        })
        Device (TPDX)
        {
            Name (SBFS, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x002C, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C1",
                    0x00, ResourceConsumer, , Exclusive,
                    )
            })
            Name (SBFE, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0015, ControllerInitiated, 0x00061A80,
                    AddressingMode7Bit, "\\_SB.PCI0.I2C1",
                    0x00, ResourceConsumer, , Exclusive,
                    )
            })
            Name (SBFG, ResourceTemplate ()
            {
                GpioInt (Level, ActiveLow, ExclusiveAndWake, PullDefault, 0x0000,
                    "\\_SB.PCI0.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x001B
                    }
            })
            Name (SBFI, ResourceTemplate ()
            {
                Interrupt (ResourceConsumer, Level, ActiveLow, ExclusiveAndWake, ,, _Y00)
                {
                    0x00000000,
                }
            })
            CreateWordField (SBFG, 0x17, INT1)
            CreateDWordField (SBFI, \_SB.PCI0.I2C1.TPDX._Y00._INT, INT2)  // _INT: Interrupts
            Name (IRQM, One)
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                INT1 = GNUM (GPDI)
                INT2 = INUM (GPDI)
                If ((IRQM == Zero))
                {
                    SHPO (GPDI, One)
                }
            }

            Method (_HID, 0, NotSerialized)  // _HID: Hardware ID
            {
                Local0 = \_SB.PCI0.LPCB.EC0.TPTP ()
                If ((Local0 == One))
                {
                    Return ("SYN1B7F")
                }

                Return ("ELAN2301")
            }

            Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
            Name (_S0W, 0x03)  // _S0W: S0 Device Wake State
            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                Local0 = \_SB.PCI0.LPCB.EC0.TPTP ()
                If ((Local0 == One))
                {
                    If ((Arg0 == HIDG))
                    {
                        Return (HIDD (Arg0, Arg1, Arg2, Arg3, 0x20))
                    }

                    If ((Arg0 == TP7G))
                    {
                        Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFS, SBFG))
                    }
                }

                If ((Arg0 == HIDG))
                {
                    Return (HIDD (Arg0, Arg1, Arg2, Arg3, One))
                }

                If ((Arg0 == TP7G))
                {
                    Return (TP7D (Arg0, Arg1, Arg2, Arg3, SBFE, SBFG))
                }

                Return (Buffer (One)
                {
                     0x00                                             // .
                })
            }

            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                If (_OSI ("Darwin"))
                {
                    Return (0x0F)
                }
                Else
                {
                    Return (Zero)
                }
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Return (ConcatenateResTemplate (SBFE, SBFG))
            }
        }
    }
}

