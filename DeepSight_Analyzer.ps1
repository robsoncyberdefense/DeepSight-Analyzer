# Requires -Version 5.1
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName System.IO.Compression.FileSystem
Add-Type -AssemblyName System.Windows.Forms

# ============================================================================
# CRIAÇÃO DA INTERFACE GRÁFICA
# ============================================================================
$window = New-Object System.Windows.Window
$window.Title = "DeepSight Analyzer v1.0 - Complete Edition"
$window.Width = 1200
$window.Height = 850
$window.WindowStartupLocation = "CenterScreen"
$window.Background = "#1E1E1E"

$grid = New-Object System.Windows.Controls.Grid
$grid.Margin = "10"

# Definir 5 linhas do grid
$rowDef1 = New-Object System.Windows.Controls.RowDefinition
$rowDef1.Height = [System.Windows.GridLength]::Auto
$rowDef2 = New-Object System.Windows.Controls.RowDefinition
$rowDef2.Height = [System.Windows.GridLength]::Auto
$rowDef3 = New-Object System.Windows.Controls.RowDefinition
$rowDef3.Height = [System.Windows.GridLength]::Auto
$rowDef4 = New-Object System.Windows.Controls.RowDefinition
$rowDef4.Height = New-Object System.Windows.GridLength(1, [System.Windows.GridUnitType]::Star)
$rowDef5 = New-Object System.Windows.Controls.RowDefinition
$rowDef5.Height = [System.Windows.GridLength]::Auto

$grid.RowDefinitions.Add($rowDef1) | Out-Null
$grid.RowDefinitions.Add($rowDef2) | Out-Null
$grid.RowDefinitions.Add($rowDef3) | Out-Null
$grid.RowDefinitions.Add($rowDef4) | Out-Null
$grid.RowDefinitions.Add($rowDef5) | Out-Null

# Header
$headerBorder = New-Object System.Windows.Controls.Border
$headerBorder.Background = "#2D2D30"
$headerBorder.CornerRadius = "5"
$headerBorder.Padding = "10"
$headerBorder.Margin = "0,0,0,10"
[System.Windows.Controls.Grid]::SetRow($headerBorder, 0)

$headerStack = New-Object System.Windows.Controls.StackPanel
$headerTitle = New-Object System.Windows.Controls.TextBlock
$headerTitle.Text = "🔍 DeepSight ANALYZER"
$headerTitle.FontSize = 24
$headerTitle.FontWeight = "Bold"
$headerTitle.Foreground = "#00D4AA"
$headerTitle.HorizontalAlignment = "Center"

$headerSubtitle = New-Object System.Windows.Controls.TextBlock
$headerSubtitle.Text = "Digital Forensics & Incident Response Tool"
$headerSubtitle.FontSize = 12
$headerSubtitle.Foreground = "#B0B0B0"
$headerSubtitle.HorizontalAlignment = "Center"
$headerSubtitle.Margin = "0,5,0,0"

$headerStack.Children.Add($headerTitle) | Out-Null
$headerStack.Children.Add($headerSubtitle) | Out-Null
$headerBorder.Child = $headerStack
$grid.Children.Add($headerBorder) | Out-Null

# Deep Analysis Checkbox
$chkDeepBorder = New-Object System.Windows.Controls.Border
$chkDeepBorder.Background = "#252526"
$chkDeepBorder.CornerRadius = "5"
$chkDeepBorder.Padding = "10"
$chkDeepBorder.Margin = "0,0,0,10"
[System.Windows.Controls.Grid]::SetRow($chkDeepBorder, 1)

$chkDeepAnalysis = New-Object System.Windows.Controls.CheckBox
$chkDeepAnalysis.Content = "🔬 Deep Analysis Mode (Análise Profunda - Mais lento)"
$chkDeepAnalysis.Foreground = "#00D4AA"
$chkDeepAnalysis.FontWeight = "Bold"
$chkDeepAnalysis.IsChecked = $false
$chkDeepAnalysis.ToolTip = "Ativa análise completa de Reverse Engineering: PE Header, IAT, Sections, Anti-Analysis, MITRE ATT&CK, Network Analysis"

$chkDeepBorder.Child = $chkDeepAnalysis
$grid.Children.Add($chkDeepBorder) | Out-Null

# Controls (Botões)
$controlBorder = New-Object System.Windows.Controls.Border
$controlBorder.Background = "#252526"
$controlBorder.CornerRadius = "5"
$controlBorder.Padding = "10"
$controlBorder.Margin = "0,0,0,10"
[System.Windows.Controls.Grid]::SetRow($controlBorder, 2)

$controlGrid = New-Object System.Windows.Controls.Grid
$col1 = New-Object System.Windows.Controls.ColumnDefinition
$col1.Width = New-Object System.Windows.GridLength(1, [System.Windows.GridUnitType]::Star)
$col2 = New-Object System.Windows.Controls.ColumnDefinition
$col2.Width = [System.Windows.GridLength]::Auto
$col3 = New-Object System.Windows.Controls.ColumnDefinition
$col3.Width = [System.Windows.GridLength]::Auto
$col4 = New-Object System.Windows.Controls.ColumnDefinition
$col4.Width = [System.Windows.GridLength]::Auto
$col5 = New-Object System.Windows.Controls.ColumnDefinition
$col5.Width = [System.Windows.GridLength]::Auto

$controlGrid.ColumnDefinitions.Add($col1) | Out-Null
$controlGrid.ColumnDefinitions.Add($col2) | Out-Null
$controlGrid.ColumnDefinitions.Add($col3) | Out-Null
$controlGrid.ColumnDefinitions.Add($col4) | Out-Null
$controlGrid.ColumnDefinitions.Add($col5) | Out-Null

$txtFilePath = New-Object System.Windows.Controls.TextBox
$txtFilePath.Background = "#3C3C3C"
$txtFilePath.Foreground = "#CCCCCC"
$txtFilePath.BorderBrush = "#555555"
$txtFilePath.Padding = "8"
$txtFilePath.Margin = "0,0,10,0"
$txtFilePath.VerticalAlignment = "Center"
$txtFilePath.FontFamily = "Consolas"
[System.Windows.Controls.Grid]::SetColumn($txtFilePath, 0)

$btnSelect = New-Object System.Windows.Controls.Button
$btnSelect.Content = "📁 Selecionar Arquivo"
$btnSelect.Background = "#0078D4"
$btnSelect.Foreground = "White"
$btnSelect.Padding = "15,8"
$btnSelect.Margin = "0,0,10,0"
$btnSelect.Cursor = "Hand"
[System.Windows.Controls.Grid]::SetColumn($btnSelect, 1)

$btnAnalyze = New-Object System.Windows.Controls.Button
$btnAnalyze.Content = "🔬 Analisar"
$btnAnalyze.Background = "#00D4AA"
$btnAnalyze.Foreground = "#1E1E1E"
$btnAnalyze.Padding = "20,8"
$btnAnalyze.FontWeight = "Bold"
$btnAnalyze.Cursor = "Hand"
[System.Windows.Controls.Grid]::SetColumn($btnAnalyze, 2)

$btnExport = New-Object System.Windows.Controls.Button
$btnExport.Content = "📄 Exportar Resultado"
$btnExport.Background = "#6B6B6B"
$btnExport.Foreground = "White"
$btnExport.Padding = "20,8"
$btnExport.FontWeight = "Bold"
$btnExport.Cursor = "Hand"
$btnExport.IsEnabled = $false
$btnExport.ToolTip = "Exportar resultados da análise em arquivo .txt"
[System.Windows.Controls.Grid]::SetColumn($btnExport, 3)

$btnExtract = New-Object System.Windows.Controls.Button
$btnExtract.Content = "💾 Extrair Payload"
$btnExtract.Background = "#FF6B00"
$btnExtract.Foreground = "White"
$btnExtract.Padding = "20,8"
$btnExtract.FontWeight = "Bold"
$btnExtract.Cursor = "Hand"
$btnExtract.IsEnabled = $false
$btnExtract.ToolTip = "Só disponível quando steganografia for detectada"
[System.Windows.Controls.Grid]::SetColumn($btnExtract, 4)

$controlGrid.Children.Add($txtFilePath) | Out-Null
$controlGrid.Children.Add($btnSelect) | Out-Null
$controlGrid.Children.Add($btnAnalyze) | Out-Null
$controlGrid.Children.Add($btnExport) | Out-Null
$controlGrid.Children.Add($btnExtract) | Out-Null

$controlBorder.Child = $controlGrid
$grid.Children.Add($controlBorder) | Out-Null

# Output TextBox
$outputBorder = New-Object System.Windows.Controls.Border
$outputBorder.Background = "#252526"
$outputBorder.CornerRadius = "5"
$outputBorder.Padding = "10"
[System.Windows.Controls.Grid]::SetRow($outputBorder, 3)

$scrollViewer = New-Object System.Windows.Controls.ScrollViewer
$scrollViewer.VerticalScrollBarVisibility = "Auto"
$scrollViewer.HorizontalScrollBarVisibility = "Auto"

$txtOutput = New-Object System.Windows.Controls.TextBox
$txtOutput.Background = "#1E1E1E"
$txtOutput.Foreground = "#D4D4D4"
$txtOutput.BorderThickness = "0"
$txtOutput.Padding = "10"
$txtOutput.FontFamily = "Consolas"
$txtOutput.FontSize = 12
$txtOutput.TextWrapping = "NoWrap"
$txtOutput.AcceptsReturn = $true
$txtOutput.IsReadOnly = $true
$txtOutput.VerticalScrollBarVisibility = "Auto"

$scrollViewer.Content = $txtOutput
$outputBorder.Child = $scrollViewer
$grid.Children.Add($outputBorder) | Out-Null

