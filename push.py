import os

# Simple helper so you can copy/paste commands from terminal history
COMMANDS = [
    'git status',
    'git add .',
    'git commit -m "Update LavoraHub"',
    'git push -u origin main',
]

def show():
    print("Git commands for LavoraHub:\n")
    for cmd in COMMANDS:
        print(cmd)

if __name__ == "__main__":
    show()
