echo \n\n   Enabling malloc logging.\n
set env MallocStackLogging 1
set env MallocStackLoggingNoCompact 1
set env MallocScribble 1
set env MallocPreScribble 1

echo \   Enabling zombies.\n
set env NSZombieEnabled 1
set env NSDebugEnabled 1

echo \   Adding standard breakpoints.\n
fb objc_exception_throw
fb malloc_error_break
fb _NSLockError
fb NSKVODeallocateBreak
fb _NSFastEnumerationMutationHandler
fb malloc_printf
fb _NSAutoreleaseNoPool
fb -[NSAssertionHandler handleFailureInMethod:object:file:lineNumber:description:]
fb CGErrorBreakpoint

define load-fscript
  set $ok = (char)[[NSBundle bundleWithPath:@"/Library/Frameworks/FScript.framework"] load]
  if !$ok
    set $ok = (char)[[NSBundle bundleWithPath:@"~/Library/Frameworks/FScript.framework"] load]
  end
  if !$ok
    echo *** F-Script framework not found.
  else
    set $fscript_menu = (void *)[[[FScriptMenuItem alloc] init] autorelease]
    if !$fscript_menu
      echo *** Failed to allocate F-Script menu.
    else
      set $app = (void *)[NSApplication sharedApplication]
      set $main_menu = (void *)[$app mainMenu]
      call (void)[$main_menu addItem:$fscript_menu]
      dont-repeat
    end
  end
end
document load-fscript
Loads the F-Script framework and inserts its menu item into the main menu.
end

define load-silabs-kext
  if $argc != 1
    echo load-silabs-kext SiLabs???.kext\n
  else
    dont-repeat
    # Disable confirmation so GDB autoloads .sym files.
    set confirm off
      add-kext $arg0
      add-kext /Volumes/KernelDebugKit/IOUSBFamily.kext
      add-kext /Volumes/KernelDebugKit/IOSerialFamily.kext
    set confirm on
    set print asm-demangle on
    set print demangle on
    set print vtbl
  end
end
document load-silabs-kext
load-silabs-kext <KEXT>: Loads the SiLabs kext and its dependencies.
You should already have mounted the appropriate KernelDebugKit
and generated symbol files in the current directory.
end