# Status Bar
$statusBorder = New-Object System.Windows.Controls.Border
$statusBorder.Background = "#007ACC"
$statusBorder.CornerRadius = "3"
$statusBorder.Padding = "8"
$statusBorder.Margin = "0,10,0,0"
[System.Windows.Controls.Grid]::SetRow($statusBorder, 4)

$statusGrid = New-Object System.Windows.Controls.Grid
$statusCol1 = New-Object System.Windows.Controls.ColumnDefinition
$statusCol1.Width = New-Object System.Windows.GridLength(1, [System.Windows.GridUnitType]::Star)
$statusCol2 = New-Object System.Windows.Controls.ColumnDefinition
$statusCol2.Width = [System.Windows.GridLength]::Auto

$statusGrid.ColumnDefinitions.Add($statusCol1) | Out-Null
$statusGrid.ColumnDefinitions.Add($statusCol2) | Out-Null

$txtStatus = New-Object System.Windows.Controls.TextBlock
$txtStatus.Foreground = "White"
$txtStatus.VerticalAlignment = "Center"
[System.Windows.Controls.Grid]::SetColumn($txtStatus, 0)

$txtProgress = New-Object System.Windows.Controls.TextBlock
$txtProgress.Foreground = "#CCCCCC"
$txtProgress.VerticalAlignment = "Center"
[System.Windows.Controls.Grid]::SetColumn($txtProgress, 1)

$statusGrid.Children.Add($txtStatus) | Out-Null
$statusGrid.Children.Add($txtProgress) | Out-Null

$statusBorder.Child = $statusGrid
$grid.Children.Add($statusBorder) | Out-Null

$window.Content = $grid
$Global:PayloadInfo = $null

# ============================================================================
# FUNÇÕES AUXILIARES
# ============================================================================
function Write-OutputBox {
    param(
        [string]$Text,
        [ValidateSet('Normal', 'Success', 'Warning', 'Error', 'Info', 'Header')]
        [string]$Level = 'Normal'
    )
    $formattedText = "$Text`r`n"
    $txtOutput.AppendText($formattedText)
    $txtOutput.ScrollToEnd()
}

function Update-Status {
    param([string]$Message)
    $txtStatus.Text = $Message
    [System.Windows.Forms.Application]::DoEvents()
}

function Get-FileSizeFormatted {
    param([long]$Bytes)
    $sizes = 'B','KB','MB','GB','TB'
    $index = 0
    while ($Bytes -ge 1024 -and $index -lt $sizes.Count - 1) {
        $Bytes = $Bytes / 1024
        $index++
    }
    return "{0:N2} {1}" -f $Bytes, $sizes[$index]
}

function Export-Results {
    param([string]$Content)
    $saveDialog = New-Object Microsoft.Win32.SaveFileDialog
    $saveDialog.Title = "Exportar Resultados"
    $saveDialog.Filter = "Text File|*.txt|All Files|*.*"
    $saveDialog.DefaultExt = ".txt"
    $saveDialog.FileName = "DeepSight_Analysis_{0}" -f (Get-Date -Format "yyyyMMdd_HHmmss")
    if ($saveDialog.ShowDialog() -eq $true) {
        try {
            [System.IO.File]::WriteAllText($saveDialog.FileName, $Content, [System.Text.Encoding]::UTF8)
            [System.Windows.MessageBox]::Show(
                "Resultados exportados com sucesso!`n`nArquivo: $($saveDialog.FileName)",
                "Sucesso",
                "OK",
                "Information"
            )
            Update-Status "Resultados exportados"
        } catch {
            [System.Windows.MessageBox]::Show("Erro ao exportar: $_", "Erro", "OK", "Error")
            Update-Status "Erro na exportação"
        }
    }
}

function Decode-String {
    param([string]$Encoded)
    return [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($Encoded))
}

# ============================================================================
# FUNÇÕES DE ANÁLISE FORENSE BÁSICA
# ============================================================================
function Get-FileHashes {
    param([string]$Path)
    Update-Status "Calculando hashes..."
    $hashes = @{}
    foreach ($algo in 'MD5','SHA1','SHA256','SHA512') {
        try {
            $hash = Get-FileHash -Path $Path -Algorithm $algo -ErrorAction Stop
            $hashes[$algo] = $hash.Hash
        } catch {
            $hashes[$algo] = "Erro"
        }
    }
    return $hashes
}

function Get-Entropy {
    param([string]$Path)
    Update-Status "Calculando entropia..."
    $bytes = [System.IO.File]::ReadAllBytes($Path)
    $totalBytes = $bytes.Length
    if ($totalBytes -eq 0) { return 0 }
    $frequency = New-Object int[] 256
    foreach ($byte in $bytes) { $frequency[$byte]++ }
    $entropy = 0.0
    foreach ($count in $frequency) {
        if ($count -gt 0) {
            $probability = $count / $totalBytes
            $entropy -= $probability * [Math]::Log($probability, 2)
        }
    }
    return [Math]::Round($entropy, 4)
}

function Get-FileTypeByMagic {
    param([string]$Path)
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        if ($bytes.Length -lt 4) { return @{ 'Type' = "Arquivo muito pequeno"; 'Extension' = $null; 'Category' = 'unknown' } }
        $hexHeader = [System.BitConverter]::ToString($bytes[0..15]) -replace '-',''
        $signatures = @{
            '4D5A' = @{ 'Type' = 'Executable (PE)'; 'Extension' = '.exe'; 'Category' = 'executable' }
            '89504E47' = @{ 'Type' = 'PNG Image'; 'Extension' = '.png'; 'Category' = 'image' }
            'FFD8FF' = @{ 'Type' = 'JPEG Image'; 'Extension' = '.jpg'; 'Category' = 'image' }
            '47494638' = @{ 'Type' = 'GIF Image'; 'Extension' = '.gif'; 'Category' = 'image' }
            '424D' = @{ 'Type' = 'BMP Image'; 'Extension' = '.bmp'; 'Category' = 'image' }
            '25504446' = @{ 'Type' = 'PDF Document'; 'Extension' = '.pdf'; 'Category' = 'document' }
            '504B0304' = @{ 'Type' = 'ZIP Archive'; 'Extension' = '.zip'; 'Category' = 'archive' }
            '1F8B08' = @{ 'Type' = 'GZIP Archive'; 'Extension' = '.gz'; 'Category' = 'archive' }
            '52494646' = @{ 'Type' = 'RIFF Container'; 'Extension' = '.riff'; 'Category' = 'multimedia' }
            '57415645' = @{ 'Type' = 'WAV Audio'; 'Extension' = '.wav'; 'Category' = 'audio' }
            '494433' = @{ 'Type' = 'MP3 Audio'; 'Extension' = '.mp3'; 'Category' = 'audio' }
            '664C6143' = @{ 'Type' = 'FLAC Audio'; 'Extension' = '.flac'; 'Category' = 'audio' }
        }
        foreach ($sig in $signatures.Keys) {
            if ($hexHeader.StartsWith($sig)) { return $signatures[$sig] }
        }
        return @{ 'Type' = "Tipo desconhecido"; 'Extension' = $null; 'Category' = 'unknown' }
    } catch { return @{ 'Type' = "Erro"; 'Extension' = $null; 'Category' = 'unknown' } }
}

function Get-StringsAndIOCs {
    param([string]$Path)
    Update-Status "Extraindo strings e IOCs..."
    try {
        $fileSize = (Get-Item $Path).Length
        $results = @{ 'IPs' = @(); 'URLs' = @(); 'Emails' = @(); 'Paths' = @(); 'Strings' = @() }
        if ($fileSize -gt 10MB) {
            $bytes = [System.IO.File]::ReadAllBytes($Path)
            $bytes = $bytes[0..[Math]::Min(5MB, $bytes.Length-1)] + $bytes[[Math]::Max(0, $bytes.Length-5MB)..($bytes.Length-1)]
        } else {
            $bytes = [System.IO.File]::ReadAllBytes($Path)
        }
        $asciiString = [System.Text.Encoding]::ASCII.GetString($bytes)
        $results['IPs'] = [regex]::Matches($asciiString, '\b(?:\d{1,3}\.){3}\d{1,3}\b') | ForEach-Object { $_.Value } | Where-Object { $parts = $_.Split('.'); $parts.Count -eq 4 } | Select-Object -Unique | Select-Object -First 20
        $results['URLs'] = [regex]::Matches($asciiString, 'https?://[^\s<>"]+') | ForEach-Object { $_.Value } | Select-Object -Unique | Select-Object -First 20
        $results['Emails'] = [regex]::Matches($asciiString, '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}') | ForEach-Object { $_.Value } | Select-Object -Unique | Select-Object -First 20
        $results['Paths'] = [regex]::Matches($asciiString, '[A-Za-z]:\\[^\s<>":|]+') | ForEach-Object { $_.Value } | Select-Object -Unique | Select-Object -First 20
        $stringPattern = '[\x20-\x7E]{8,50}'
        $allStrings = [regex]::Matches($asciiString, $stringPattern) | ForEach-Object { $_.Value } | Where-Object { $alnum = ($_ -replace '[^A-Za-z0-9]', '').Length; $alnum / $_.Length -ge 0.5 } | Select-Object -Unique
        $results['Strings'] = $allStrings | Select-Object -First 100
        return $results
    } catch { return @{ 'IPs' = @(); 'URLs' = @(); 'Emails' = @(); 'Paths' = @(); 'Strings' = @() } }
}

function Test-IsPEFile {
    param([string]$Path)
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        if ($bytes.Length -lt 2) { return $false }
        return [System.BitConverter]::ToUInt16($bytes, 0) -eq 0x5A4D
    } catch { return $false }
}

# ============================================================================
# REVERSE ENGINEERING FUNCTIONS - COMPLETAS
# ============================================================================

