# bugbounty-toolkit

Recon scripts, report templates and checklists for bug-bounty and audit work. Built for responsible disclosure: everything here runs against systems you are authorised to test.

## Layout

```
recon/        host and endpoint discovery
templates/    report and proof-of-concept templates
checklists/   web3 and web2 review checklists
```

## recon/

- `subdomain-enum.sh` — certificate-transparency + DNS enumeration, deduped and sorted.
- `endpoint-probe.sh` — probe a host list for HTTP status, server header and title.

Both take a target list and write to a file so the run is reproducible. Passive only; no exploitation.

## templates/

- `report-template.md` — the 8-section structure used for every submission: title, affected component, severity, summary, root cause, reproduction, impact, fix.

## checklists/

- `web3.md` — reentrancy, access control, input validation, rounding, oracle, token behaviour, initialization, upgrade safety, flash-loan surface, signature and replay.
- `web2.md` — authentication, session, IDOR/BOLA, injection, file handling, CORS/CSRF, mass assignment, dependency and cloud misconfiguration.

## Rules of use

- Test only systems you are authorised to test (an active bug-bounty scope or your own infrastructure).
- Use test accounts. Do not touch another user's data.
- Build a local proof of concept before you report. A finding without a reproduction is an opinion.
- Disclose privately through the program's channel and respect the embargoes.

## License

MIT. Scripts and templates are provided as-is.
