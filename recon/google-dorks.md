# Google dorks for target discovery and recon

Start from a clear scope, then widen. Do not spray queries at a target you have not read the program scope for.

## Find the programs

```
site:*.com "bug bounty" "reward"
site:*.com "responsible disclosure" "security"
site:*.com "security@*" "vulnerability"
site:*.com "bug bounty" inurl:security
site:*.com "bug bounty program" -hackerone -immunefi
site:*.com "coordinated vulnerability disclosure"
intitle:"bug bounty" "program"
site:docs.*.com "bug bounty"
```

The `-hackerone -immunefi` filter is the useful part: it surfaces the self-managed and email-only programs that do not need a platform account.

## Surface a target

Replace `target.com` with the domain in scope.

```
site:*.target.com -www
site:target.com ext:php inurl:?
site:target.com inurl:api | inurl:v1 | inurl:graphql
site:target.com "index of /"
site:target.com ext:env | ext:log | ext:bak
site:target.com ext:js | ext:json
site:target.com inurl:admin | inurl:login | inurl:token
site:target.com "swagger" | "openapi"
site:target.com "graphql" "introspection"
```

## Leaks and exposed material

```
site:pastebin.com "target.com"
site:github.com "target.com" password
site:github.com "target.com" "api_key"
site:github.com "target.com" "secret"
site:gist.github.com "target.com"
site:gitlab.com "target.com"
site:target.com "password"
site:target.com intext:"BEGIN PRIVATE KEY"
site:target.com intext:"BEGIN RSA PRIVATE KEY"
site:target.com "token=" | "secret=" | "key="
```

## Notes and cross-checks

- `site:*.target.com -www` on a wildcard cert is the fastest way to enumerate hosts before you touch a single one.
- Corroborate with certificate transparency (`crt.sh`) and DNS, not with a single search engine result.
- A dork that returns a hit is not a finding. It is a place to look. Read the program scope before you test anything.
- Keep queries read-only. No injection, no auth bypass, no scraping at a rate the target would notice.