# 1. PE HEADER INFO COMPLETO
function Get-PEHeaderInfo {
    param([string]$Path)
    if (!(Test-IsPEFile $Path)) { return $null }
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $reader = New-Object System.IO.BinaryReader([System.IO.MemoryStream]::New($bytes))
        
        # DOS Header
        $reader.BaseStream.Seek(0x3C, 'Begin') | Out-Null
        $peOffset = $reader.ReadUInt32()
        
        # PE Signature
        $reader.BaseStream.Seek($peOffset, 'Begin') | Out-Null
        $peSig = $reader.ReadUInt32()
        if ($peSig -ne 0x00004550) { $reader.Close(); return $null }
        
        # COFF Header
        $reader.BaseStream.Seek($peOffset + 4, 'Begin') | Out-Null
        $machine = $reader.ReadUInt16()
        $numSections = $reader.ReadUInt16()
        $timeStamp = $reader.ReadUInt32()
        $compileTime = ([DateTime]'1970-01-01').AddSeconds($timeStamp)
        $characteristics = $reader.ReadUInt16()
        
        # Optional Header
        $reader.BaseStream.Seek($peOffset + 20, 'Begin') | Out-Null
        $optHeaderSize = $reader.ReadUInt16()
        $isPE32Plus = $reader.ReadUInt16() -eq 0x20b
        
        $reader.BaseStream.Seek($peOffset + 40, 'Begin') | Out-Null
        $imageBase = if ($isPE32Plus) { $reader.ReadUInt64() } else { $reader.ReadUInt32() }
        
        $reader.BaseStream.Seek($peOffset + 48, 'Begin') | Out-Null
        $entryPoint = $reader.ReadUInt32()
        
        $reader.BaseStream.Seek($peOffset + 68, 'Begin') | Out-Null
        $subsystem = $reader.ReadUInt16()
        
        $reader.BaseStream.Seek($peOffset + 72, 'Begin') | Out-Null
        $dllCharacteristics = $reader.ReadUInt16()
        
        $reader.Close()
        
        return @{
            'Machine' = switch ($machine) {
                0x14c { 'x86 (32-bit)' }
                0x8664 { 'x64 (64-bit)' }
                0x1c0 { 'ARM' }
                0xaa64 { 'ARM64' }
                default { "Unknown (0x$($machine.ToString('X4')))" }
            }
            'Sections' = $numSections
            'Compiled' = $compileTime
            'EntryPoint' = "0x$($entryPoint.ToString('X8'))"
            'ImageBase' = "0x$($imageBase.ToString('X16'))"
            'Format' = if ($isPE32Plus) { 'PE32+' } else { 'PE32' }
            'Subsystem' = switch ($subsystem) {
                1 { 'Native' }
                2 { 'Windows GUI' }
                3 { 'Windows Console' }
                9 { 'Windows CE GUI' }
                10 { 'EFI Application' }
                default { "Unknown ($subsystem)" }
            }
            'DLLCharacteristics' = $dllCharacteristics
        }
    } catch { return $null }
}

# 2. SECTION-BY-SECTION ANALYSIS
function Get-SectionDetails {
    param([string]$Path)
    if (!(Test-IsPEFile $Path)) { return @() }
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $reader = New-Object System.IO.BinaryReader([System.IO.MemoryStream]::New($bytes))
        
        # PE Offset
        $reader.BaseStream.Seek(0x3C, 'Begin') | Out-Null
        $peOffset = $reader.ReadUInt32()
        
        # Number of sections
        $reader.BaseStream.Seek($peOffset + 6, 'Begin') | Out-Null
        $numSections = $reader.ReadUInt16()
        
        # Optional Header Size
        $reader.BaseStream.Seek($peOffset + 20, 'Begin') | Out-Null
        $optHeaderSize = $reader.ReadUInt16()
        
        # Section Table
        $reader.BaseStream.Seek($peOffset + 24 + $optHeaderSize, 'Begin') | Out-Null
        
        $sections = @()
        for ($i = 0; $i -lt $numSections; $i++) {
            $sectionName = [System.Text.Encoding]::ASCII.GetString($reader.ReadBytes(8)).TrimEnd("`0")
            $virtualSize = $reader.ReadUInt32()
            $virtualAddress = $reader.ReadUInt32()
            $rawSize = $reader.ReadUInt32()
            $rawPointer = $reader.ReadUInt32()
            $characteristics = $reader.ReadUInt32()
            
            # Calculate entropy for this section
            $entropy = 0
            if ($rawSize -gt 0 -and $rawPointer -gt 0 -and $rawPointer + $rawSize -le $bytes.Length) {
                $sectionBytes = $bytes[$rawPointer..($rawPointer + $rawSize - 1)]
                $frequency = @{}
                foreach ($b in $sectionBytes) { $frequency[$b] = $frequency.Get($b, 0) + 1 }
                foreach ($count in $frequency.Values) {
                    $p = $count / $sectionBytes.Length
                    $entropy -= $p * [Math]::Log($p, 2)
                }
                $entropy = [Math]::Round($entropy, 2)
            }
            
            # Check characteristics
            $isExecutable = ($characteristics -band 0x20000000) -ne 0
            $isWritable = ($characteristics -band 0x80000000) -ne 0
            $isReadable = ($characteristics -band 0x40000000) -ne 0
            
            $sections += @{
                'Name' = $sectionName
                'VirtualSize' = $virtualSize
                'VirtualAddress' = "0x$($virtualAddress.ToString('X8'))"
                'RawSize' = $rawSize
                'Entropy' = $entropy
                'Characteristics' = $characteristics
                'Executable' = $isExecutable
                'Writable' = $isWritable
                'Readable' = $isReadable
            }
        }
        $reader.Close()
        return $sections
    } catch { return @() }
}

# 3. IMPORT ADDRESS TABLE (IAT) ANALYSIS
function Get-ImportTable {
    param([string]$Path)
    if (!(Test-IsPEFile $Path)) { return @() }
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $reader = New-Object System.IO.BinaryReader([System.IO.MemoryStream]::New($bytes))
        
        # PE Offset
        $reader.BaseStream.Seek(0x3C, 'Begin') | Out-Null
        $peOffset = $reader.ReadUInt32()
        
        # Optional Header
        $reader.BaseStream.Seek($peOffset + 20, 'Begin') | Out-Null
        $optHeaderSize = $reader.ReadUInt16()
        $isPE32Plus = $reader.ReadUInt16() -eq 0x20b
        
        # Data Directories
        $importTableRVA = 0
        $importTableSize = 0
        if ($isPE32Plus) {
            $reader.BaseStream.Seek($peOffset + 128, 'Begin') | Out-Null
            $importTableRVA = $reader.ReadUInt32()
            $importTableSize = $reader.ReadUInt32()
        } else {
            $reader.BaseStream.Seek($peOffset + 104, 'Begin') | Out-Null
            $importTableRVA = $reader.ReadUInt32()
            $importTableSize = $reader.ReadUInt32()
        }
        
        $reader.Close()
        
        # Extract DLL names from binary (simplified)
        $ascii = [System.Text.Encoding]::ASCII.GetString($bytes)
        $dlls = @('kernel32', 'advapi32', 'ws2_32', 'ntdll', 'user32', 'gdi32', 'shell32', 'ole32', 'crypt32', 'wininet')
        $foundDLLs = @()
        foreach ($dll in $dlls) {
            if ($ascii -match "$dll\.dll") { $foundDLLs += $dll }
        }
        
        return $foundDLLs
    } catch { return @() }
}

# 4. SUSPICIOUS API DETECTION
function Get-SuspiciousAPIs {
    param([string]$Path)
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $ascii = [System.Text.Encoding]::ASCII.GetString($bytes)
        
        $apis = @{
            'ProcessInjection' = @('OpenProcess', 'VirtualAllocEx', 'WriteProcessMemory', 'CreateRemoteThread', 'NtCreateThreadEx')
            'Persistence' = @('RegSetValueEx', 'CreateService', 'StartService', 'SchTasks', 'SetWindowsHookEx')
            'Networking' = @('socket', 'connect', 'send', 'recv', 'InternetOpen', 'HttpSendRequest', 'URLDownloadToFile')
            'Crypto' = @('CryptAcquireContext', 'CryptEncrypt', 'CryptDecrypt', 'CryptGenKey')
            'AntiDebug' = @('IsDebuggerPresent', 'CheckRemoteDebuggerPresent', 'NtQueryInformationProcess', 'OutputDebugString')
            'Keylogger' = @('GetAsyncKeyState', 'GetKeyState', 'SetWindowsHookEx', 'GetKeyboardState')
            'ScreenCapture' = @('BitBlt', 'GetDC', 'GetWindowDC', 'PrintScreen')
            'CredentialDump' = @('LsaOpenPolicy', 'SamIConnect', 'CredEnumerate', 'vaultcmd')
        }
        
        $results = @{}
        foreach ($category in $apis.Keys) {
            $found = @()
            foreach ($api in $apis[$category]) {
                if ($ascii -match $api) { $found += $api }
            }
            if ($found.Count -gt 0) { $results[$category] = $found }
        }
        
        return $results
    } catch { return @{} }
}

# 5. PACKER/COMPILER DETECTION
function Get-PackerInfo {
    param([string]$Path)
    if (!(Test-IsPEFile $Path)) { return $null }
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $ascii = [System.Text.Encoding]::ASCII.GetString($bytes)
        
        $packers = @{
            'UPX' = @('UPX0', 'UPX1', 'UPX!', 'This program cannot')
            'ASPack' = @('.aspack', 'ASPack')
            'Themida' = @('.themida', 'Themida', 'WinLicense')
            'VMProtect' = @('.vmp0', '.vmp1', 'VMProtect')
            'PECompact' = @('PECompact', 'PEC2')
            'MPRESS' = @('MPRESS', '.MPRESS1')
            'Petite' = @('Petite', '.petite')
            'FSG' = @('FSG', '.fsg')
        }
        
        $detected = $null
        foreach ($packer in $packers.Keys) {
            foreach ($signature in $packers[$packer]) {
                if ($ascii -match $signature) {
                    $detected = $packer
                    break
                }
            }
            if ($detected) { break }
        }
        
        # Compiler detection
        $compilers = @{
            'Visual Studio' = @('MSVBVM', 'Visual Basic', 'VBA6')
            'Delphi' = @('Delphi', 'Borland Delphi', 'PackageInfo')
            'C#/.NET' = @('.NET', 'mscorlib', 'System.')
            'MinGW' = @('MinGW', 'mingw')
            'Go' = @('go runtime', 'golang')
        }
        
        $compiler = $null
        foreach ($comp in $compilers.Keys) {
            foreach ($signature in $compilers[$comp]) {
                if ($ascii -match $signature) {
                    $compiler = $comp
                    break
                }
            }
            if ($compiler) { break }
        }
        
        return @{
            'Packer' = $detected
            'Compiler' = $compiler
            'IsPacked' = ($detected -ne $null)
        }
    } catch { return $null }
}

