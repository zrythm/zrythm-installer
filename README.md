Zrythm installer scripts
========================

*This is a meta repo for managing Zrythm installer
builds and is generally only useful for Zrythm
maintainers.*

Licensed under the AGPLv3+. See the [COPYING](COPYING)
file for details.

# Note for windows
Can use the following to spawn an MSYS2 shell from the
windows shell

    C:\msys64\usr\bin\env.exe MSYSTEM=MINGW64 C:\msys64\usr\bin\bash.exe -l

# How to debug on windows

## To get log

Powershell:
```bash
$output = cmd /c 'C:\Program Files\Zrythm\bin\zrythm_debug.exe' 2`>`&1
$output
```

MSYS shell:
```bash
'C:\Program Files\Zrythm\bin\zrythm_debug.exe'
```

## Backtrace
If gdb doesn't work from MSYS/Powershell, open the .exe with Visual Studio and debug it. At least it will show the call stack libraries.

# To add sound devices to VMs
<https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/virtualization_administration_guide/section-libvirt-dom-xml-sound-devices>

Example

    <devices>
      <sound model='ich6'>
      <sound/>
      <sound model='es1370'>
      <sound/>
    </devices>

----

Copyright (C) 2020-2021 Alexandros Theodotou

Copying and distribution of this file, with or without modification,
are permitted in any medium without royalty provided the copyright
notice and this notice are preserved.  This file is offered as-is,
without any warranty.
