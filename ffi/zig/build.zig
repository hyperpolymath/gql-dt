// SPDX-License-Identifier: PMPL-1.0-or-later
// SPDX-FileCopyrightText: 2025 Jonathan D.A. Jewell (@hyperpolymath)
//
// build.zig - FBQLdt FFI Build Configuration

const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Build shared library for FFI
    const lib = b.addStaticLibrary(.{
        .name = "fbqldt",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .version = .{ .major = 0, .minor = 7, .patch = 5 },
    });

    // Export C symbols for FFI
    lib.linkLibC();

    b.installArtifact(lib);

    // Also create a shared library version
    const lib_shared = b.addSharedLibrary(.{
        .name = "fbqldt",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .version = .{ .major = 0, .minor = 7, .patch = 5 },
    });

    lib_shared.linkLibC();
    b.installArtifact(lib_shared);
}