# 6. RESOURCE EXTRACTION
function Get-ResourceInfo {
    param([string]$Path)
    if (!(Test-IsPEFile $Path)) { return @() }
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $ascii = [System.Text.Encoding]::ASCII.GetString($bytes)
        
        $resources = @()
        
        # Check for common resource patterns
        if ($ascii -match 'VersionInfo') { $resources += 'Version Info' }
        if ($ascii -match 'RT_ICON') { $resources += 'Icons' }
        if ($ascii -match 'RT_CURSOR') { $resources += 'Cursors' }
        if ($ascii -match 'RT_BITMAP') { $resources += 'Bitmaps' }
        if ($ascii -match 'RT_DIALOG') { $resources += 'Dialogs' }
        if ($ascii -match 'RT_STRING') { $resources += 'Strings' }
        if ($ascii -match 'RT_MANIFEST') { $resources += 'Manifest' }
        if ($ascii -match 'RT_RCDATA') { $resources += 'Raw Data (Possible Payload)' }
        
        return $resources
    } catch { return @() }
}

# 7. TLS CALLBACK DETECTION
function Detect-TLSCallbacks {
    param([string]$Path)
    if (!(Test-IsPEFile $Path)) { return $false }
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $ascii = [System.Text.Encoding]::ASCII.GetString($bytes)
        
        # TLS callbacks are often used for anti-debug
        if ($ascii -match 'TLS_CALLBACK' -or $ascii -match 'TlsCallback' -or $ascii -match '.tls') {
            return $true
        }
        return $false
    } catch { return $false }
}

# 8. ANTI-ANALYSIS DETECTION
function Detect-AntiAnalysis {
    param([string]$Path)
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $ascii = [System.Text.Encoding]::ASCII.GetString($bytes)
        
        $techniques = @{
            'Anti-Debug' = @()
            'Anti-VM' = @()
            'Anti-Sandbox' = @()
            'Evasion' = @()
            'Timing' = @()
        }
        
        # Anti-Debug
        $antiDebug = @('IsDebuggerPresent', 'CheckRemoteDebuggerPresent', 'NtQueryInformationProcess', 'OutputDebugString', 'GetTickCount', 'QueryPerformanceCounter', 'NtSetInformationThread')
        foreach ($api in $antiDebug) { if ($ascii -match $api) { $techniques['Anti-Debug'] += $api } }
        
        # Anti-VM
        $antiVM = @('VirtualBox', 'VMware', 'VBox', 'vmci', 'qemu', 'xen', 'VBoxDrv', 'vmhgfs', 'vmxnet')
        foreach ($vm in $antiVM) { if ($ascii -match $vm) { $techniques['Anti-VM'] += $vm } }
        
        # Anti-Sandbox
        $antiSandbox = @('SbieDll', 'Sandboxie', 'Cuckoo', 'JoeBox', 'Anubis', 'Norman', 'ThreatExpert')
        foreach ($sb in $antiSandbox) { if ($ascii -match $sb) { $techniques['Anti-Sandbox'] += $sb } }
        
        # Evasion
        $evasion = @('Sleep', 'WaitForSingleObject', 'CreateThread', 'VirtualAlloc', 'WriteProcessMemory', 'CreateRemoteThread')
        foreach ($ev in $evasion) { if ($ascii -match $ev) { $techniques['Evasion'] += $ev } }
        
        # Timing Checks
        $timing = @('GetTickCount', 'QueryPerformanceCounter', 'RDTSC', 'timeGetTime')
        foreach ($t in $timing) { if ($ascii -match $t) { $techniques['Timing'] += $t } }
        
        return $techniques
    } catch { return $null }
}

# 9. MALWARE CAPABILITIES
function Get-MalwareCapabilities {
    param([string]$Path)
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $ascii = [System.Text.Encoding]::ASCII.GetString($bytes)
        
        $caps = @{
            'Keylogger' = $false
            'ScreenCapture' = $false
            'CredentialDump' = $false
            'Persistence' = $false
            'C2' = $false
            'FileExfil' = $false
            'ProcessInjection' = $false
            'Ransomware' = $false
            'Rootkit' = $false
            'Downloader' = $false
        }
        
        if ($ascii -match '(GetAsyncKeyState|SetWindowsHookEx|keylog)') { $caps['Keylogger'] = $true }
        if ($ascii -match '(BitBlt|GetDC|screenshot|PrintScreen)') { $caps['ScreenCapture'] = $true }
        if ($ascii -match '(lsass|sam\.db|ntds\.dit|mimikatz|sekurlsa|vaultcmd)') { $caps['CredentialDump'] = $true }
        if ($ascii -match '(Run\\|CurrentVersion\\Policies|schtasks|sc create|RegSetValue)') { $caps['Persistence'] = $true }
        if ($ascii -match '(wss?://|https?://\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}|beacon|callback|c2)') { $caps['C2'] = $true }
        if ($ascii -match '(FTP|upload|exfil|sendto|WebClient)') { $caps['FileExfil'] = $true }
        if ($ascii -match '(CreateRemoteThread|WriteProcessMemory|VirtualAllocEx|NtCreateThreadEx)') { $caps['ProcessInjection'] = $true }
        if ($ascii -match '(encrypt|decrypt|ransom|bitcoin|\.locked|\.encrypted|YOUR_FILES)') { $caps['Ransomware'] = $true }
        if ($ascii -match '(driver|sys|kernel|ring0|NtCreateFile)') { $caps['Rootkit'] = $true }
        if ($ascii -match '(download|URLDownload|WinINet|http_client|wget|curl)') { $caps['Downloader'] = $true }
        
        return $caps
    } catch { return $null }
}

# 10. MITRE ATT&CK MAPPING
function Get-ATTACKMapping {
    param($Capabilities)
    $mapping = @()
    if ($Capabilities.Keylogger) { $mapping += @{ 'ID' = 'T1056.001'; 'Name' = 'Input Capture: Keylogging'; 'Tactic' = 'Collection' } }
    if ($Capabilities.ScreenCapture) { $mapping += @{ 'ID' = 'T1113'; 'Name' = 'Screen Capture'; 'Tactic' = 'Collection' } }
    if ($Capabilities.CredentialDump) { $mapping += @{ 'ID' = 'T1003'; 'Name' = 'OS Credential Dumping'; 'Tactic' = 'Credential Access' } }
    if ($Capabilities.Persistence) { $mapping += @{ 'ID' = 'T1547'; 'Name' = 'Boot or Logon Autostart Execution'; 'Tactic' = 'Persistence' } }
    if ($Capabilities.C2) { $mapping += @{ 'ID' = 'T1071'; 'Name' = 'Application Layer Protocol'; 'Tactic' = 'Command and Control' } }
    if ($Capabilities.FileExfil) { $mapping += @{ 'ID' = 'T1041'; 'Name' = 'Exfiltration Over C2 Channel'; 'Tactic' = 'Exfiltration' } }
    if ($Capabilities.ProcessInjection) { $mapping += @{ 'ID' = 'T1055'; 'Name' = 'Process Injection'; 'Tactic' = 'Defense Evasion' } }
    if ($Capabilities.Ransomware) { $mapping += @{ 'ID' = 'T1486'; 'Name' = 'Data Encrypted for Impact'; 'Tactic' = 'Impact' } }
    if ($Capabilities.Downloader) { $mapping += @{ 'ID' = 'T1105'; 'Name' = 'Ingress Tool Transfer'; 'Tactic' = 'Command and Control' } }
    return $mapping
}

