const std = @import("std");
const Builder = std.build.Builder;
const LibExeObjStep = std.build.LibExeObjStep;
const CrossTarget = @import("std").zig.CrossTarget;
const Mode = std.builtin.Mode;

pub fn build(b: *std.build.Builder) void {

    const mode = b.standardReleaseOptions();

    const lib = b.addStaticLibrary("cimgui", null);
    lib.setBuildMode(mode);
    lib.addCSourceFile("src/cimgui/imgui/imgui.cpp", &[_][]const u8{""});
    lib.addCSourceFile("src/cimgui/imgui/imgui_widgets.cpp", &[_][]const u8{""});
    lib.addCSourceFile("src/cimgui/imgui/imgui_tables.cpp", &[_][]const u8{""});
    lib.addCSourceFile("src/cimgui/imgui/imgui_draw.cpp", &[_][]const u8{""});
    lib.addCSourceFile("src/cimgui/imgui/imgui_demo.cpp", &[_][]const u8{""});
    lib.addCSourceFile("src/cimgui/cimgui.cpp", &[_][]const u8{""});

    // const compile_shader = b.addSystemCommand(&[_][]const u8{
    //     "../sokol-tools-bin/bin/osx/sokol-shdc",
    //     "-i", "shader.glsl", "-o", "shader.glsl.h", "-l", "metal_macos"
    // });

    const exe = b.addExecutable("CRenderer", null);
    const target = b.standardTargetOptions(.{});
    exe.setTarget(target);
    exe.setBuildMode(mode);

    if(exe.target.isWindows()){
        exe.addCSourceFile("src/main.c", &[_][]const u8 {"-DSOKOL_GLCORE33", "-I", "src/sokol"});
        exe.addCSourceFile("src/sokol/sokol.c", &[_][]const u8{});

        exe.linkSystemLibrary("kernel32");
        exe.linkSystemLibrary("user32");
        exe.linkSystemLibrary("gdi32");
        exe.linkSystemLibrary("ole32");
        // exe.linkSystemLibrary("d3d11");
        // exe.linkSystemLibrary("dxgi");

    }else if(exe.target.isDarwin()){
        exe.addCSourceFile("src/main.c", &[_][]const u8 {"-DSOKOL_METAL", "-fobjc-arc", "-I", "src/sokol"});
        exe.addCSourceFile("src/sokol/sokol.m", &[_][]const u8{});
        exe.linkFramework("Foundation");
        exe.linkFramework("MetalKit");
        exe.linkFramework("Metal");
        exe.linkFramework("Cocoa");
        exe.linkFramework("QuartzCore");
        exe.linkFramework("AudioToolbox");
    }

    exe.linkLibC();
    exe.linkLibCpp();
    exe.linkLibrary(lib);

    exe.install();
    b.step("run", "Runs the executable").dependOn(&exe.run().step);
}