# TLB Entry Contents

| field | purpose |
|-------|---------|
| VPN | virtual page number being translated |
| PFN | physical frame number — actual location in RAM |
| valid bit | whether this entry holds a valid translation |
| protection bits | read / write / execute permissions |
| dirty bit | whether the page has been written to |
| ASID | address space identifier — which process owns this entry |
