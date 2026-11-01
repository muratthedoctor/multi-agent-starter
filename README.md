# Multi-agent Starter

Token-tasarruflu bir Claude Code multi-agent kurulumu. Pahalı orchestrator (ana oturum) planlar/delege eder/birleştirir; ucuz subagent'lar okuma, implementasyon, test ve inceleme işini yapıp sadece damıtılmış rapor döndürür. Her role görev yüküne göre model atanır.

## Yapı

```
.
├── .claude/                 # ~/.claude/ ile birebir eşlenir (kurulum hedefi)
│   ├── CLAUDE.md            # global delegasyon kuralları + model tablosu
│   └── agents/
│       ├── explorer.md      # haiku — salt okunur kod tarama
│       ├── coder.md         # sonnet — atanmış path'lerde implementasyon
│       ├── reviewer.md      # opus — bağımsız hata bulma
│       └── tester.md        # haiku — build/lint/test çalıştırma
├── AGENTS.md               # operatör spesifikasyonu (proje-bazı, kök dosyası)
├── AGENT_POLICY.md         # ayrıntılı kalite/doğrulama/metrik politikası (referans)
├── DELEGATION_EXAMPLES.md  # explorer/coder/reviewer task şablonları
├── schemas/                # ortak sözleşmeler
│   ├── task.schema.json
│   └── result.schema.json
└── install.ps1             # ~/.claude/ içine kuran script
```

Orchestrator ayrı bir dosya değildir: ana oturumun kendisidir. En güçlü modelde (opus) çalıştır.

## Kurulum

Repo'nun `.claude/` klasörü global `~/.claude/` ile birebir eşlenir. Kurulum, onu kopyalamaktan ibaret.

**Script ile (Windows):**

```powershell
pwsh ./install.ps1
```

**Elle (her platform):**

1. `.claude/CLAUDE.md` → `~/.claude/CLAUDE.md` (varsa önce yedekle)
2. `.claude/agents/*.md` → `~/.claude/agents/`

**Claude'a kurdurmak için:** Repo dizinini Claude'a verip "bu dizini kendine kur" de — yukarıdaki eşlemeyi uygular.

Kurulumdan sonra her projede `explorer`/`coder`/`reviewer`/`tester` subagent'ları Agent tool'dan görünür.

## Operatör spesifikasyonu (AGENTS.md)

`AGENTS.md` global değildir; her projede geçerli olmasını istediğinde o projenin köküne `AGENTS.md` olarak kopyala. Claude Code onu o proje için otomatik okur.

## Güncelleme

Bu repo tek doğruluk kaynağıdır. Bir rolü değiştirince repoda düzenle, commit/push et, sonra `install.ps1`'i tekrar çalıştır — `~/.claude/` yeniden senkronlanır.
