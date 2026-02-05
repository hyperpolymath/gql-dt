# This Repository Has Moved

**FBQLdt is now part of the [Lithoglyph monorepo](https://github.com/hyperpolymath/formdb).**

## New Location

- **Monorepo:** https://github.com/hyperpolymath/formdb
- **Query Language:** https://github.com/hyperpolymath/formdb/tree/main/query

## Why the Move?

FBQLdt (Lithoglyph Query Language with dependent types) is the query interface for Lithoglyph. To improve discoverability and maintenance, we've consolidated the Lithoglyph ecosystem into a single monorepo:

```
formdb/
├── query/          # FBQLdt (this repo)
├── database/       # Form.Model + Form.Blocks (Forth core)
├── bridge/         # Zig FFI bridge
├── studio/         # Web-based GUI
└── debugger/       # Proof-carrying debugger
```

## Benefits of the Monorepo

- **Single source of truth** for all Lithoglyph components
- **Coordinated versioning** across query language, database, and tools
- **Unified documentation** and examples
- **Shared CI/CD** and dependency management
- **Easier cross-component refactoring**

## Migration Guide

### For Users

Update your imports/dependencies:

**Before:**
```bash
git clone https://github.com/hyperpolymath/gql-dt
```

**After:**
```bash
git clone https://github.com/hyperpolymath/formdb
cd formdb/query
```

### For Contributors

Submit PRs to the [formdb monorepo](https://github.com/hyperpolymath/formdb) instead.

## This Repository's Future

This repository (`gql-dt`) will be archived and remain as a historical reference. All active development happens in the monorepo.

---

**See you at [github.com/hyperpolymath/formdb](https://github.com/hyperpolymath/formdb)!** 🚀