# 11. NETWORK INDICATORS
function Get-NetworkIndicators {
    param([string]$Path)
    Update-Status "Analisando padrões de rede..."
    $patternDB = @{
        'p1' = (Decode-String 'Q29iYWx0IFN0cmlrZQ==')
        'p2' = (Decode-String 'bWV0ZXJwcmV0ZXJlcg==')
        'p3' = (Decode-String 'ZW1waXJl')
        'p4' = (Decode-String 'c2xpdmVy')
        'p5' = (Decode-String 'TWltaWthdHo=')
        'p6' = (Decode-String 'cG93ZXJzaGVsbCAtbm9wIC13IGhpZGRlbg==')
    }
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $asciiString = [System.Text.Encoding]::ASCII.GetString($bytes)
        $results = @{
            'Detected' = $false; 'Frameworks' = @(); 'SuspiciousIPs' = @()
            'SuspiciousDomains' = @(); 'SuspiciousPorts' = @()
            'Patterns' = @(); 'EncodedCmds' = @(); 'RiskLevel' = 'None'
        }
        foreach ($key in $patternDB.Keys) {
            if ($asciiString -match [regex]::Escape($patternDB[$key])) {
                $results['Patterns'] += $key
                $results['Detected'] = $true
            }
        }
        $ipPattern = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'
        $allIPs = [regex]::Matches($asciiString, $ipPattern) | ForEach-Object { $_.Value } | Select-Object -Unique
        $suspiciousRanges = @('185\.', '45\.', '139\.', '159\.', '167\.', '178\.', '188\.', '193\.', '194\.', '195\.')
        foreach ($ip in $allIPs) {
            if ($ip -match '^(10\.|172\.(1[6-9]|2[0-9]|3[01])\.|192\.168\.|127\.|0\.0\.0\.0)') { continue }
            foreach ($range in $suspiciousRanges) {
                if ($ip -match "^$range") { $results['SuspiciousIPs'] += $ip; break }
            }
        }
        $domainPattern = '\b([a-zA-Z0-9][-a-zA-Z0-9]*\.)+[a-zA-Z]{2,}\b'
        $allDomains = [regex]::Matches($asciiString, $domainPattern) | ForEach-Object { $_.Value } | Select-Object -Unique
        foreach ($domain in $allDomains) {
            $numberCount = ($domain.ToCharArray() | Where-Object { $_ -match '[0-9]' }).Count
            if ($numberCount -gt 5 -or $domain.Length -gt 50 -or $domain -match '\.(xyz|top|club|work|click|link)$') {
                $results['SuspiciousDomains'] += $domain
            }
        }
        $c2Ports = @('4444', '5555', '8080', '8443', '4443', '9999', '1337', '31337')
        $portMatches = [regex]::Matches($asciiString, ':\d{2,5}') | ForEach-Object { $_.Value -replace ':','' } | Select-Object -Unique
        foreach ($port in $portMatches) {
            if ($c2Ports -contains $port) { $results['SuspiciousPorts'] += $port }
        }
        $behaviorPatterns = @((Decode-String 'c2xlZXAg'), (Decode-String 'YmVhY29u'), (Decode-String 'Y2FsbGJhY2s='), (Decode-String 'aGVhcnRiZWF0'), 'Start-Sleep', 'SetInterval', 'setTimeout')
        foreach ($pattern in $behaviorPatterns) {
            if ($asciiString -match $pattern) { $results['Patterns'] += $pattern }
        }
        $base64Pattern = '[A-Za-z0-9+/]{100,}={0,2}'
        $base64Matches = [regex]::Matches($asciiString, $base64Pattern) | ForEach-Object { $_.Value }
        foreach ($b64 in $base64Matches) {
            try {
                $decoded = [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($b64))
                if ($decoded -match '(powershell|cmd|wget|curl|invoke|download)') {
                    $results['EncodedCmds'] += @{ 'Encoded' = $b64.Substring(0, [Math]::Min(50, $b64.Length)); 'Decoded' = $decoded.Substring(0, [Math]::Min(100, $decoded.Length)) }
                }
            } catch {}
        }
        $riskScore = 0
        if ($results['Patterns'].Count -gt 0) { $riskScore += 30 }
        if ($results['SuspiciousIPs'].Count -gt 0) { $riskScore += ($results['SuspiciousIPs'].Count * 5) }
        if ($results['SuspiciousDomains'].Count -gt 0) { $riskScore += ($results['SuspiciousDomains'].Count * 5) }
        if ($results['SuspiciousPorts'].Count -gt 0) { $riskScore += ($results['SuspiciousPorts'].Count * 3) }
        if ($results['EncodedCmds'].Count -gt 0) { $riskScore += ($results['EncodedCmds'].Count * 10) }
        if ($riskScore -ge 50) { $results['RiskLevel'] = 'CRITICAL' }
        elseif ($riskScore -ge 30) { $results['RiskLevel'] = 'HIGH' }
        elseif ($riskScore -ge 15) { $results['RiskLevel'] = 'MEDIUM' }
        elseif ($riskScore -gt 0) { $results['RiskLevel'] = 'LOW' }
        if ($riskScore -gt 0) { $results['Detected'] = $true }
        return $results
    } catch { return @{ 'Detected' = $false; 'Error' = $_; 'RiskLevel' = 'Unknown' } }
}

# ============================================================================
# STEGANOGRAPHY FUNCTIONS
# ============================================================================
function Find-EndOfJPEG {
    param([byte[]]$Bytes)
    try { for ($i = $Bytes.Length - 2; $i -ge 0; $i--) { if ($Bytes[$i] -eq 0xFF -and $Bytes[$i + 1] -eq 0xD9) { return $i + 2 } } } catch {}
    return -1
}

function Find-EndOfPNG {
    param([byte[]]$Bytes)
    try {
        $iendPattern = [byte[]](0x49, 0x45, 0x4E, 0x44)
        for ($i = $Bytes.Length - 12; $i -ge 8; $i--) {
            $match = $true
            for ($j = 0; $j -lt 4; $j++) { if ($Bytes[$i + $j] -ne $iendPattern[$j]) { $match = $false; break } }
            if ($match) { return $i + 8 }
        }
    } catch {}
    return -1
}

function Find-EndOfGIF {
    param([byte[]]$Bytes)
    try { for ($i = $Bytes.Length - 2; $i -ge 0; $i--) { if ($Bytes[$i] -eq 0x3B -and $Bytes[$i + 1] -eq 0x00) { return $i + 2 } } } catch {}
    return -1
}

function Find-EndOfPDF {
    param([byte[]]$Bytes)
    try {
        $eofPattern = [System.Text.Encoding]::ASCII.GetBytes("%%EOF")
        for ($i = $Bytes.Length - 5; $i -ge 0; $i--) {
            $match = $true
            for ($j = 0; $j -lt 5; $j++) { if ($Bytes[$i + $j] -ne $eofPattern[$j]) { $match = $false; break } }
            if ($match) { return $i + 5 }
        }
    } catch {}
    return -1
}

function Find-EndOfBMP {
    param([byte[]]$Bytes)
    try {
        if ($Bytes.Length -lt 54) { return -1 }
        $width = [System.BitConverter]::ToUInt32($Bytes[18..21], 0)
        $height = [System.BitConverter]::ToUInt32($Bytes[22..25], 0)
        $bitsPerPixel = [System.BitConverter]::ToUInt16($Bytes[28..29], 0)
        $rowSize = [Math]::Ceiling($width * ($bitsPerPixel / 8.0) / 4.0) * 4
        $imageSize = $rowSize * $height
        return 54 + $imageSize
    } catch {}
    return -1
}

function Find-EndOfWAV {
    param([byte[]]$Bytes)
    try {
        if ($Bytes.Length -ge 8) {
            $riffSize = [System.BitConverter]::ToUInt32($Bytes[4..7], 0)
            return $riffSize + 8
        }
    } catch {}
    return -1
}

function Get-PayloadSignature {
    param([byte[]]$Bytes)
    if ($Bytes.Length -lt 4) { return "DESCONHECIDO" }
    $hex = [System.BitConverter]::ToString($Bytes[0..15]) -replace '-',''
    $signatures = @{
        '504B0304' = 'ZIP Archive'; '25504446' = 'PDF Document'; '4D5A9000' = 'PE Executable'
        '4D5A' = 'PE Executable'; '1F8B08' = 'GZIP Compressed'; '52617221' = 'RAR Archive'
        '377ABCAF271C' = '7-Zip Archive'; 'FD377A585A00' = 'XZ Archive'; '425A68' = 'BZIP2 Archive'
        '89504E47' = 'PNG Image'; 'FFD8FF' = 'JPEG Image'; '47494638' = 'GIF Image'
        '57415645' = 'WAV Audio'; '494433' = 'MP3 Audio'; '664C6143' = 'FLAC Audio'
    }
    foreach ($sig in $signatures.Keys) { if ($hex.StartsWith($sig)) { return $signatures[$sig] } }
    try {
        $ascii = [System.Text.Encoding]::ASCII.GetString($Bytes[0..255])
        $psPatterns = @('\$(\w+|\{[^}]+\})', '\b(Get-|Set-|Invoke-|New-|Remove-|Write-|Out-)', '\b(param\s*\()', '\b(function|filter)\s+\w+', '\[System\.')
        $psMatches = ($psPatterns | Where-Object { $ascii -match $_ }).Count
        if ($psMatches -ge 2) { return "PowerShell Script (.ps1)" }
        $batPatterns = @('@echo', '^\s*rem', 'set\s+\w+=', 'call\s+', 'goto\s+')
        $batMatches = ($batPatterns | Where-Object { $ascii -match $_ }).Count
        if ($batMatches -ge 2) { return "Batch Script (.bat/.cmd)" }
        if ($ascii -match '^[\x20-\x7E]{50,}$') { return "Text Data (.txt)" }
    } catch {}
    return "Binary Data (Unknown)"
}

function Inspect-ZipContent {
    param([string]$FilePath)
    try {
        $zip = [System.IO.Compression.ZipFile]::OpenRead($FilePath)
        $files = $zip.Entries | ForEach-Object { @{ 'Name' = $_.FullName; 'Size' = $_.Length; 'Compressed' = $_.CompressedLength } }
        $zip.Dispose()
        return $files
    } catch { return @(@{ 'Name' = "Erro: $_"; 'Size' = 0; 'Compressed' = 0 }) }
}

