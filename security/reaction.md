# Reaction

Reaction est un service qui scan les sorties des fichiers et effectue des actions quand un certain usage est détecté.


```shell
apt install ./reaction_2.2.1-1_amd64.deb
systemctl enable --now reaction@reaction.jsonnet
```

```shell
reaction show
```

```
nft list set inet reaction banned_ips
```

```
local bots = [
  "ChatGPT-User",
  "DuckAssistBot",
  "Meta-ExternalFetcher",
  "AI2Bot",
  "Applebot-Extended",
  "Bytespider",
  "CCBot",
  "ClaudeBot",
  "Diffbot",
  "FacebookBot",
  "Google-Extended",
  "GPTBot",
  "Kangaroo Bot",
  "Meta-ExternalAgent",
  "omgili",
  "Timpibot",
  "Webzio-Extended",
  "Amazonbot",
  "Applebot",
  "OAI-SearchBot",
  "PerplexityBot",
  "YouBot",
  "Yandexbot",
  "Baiduspider"
];

local banFor(time) = {
  ban: {
    cmd: ['nft', 'add element inet reaction banned_ips { <ip> }'],
  },
  unban: {
    cmd: ['nft', 'delete element inet reaction banned_ips { <ip> }'],
    after: time,
  },
};

{
  patterns: {
    ip: {
      type: 'ipv4',
    },
  },

  start: [
    ['nft', |||
    table inet reaction {
      set whitelist_ips {
        type ipv4_addr
        flags interval
        elements = { 192.168.137.0/24 }
      }

      set banned_ips {
        type ipv4_addr
        flags interval
        auto-merge
      }

      chain input {
        type filter hook input priority 0
        ip saddr @whitelist_ips accept
        ip saddr @banned_ips drop
      }
    }
||| ],
  ],

  stop: [
    ['nft', 'delete table inet reaction'],
  ],

  streams: {
    ssh: {
      cmd: ['journalctl', '-fu', 'ssh.service'],
      filters: {
        failedlogin: {
          regex: [
            @'authentication failure;.*rhost=<ip>',
            @'Failed password for .* from <ip>',
            @'Connection from <ip> port [0-9]*: invalid format',
            @'Invalid user .* from <ip>',
            @'Timeout before authentication for <ip>',
          ],
          retry: 3,
          retryperiod: '6h',
          actions: banFor('96h'),
        },
      },
    },

    apache: {
      cmd: ['tail', '-n0', '-f', '/var/log/nginx/access.log'],
      filters: {
        aiBots: {
          regex: [
            // User-Agent is the last field
            // Bot's name can be anywhere in the User-Agent
            // (hence the leading and trailing [^"]*
            @'^<ip> .* "[^"]*(%s)[^"]*"$' % std.join('|', bots)
          ],
          actions: banFor('30d'),
        },
      },
    }
  },
}
```

```shell
nft list ruleset inet
```
