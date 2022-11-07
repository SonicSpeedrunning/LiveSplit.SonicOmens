// Load time remover for Sonic Omens
// Coding: Jujstme
// contacts: just.tribe@gmail.com
// Version: 1.0.0

state("MugenEngine-Win64-Shipping") {}

init
{
    var ptr = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize)
        .Scan(new SigScanTarget(5, "89 43 60 8B 05")
        { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) }
    );
    if (ptr == IntPtr.Zero) throw new NullReferenceException();

    vars.isLoading = new MemoryWatcher<bool>(ptr);
}

update
{
    vars.isLoading.Update(game);
}

isLoading
{
    return vars.isLoading.Current;
}