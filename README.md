#!/usr/bin/env python3

import os
import subprocess
from datetime import datetime

# CHANGE THIS TO YOUR REPOSITORY PATH
REPO_PATH = "/path/to/your/repository"

os.chdir(REPO_PATH)

timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

with open("activity.log", "a", encoding="utf-8") as f:
    f.write(f"{timestamp}\n")

commands = [
    ["git", "add", "activity.log"],
    ["git", "commit", "-m", f"Daily update {timestamp}"],
    ["git", "push", "origin", "main"]
]

for cmd in commands:
    result = subprocess.run(cmd, capture_output=True, text=True)

    if result.returncode != 0:
        print(f"Error running: {' '.join(cmd)}")
        print(result.stderr)
        exit(1)

print("Commit and push completed.")
