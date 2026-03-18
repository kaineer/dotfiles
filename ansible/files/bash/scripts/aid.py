#!/usr/bin/env python3

import os
import re
import shutil
import sys
from pathlib import Path

# Supported file extensions
MEDIA_EXTENSIONS = {".png", ".jpg", ".jpeg", ".mp4"}
MARKDOWN_EXTENSIONS = {".md"}
SUPPORTED_EXTENSIONS = MEDIA_EXTENSIONS | MARKDOWN_EXTENSIONS


def get_username():
    """Get current username"""
    return os.environ.get("USER") or os.environ.get("USERNAME") or os.getlogin()


def is_dry_run():
    """Check if DRY mode is enabled"""
    return os.environ.get("DRY", "").lower() in ("yes", "true", "1", "y")


def get_relative_nomad_path(full_path):
    """Return path relative to /home/$USER/nomad or the path itself if it doesn't contain nomad"""
    username = get_username()
    nomad_base = f"/home/{username}/nomad"

    path_str = str(full_path)
    if path_str.startswith(nomad_base):
        return path_str[len(nomad_base) :]  # Remove base path
    return path_str


def format_file_list(files, dest_path):
    """Format file list for a specific destination directory"""
    if not files:
        return ""

    # Get the relative path for display
    rel_path = get_relative_nomad_path(dest_path)

    # Build the output
    output = [f"### Move to directory {rel_path}:"]

    # Add numbered files
    for i, filename in enumerate(sorted(files), 1):
        output.append(f"  {i:03d}. {filename}")

    # Add files count
    output.append(f"(Files per directory: {len(files)})")

    return "\n".join(output)


def cmd_nomad():
    """nomad command - check if /media/$USER/nomad directory exists"""
    username = get_username()
    nomad_path = Path(f"/media/{username}/nomad")

    if nomad_path.exists() and nomad_path.is_dir():
        return 0
    else:
        return 1


def cmd_move(args):
    """move command - transfer files from source to destination"""
    if len(args) < 2:
        print(
            "Error: move command requires two parameters: source directory and destination directory",
            file=sys.stderr,
        )
        return 1

    src_dir = Path(args[0])
    dest_dir_arg = args[1]

    # Check source directory
    if not src_dir.exists() or not src_dir.is_dir():
        print(
            f"Error: source directory {src_dir} does not exist or is not a directory",
            file=sys.stderr,
        )
        return 1

    # Process destination directory
    if not dest_dir_arg.startswith("/"):
        # Relative path - add /media/$USER/nomad/
        username = get_username()
        dest_dir = Path(f"/media/{username}/nomad") / dest_dir_arg
    else:
        dest_dir = Path(dest_dir_arg)

    # Create destination directory if it doesn't exist (only if not in DRY mode)
    if not is_dry_run():
        try:
            dest_dir.mkdir(parents=True, exist_ok=True)
        except Exception as e:
            print(
                f"Error creating destination directory {dest_dir}: {e}", file=sys.stderr
            )
            return 1

    # Pattern for date format: yyyymmdd
    date_pattern = re.compile(r"^\d{8}$")

    # Valid extensions
    valid_extensions = SUPPORTED_EXTENSIONS

    # Statistics
    total_image_files = 0
    total_md_files = 0

    # Dictionary to group files by destination subdirectory
    files_by_dest = {}

    # First pass: collect all files to be moved
    for item in src_dir.iterdir():
        if not item.is_dir():
            continue

        # Check if subdirectory name matches yyyymmdd format
        if not date_pattern.match(item.name):
            continue

        # Destination subdirectory with the same name (date)
        dest_subdir = dest_dir / item.name

        # Collect files with valid extensions
        for file_path in item.iterdir():
            if not file_path.is_file():
                continue

            # Check file extension
            if file_path.suffix.lower() not in valid_extensions:
                continue

            # Group by destination subdirectory
            if dest_subdir not in files_by_dest:
                files_by_dest[dest_subdir] = []

            files_by_dest[dest_subdir].append(file_path)

            # Count statistics
            if file_path.suffix.lower() in MEDIA_EXTENSIONS:
                total_image_files += 1
            elif file_path.suffix.lower() in MARKDOWN_EXTENSIONS:
                total_md_files += 1

    # Process each destination directory
    for dest_subdir, files in files_by_dest.items():
        # Get list of filenames for display
        filenames = [f.name for f in files]

        # Display the files for this directory
        print(format_file_list(filenames, dest_subdir))
        print()  # Empty line after each directory

        # Create destination subdirectory (if not in DRY mode)
        if not is_dry_run():
            try:
                dest_subdir.mkdir(exist_ok=True)
            except Exception as e:
                print(
                    f"Error creating subdirectory {dest_subdir}: {e}", file=sys.stderr
                )
                continue

        # Move files (only if not in DRY mode)
        if not is_dry_run():
            for file_path in files:
                dest_file = dest_subdir / file_path.name
                try:
                    shutil.move(str(file_path), str(dest_file))
                except Exception as e:
                    print(f"Error moving {file_path}: {e}", file=sys.stderr)

    # Display totals
    if total_image_files + total_md_files > 0:
        print("### Totals:")
        print(f"  Image files: {total_image_files}")
        print(f"  Markdown files: {total_md_files}")
        if not is_dry_run():
            print(f"  Total files: {total_image_files + total_md_files}")

        if is_dry_run():
            print(
                f"\nDRY RUN: {total_image_files + total_md_files} files would be moved"
            )
    else:
        print("No files found")

    return 0


def main():
    """Main command processing function"""
    if len(sys.argv) < 2:
        print("Usage: script.py <command> [arguments...]", file=sys.stderr)
        print("Commands:", file=sys.stderr)
        print("  nomad - check if /media/$USER/nomad directory exists", file=sys.stderr)
        print(
            "  move <source_directory> <destination_directory> - move files from date-named directories",
            file=sys.stderr,
        )
        print("\nEnvironment variables:", file=sys.stderr)
        print(
            "  DRY=yes - enable dry run mode (show what would be done without actually moving)",
            file=sys.stderr,
        )
        return 1

    command = sys.argv[1]

    if command == "nomad":
        return cmd_nomad()
    elif command == "move":
        return cmd_move(sys.argv[2:])
    else:
        print(f"Unknown command: {command}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
