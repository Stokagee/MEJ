#!/usr/bin/env python3
"""
Fix Robot Framework output.xml by removing NULL bytes padding.

Problem: output.xml sometimes has NULL bytes (0x00) after the </robot> tag,
causing "not well-formed (invalid token)" errors when parsing.

Usage:
    python fix_output_xml.py results/output.xml
"""

import sys
import os


def fix_output_xml(filepath: str) -> bool:
    """
    Remove NULL bytes padding from output.xml file.

    Args:
        filepath: Path to the output.xml file

    Returns:
        True if file was fixed, False if no fix was needed
    """
    if not os.path.exists(filepath):
        print(f"Error: File not found: {filepath}")
        return False

    with open(filepath, 'rb') as f:
        content = f.read()

    # Find the </robot> end tag
    end_tag = b'</robot>'
    pos = content.find(end_tag)

    if pos == -1:
        print(f"Warning: No </robot> tag found in {filepath}")
        return False

    # Calculate expected end position
    expected_end = pos + len(end_tag)

    # Check if there's extra content after the tag
    actual_content = content[:expected_end]
    extra_bytes = content[expected_end:]

    # Check if extra bytes are NULL bytes or whitespace
    if not extra_bytes:
        print(f"OK: {filepath} is clean (no extra bytes)")
        return False

    # Check if extra bytes are only NULL bytes or whitespace
    non_null_extra = [b for b in extra_bytes if b != 0 and b not in (ord('\n'), ord('\r'), ord(' '))]

    if not non_null_extra:
        # Only NULL bytes and/or whitespace - truncate
        with open(filepath, 'wb') as f:
            f.write(actual_content)

        removed_kb = len(extra_bytes) / 1024
        print(f"Fixed: {filepath} - removed {removed_kb:.1f} KB of padding")
        return True
    else:
        print(f"Warning: {filepath} has non-NULL content after </robot>")
        return False


def main():
    if len(sys.argv) < 2:
        print("Usage: python fix_output_xml.py <output.xml>")
        print("       python fix_output_xml.py results/output.xml")
        sys.exit(1)

    filepath = sys.argv[1]
    fixed = fix_output_xml(filepath)
    sys.exit(0 if fixed or not os.path.exists(filepath) else 0)


if __name__ == "__main__":
    main()
