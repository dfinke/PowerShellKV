$KVFilename = "kvps.snippet"
$KVPath     = "$($env:LOCALAPPDATA)\kv"
$KVFullName = Join-Path $KVPath $KVFilename

function Save-KV {
    <#
        .Synopsis
            A Quick Description of what the command does
        .Description
            A Detailed Description of what the command does
        .Example
            An example of using the command        
    #>

    $Global:kvhash | Export-Clixml -Path $KVFullName
}

function kv {
    <#
        .Synopsis
            A Quick Description of what the command does
        .Description
            A Detailed Description of what the command does
        .Example
            An example of using the command        
    #>
    param(
        [Parameter(Position=0)]
        $k,
        [Parameter(ValueFromPipeline,Position=1)]
        $v,
        [Switch]$Remove
    )

    Begin {

        Add-Type -AssemblyName PresentationCore

        if(!$Global:kvhash) {$Global:kvhash=@{}}

        if(!(Test-Path $KVPath )) {
            New-Item $KVPath -Type directory | Out-Null   
        }

        if(Test-Path $KVFullName) {
            $Global:kvhash = Import-Clixml $KVFullName
        }

        $target = @()
    }

    Process {
        $target += $v
    }

    End {
        
        if(!$target -and ! $k) { $Global:kvhash.Keys}

        if(!$target) {
        
            if($Remove) {
                $Global:kvhash.Remove($k)
                Save-KV
            } else {
                $Global:kvhash.$k
            }
        } else {

            $Global:kvhash.$k=$target
            Save-KV
            [Windows.Clipboard]::SetText($target)
        }
    }
}

cls
#kv dev MaxServer0412_Tangerine1
#kv dev

#'MaxServer0412_Tangerine1' | kv dev
#kv dev MaxServer0412_Tangerine2
#kv dev 

#function ql {$args}

#ql a b c | kv test
#kv test
#kv -Remove test
#kv test