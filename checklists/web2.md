# Web2 / application review checklist

## Authentication and session
- Login flows: OAuth redirect handling, state parameter, PKCE, account enumeration.
- Session: fixation, predictable tokens, missing invalidation on logout or password change.
- Password reset and invite: token entropy, expiry, reuse, host header injection in links.

## Authorization
- IDOR / BOLA: object IDs in the path or body that the server does not re-check.
- BOLA on nested or bulk endpoints (`?ids=`), mass assignment of privileged fields.
- Privilege escalation within a tenant; cross-tenant access by design or by bug.

## Injection
- SQL / NoSQL / ORM injection; command injection; SSRF (metadata endpoints, webhooks, PDF renderers).
- SSTI in templates; XXE in XML parsers; LDAP injection.

## Client side
- Stored and reflected XSS, DOM XSS, CSP bypass that actually executes script.
- CSRF on state-changing actions; missing `SameSite`; origin checks bypassable.
- Open redirect that reaches an OAuth flow or a trusted-domain page.

## Files and uploads
- Content-type and extension handling; path traversal in download and upload; zip slip.
- SSRF through image or document import.

## Configuration and cloud
- Exposed `.git`, `.env`, source maps, debug endpoints, swagger, GraphQL introspection.
- Object storage open to public listing; IAM over-permissive; metadata service reachable.
- CORS wildcard with credentials; missing `security.txt` is not a finding.

## Evidence discipline
- A finding needs an HTTP status, a response body, or a capture. No impact, no bounty.
- Rate limiting and "best practice" gaps are usually ineligible — read the program's out-of-scope list.
