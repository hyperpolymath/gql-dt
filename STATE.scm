;; SPDX-License-Identifier: PMPL-1.0-or-later
;; SPDX-FileCopyrightText: 2025 hyperpolymath
;;
;; STATE.scm - Project state tracking for fdql-dt
;; Media-Type: application/vnd.state+scm

(state
  (metadata
    (version "0.2.0")
    (schema-version "1.0.0")
    (created "2025-01-12")
    (updated "2026-01-12")
    (project "fdql-dt")
    (repo "https://github.com/hyperpolymath/fdql-dt"))

  (project-context
    (name "FQLdt: Dependently-Typed FormDB Query Language")
    (tagline "Compile-time verification of database constraints via dependent types")
    (tech-stack
      (primary "Lean 4")
      (lean-version "v4.15.0")
      (mathlib-version "v4.15.0")
      (ffi "Zig")
      (config "Nickel")
      (containers "Podman/Nerdctl")))

  (current-position
    (phase "implementation")
    (overall-completion 65)  ; Milestones 1-4 complete
    (components
      (specifications
        (status complete)
        (completion 100)
        (files
          "spec/FQL_Dependent_Types_Complete_Specification.md"
          "spec/normalization-types.md"
          "docs/WP06_Dependently_Typed_FormDB.md"))
      (lean4-project-setup
        (status complete)
        (completion 100)
        (files
          "lakefile.lean"
          "lean-toolchain"
          "lake-manifest.json"
          "src/FqlDt.lean"))
      (refinement-types
        (status complete)
        (completion 100)
        (files
          "src/FqlDt/Types.lean"
          "src/FqlDt/Types/BoundedNat.lean"
          "src/FqlDt/Types/BoundedInt.lean"
          "src/FqlDt/Types/NonEmptyString.lean"
          "src/FqlDt/Types/Confidence.lean"))
      (prompt-scores
        (status complete)
        (completion 100)
        (files
          "src/FqlDt/Prompt.lean"
          "src/FqlDt/Prompt/PromptDimension.lean"
          "src/FqlDt/Prompt/PromptScores.lean"))
      (provenance-tracking
        (status complete)
        (completion 100)
        (files
          "src/FqlDt/Provenance.lean"
          "src/FqlDt/Provenance/ActorId.lean"
          "src/FqlDt/Provenance/Rationale.lean"
          "src/FqlDt/Provenance/Tracked.lean"))
      (zig-ffi-bridge
        (status not-started)
        (completion 0))
      (fql-parser
        (status not-started)
        (completion 0)))
    (working-features
      (container-build "justfile with nerdctl/podman/docker fallback")
      (lake-build "lake build succeeds with all Lean 4 modules")))

  (route-to-mvp
    (target-version "1.0.0")
    (definition "Phase 1: Refinement types working in Lean 4")

    (milestones
      (milestone-1
        (name "Lean 4 Project Setup")
        (status complete)
        (completed-date "2026-01-12")
        (items
          (item "Create lakefile.lean with Mathlib4 dependency" status: complete)
          (item "Add lean-toolchain file (leanprover/lean4:v4.15.0)" status: complete)
          (item "Create FqlDt/ source directory structure" status: complete)
          (item "Update Dockerfile for Lean 4 + elan" status: pending)
          (item "Verify lake build succeeds" status: complete)))

      (milestone-2
        (name "Core Refinement Types")
        (status complete)
        (completed-date "2026-01-12")
        (depends-on milestone-1)
        (items
          (item "FqlDt/Types/BoundedNat.lean - BoundedNat min max structure" status: complete)
          (item "FqlDt/Types/BoundedInt.lean - BoundedInt min max structure" status: complete)
          (item "FqlDt/Types/NonEmptyString.lean - String with length > 0 proof" status: complete)
          (item "FqlDt/Types/Confidence.lean - Float 0.0 1.0 with runtime validation" status: complete)
          (item "Prove basic theorems (bounds preserved under arithmetic)" status: complete)))

      (milestone-3
        (name "PROMPT Score Types")
        (status complete)
        (completed-date "2026-01-12")
        (depends-on milestone-2)
        (items
          (item "FqlDt/Prompt/PromptDimension.lean - BoundedNat 0 100 alias" status: complete)
          (item "FqlDt/Prompt/PromptScores.lean - 6 dimensions struct" status: complete)
          (item "Auto-computed overall field with correctness proof" status: complete)
          (item "Smart constructor PromptScores.create" status: complete)
          (item "Theorem: overall_in_bounds" status: complete)))

      (milestone-4
        (name "Provenance Tracking")
        (status complete)
        (completed-date "2026-01-12")
        (depends-on milestone-2)
        (items
          (item "FqlDt/Provenance/ActorId.lean - NonEmptyString wrapper" status: complete)
          (item "FqlDt/Provenance/Rationale.lean - NonEmptyString wrapper" status: complete)
          (item "FqlDt/Provenance/Tracked.lean - Timestamp + Tracked alpha structure" status: complete)
          (item "Theorem: tracked_has_provenance" status: complete)
          (item "TrackedList with all_have_provenance theorem" status: complete)))

      (milestone-5
        (name "Zig FFI Bridge")
        (status not-started)
        (depends-on milestone-3 milestone-4)
        (items
          (item "bridge/fdb_types.zig - FdbStatus, proof blob structs")
          (item "bridge/fdb_insert.zig - fdb_insert with proof_blob param")
          (item "Lean 4 @[extern] declarations")
          (item "Integration test: Lean calls Zig")))

      (milestone-6
        (name "Basic FQL Parser")
        (status not-started)
        (depends-on milestone-5)
        (items
          (item "Parse INSERT INTO ... VALUES ... WITH_PROOF {...}")
          (item "Type-check values against Lean 4 definitions")
          (item "Generate proof obligations")
          (item "Error messages with suggestions")
          (item "End-to-end test: FQL string -> type-checked insert")))))

  (blockers-and-issues
    (critical ())
    (high ())  ; DECISION-001 resolved: Lean 4 v4.15.0 chosen
    (medium
      (issue
        (id "DECISION-002")
        (title "Parser approach")
        (description "Hand-rolled vs parsec-style vs integrate with existing FQL parser")
        (options
          "Hand-rolled (simple, no deps)"
          "Lean 4 Parsec (built-in)"
          "Integrate with FormDB's Factor-based FQL parser")))
    (low
      (issue
        (id "DECISION-003")
        (title "FormDB integration strategy")
        (description "Mock Forth core for MVP, or wire to real Form.Bridge?")
        (recommendation "Mock for MVP, real integration in 1.1"))))

  (formdb-alignment
    (formdb-version "0.0.4")
    (alignment-date "2026-01-12")
    (status "spec-aligned")
    (compatible-features
      "FFI via CBOR-encoded proof blobs (Form.Bridge)"
      "NormalizationStep type (FunDep.lean)"
      "Three-phase migration (Announce/Shadow/Commit)"
      "Proof verification API")
    (integration-points
      (formdb-fundep "FormDB's FunDep.lean uses String-based attrs - upgrade to schema-bound")
      (formdb-normalizer "FormDB's fd-discovery.factor aligns with DFD algorithm spec")
      (formdb-bridge "bridge.zig exports fdb_verify_proof compatible with spec"))
    (when-fdql-dt-implements
      "FormDB should import fdql-dt types for FunDep, NormalForm predicates"
      "Proofs.lean should use fdql-dt's LosslessTransform theorem"))

  (critical-next-actions
    (immediate
      (action "Update Dockerfile for Lean 4 + elan")
      (action "Add CI workflow for lake build"))
    (this-week
      (action "Start Milestone 5: Zig FFI Bridge")
      (action "Create bridge/fdb_types.zig"))
    (this-month
      (action "Complete Milestone 5 (Zig FFI)")
      (action "Begin Milestone 6 (FQL Parser)")))

  (unified-roadmap
    (reference "UNIFIED-ROADMAP.scm")
    (role "Dependently-typed query language - critical path item")
    (mvp-blockers
      "M5: Zig FFI Bridge (blocks Studio M3, real type checking)"
      "M6: FQL Parser (blocks full FQLdt compilation)")
    (this-repo-priority
      "Complete M5 Zig FFI - highest priority"
      "Integrate with FormDB's EBNF grammar"
      "Proof blob serialization (CBOR RFC 8949)"))

  (session-history
    (snapshot
      (date "2025-01-12")
      (session-id "initial-analysis")
      (accomplishments
        "Analyzed repo structure and specifications"
        "Identified MVP 1.0 scope as Phase 1 (refinement types)"
        "Created STATE.scm with 6-milestone roadmap"
        "Documented decision points and blockers")
      (next-steps
        "Create Lean 4 project structure"
        "Implement first refinement type (BoundedNat)"))
    (snapshot
      (date "2026-01-12")
      (session-id "core-implementation")
      (accomplishments
        "Set up Lean 4 project with Mathlib4 v4.15.0"
        "Implemented BoundedNat, BoundedInt with proofs"
        "Implemented NonEmptyString with non-emptiness proof"
        "Implemented Confidence with runtime validation"
        "Implemented PromptDimension and PromptScores"
        "PromptScores.create auto-computes overall with correctness proof"
        "Implemented ActorId, Rationale, Timestamp, Tracked"
        "Tracked.has_provenance theorem ensures all values have provenance"
        "TrackedList.all_have_provenance for collection-level guarantees"
        "Resolved omega import issue (built-in in Lean 4)"
        "Verified lake build succeeds")
      (next-steps
        "Update Dockerfile for Lean 4"
        "Add CI workflow"
        "Start Zig FFI bridge"))))

;; Helper functions for state queries
(define (get-completion-percentage state)
  (state 'current-position 'overall-completion))

(define (get-blockers state priority)
  (state 'blockers-and-issues priority))

(define (get-milestone state n)
  (state 'route-to-mvp 'milestones (string->symbol (format "milestone-~a" n))))
