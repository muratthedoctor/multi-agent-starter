# Multi-agent Starter

## Tasarım

- Orchestrator: planlar, görevleri böler, sonuçları birleştirir.
- Explorer: salt okunur kod tabanı analizi.
- Coder: kod dosyalarını değiştirir.
- Reviewer: diff ve test kanıtlarını inceler; kodu değiştirmez.
- Tester: test yazar, kodu test eder.
- Her agent rol talimatlarını bu paketteki `prompts/` klasöründen alır.

## Dosyalar

- `prompts/ORCHESTRATOR.md`: ana agentın planlama ve delegasyon politikası.
- `prompts/EXPLORER.md`: salt okunur araştırmacı.
- `prompts/CODER.md`: kod değişikliği worker'ı.
- `prompts/REVIEWER.md`: bağımsız reviewer.
- `prompts/TESTER.md`: test worker'ı.
- `AGENT_POLICY.md`: harness-genel kalite, güvenlik ve ölçüm politikası.
- `schemas/task.schema.json`: ortak görev sözleşmesi.
- `schemas/result.schema.json`: ortak sonuç sözleşmesi.

## Çalışan kurulum (`.claude/agents/`)

`agents/*.md` dosyaları tasarım referansıdır; gerçek Claude Code subagent'ları `.claude/agents/` altında, her biri görev yüküne göre model atanmış şekilde duruyor:

| Subagent | Model | Neden |
|---|---|---|
| `explorer` | haiku | Salt okunur kod tarama/arama — mekanik, karar içermez. |
| `coder` | sonnet | Atanmış dosyalarda implementasyon — orta şiddette mühendislik kararı gerekir. |
| `reviewer` | opus | Bağımsız hata bulma — karar-kritik, derin düşünme gerektirir. |
| `tester` | haiku | Build/lint/test çalıştırma ve log sınıflandırma — mekanik. |

Orchestrator ayrı bir subagent değildir: ana oturumun kendisidir (planlar, delege eder, doğrular, birleştirir), bu yüzden en güçlü modelde (opus) çalıştırılması önerilir. Çağırmak için Agent tool'u subagent_type olarak `explorer`/`coder`/`reviewer`/`tester` ile kullan; `AGENT_POLICY.md`'deki delegasyon kuralları (açık deliverable/acceptance criteria, salt-okunur roller kendi sınırında, aynı dosyaya iki worker aynı anda yazamaz, kuplajlı işi paralel değil seri yap) geçerlidir. Eşzamanlı worker sayısı sınırı ve "trivial işi delege etme" kısıtı kaldırıldı; dosya çakışması koruması ise geri eklendi.

Bu `.claude/agents/` klasörü şu an sadece bu proje için geçerli. Aynı subagent setini başka projelerde de token tasarrufuyla kullanmak istersen, bu 4 dosyayı `~/.claude/agents/` altına kopyalaman yeterli (global subagent'lar tüm projelerde görünür).

## Global AGENTS.md (manuel adım)

`AGENTS.md`'deki operatör spesifikasyonunu tüm sohbetlerde (her proje, her dizin) geçerli kılmak için içeriğini `C:\Users\PC\.claude\CLAUDE.md` dosyasına kopyalaman gerekiyor — bu dosya Claude Code tarafından her oturumda, çalışma dizininden bağımsız okunur. Bu yazma işlemini oturum içinden kendim yapamadım (auto-mode, çalışma dizini dışına yazmayı engelliyor); dosya yoksa oluşturup bu projedeki `AGENTS.md` içeriğini içine yapıştırman yeterli.