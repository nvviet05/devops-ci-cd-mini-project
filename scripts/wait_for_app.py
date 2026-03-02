import sys
import time
from urllib.request import urlopen
from urllib.error import URLError, HTTPError

url = sys.argv[1] if len(sys.argv) > 1 else "http://localhost:3000/health"
timeout_seconds = int(sys.argv[2]) if len(sys.argv) > 2 else 60
interval = 2

print(f"[INFO] Waiting for app: {url} (timeout={timeout_seconds}s)")
start = time.time()

while True:
    try:
        with urlopen(url, timeout=5) as resp:
            if resp.status == 200:
                print("[INFO] App is healthy.")
                sys.exit(0)
    except (URLError, HTTPError, TimeoutError) as exc:
        print(f"[INFO] Not ready yet: {exc}")

    if time.time() - start > timeout_seconds:
        print("[ERROR] Timeout waiting for app.")
        sys.exit(1)

    time.sleep(interval)
