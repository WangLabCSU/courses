#!/usr/bin/env python3
"""
Convert Reveal.js HTML slides to PDF using Playwright.
"""

import os
import sys
import argparse
from pathlib import Path
from playwright.sync_api import sync_playwright, TimeoutError as PlaywrightTimeoutError


def convert_html_to_pdf(input_path: str, output_path: str, timeout: int = 30000) -> bool:
    """
    Convert a Reveal.js HTML presentation to PDF.
    
    Args:
        input_path: Path to the HTML file
        output_path: Path for the output PDF file
        timeout: Page load timeout in milliseconds
    
    Returns:
        True if successful, False otherwise
    """
    input_file = Path(input_path).resolve()
    output_file = Path(output_path).resolve()
    
    if not input_file.exists():
        print(f"Error: Input file not found: {input_file}")
        return False
    
    if not input_file.suffix.lower() == '.html':
        print(f"Warning: Input file does not have .html extension: {input_file}")
    
    output_file.parent.mkdir(parents=True, exist_ok=True)
    
    print(f"Converting: {input_file}")
    print(f"Output: {output_file}")
    
    try:
        with sync_playwright() as p:
            browser = p.chromium.launch()
            page = browser.new_page()
            
            url = f"file://{input_file}"
            print(f"Loading: {url}?print-pdf")
            
            page.goto(f"{url}?print-pdf", wait_until="networkidle", timeout=timeout)
            
            page.locator(".reveal.ready").wait_for(timeout=timeout)
            
            print("Generating PDF...")
            page.pdf(
                path=str(output_file),
                prefer_css_page_size=True,
                print_background=True
            )
            
            browser.close()
            
        print(f"Successfully created: {output_file}")
        return True
        
    except PlaywrightTimeoutError as e:
        print(f"Error: Timeout while loading page: {e}")
        return False
    except Exception as e:
        print(f"Error: {type(e).__name__}: {e}")
        return False


def main():
    parser = argparse.ArgumentParser(
        description="Generate PDF slides from Reveal.js HTML presentations",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  %(prog)s slides.html slides.pdf
  %(prog)s -i slides.html -o slides.pdf
  %(prog)s /path/to/presentation.html /path/to/output.pdf
        """
    )
    
    parser.add_argument(
        "input", 
        nargs="?",
        help="HTML filename (or use -i/--input)"
    )
    parser.add_argument(
        "output", 
        nargs="?",
        help="PDF filename (or use -o/--output)"
    )
    parser.add_argument(
        "-i", "--input",
        dest="input_file",
        help="HTML filename"
    )
    parser.add_argument(
        "-o", "--output",
        dest="output_file", 
        help="PDF filename"
    )
    parser.add_argument(
        "-t", "--timeout",
        type=int,
        default=30000,
        help="Page load timeout in milliseconds (default: 30000)"
    )
    
    args = parser.parse_args()
    
    input_path = args.input or args.input_file
    output_path = args.output or args.output_file
    
    if not input_path:
        parser.error("Input file is required")
    if not output_path:
        parser.error("Output file is required")
    
    input_path = os.path.abspath(input_path)
    output_path = os.path.abspath(output_path)
    
    success = convert_html_to_pdf(input_path, output_path, args.timeout)
    sys.exit(0 if success else 1)


if __name__ == "__main__":
    main()
