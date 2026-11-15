# Web3 / smart-contract review checklist

Work top to bottom. For every item, ask "what if the caller is malicious?".

## Access control
- Missing or mis-set `onlyOwner` / role checks; roles grantable by anyone.
- Signature-based auth: replay across chains, missing deadline, EIP-712 domain, malleable `s`/`v`.
- `delegatecall` / proxy: storage collisions, uninitialized implementation, admin bypass.

## State and accounting
- Checks-effects-interactions order; reentrancy (single-function, cross-function, read-only).
- Integer rounding against the user; division before multiplication.
- Counters that advance before value moves (recorded > transferred desync).
- First-depositor / share-inflation; donation attacks.

## External calls and oracles
- Spot price or manipulable TWAP; missing staleness check; wrong decimals.
- Unchecked low-level calls; silent failure; token return values ignored.
- Oracle single-source dependency; no circuit breaker.

## Tokens
- Fee-on-transfer, rebasing, reflection, and fee-in-ETH tokens breaking accounting.
- Weird decimals, missing return values, ERC-777 / ERC-1155 hooks re-entering.
- Approve race, permit front-running, unlimited approvals.

## Upgradeability and initialization
- Re-initializable initializer; proxy admin in a multisig; unprotected `upgradeTo`.
- Storage gaps / layout drift across versions.

## Cross-chain
- Message replay and missing finality; validator-set takeover; burned-vs-minted conservation.
- Peer allowlists, endpoint checks, inbound rate limits.

## Governance
- Flash-loan voting; quorum and timelock bypass; delegate power snapshots.

## Impact discipline
- A finding without a proven money or state path is an opinion. Prove the movement, then rate it.
