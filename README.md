Fairly straightforward here; I'd done a more complex setup with SideTable, so I
adapted that solution and fixed the differing assumptions. Pagination in Rails
is trivial (courtesy [api-pagination](https://github.com/davidcelis/api-pagination))
, so it is included.

Accepts any combination of min/max for price, bedrooms, and bathrooms, including
none. Does not currently accept queries for specific values; this would be a
possible simple extension. 

Right now it stores everything in a Postgres database, with the given CSV
converted to a seeds file (accidentally wiped out that snippet when switching
from a SQLite project to a Postgres one). Accepting CSV files as new data, or
some other endpoint for new entries, might be another extension.