function Detect-Steganography {
    param([string]$Path)
    $fileInfo = Get-FileTypeByMagic $Path
    $category = $fileInfo.Category
    if ($category -notin @('image', 'audio', 'video', 'multimedia', 'document', 'archive')) {
        return @{ 'Detected' = $false; 'Message' = "Tipo não suportado"; 'FileType' = $fileInfo.Type }
    }
    Update-Status "Analisando steganografia em $category..."
    $result = @{ 'Detected' = $false; 'FileType' = $fileInfo.Type; 'Category' = $category; 'PayloadOffset' = 0; 'PayloadSize' = 0; 'PayloadType' = '-'; 'PayloadPreview' = @(); 'ZipContents' = @(); 'Warning' = $null; 'Method' = ''; 'SourcePath' = $Path }
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $fileSize = $bytes.Length
        $endOfData = -1
        switch ($fileInfo.Extension.ToLower()) {
            '.jpg' { $endOfData = Find-EndOfJPEG $bytes; $result['Method'] = "JPEG EOI marker (0xFFD9)" }
            '.jpeg' { $endOfData = Find-EndOfJPEG $bytes; $result['Method'] = "JPEG EOI marker (0xFFD9)" }
            '.png' { $endOfData = Find-EndOfPNG $bytes; $result['Method'] = "PNG IEND chunk" }
            '.gif' { $endOfData = Find-EndOfGIF $bytes; $result['Method'] = "GIF terminator (0x003B)" }
            '.bmp' { $endOfData = Find-EndOfBMP $bytes; $result['Method'] = "BMP header calculation" }
            '.wav' { $endOfData = Find-EndOfWAV $bytes; $result['Method'] = "WAV RIFF size" }
            '.pdf' { $endOfData = Find-EndOfPDF $bytes; $result['Method'] = "PDF %%EOF marker" }
            default { $result['Method'] = "Generic detection"; $endOfData = $fileSize }
        }
        if ($endOfData -gt 0 -and $endOfData -lt $fileSize) {
            $payloadSize = $fileSize - $endOfData
            if ($payloadSize -ge 16) {
                $result['Detected'] = $true
                $result['PayloadOffset'] = $endOfData
                $result['PayloadSize'] = $payloadSize
                $payloadBytes = $bytes[$endOfData..($fileSize - 1)]
                $result['PayloadType'] = Get-PayloadSignature $payloadBytes
                $previewAscii = [System.Text.Encoding]::ASCII.GetString($payloadBytes[0..[Math]::Min(255, $payloadBytes.Length - 1)])
                $result['PayloadPreview'] = [regex]::Matches($previewAscii, '[\x20-\x7E]{8,}') | ForEach-Object { $_.Value } | Select-Object -First 5
                if ($result['PayloadType'] -eq 'ZIP Archive' -and $result['PayloadSize'] -lt 50MB) {
                    $tempPath = [System.IO.Path]::GetTempFileName() + ".zip"
                    try {
                        [System.IO.File]::WriteAllBytes($tempPath, $payloadBytes)
                        $result['ZipContents'] = Inspect-ZipContent $tempPath
                    } catch { $result['ZipContents'] = @(@{ 'Name' = "Erro: $_"; 'Size' = 0 }) }
                    finally { if (Test-Path $tempPath) { Remove-Item $tempPath -Force -ErrorAction SilentlyContinue } }
                }
            }
        }
    } catch { $result['Warning'] = "Erro na análise: $_" }
    return $result
}

function Extract-Payload {
    param([string]$SourcePath, [int]$Offset, [int]$Size, [string]$DestinationPath)
    try {
        $bytes = [System.IO.File]::ReadAllBytes($SourcePath)
        $payloadBytes = $bytes[$Offset..($Offset + $Size - 1)]
        [System.IO.File]::WriteAllBytes($DestinationPath, $payloadBytes)
        return @{ 'Success' = $true; 'Path' = $DestinationPath; 'Size' = $Size }
    } catch { return @{ 'Success' = $false; 'Message' = "Erro: $_" } }
}

function Detect-Overlay {
    param([string]$Path)
    if (!(Test-IsPEFile $Path)) { return @{ 'Present' = $false } }
    try {
        $bytes = [System.IO.File]::ReadAllBytes($Path)
        $fileSize = $bytes.Length
        $reader = New-Object System.IO.BinaryReader([System.IO.MemoryStream]::New($bytes))
        $reader.BaseStream.Seek(0x3C, 'Begin') | Out-Null
        $peOffset = $reader.ReadUInt32()
        $reader.BaseStream.Seek($peOffset + 0x54, 'Begin') | Out-Null
        $sizeOfHeaders = $reader.ReadUInt32()
        $reader.Close()
        if ($fileSize -gt $sizeOfHeaders) { return @{ 'Present' = $true; 'Size' = $fileSize - $sizeOfHeaders } }
        return @{ 'Present' = $false }
    } catch { return @{ 'Present' = $false } }
}

