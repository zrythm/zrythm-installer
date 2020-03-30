# Create installer

    export ANSIBLE_STDOUT_CALLBACK=debug
    make -j4

# Note for windows
Can use the following to spawn an MSYS2 shell from the
windows shell

    C:\msys64\usr\bin\env.exe MSYSTEM=MINGW64 C:\msys64\usr\bin\bash.exe -l

# To add sound devices to VMs
<https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/virtualization_administration_guide/section-libvirt-dom-xml-sound-devices>

Example

    <devices>
      <sound model='ich6'>
      <sound/>
      <sound model='es1370'>
      <sound/>
    </devices>
