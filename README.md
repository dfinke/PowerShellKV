A PowerShell key value store that allows you to save snippets of text that you can later find and copy to your clipboard

inspired by http://kv.codeplex.com/

#Usage:

```powershell
kv name "John Doe" # saves the the value, 'John Doe' under the key, 'name'
kv name            # retrieve the value 'fred smith' straight to your clipboard.
```

```powershell
kv #lists all keys
```
```powershell
kv -r name # will remove the key ‘name’ (and its value) from your store
```

#You can also pipe a value in, e.g.

```powershell
'Hello Jim' | kv Greeting  # will store 'Hello Fred' under the key 'Greeting'
```

```powershell
gc .\kv.ps1 | kv TheFile # will store the content of 'kv.ps1' under the key 'TheFile'
```