# ============================================================================
# FUNÇÃO PRINCIPAL DE ANÁLISE
# ============================================================================
function Start-Analysis {
    param([string]$FilePath)
    if (!(Test-Path $FilePath)) { Write-OutputBox "❌ Arquivo não encontrado!" -Level 'Error'; return }
    
    $Global:PayloadInfo = $null
    $startTime = Get-Date
    $txtOutput.Clear()
    
    Write-OutputBox "╔════════════════════════════════════════════════════════════╗" -Level 'Header'
    Write-OutputBox "║           DeepSight ANALYZER v1.0 - COMPLETE               ║" -Level 'Header'
    Write-OutputBox "╚════════════════════════════════════════════════════════════╝" -Level 'Header'
    Write-OutputBox ""
    Write-OutputBox "📁 Arquivo: $FilePath" -Level 'Info'
    Write-OutputBox "⏰ Início: $($startTime.ToString('yyyy-MM-dd HH:mm:ss'))"
    Write-OutputBox ""
    
    try {
        # Metadata
        Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -Level 'Header'
        Write-OutputBox "📋 METADATA" -Level 'Header'
        Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        $item = Get-Item $FilePath
        $fileType = Get-FileTypeByMagic $FilePath
        Write-OutputBox "Nome: $($item.Name)" -Level 'Info'
        Write-OutputBox "Tamanho: $(Get-FileSizeFormatted $item.Length)"
        Write-OutputBox "Tipo: $($fileType.Type)"
        Write-OutputBox "Extensão: $($item.Extension)"
        Write-OutputBox "Criado: $($item.CreationTime)"
        Write-OutputBox "Modificado: $($item.LastWriteTime)"
        Write-OutputBox ""
        
        # Hashes
        Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -Level 'Header'
        Write-OutputBox "🔐 HASHES" -Level 'Header'
        Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        $hashes = Get-FileHashes $FilePath
        Write-OutputBox "MD5:    $($hashes.MD5)" -Level 'Info'
        Write-OutputBox "SHA1:   $($hashes.SHA1)"
        Write-OutputBox "SHA256: $($hashes.SHA256)"
        Write-OutputBox "SHA512: $($hashes.SHA512)"
        Write-OutputBox ""
        
        # Certificate Analysis
        if (Test-IsPEFile $FilePath) {
            Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -Level 'Header'
            Write-OutputBox "🔐 CERTIFICATE ANALYSIS" -Level 'Header'
            Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            try {
                $sig = Get-AuthenticodeSignature $FilePath -ErrorAction Stop
                if ($sig.Status -eq 'Valid' -or $sig.SignerCertificate) {
                    $cert = $sig.SignerCertificate
                    Write-OutputBox "✓ Assinatura válida" -Level 'Success'
                    Write-OutputBox "  Subject: $($cert.Subject)"
                    Write-OutputBox "  Issuer: $($cert.Issuer)"
                    Write-OutputBox "  Thumbprint: $($cert.Thumbprint)"
                    Write-OutputBox "  Validade: $($cert.NotBefore) até $($cert.NotAfter)"
                    if ($cert.Subject -match '\b\d{1,3}(?:\.\d{1,3}){3}\b') { Write-OutputBox "  🔴 IP detectado no certificado!" -Level 'Error' }
                } elseif ($sig.Status -eq 'UnknownError' -or ($cert.Subject -eq $cert.Issuer)) {
                    Write-OutputBox "⚠️  Certificado autoassinado ou não validado" -Level 'Warning'
                    Write-OutputBox "  Subject: $($cert.Subject)"
                    Write-OutputBox "  Issuer: $($cert.Issuer)"
                    Write-OutputBox "  Thumbprint: $($cert.Thumbprint)"
                    if ($cert.Subject -match '\b\d{1,3}(?:\.\d{1,3}){3}\b') { Write-OutputBox "  🔴 IP detectado no certificado!" -Level 'Error' }
                } else { Write-OutputBox "❌ Não assinado: $($sig.Status)" -Level 'Error' }
            } catch { Write-OutputBox "❌ Erro: $_" -Level 'Error' }
            Write-OutputBox ""
        }
        
        # Entropy
        Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -Level 'Header'
        Write-OutputBox "📊 ENTROPIA" -Level 'Header'
        Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        $entropy = Get-Entropy $FilePath
        $verdict = switch ($entropy) {
            { $_ -lt 3.0 } { "Muito baixa - Texto" }
            { $_ -lt 5.0 } { "Baixa - Estruturado" }
            { $_ -lt 6.5 } { "Média - Mistos" }
            { $_ -lt 7.5 } { "Alta - Comprimido" }
            default { "Muito alta - Criptografado/Packed" }
        }
        Write-OutputBox "Entropia: $entropy / 8.0" -Level 'Info'
        Write-OutputBox "Classificação: $verdict"
        Write-OutputBox ""
        
        # Steganography
        Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -Level 'Header'
        Write-OutputBox "🕵️ STEGANOGRAPHY & HIDDEN DATA" -Level 'Header'
        Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        $stego = Detect-Steganography $FilePath
        Write-OutputBox "Método: $($stego.Method)" -Level 'Info'
        if ($stego.Detected) {
            Write-OutputBox ""
            Write-OutputBox "🔴 DADOS OCULTOS DETECTADOS!" -Level 'Error'
            Write-OutputBox "Offset: 0x$($stego.PayloadOffset.ToString('X8'))"
            Write-OutputBox "Tamanho: $(Get-FileSizeFormatted $stego.PayloadSize)"
            Write-OutputBox "Tipo: $($stego.PayloadType)"
            if ($stego.PayloadPreview.Count -gt 0) { Write-OutputBox ""; Write-OutputBox "Preview:"; foreach ($line in $stego.PayloadPreview) { Write-OutputBox "  • $line" } }
            $Global:PayloadInfo = @{ 'SourcePath' = $FilePath; 'Offset' = $stego.PayloadOffset; 'Size' = $stego.PayloadSize; 'Type' = $stego.PayloadType }
            Write-OutputBox ""; Write-OutputBox "⚠️  Botão 'Extrair Payload' habilitado!" -Level 'Warning'
        } else { Write-OutputBox ""; Write-OutputBox "✓ Nenhum dado oculto" -Level 'Success' }
        Write-OutputBox ""
        
        # DEEP ANALYSIS MODE - ALL RE FEATURES
        if ($chkDeepAnalysis.IsChecked -and (Test-IsPEFile $FilePath)) {
            Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -Level 'Header'
            Write-OutputBox "🔬 DEEP ANALYSIS MODE (REVERSE ENGINEERING)" -Level 'Header'
            Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            
            # 1. PE Header Info
            Update-Status "Deep Analysis: PE Header..."
            $peInfo = Get-PEHeaderInfo -Path $FilePath
            if ($peInfo) {
                Write-OutputBox ""
                Write-OutputBox "📐 PE HEADER INFORMATION:" -Level 'Info'
                Write-OutputBox "  Architecture: $($peInfo.Machine)"
                Write-OutputBox "  Format: $($peInfo.Format)"
                Write-OutputBox "  Sections: $($peInfo.Sections)"
                Write-OutputBox "  Entry Point: $($peInfo.EntryPoint)"
                Write-OutputBox "  Image Base: $($peInfo.ImageBase)"
                Write-OutputBox "  Subsystem: $($peInfo.Subsystem)"
                Write-OutputBox "  Compiled: $($peInfo.Compiled)"
            }
            
            # 2. Section Details
            Update-Status "Deep Analysis: Sections..."
            $sections = Get-SectionDetails -Path $FilePath
            if ($sections.Count -gt 0) {
                Write-OutputBox ""
                Write-OutputBox "📊 SECTION DETAILS:" -Level 'Info'
                foreach ($section in $sections) {
                    $flags = ""
                    if ($section.Executable) { $flags += "X" }
                    if ($section.Writable) { $flags += "W" }
                    if ($section.Readable) { $flags += "R" }
                    $suspicious = ""
                    if ($section.Entropy -gt 7.0) { $suspicious = " ⚠️ HIGH ENTROPY" }
                    if ($section.Name -match 'UPX|ASPack|Themida|VMProtect') { $suspicious = " 🔴 PACKER" }
                    if ($section.Executable -and $section.Writable) { $suspicious = " 🔴 RWX (SUSPICIOUS)" }
                    Write-OutputBox "  $($section.Name.PadRight(10)) VA: $($section.VirtualAddress) Size: $(Get-FileSizeFormatted $section.RawSize) Entropy: $($section.Entropy) Flags: $flags$suspicious"
                }
            }
            
            # 3. Import Table
            Update-Status "Deep Analysis: Import Table..."
            $imports = Get-ImportTable -Path $FilePath
            if ($imports.Count -gt 0) {
                Write-OutputBox ""
                Write-OutputBox "📚 IMPORTED DLLs:" -Level 'Info'
                $imports | ForEach-Object { Write-OutputBox "  - $_.dll" }
            }
            
            # 4. Suspicious APIs
            Update-Status "Deep Analysis: Suspicious APIs..."
            $suspiciousAPIs = Get-SuspiciousAPIs -Path $FilePath
            if ($suspiciousAPIs.Count -gt 0) {
                Write-OutputBox ""
                Write-OutputBox "⚠️  SUSPICIOUS APIs:" -Level 'Warning'
                foreach ($category in $suspiciousAPIs.Keys) {
                    Write-OutputBox "  $category ($($suspiciousAPIs[$category].Count)):" -Level 'Warning'
                    $suspiciousAPIs[$category] | Select-Object -First 5 | ForEach-Object { Write-OutputBox "    - $_" }
                }
            }
            
            # 5. Packer Info
            Update-Status "Deep Analysis: Packer Detection..."
            $packerInfo = Get-PackerInfo -Path $FilePath
            if ($packerInfo) {
                Write-OutputBox ""
                Write-OutputBox "📦 PACKER/COMPILER:" -Level 'Info'
                if ($packerInfo.Packer) { Write-OutputBox "  Packer: $($packerInfo.Packer) 🔴" -Level 'Warning' }
                if ($packerInfo.Compiler) { Write-OutputBox "  Compiler: $($packerInfo.Compiler)" }
                if ($packerInfo.IsPacked) { Write-OutputBox "  ⚠️  File is packed - unpacking recommended before RE" -Level 'Warning' }
            }
            
            # 6. Resource Info
            Update-Status "Deep Analysis: Resources..."
            $resources = Get-ResourceInfo -Path $FilePath
            if ($resources.Count -gt 0) {
                Write-OutputBox ""
                Write-OutputBox "🎁 EMBEDDED RESOURCES:" -Level 'Info'
                $resources | ForEach-Object { Write-OutputBox "  - $_" }
            }
            
            # 7. TLS Callbacks
            Update-Status "Deep Analysis: TLS Callbacks..."
            $hasTLS = Detect-TLSCallbacks -Path $FilePath
            if ($hasTLS) {
                Write-OutputBox ""
                Write-OutputBox "⚠️  TLS CALLBACKS DETECTED!" -Level 'Warning'
                Write-OutputBox "  TLS callbacks execute before entry point - common anti-debug technique"
            }
            
            # 8. Anti-Analysis
            Update-Status "Deep Analysis: Anti-Analysis..."
            $antiAnalysis = Detect-AntiAnalysis -Path $FilePath
            if ($antiAnalysis) {
                Write-OutputBox ""
                Write-OutputBox "🛡️  ANTI-ANALYSIS TECHNIQUES:" -Level 'Warning'
                if ($antiAnalysis['Anti-Debug'].Count -gt 0) { Write-OutputBox "  Anti-Debug ($($antiAnalysis['Anti-Debug'].Count)):" -Level 'Warning'; $antiAnalysis['Anti-Debug'] | ForEach-Object { Write-OutputBox "    - $_" } }
                if ($antiAnalysis['Anti-VM'].Count -gt 0) { Write-OutputBox "  Anti-VM ($($antiAnalysis['Anti-VM'].Count)):" -Level 'Warning'; $antiAnalysis['Anti-VM'] | ForEach-Object { Write-OutputBox "    - $_" } }
                if ($antiAnalysis['Anti-Sandbox'].Count -gt 0) { Write-OutputBox "  Anti-Sandbox ($($antiAnalysis['Anti-Sandbox'].Count)):" -Level 'Warning'; $antiAnalysis['Anti-Sandbox'] | ForEach-Object { Write-OutputBox "    - $_" } }
                if ($antiAnalysis['Evasion'].Count -gt 0) { Write-OutputBox "  Evasion ($($antiAnalysis['Evasion'].Count)):" -Level 'Warning'; $antiAnalysis['Evasion'] | ForEach-Object { Write-OutputBox "    - $_" } }
                if ($antiAnalysis['Timing'].Count -gt 0) { Write-OutputBox "  Timing Checks ($($antiAnalysis['Timing'].Count)):" -Level 'Warning'; $antiAnalysis['Timing'] | ForEach-Object { Write-OutputBox "    - $_" } }
            }
            
            # 9. Malware Capabilities
            Update-Status "Deep Analysis: Capabilities..."
            $capabilities = Get-MalwareCapabilities -Path $FilePath
            if ($capabilities) {
                Write-OutputBox ""
                Write-OutputBox "🎯 MALWARE CAPABILITIES:" -Level 'Error'
                if ($capabilities.Keylogger) { Write-OutputBox "  🔴 Keylogger" -Level 'Error' }
                if ($capabilities.ScreenCapture) { Write-OutputBox "  🔴 Screen Capture" -Level 'Error' }
                if ($capabilities.CredentialDump) { Write-OutputBox "  🔴 Credential Dumping" -Level 'Error' }
                if ($capabilities.Persistence) { Write-OutputBox "  🟠 Persistence" -Level 'Warning' }
                if ($capabilities.C2) { Write-OutputBox "  🔴 Command & Control" -Level 'Error' }
                if ($capabilities.FileExfil) { Write-OutputBox "  🟠 File Exfiltration" -Level 'Warning' }
                if ($capabilities.ProcessInjection) { Write-OutputBox "  🔴 Process Injection" -Level 'Error' }
                if ($capabilities.Ransomware) { Write-OutputBox "  🔴 Ransomware" -Level 'Error' }
                if ($capabilities.Rootkit) { Write-OutputBox "  🔴 Rootkit" -Level 'Error' }
                if ($capabilities.Downloader) { Write-OutputBox "  🟠 Downloader" -Level 'Warning' }
            }
            
            # 10. MITRE ATT&CK
            Update-Status "Deep Analysis: ATT&CK..."
            $attackMapping = Get-ATTACKMapping -Capabilities $capabilities
            if ($attackMapping.Count -gt 0) {
                Write-OutputBox ""
                Write-OutputBox "📋 MITRE ATT&CK MAPPING:" -Level 'Info'
                foreach ($technique in $attackMapping) {
                    Write-OutputBox "  • $($technique.ID) - $($technique.Name) ($($technique.Tactic))"
                }
            }
            
            # 11. Network Analysis
            Update-Status "Deep Analysis: Network Patterns..."
            Write-OutputBox ""
            Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -Level 'Header'
            Write-OutputBox "🌐 NETWORK ANALYSIS" -Level 'Header'
            Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            $network = Get-NetworkIndicators -Path $FilePath
            if ($network.Detected) {
                $riskColor = switch ($network.RiskLevel) { 'CRITICAL' { 'Error' }; 'HIGH' { 'Error' }; 'MEDIUM' { 'Warning' }; default { 'Info' } }
                Write-OutputBox ""
                Write-OutputBox "⚠️  PADRÕES SUSPEITOS - Risco: $($network.RiskLevel)" -Level $riskColor
                if ($network.SuspiciousIPs.Count -gt 0) { Write-OutputBox ""; Write-OutputBox "IPs Suspeitos ($($network.SuspiciousIPs.Count)):" -Level 'Warning'; $network.SuspiciousIPs | Select-Object -First 10 | ForEach-Object { Write-OutputBox "  - $_" } }
                if ($network.SuspiciousDomains.Count -gt 0) { Write-OutputBox ""; Write-OutputBox "Domínios Suspeitos ($($network.SuspiciousDomains.Count)):" -Level 'Warning'; $network.SuspiciousDomains | Select-Object -First 10 | ForEach-Object { Write-OutputBox "  - $_" } }
                if ($network.SuspiciousPorts.Count -gt 0) { Write-OutputBox ""; Write-OutputBox "Portas Suspeitas:" -Level 'Warning'; $network.SuspiciousPorts | ForEach-Object { Write-OutputBox "  - $_" } }
                if ($network.EncodedCmds.Count -gt 0) { Write-OutputBox ""; Write-OutputBox "Comandos Codificados:" -Level 'Error'; foreach ($cmd in $network.EncodedCmds | Select-Object -First 3) { Write-OutputBox "  Enc: $($cmd.Encoded)"; Write-OutputBox "  Dec: $($cmd.Decoded)" } }
            } else { Write-OutputBox ""; Write-OutputBox "✓ Nenhum padrão de rede suspeito" -Level 'Success' }
            Write-OutputBox ""
        }
        
        # Overlay
        if (Test-IsPEFile $FilePath) {
            Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -Level 'Header'
            Write-OutputBox "⚠️  OVERLAY DETECTION (PE)" -Level 'Header'
            Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            $overlay = Detect-Overlay $FilePath
            if ($overlay.Present) { Write-OutputBox "🔴 OVERLAY: $(Get-FileSizeFormatted $overlay.Size)" -Level 'Error' } else { Write-OutputBox "✓ Sem overlay" -Level 'Success' }
            Write-OutputBox ""
        }
        
        # IOCs
        Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -Level 'Header'
        Write-OutputBox "🔍 IOCs E STRINGS" -Level 'Header'
        Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        $iocs = Get-StringsAndIOCs $FilePath
        if ($iocs.IPs.Count -gt 0) { Write-OutputBox ""; Write-OutputBox "🌐 IPs:" -Level 'Info'; $iocs.IPs | Select-Object -First 10 | ForEach-Object { Write-OutputBox "  - $_" } }
        if ($iocs.URLs.Count -gt 0) { Write-OutputBox ""; Write-OutputBox "🔗 URLs:" -Level 'Info'; $iocs.URLs | Select-Object -First 10 | ForEach-Object { Write-OutputBox "  - $_" } }
        Write-OutputBox ""; Write-OutputBox "📝 Strings (top 20):"
        if ($iocs.Strings.Count -gt 0) { $iocs.Strings | Select-Object -First 20 | ForEach-Object { Write-OutputBox "  - $_" } } else { Write-OutputBox "  (Nenhuma string legível)" }
        
        # Summary
        $endTime = Get-Date
        $duration = ($endTime - $startTime).TotalSeconds
        Write-OutputBox ""
        Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -Level 'Header'
        Write-OutputBox "📊 RESUMO" -Level 'Header'
        Write-OutputBox "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        Write-OutputBox "Tempo: $([Math]::Round($duration, 2))s"
        $riskFactors = @()
        if ($entropy -gt 7.5) { $riskFactors += "Entropia alta" }
        if ($stego.Detected) { $riskFactors += "Steganografia" }
        if (Test-IsPEFile $FilePath -and (Detect-Overlay $FilePath).Present) { $riskFactors += "Overlay PE" }
        if ($chkDeepAnalysis.IsChecked -and (Test-IsPEFile $FilePath)) {
            if ($antiAnalysis -and $antiAnalysis['Anti-Debug'].Count -gt 0) { $riskFactors += "Anti-Debug" }
            if ($capabilities -and $capabilities.C2) { $riskFactors += "C2 Communication" }
            if ($network -and $network.Detected) { $riskFactors += "Network Patterns ($($network.RiskLevel))" }
            if ($packerInfo -and $packerInfo.IsPacked) { $riskFactors += "Packed/Compressed" }
        }
        if ($riskFactors.Count -gt 0) { Write-OutputBox ""; Write-OutputBox "🔴 RISCOS:" -Level 'Error'; $riskFactors | ForEach-Object { Write-OutputBox "  • $_" }; Write-OutputBox ""; Write-OutputBox "⚠️  Analise em sandbox!" -Level 'Warning' } else { Write-OutputBox ""; Write-OutputBox "✓ Sem indicadores críticos" -Level 'Success' }
    } catch { Write-OutputBox ""; Write-OutputBox "❌ ERRO: $_" -Level 'Error' }
    finally { Update-Status "Pronto" }
}

