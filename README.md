# 🔍 DeepSight Analyzer

**Digital Forensics & Incident Response Tool**

🔍 Visão Geral
O DeepSight Analyzer é uma ferramenta de análise forense digital e resposta a incidentes (DFIR - Digital Forensics and Incident Response)
desenvolvida em PowerShell com interface gráfica WPF. A ferramenta permite realizar análise estática avançada de arquivos, 
detecção de malware, extração de indicadores de comprometimento (IOCs) e análise de técnicas de evasão.

## 🌟 Funcionalidades Principais

### 🔬 Análise Forense Completa
- **Hashes Criptográficos**: MD5, SHA1, SHA256, SHA512
- **Entropia de Shannon**: Detecção de packing/criptografia
- **File Type Detection**: Identificação por magic bytes
- **Metadata Extraction**: Timestamps, attributes, version info
- **Certificate Analysis**: Validação de assinaturas digitais com detecção de IPs

### 🕵️ Steganography Detection
Detecção de dados ocultos em múltiplos formatos:
- **Imagens**: PNG (IEND chunk), JPEG (EOI marker), GIF, BMP
- **Áudio**: WAV (RIFF size), MP3
- **Documentos**: PDF (%%EOF marker)
- **Payload Extraction**: Extração automática de arquivos embutidos
- **ZIP Inspection**: Listagem de conteúdo de ZIPs ocultos

### 🔧 Deep Analysis Mode (Reverse Engineering)
Análise avançada para arquivos PE (Portable Executable):
- **PE Header Analysis**: Architecture, Entry Point, Image Base, Subsystem
- **Section-by-Section**: Nome, VA, Size, Entropy individual por seção
- **Import Address Table (IAT)**: DLLs e APIs importadas
- **Suspicious API Detection**: 
  - Process Injection (OpenProcess, VirtualAllocEx, WriteProcessMemory)
  - Persistence (RegSetValue, CreateService, SchTasks)
  - Networking (socket, connect, InternetOpen)
  - Anti-Debug (IsDebuggerPresent, CheckRemoteDebuggerPresent)
  - Keylogger, Screen Capture, Credential Dumping
- **Packer/Compiler Detection**: UPX, ASPack, Themida, VMProtect, etc.
- **Resource Extraction**: Icons, Version Info, Manifest, Raw Data
- **TLS Callback Detection**: Técnicas anti-debug avançadas

### 🎯 Malware Capabilities Detection
Identificação automática de capacidades maliciosas:
- 🔴 Keylogger
- 🔴 Screen Capture
- 🔴 Credential Dumping (LSASS, Mimikatz)
- 🟠 Persistence (Registry, Scheduled Tasks)
- 🔴 Command & Control (C2)
- 🟠 File Exfiltration
- 🔴 Process Injection
- 🔴 Ransomware indicators
- 🔴 Rootkit capabilities
- 🟠 Downloader

### 📋 MITRE ATT&CK Mapping
Mapeamento automático para técnicas ATT&CK:
- T1056.001 - Input Capture: Keylogging
- T1113 - Screen Capture
- T1003 - OS Credential Dumping
- T1547 - Boot or Logon Autostart Execution
- T1071 - Application Layer Protocol
- T1041 - Exfiltration Over C2 Channel
- T1055 - Process Injection
- T1486 - Data Encrypted for Impact
- T1105 - Ingress Tool Transfer

### 🌐 Network Indicators Analysis
Detecção de padrões de rede suspeitos:
- **Frameworks C2**: Cobalt Strike, Meterpreter, Empire, Sliver, Mimikatz
- **Suspicious IPs**: Ranges conhecidas de C2 (185.x, 45.x, 139.x, etc.)
- **Suspicious Domains**: DGA detection, TLDs suspeitas (.xyz, .top, .club)
- **C2 Ports**: 4444, 8443, 1337, 31337, etc.
- **Encoded Commands**: Base64 decoding de PowerShell/CMD
- **Behavior Patterns**: Sleep, beacon, callback, heartbeat

### 📊 IOC Extraction
Extração automática de Indicadores de Comprometimento:
- Endereços IP (validação de ranges)
- URLs completas
- Endereços de email
- Paths de arquivo Windows
- Strings legíveis filtradas

### 💾 Payload Extraction
- Detecção automática de tipo (PE, ZIP, PDF, PS1, BAT, etc.)
- Extração com um clique
- Alertas de segurança
- Preview de conteúdo

## 🎨 Interface Profissional

### GUI WPF Moderna
- **Dark Theme**: Interface escura profissional
- **Color-coded Output**: 
  - 🟢 Success
  - 🟡 Warning  
  - 🔴 Error
  - 🔵 Info
  - ⚪ Header
- **Drag & Drop**: Arraste arquivos diretamente
- **Export Results**: Salve análises completas em .txt
- **Status Bar**: Progresso em tempo real
- **Deep Analysis Toggle**: Ative/desative análise profunda

## 📋 Casos de Uso

### Para Analistas de SOC/IR
- ✅ Triagem rápida de alertas
- ✅ Extração de IoCs para bloqueio
- ✅ Geração de reports para threat intel
- ✅ Análise preliminar de malware

### Para Reverse Engineers
- ✅ Análise estática antes de abrir IDA/Ghidra
- ✅ Identificação de packers/compilers
- ✅ Detecção de anti-analysis techniques
- ✅ Mapeamento de capabilities
- ✅ Economia de 30-60 minutos por sample