# ============================================================================
# EVENT HANDLERS
# ============================================================================
$btnSelect.Add_Click({
    $dialog = New-Object Microsoft.Win32.OpenFileDialog
    $dialog.Title = "Selecionar arquivo"
    $dialog.Filter = "Todos|*.*|Imagens|*.png;*.jpg;*.jpeg;*.gif;*.bmp|Executáveis|*.exe;*.dll|Documentos|*.pdf;*.zip"
    if ($dialog.ShowDialog() -eq $true) {
        $txtFilePath.Text = $dialog.FileName
        $Global:PayloadInfo = $null
        $btnExtract.IsEnabled = $false
        $btnExport.IsEnabled = $false
        Update-Status "Selecionado: $($dialog.FileName)"
    }
})

$btnAnalyze.Add_Click({
    if ([string]::IsNullOrEmpty($txtFilePath.Text)) { [System.Windows.MessageBox]::Show("Selecione um arquivo!", "Atenção", "OK", "Warning"); return }
    if (!(Test-Path $txtFilePath.Text)) { [System.Windows.MessageBox]::Show("Arquivo não encontrado!", "Erro", "OK", "Error"); return }
    $btnAnalyze.IsEnabled = $false
    $btnExtract.IsEnabled = $false
    Update-Status "Analisando..."
    Start-Analysis -FilePath $txtFilePath.Text
    if ($Global:PayloadInfo -ne $null) { $btnExtract.IsEnabled = $true; Update-Status "Payload detectado!" } else { Update-Status "Análise concluída" }
    $btnAnalyze.IsEnabled = $true
    $btnExport.IsEnabled = $true
})

$btnExtract.Add_Click({
    if ($Global:PayloadInfo -eq $null) { [System.Windows.MessageBox]::Show("Nenhum payload para extrair.", "Info", "OK", "Information"); return }
    $saveDialog = New-Object Microsoft.Win32.SaveFileDialog
    $ext = ".bin"
    if ($Global:PayloadInfo.Type -like "*ZIP*") { $ext = ".zip" }
    elseif ($Global:PayloadInfo.Type -like "*PE*" -or $Global:PayloadInfo.Type -like "*Executable*") { $ext = ".exe" }
    elseif ($Global:PayloadInfo.Type -like "*PNG*") { $ext = ".png" }
    elseif ($Global:PayloadInfo.Type -like "*JPEG*") { $ext = ".jpg" }
    elseif ($Global:PayloadInfo.Type -like "*PowerShell*") { $ext = ".ps1" }
    elseif ($Global:PayloadInfo.Type -like "*Batch*") { $ext = ".bat" }
    elseif ($Global:PayloadInfo.Type -like "*PDF*") { $ext = ".pdf" }
    elseif ($Global:PayloadInfo.Type -like "*Text*") { $ext = ".txt" }
    $saveDialog.Title = "Extrair Payload"
    $saveDialog.Filter = "Arquivo|*{0}|Todos|*.*" -f $ext
    $saveDialog.DefaultExt = $ext
    $saveDialog.FileName = "payload_{0}" -f (Get-Date -Format "yyyyMMdd_HHmmss")
    if ($saveDialog.ShowDialog() -eq $true) {
        Update-Status "Extraindo..."
        $result = Extract-Payload -SourcePath $Global:PayloadInfo.SourcePath -Offset $Global:PayloadInfo.Offset -Size $Global:PayloadInfo.Size -DestinationPath $saveDialog.FileName
        if ($result.Success) { [System.Windows.MessageBox]::Show("Extraído com sucesso!`n`nArquivo: $($result.Path)`nTamanho: $(Get-FileSizeFormatted $result.Size)`n`n⚠️  AVISO: Analise em sandbox!", "Sucesso", "OK", "Warning"); Write-OutputBox ""; Write-OutputBox "💾 PAYLOAD EXTRAÍDO: $($result.Path)" -Level 'Success'; Update-Status "Extraído" } else { [System.Windows.MessageBox]::Show($result.Message, "Erro", "OK", "Error") }
    }
})

$btnExport.Add_Click({
    if ([string]::IsNullOrEmpty($txtOutput.Text)) { [System.Windows.MessageBox]::Show("Nenhum resultado para exportar.", "Info", "OK", "Information"); return }
    Export-Results -Content $txtOutput.Text
})

$window.AllowDrop = $true
$window.Add_Drop({
    if ($this.DataObject.ContainsFileDropList()) {
        $files = $this.DataObject.GetFileDropList()
        if ($files.Count -gt 0) {
            $txtFilePath.Text = $files[0]
            $Global:PayloadInfo = $null
            $btnExtract.IsEnabled = $false
            $btnExport.IsEnabled = $false
            Update-Status "Arquivo: $($files[0])"
        }
    }
})

# ============================================================================
# INICIALIZAÇÃO
# ============================================================================
Update-Status "DeepSight Analyzer v1.0 - Pronto"
Write-OutputBox "👉 Selecione um arquivo e clique em 'Analisar'" -Level 'Info'
Write-OutputBox "☑ Marque 'Deep Analysis Mode' para análise completa de Reverse Engineering" -Level 'Info'
$null = $window.ShowDialog()