### Para DFIR Professionals
- ✅ Análise forense post-mortem
- ✅ Extração de artefatos ocultos
- ✅ Detecção de steganografia
- ✅ Validação de certificados
- ✅ Timeline analysis

## 🚀 Requisitos

- **PowerShell**: 5.1 ou superior
- **Sistema**: Windows 10/11
- **Assemblies**: 
  - PresentationFramework (WPF)
  - PresentationCore
  - WindowsBase
  - System.IO.Compression.FileSystem
  - System.Windows.Forms

## 📦 Instalação

```powershell
# Clone o repositório
git clone https://github.com/robsoncyberdefense/DeepSight-Analyzer.git
cd DeepSight-Analyzer

# Execute diretamente
.\DeepSight_Analyzer.ps1
```
💡 Uso
Análise Básica
1. Clique em "📁 Selecionar Arquivo" ou arraste um arquivo
2. Clique em "🔬 Analisar"
3. Visualize os resultados na tela
4. Clique em "📄 Exportar Resultado" para salvar

Deep Analysis Mode
1. Marque a checkbox "🔬 Deep Analysis Mode"
2. Selecione um arquivo PE (exe, dll, sys)
3. Clique em "🔬 Analisar"
4. Aguarde a análise completa (mais lenta, mas mais detalhada)

Extração de Payload
Quando steganography for detectada:
1. O botão "💾 Extrair Payload" será habilitado automaticamente
2. Clique no botão
3. Escolha o local para salvar
4. ⚠️ AVISO: Analise o payload extraído em sandbox!

🎯 Exemplo de Output
```
╔════════════════════════════════════════════════════════════╗
║           DeepSight ANALYZER v1.0 - COMPLETE               ║
╚════════════════════════════════════════════════════════════╝

📁 Arquivo: C:\Samples\suspicious.exe
⏰ Início: 2026-03-20 14:30:15

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔐 HASHES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MD5:    d41d8cd98f00b204e9800998ecf8427e
SHA1:   da39a3ee5e6b4b0d3255bfef95601890afd80709
SHA256: e3b0c44298fc1c149afbf4c8996fb92427ae41e4...
SHA512: cf83e1357eefb8bdf1542850d66d8007d620e405...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 ENTROPIA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Entropia: 7.9906 / 8.0
Classificação: Muito alta - Criptografado/Packed

🔬 DEEP ANALYSIS MODE (REVERSE ENGINEERING)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🛡️  ANTI-ANALYSIS:
  Anti-Debug (3):
    - IsDebuggerPresent
    - CheckRemoteDebuggerPresent
    - NtQueryInformationProcess
  Anti-VM (2):
    - VirtualBox
    - VMware

🎯 CAPABILITIES:
  🔴 Keylogger
  🔴 Credential Dumping
  🔴 Command & Control

📋 MITRE ATT&CK:
  • T1056.001 - Input Capture: Keylogging
  • T1003 - OS Credential Dumping
  • T1071 - Application Layer Protocol

🌐 NETWORK ANALYSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️  PADRÕES SUSPEITOS - Risco: HIGH
IPs Suspeitos (2):
  - 45.76.71.127
  - 185.220.101.45
Domínios Suspeitos (1):
  - c2server.xyz
Portas Suspeitas:
  - 4444
  - 8443

📊 RESUMO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Tempo: 3.42s

🔴 RISCOS:
  • Entropia alta
  • Anti-Debug
  • C2 Communication
  • Network Patterns (HIGH)

⚠️  Analise em sandbox!
```
🔒 Considerações de Segurança

⚠️ AVISOS IMPORTANTES:
- Execute em ambiente isolado (VM/sandbox)
- Não analise arquivos em produção
- Payloads extraídos podem ser maliciosos
- Sempre valide em ambiente controlado

🛡️ Integrações Recomendadas
- VirusTotal: Valide hashes extraídos
- YARA: Combine com regras YARA personalizadas
- SIEM/SOAR: Exporte IoCs para sua plataforma
- Ghidra/IDA: Use como triagem prévia

## 📊 Comparativo de Ferramentas

| Ferramenta | Triagem | RE Profundo | Steganography | MITRE ATT&CK |
|------------|---------|-------------|---------------|--------------|
| PEStudio | ⭐⭐⭐⭐⭐ | ⭐⭐ | ❌ | ❌ |
| Detect It Easy | ⭐⭐⭐⭐ | ⭐⭐ | ❌ | ❌ |
| Ghidra/IDA | ⭐ | ⭐⭐⭐⭐⭐ | ❌ | ❌ |
| **DeepSight** | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |

🤝 Contribuições

Contribuições são bem-vindas! Sinta-se à vontade para:
- Reportar bugs
- Sugerir novas funcionalidades
- Enviar pull requests
- Melhorar detecções

📄 Licença
Este projeto é fornecido "como está" para fins educacionais e de pesquisa em segurança.

⚠️ Disclaimer
Esta ferramenta é destinada exclusivamente para:
- Análise forense autorizada
- Pesquisa em segurança
- Educação e treinamento
- Resposta a incidentes em ambientes controlados

O uso indevido é de responsabilidade do usuário.

👤 Autor
Robson Nunes - Cyber Security
LinkedIn: www.linkedin.com/in/robsoncyberdefense

⭐ Se você acha esta ferramenta útil, dê uma estrela no repositório!
