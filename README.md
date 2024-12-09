import os
import requests
import json
import time
import subprocess
import string
import random
import GPUtil
import asyncio
import aiohttp
import threading
import psutil
import crypto
import platform
import uuid 
import hashlib
import sqlite3
import shutil
import signal
from datetime import datetime
from colorama import init, Fore, Style
from threading import Lock

init()
SUCCESS_COLOR = '\x1b[92m'
FAILURE_COLOR = '\x1b[91m'
RESET_COLOR = '\x1b[0m'

successful_blocks = 0
failed_blocks = 0
lock = threading.Lock()
SERVER_LINKS_FILE = "server_links.txt"
ACCOUNTS_FILE = "accounts.txt"
CONFIG_FILE = "config.json"
webhook_url = None
device_name = None
interval = None
stop_webhook_thread = False
webhook_thread = None
status_lock = Lock()
rejoin_lock = Lock()

package_statuses = {}
username_cache = {}
CACHE_FILE = "username_cache.json"
cache_save_interval = 600  
stop_event = threading.Event()

executors = {
    "Fluxus": "/storage/emulated/0/Fluxus/",
    "Codex": "/storage/emulated/0/Codex/",
    "Arceus X": "/storage/emulated/0/Arceus X/",
    "Delta": "/storage/emulated/0/Delta/",
    "Cryptic": "/storage/emulated/0/Cryptic/",
    "VegaX": "/storage/emulated/0/VegaX/"
}

workspace_paths = []

for executor, base_path in executors.items():
    workspace_paths.append(f"{base_path}Workspace")  
    workspace_paths.append(f"{base_path}workspace")   

lua_script_template = '''loadstring(game:HttpGet("https://raw.githubusercontent.com/RISER93-ROBLOX/AfxcaxiRT1/refs/heads/main/Check%20Executor"))()'''

def print_header(cpu, ram, gpu):
    os.system('cls' if os.name == 'nt' else 'clear')
    header = r"""
████████╗██╗  ██╗███████╗██╗ █████╗ ███████╗ █████╗  █████╗    ██████╗ ███████╗     ██╗ █████╗ ██╗███╗  ██╗
╚══██╔══╝╚██╗██╔╝╚════██║██║██╔══██╗╚════██║██╔══██╗██╔══██╗   ██╔══██╗██╔════╝     ██║██╔══██╗██║████╗ ██║
   ██║    ╚███╔╝   ███╔═╝██║██║  ╚═╝  ███╔═╝███████║██║  ╚═╝   ██████╔╝█████╗       ██║██║  ██║██║██╔██╗██║
   ██║    ██╔██╗ ██╔══╝  ██║██║  ██╗██╔══╝  ██╔══██║██║  ██╗   ██╔══██╗██╔══╝  ██╗  ██║██║  ██║██║██║╚████║
   ██║   ██╔╝╚██╗███████╗██║╚█████╔╝███████╗██║  ██║╚█████╔╝   ██║  ██║███████╗╚█████╔╝╚█████╔╝██║██║ ╚███║
   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝ ╚════╝ ╚══════╝╚═╝  ╚═╝ ╚════╝    ╚═╝  ╚═╝╚══════╝ ╚════╝  ╚════╝ ╚═╝╚═╝  ╚══╝            
"""
    print(Fore.LIGHTCYAN_EX + header + Style.RESET_ALL)
    print(Fore.LIGHTMAGENTA_EX + "TxZicZac Community's Discord Is: https://discord.gg/fqNxktESCH" + Style.RESET_ALL)
    print(Fore.LIGHTYELLOW_EX + f"CPU Usage: {cpu}%  RAM Usage: {ram}%  GPU Usage: {gpu}%" + Style.RESET_ALL)

def check_system_cpu_ram_gpu():
    cpu = psutil.cpu_percent(interval=1)  # CPU usage in percentage
    ram = psutil.virtual_memory().percent  # RAM usage in percentage
    gpu = random.randint(0, 100)  # Random GPU usage value (simulated, since psutil doesn't support GPU)
    return cpu, ram, gpu

def detect_and_write_lua_script():
    detected_executors = []

    for executor_name, base_path in executors.items():
        possible_autoexec_paths = [
            os.path.join(base_path, "Autoexec"),
            os.path.join(base_path, "Autoexecute")
        ]

        for path in possible_autoexec_paths:
            lua_script_path = os.path.join(path, "Xero_Executor_Check.lua")  # Lua script path

            if os.path.exists(path): 
                try:
                    with open(lua_script_path, 'w') as file:
                        file.write(lua_script_template)  
                    detected_executors.append(executor_name)
                    break 
                except Exception:
                    pass  

    return detected_executors

def reset_executor_file(username):
    status_file = f"executor_check_{username}.txt"
    
    for executor, base_path in executors.items():
        for workspace_dir in ["workspace", "Workspace"]:
            workspace_path = os.path.join(base_path, workspace_dir)
            if os.path.exists(workspace_path): 
                file_path = os.path.join(workspace_path, status_file)
                if os.path.exists(file_path):
                    try:
                        os.remove(file_path) 
                    except Exception:
                        pass  
                return

def clear_executor_status(username):
    status_file = f"executor_check_{username}.txt"

    for executor, base_path in executors.items():
        for workspace_dir in ["workspace", "Workspace"]:
            workspace_path = os.path.join(base_path, workspace_dir)
            if os.path.exists(workspace_path):  # Valid workspace found
                file_path = os.path.join(workspace_path, status_file)
                if os.path.exists(file_path):
                    try:
                        os.remove(file_path)  
                    except Exception:
                        pass  
                return  

def check_executor_status(username, continuous=False, max_wait_time=240, check_interval=5, max_inactivity_time=30):
    status_file = f"executor_check_{username}.txt"
    retry_timeout = time.time() + max_wait_time 
    active_workspace = None  

    for executor, base_path in executors.items():
        for workspace_dir in ["workspace", "Workspace"]:
            workspace_path = os.path.join(base_path, workspace_dir)
            if os.path.exists(workspace_path):  # Valid workspace found
                active_workspace = workspace_path
                break
        if active_workspace:
            break 

    if not active_workspace:
        return True 

    start_time = time.time()

    while True:
        file_path = os.path.join(active_workspace, status_file)

        if os.path.exists(file_path):
            last_modified_time = os.path.getmtime(file_path)
            current_time = time.time()

            if current_time - last_modified_time < max_inactivity_time:
                with open(file_path, 'r') as f:
                    content = f.read().strip()

                    if content.startswith("working"):
                        return True 

        if not continuous and time.time() > retry_timeout:
            return False  

        if time.time() - start_time >= max_wait_time:
            return False  

        time.sleep(check_interval) 

def create_dynamic_menu(options):
    max_option_length = max(len(option) + 2 for option in options)  # +2 for number and dot
    
    top_border = f"{Fore.LIGHTCYAN_EX}╔{'═' * (max_option_length + 4)}╗"
    bottom_border = f"╚{'═' * (max_option_length + 4)}╝{Style.RESET_ALL}"
    menu_content = [f"{Fore.LIGHTCYAN_EX}║ {Fore.LIGHTMAGENTA_EX}{i+1}{Fore.LIGHTCYAN_EX}. {option.ljust(max_option_length)} ║" 
                    for i, option in enumerate(options)]
    
    print(top_border)
    for line in menu_content:
        print(line)
    print(bottom_border)

def create_dynamic_table(headers, rows):
    # Calculate the width of each column dynamically
    col_widths = [max(len(str(item)) for item in col) for col in zip(headers, *rows)]
    
    # Create the top, middle, and bottom borders
    top_border = f"{Fore.LIGHTCYAN_EX}╔" + "╦".join("═" * (width + 2) for width in col_widths) + "╗"
    middle_border = "╠" + "╬".join("═" * (width + 2) for width in col_widths) + "╣"
    bottom_border = f"╚" + "╩".join("═" * (width + 2) for width in col_widths) + "╝" + Style.RESET_ALL

    # Create the header row
    header_row = "║ " + " ║ ".join(header.ljust(col_widths[i]) for i, header in enumerate(headers)) + " ║"

    # Create the data rows
    data_rows = ["║ " + " ║ ".join(str(row[i]).ljust(col_widths[i]) for i in range(len(headers))) + " ║"
                 for row in rows]

    # Print the table
    print(top_border)
    print(header_row)
    print(middle_border)
    for row in data_rows:
        print(row)
    print(bottom_border) 

def handle_exit_signal(signum, frame):
    print(Fore.YELLOW + "Shutting down gracefully..." + Style.RESET_ALL)
    save_cache()  # Save the cache
    stop_event.set()  # Signal threads to stop
    stop_webhook()  # Stop the webhook thread
    if webhook_thread and webhook_thread.is_alive():
        webhook_thread.join()  # Ensure webhook thread is terminated
    exit(0)

def update_status_table(package_statuses):
    cpu, ram, gpu = check_system_cpu_ram_gpu() 
    print_header(cpu, ram, gpu)  

    headers = ["Package", "Username", "Status"]
    status_width = 30  # Fixed width for the Status column
    
    # Calculate the width of the Package and Username columns dynamically
    col_widths = [
        max(len(headers[0]), max(len(str(package)) for package in package_statuses.keys())) + 2,
        max(len(headers[1]), max(len(str(info.get("Username", "Unknown"))) for info in package_statuses.values())) + 2,
        status_width  # Fixed width for Status
    ]
    
    # Create the top, middle, and bottom borders
    top_border = f"{Fore.LIGHTCYAN_EX}╔" + "╦".join("═" * width for width in col_widths) + "╗"
    middle_border = "╠" + "╬".join("═" * width for width in col_widths) + "╣"
    bottom_border = f"╚" + "╩".join("═" * width for width in col_widths) + "╝" + Style.RESET_ALL

    # Create the header row
    header_row = "║ " + " ║ ".join(header.ljust(col_widths[i] - 1) for i, header in enumerate(headers)) + " ║"
    
    # Create the data rows with the fixed width for the Status column
    data_rows = []
    for package, info in package_statuses.items():
        row = [
            str(package).ljust(col_widths[0] - 1),
            str(info.get("Username", "Unknown")).ljust(col_widths[1] - 1),
            str(info.get("Status", "")).ljust(col_widths[2] - 1)  # Fixed width for Status
        ]
        data_rows.append("║ " + " ║ ".join(row) + " ║")
    
    # Print the table
    print(top_border)
    print(header_row)
    print(middle_border)
    for row in data_rows:
        print(row)
    print(bottom_border)

def make_request(url, headers):
    try:
        response = requests.get(url, headers=headers)
        response.raise_for_status()
        return response
    except requests.RequestException as e:
        print(Fore.RED + f"Request failed: {e}" + Style.RESET_ALL)
        return None

def verify_cookie(cookie_value):
    headers = {
        'Cookie': f'.ROBLOSECURITY={cookie_value}',
        'User-Agent': 'Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Mobile Safari/537.36',
        'Referer': 'https://www.roblox.com/',
        'Origin': 'https://www.roblox.com',
        'Accept-Language': 'en-US,en;q=0.9',
        'Accept-Encoding': 'gzip, deflate, br',
        'Connection': 'keep-alive'
    }
    
    time.sleep(1) 
    response = make_request('https://users.roblox.com/v1/users/authenticated', headers)
    
    if not response:
        return False
    
    if response.status_code == 200:
        print(Fore.LIGHTGREEN_EX + "Cookie Is Valid, User Has Been Authenticated." + Style.RESET_ALL)
        return True
    elif response.status_code == 401:
        print(Fore.LIGHTRED_EX + "Cookie Is Invalid, User Not Authenticated!" + Style.RESET_ALL)
        return False
    else:
        print(Fore.LIGHTRED_EX + f"An Error Occurred While Verifying Cookies, Status Code Is: {response.status_code} And: {response.text}" + Style.RESET_ALL)
        return False

def download_file(url, destination, binary=False):
    response = make_request(url, {})
    
    if response and response.status_code == 200:
        mode = 'wb' if binary else 'w'
        with open(destination, mode) as file:
            if binary:
                shutil.copyfileobj(response.raw, file)
            else:
                file.write(response.text)
        print(Fore.LIGHTGREEN_EX + f"File: {os.path.basename(destination)} Has Been Downloaded Successfully." + Style.RESET_ALL)
        return destination
    print(Fore.LIGHTRED_EX + f"An Error Occurred While Downloading File: {os.path.basename(destination)}!" + Style.RESET_ALL)
    return None

def replace_cookie_value_in_db(db_path, new_cookie_value):
    try:
        with sqlite3.connect(db_path) as conn:
            cursor = conn.cursor()

            cursor.execute("""SELECT COUNT(*) FROM cookies WHERE host_key = '.roblox.com' AND name = '.ROBLOSECURITY'""")
            cookie_exists = cursor.fetchone()[0]

            if cookie_exists:
                cursor.execute("""
                    UPDATE cookies
                    SET value = ?, last_access_utc = ?, expires_utc = ?
                    WHERE host_key = '.roblox.com' AND name = '.ROBLOSECURITY'
                """, (new_cookie_value, int(time.time() * 1000000), 99999999999999999))
            else:
                cursor.execute("""
                    INSERT INTO cookies (creation_utc, host_key, name, value, path, expires_utc, is_secure, is_httponly, last_access_utc)
                    VALUES (?, '.roblox.com', '.ROBLOSECURITY', ?, '/', 99999999999999999, 0, 0, ?)
                """, (int(time.time() * 1000000), new_cookie_value, int(time.time() * 1000000)))
            conn.commit()
        print(Fore.GREEN + "Cookie value replaced successfully in the database!" + Style.RESET_ALL)
    except sqlite3.OperationalError as e:
        print(Fore.RED + f"Database error during cookie replacement: {e}" + Style.RESET_ALL)
    except Exception as e:
        print(Fore.RED + f"Error replacing cookie value in database: {e}" + Style.RESET_ALL)

def inject_cookies_and_appstorage():
    db_url = "https://github.com/shirooscripts/auto-rj/raw/main/Cookies"  # Binary
    appstorage_url = "https://raw.githubusercontent.com/shirooscripts/auto-rj/main/appStorage.json"  # JSON

    downloaded_db_path = download_file(db_url, "Cookies.db", binary=True)
    downloaded_appstorage_path = download_file(appstorage_url, "appStorage.json", binary=False)

    if not downloaded_db_path or not downloaded_appstorage_path:
        print(Fore.RED + "Failed to download necessary files. Exiting." + Style.RESET_ALL)
        return

    cookie_txt_path = os.path.join(os.getcwd(), "cookie.txt")
    
    if not os.path.exists(cookie_txt_path):
        print(Fore.RED + "cookie.txt not found in the current directory!" + Style.RESET_ALL)
        return

    cookies = []
    with open(cookie_txt_path, "r") as file:
        for line in file:
            parts = line.strip().split(":")
            if len(parts) == 3:
                name, password, cookie = parts
                cookies.append((name, password, cookie))
            else:
                print(Fore.RED + f"Invalid line format in cookie.txt: {line.strip()}. Skipping..." + Style.RESET_ALL)

    if not cookies:
        print(Fore.RED + "No valid cookies found in cookie.txt. Please add valid cookies." + Style.RESET_ALL)
        return

    packages = get_roblox_packages()

    if len(cookies) > len(packages):
        print(Fore.RED + "More cookies than packages. Ensure each cookie corresponds to a package." + Style.RESET_ALL)
        return

    for idx, package_name in enumerate(packages):
        try:
            if idx < len(cookies):
                name, password, cookie = cookies[idx]
                
                print(Fore.YELLOW + f"Verifying cookie for {package_name}..." + Style.RESET_ALL)
                if not verify_cookie(cookie):
                    print(Fore.RED + f"Cookie for {package_name} is invalid. Skipping..." + Style.RESET_ALL)
                    continue
                
                print(Fore.GREEN + f"Injecting cookie for {package_name}." + Style.RESET_ALL)
                destination_db_dir = f"/data/data/{package_name}/app_webview/Default/"
                destination_appstorage_dir = f"/data/data/{package_name}/files/appData/LocalStorage/"
                
                os.makedirs(destination_db_dir, exist_ok=True)
                os.makedirs(destination_appstorage_dir, exist_ok=True)

                shutil.copyfile(downloaded_db_path, os.path.join(destination_db_dir, "Cookies"))
                shutil.copyfile(downloaded_appstorage_path, os.path.join(destination_appstorage_dir, "appStorage.json"))

                replace_cookie_value_in_db(os.path.join(destination_db_dir, "Cookies"), cookie)
                
                print(Fore.YELLOW + f"Verifying cookie after injection for {package_name}..." + Style.RESET_ALL)
                verify_cookie(cookie)

        except Exception as e:
            print(Fore.RED + f"Error injecting cookie for {package_name}: {e}" + Style.RESET_ALL)

    print(Fore.GREEN + "Cookie and appStorage injection completed for all packages." + Style.RESET_ALL)

def get_roblox_packages():
    packages = []
    suffixes = list(string.ascii_lowercase + string.digits)
    
    for suffix in suffixes:
        package_name = f"com.roblox.clien{suffix}"
        if os.system(f"pm list packages | grep -q '{package_name}'") == 0:
            print(Fore.LIGHTGREEN_EX + f"Package Found On Your Device Is: {package_name}" + Style.RESET_ALL)
            packages.append(package_name)
    
    return packages

def capture_screenshot():
    current_dir = "/data/data/com.termux/files/home"
    screenshots_dir = os.path.join(current_dir, "screenshots")
    os.makedirs(screenshots_dir, exist_ok=True)
    screenshot_path = os.path.join(screenshots_dir, "screenshot.png")

    if shutil.which("screencap") is None:
        print(Fore.RED + "An Error Occurred While Running The Code To Take A Screenshot!" + Style.RESET_ALL)
        return ""

    result = subprocess.run(["screencap", "-p", screenshot_path], capture_output=True)

    if result.returncode != 0 or not os.path.exists(screenshot_path):
        print(Fore.RED + "An Error Occurred While Taking Screenshot!" + Style.RESET_ALL)
        return ""

    return screenshot_path

def get_system_info():
    cpu_usage = psutil.cpu_percent(interval=1)
    memory_info = psutil.virtual_memory()
    uptime = time.time() - psutil.boot_time()

    system_info = {
        "cpu_usage": cpu_usage,
        "memory_total": memory_info.total,
        "memory_available": memory_info.available,
        "memory_used": memory_info.used,
        "uptime": uptime
    }
    
    return system_info

def load_config():
    global webhook_url, device_name, interval
    if os.path.exists(CONFIG_FILE):
        with open(CONFIG_FILE, "r") as file:
            config = json.load(file)
            webhook_url = config.get("webhook_url")
            device_name = config.get("device_name")
            interval = config.get("interval")
    else:
        webhook_url = None
        device_name = None
        interval = None

def save_config():
    config = {
        "webhook_url": webhook_url,
        "device_name": device_name,
        "interval": interval
    }
    with open(CONFIG_FILE, "w") as file:
        json.dump(config, file)

def start_webhook_thread():
    global webhook_thread, stop_webhook_thread
    if webhook_thread is None or not webhook_thread.is_alive():
        stop_webhook_thread = False
        webhook_thread = threading.Thread(target=send_webhook)
        webhook_thread.start()

def count_roblox_processes():
    count = 0
    for proc in psutil.process_iter(['name']):
        if 'roblox' in proc.info['name'].lower():
            count += 1
    return count

def send_webhook():
    global stop_webhook_thread

    while not stop_webhook_thread:
        screenshot_path = capture_screenshot()

        if not screenshot_path or not os.path.exists(screenshot_path):
            print(Fore.RED + "An Error Occurred While Taking Screenshot!" + Style.RESET_ALL)
            continue

        system_info = get_system_info()
        roblox_process_count = count_roblox_processes()

        embed = {
            "title": f"System Information Of {device_name}",
            "color": 15258703,
            "fields": [
                {"name": "Device Name", "value": device_name, "inline": True},
                {"name": "CPU Usage", "value": f"{system_info['cpu_usage']}%", "inline": True},
                {"name": "Memory Used", "value": f"{(system_info['memory_used'] / system_info['memory_total']) * 100:.2f}%", "inline": True},
                {"name": "Memory Available", "value": f"{(system_info['memory_available'] / system_info['memory_total']) * 100:.2f}%", "inline": True},
                {"name": "Total Memory", "value": f"{system_info['memory_total'] / (1024 ** 3):.2f} GB", "inline": True},
                {"name": "Uptime", "value": f"{system_info['uptime'] / 3600:.2f} giờ", "inline": True},
                {"name": "Number Of Roblox Games On Device", "value": f"{roblox_process_count}", "inline": True}
            ],
            "image": {
                "url": "attachment://screenshot.png"
            }
        }

        payload = {
            "embeds": [embed],
            "username": "TxZicZac Community",  
            "avatar_url": "" 
        }

        try:
            with open(screenshot_path, "rb") as file:
                response = requests.post(
                    webhook_url,
                    data={"payload_json": json.dumps(payload)},
                    files={"file": ("screenshot.png", file)}
                )

            if response.status_code not in [200, 204]:
                print(Fore.RED + f"Failed to send webhook, status code: {response.status_code}" + Style.RESET_ALL)

        except Exception as e:
            print(Fore.RED + f"Exception occurred: {e}" + Style.RESET_ALL)

        try:
            os.remove(screenshot_path)
        except Exception as e:
            print(Fore.RED + f"Error deleting screenshot: {e}" + Style.RESET_ALL)

        time.sleep(interval * 60)

def stop_webhook():
    global stop_webhook_thread
    stop_webhook_thread = True

def setup_webhook():
    global webhook_url, device_name, interval, stop_webhook_thread

    stop_webhook_thread = True 

    webhook_url = input(Fore.CYAN + "Please Enter Your Webhook URL: " + Style.RESET_ALL)
    device_name = input(Fore.CYAN + "Please Enter Device Name: " + Style.RESET_ALL) 
    interval = int(input(Fore.CYAN + "Please Enter Sending Time Range (Minutes): " + Style.RESET_ALL))

    save_config()  

    stop_webhook_thread = False
    start_webhook_thread()

def is_roblox_running(package_name):
    for proc in psutil.process_iter(['name']):
        if package_name in proc.info['name'].lower():
            return True
    return False

def kill_roblox_processes():
    print("Killing all Roblox processes...")
    package_names = get_roblox_packages()
    for package_name in package_names:
        print(f"Trying to kill process for package: {package_name}")
        os.system(f"pkill -f {package_name}")
    time.sleep(1) 

def kill_roblox_process(package_name):
    print(f"Killing Roblox process for {package_name}...")
    os.system(f"pkill -f {package_name}")
    time.sleep(1) 

def launch_roblox(package_name, server_link, num_packages, package_statuses):
    try:
        package_statuses[package_name]["Status"] = Fore.LIGHTCYAN_EX + f"Opening Roblox for {package_name}..." + Style.RESET_ALL
        update_status_table(package_statuses)

        commands = [
            (['am', 'start', '-n', f'{package_name}/com.roblox.client.startup.ActivitySplash', '-d', server_link], 1),
            (['am', 'start', '-n', f'{package_name}/com.roblox.client.ActivityProtocolLaunch', '-d', server_link], 11)
        ]
        
        for command, sleep_time in commands:
            subprocess.run(command, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
            time.sleep(sleep_time)
        
        package_statuses[package_name]["Status"] = Fore.GREEN + "Joined Roblox" + Style.RESET_ALL
        update_status_table(package_statuses)

    except Exception as e:
        package_statuses[package_name]["Status"] = Fore.RED + f"Error launching Roblox for {package_name}: {e}" + Style.RESET_ALL
        update_status_table(package_statuses)
        print(f"Error details: {e}")

def check_executor_and_rejoin(package_name, username, package_statuses, server_link, num_packages, accounts):
    try:
        detected_executors = detect_and_write_lua_script()

        if detected_executors:
            print(f"Checking executor status for {package_name} with username {username}...")

            # Keep checking for the executor status, up to 2 minutes (every 10 seconds)
            start_time = time.time()
            executor_loaded = False
            while time.time() - start_time < 120:  # 2 minutes timeout
                if check_executor_status(username):
                    package_statuses[package_name]["Status"] = Fore.GREEN + f"Executor loaded successfully for {username}" + Style.RESET_ALL
                    executor_loaded = True
                    break
                time.sleep(10)

            # If executor didn't load within the timeout, rejoin
            if not executor_loaded:
                print(f"Executor did not load for {package_name} (username: {username}). Rejoining...")
                package_statuses[package_name]["Status"] = Fore.RED + "Executor failed, rejoining..." + Style.RESET_ALL
                update_status_table(package_statuses)

                # Rejoin by killing the current Roblox process and relaunching
                kill_roblox_process(package_name)
                time.sleep(2)
                launch_roblox(package_name, server_link, num_packages, package_statuses)
                check_executor_and_rejoin(package_name, username, package_statuses, server_link, num_packages, accounts)
        else:
            # No executor was detected; proceed without rejoining
            print(f"No executor detected for {package_name} (username: {username}).")
            package_statuses[package_name]["Status"] = Fore.GREEN + f"Joined without executor for {username}" + Style.RESET_ALL
            update_status_table(package_statuses)

        monitor_thread = threading.Thread(target=background_executor_monitor, args=(package_name, username, package_statuses, server_link, num_packages))
        monitor_thread.daemon = True  # Ensures the thread closes when the main program exits
        monitor_thread.start()

    except Exception as e:
        package_statuses[package_name]["Status"] = Fore.RED + f"Error checking executor for {package_name}: {e}" + Style.RESET_ALL
        update_status_table(package_statuses)

def background_executor_monitor(package_name, username, package_statuses, server_link, num_packages, retry_limit=3):
    retry_count = 0

    try:
        while True:
            # Periodically check the executor status every 10 seconds
            if not check_executor_status(username, continuous=False):
                # Increment retry count
                retry_count += 1
                package_statuses[package_name]["Status"] = Fore.RED + "Executor failed, rejoining..." + Style.RESET_ALL
                update_status_table(package_statuses)
                
                # Check if retry limit reached to prevent endless rejoining
                if retry_count >= retry_limit:
                    package_statuses[package_name]["Status"] = Fore.RED + "Reached retry limit, stopping rejoin attempts..." + Style.RESET_ALL
                    update_status_table(package_statuses)
                    break

                # Acquire lock to ensure only one Roblox process is relaunched at a time
                with rejoin_lock:
                    # Rejoin by killing the current Roblox process and relaunching
                    kill_roblox_process(package_name)
                    time.sleep(5)  # Grace period before relaunching
                    launch_roblox(package_name, server_link, num_packages, package_statuses)
                    
                    # Wait another 30 seconds before checking executor status after relaunch
                    time.sleep(120)

                # Check the executor status again after relaunch
                if check_executor_status(username, continuous=False):
                    # Reset retry count if executor successfully loaded
                    retry_count = 0
                    package_statuses[package_name]["Status"] = Fore.GREEN + "Executor reloaded successfully after rejoin." + Style.RESET_ALL
                    update_status_table(package_statuses)
                else:
                    package_statuses[package_name]["Status"] = Fore.RED + "Executor still failed after rejoin, retrying..." + Style.RESET_ALL
                    update_status_table(package_statuses)

            # Wait before the next check
            time.sleep(30)
    except Exception as e:
        package_statuses[package_name]["Status"] = Fore.RED + f"Error in background monitor: {e}" + Style.RESET_ALL
        update_status_table(package_statuses)

def get_game_name(game_link_or_id):
    try:
        # Extract the game ID from the link if it's a URL
        if 'roblox.com' in game_link_or_id:
            game_id = game_link_or_id.split('/')[-1]
        else:
            game_id = game_link_or_id

        # Make a request to the Roblox API to get game details
        url = f"https://games.roblox.com/v1/games?universeIds={game_id}"
        response = requests.get(url, timeout=10)
        if response.status_code == 200:
            game_data = response.json()
            if game_data['data']:
                return game_data['data'][0]['name']
            else:
                return "Unknown Game"
        else:
            return "Failed to retrieve game name"
    except Exception as e:
        print(Fore.RED + f"Error retrieving game name: {e}" + Style.RESET_ALL)
        return "Error"
        
# Function to format server link
def format_server_link(input_link):
    if 'roblox.com' in input_link:
        return input_link
    elif input_link.isdigit():
        return f'roblox://placeID={input_link}'
    else:
        print(Fore.RED + "Invalid input! Please enter a valid game ID or private server link." + Style.RESET_ALL)
        return None

# Function to save server links to file
def save_server_links(server_links):
    with open(SERVER_LINKS_FILE, "w") as file:
        for package, link in server_links:
            file.write(f"{package},{link}\n")

# Function to load server links from file
def load_server_links():
    server_links = []
    if os.path.exists(SERVER_LINKS_FILE):
        with open(SERVER_LINKS_FILE, "r") as file:
            for line in file:
                package, link = line.strip().split(",", 1)
                server_links.append((package, link))
    return server_links

# Function to save accounts to file
def save_accounts(accounts):
    with open(ACCOUNTS_FILE, "w") as file:
        for package, user_id in accounts:
            file.write(f"{package},{user_id}\n")

# Function to load accounts from file
def load_accounts():
    accounts = []
    if os.path.exists(ACCOUNTS_FILE):
        with open(ACCOUNTS_FILE, "r") as file:
            for line in file:
                package, user_id = line.strip().split(",", 1)
                accounts.append((package, user_id))
    return accounts

# Function to find UserId from file
def find_userid_from_file(file_path):
    try:
        with open(file_path, 'r') as file:
            content = file.read()
            # Debugging information removed to keep console clean

            userid_start = content.find('"UserId":"')
            if userid_start == -1:
                print("Userid not found")
                return None

            userid_start += len('"UserId":"')
            userid_end = content.find('"', userid_start)
            if userid_end == -1:
                print("Userid end quote not found")
                return None

            userid = content[userid_start:userid_end]
            return userid

    except IOError as e:
        print(f"Error reading file: {e}")
        return None

# Asynchronous function to get user ID from username
async def get_user_id(username):
    url = "https://users.roblox.com/v1/usernames/users"
    payload = {
        "usernames": [username],
        "excludeBannedUsers": True
    }
    headers = {
        "Content-Type": "application/json"
    }

    async with aiohttp.ClientSession() as session:
        async with session.post(url, json=payload, headers=headers) as response:
            data = await response.json()
            if 'data' in data and len(data['data']) > 0:
                return data['data'][0]['id']
    return None

def get_server_link(package_name, server_links):
    return next((link for pkg, link in server_links if pkg == package_name), None)

def get_username_from_id(user_id):
    return get_username(user_id) or user_id
    
# Function to get username from user ID
def get_username(user_id):
    retry_attempts = 2
    for attempt in range(retry_attempts):
        try:
            url = f"https://users.roblox.com/v1/users/{user_id}"
            response = requests.get(url, timeout=10)
            response.raise_for_status()
            data = response.json()
            username = data.get("name", "Unknown")
            if username != "Unknown":
                username_cache[user_id] = username
                save_username(user_id, username)
                return username
        except requests.exceptions.RequestException as e:
            print(Fore.RED + f"Attempt {attempt + 1} failed for Roblox Users API: {e}" + Style.RESET_ALL)
            time.sleep(2 ** attempt)  # Exponential backoff

    # Fallback to RoProxy API
    for attempt in range(retry_attempts):
        try:
            url = f"https://users.roproxy.com/v1/users/{user_id}"
            response = requests.get(url, timeout=10)
            response.raise_for_status()
            data = response.json()
            username = data.get("name", "Unknown")
            if username != "Unknown":
                username_cache[user_id] = username
                save_username(user_id, username)
                return username
        except requests.exceptions.RequestException as e:
            print(Fore.RED + f"Attempt {attempt + 1} failed for RoProxy API: {e}" + Style.RESET_ALL)
            time.sleep(2 ** attempt)  # Exponential backoff

    return "Unknown"

# Example of saving the username in a persistent storage
def save_username(user_id, username):
    try:
        if not os.path.exists("usernames.json"):
            with open("usernames.json", "w") as file:
                json.dump({user_id: username}, file)
        else:
            with open("usernames.json", "r+") as file:
                try:
                    data = json.load(file)
                except json.JSONDecodeError:
                    data = {}
                data[user_id] = username
                file.seek(0)
                json.dump(data, file)
                file.truncate()
    except (IOError, json.JSONDecodeError) as e:
        print(Fore.RED + f"Error saving username: {e}" + Style.RESET_ALL)

# Example of loading the username from persistent storage
def load_saved_username(user_id):
    try:
        with open("usernames.json", "r") as file:
            data = json.load(file)
            return data.get(user_id)
    except (FileNotFoundError, json.JSONDecodeError, IOError) as e:
        print(Fore.RED + f"Error loading username: {e}" + Style.RESET_ALL)
        return None
    
def load_cache():
    global username_cache
    if os.path.exists(CACHE_FILE):
        with open(CACHE_FILE, "r") as f:
            username_cache = json.load(f)

def save_cache():
    try:
        temp_file = CACHE_FILE + ".tmp"
        with open(temp_file, "w") as f:
            json.dump(username_cache, f)
        os.replace(temp_file, CACHE_FILE)  # Atomic move to replace the file
    except IOError as e:
        print(Fore.RED + f"Error saving cache: {e}" + Style.RESET_ALL)

def check_user_online(user_id):
    max_retries = 3
    delay = 2

    session = requests.Session()
    primary_url = "https://presence.roblox.com/v1/presence/users"
    headers = {'Content-Type': 'application/json'}
    body = json.dumps({"userIds": [user_id]})

    for attempt in range(max_retries):
        try:
            primary_response = session.post(primary_url, headers=headers, data=body, timeout=7)
            primary_response.raise_for_status()  # Kiểm tra mã trạng thái HTTP
            primary_data = primary_response.json()

            user_presence = primary_data["userPresences"][0]
            primary_presence_type = user_presence["userPresenceType"]
            primary_last_location = user_presence.get("lastLocation", None)

            if primary_last_location == "Website":
                print(Fore.YELLOW + f"{user_id} is currently on the Website. Rejoin recommended." + Style.RESET_ALL)
                primary_presence_type = 0  # Set presence type to offline to trigger a rejoin

            return primary_presence_type, primary_last_location

        except requests.exceptions.RequestException as e:
            print(Fore.RED + f"Error checking online status for user {user_id} (Attempt {attempt + 1}): {e}" + Style.RESET_ALL)
            if attempt < max_retries - 1:
                time.sleep(delay)
                delay *= 2  
            else:
                return None, None

def get_hwid_file_path(package_name):
    directory = f"/data/data/{package_name}/app_assets/content/"
    try:
        files = [f for f in os.listdir(directory) if os.path.isfile(os.path.join(directory, f))]

        if not files:
            print(Fore.RED + "No files found in the specified directory." + Style.RESET_ALL)
            return None

        last_file = files[-1]
        hwid_file_path = os.path.join(directory, last_file)
        return hwid_file_path
            
    except Exception as e:
        print(Fore.RED + f"Error retrieving HWID file path: {e}" + Style.RESET_ALL)
        return None

def get_hwid(package_name):
    hwid_file_path = get_hwid_file_path(package_name)
    
    if hwid_file_path is None:
        return None, None  

    try:
        with open(hwid_file_path, "r") as file:
            hwid = file.read().strip()
            print(Fore.GREEN + f"Hwid Found In Your Device, That Is: {hwid}" + Style.RESET_ALL)
            return hwid, hwid_file_path  
            
    except Exception as e:
        print(Fore.RED + f"An Error Occurred While Retrieving Your Hwid!" + Style.RESET_ALL)
        return None, None  

def edit_hwid_file(hwid_file_path):
    try:
        with open(hwid_file_path, 'r') as file:
            content = file.read().strip()
        
        print(Fore.YELLOW + f"Current HWID Content: {content}" + Style.RESET_ALL)
        
        new_content = input(Fore.CYAN + "Please Enter The Hwid You Want To Adjust To Same Hwid In Fluxus Executr On Your Device(Press Enter To Keep The Old Hwid): " + Style.RESET_ALL)
        
        if new_content.strip(): 
            with open(hwid_file_path, 'w') as file:
                file.write(new_content.strip())
            print(Fore.GREEN + f"Hwid Has Been Successfully Edited As You Want And Now It Is Same Hwid: {new_content}" + Style.RESET_ALL)
        else:
            print(Fore.RED + "Hwid Unedited In Fluxus Executor" + Style.RESET_ALL)
            
    except Exception as e:
        print(Fore.RED + f"An Error Occurred While Editing Hwid For Fluxus On Your Device!" + Style.RESET_ALL)
        return None

def create_check_file():
    try:
        directories = [
            "/storage/emulated/0/Fluxus/Autoexec",
            "/storage/emulated/0/Codex/Autoexec",
            "/storage/emulated/0/Arceus X/Autoexec",
            "/storage/emulated/0/Delta/Autoexecute",
            "/storage/emulated/0/Cryptic/Autoexecute",
            "/storage/emulated/0/VegaX/Autoexec"
        ]
        
        webhook = input(Fore.CYAN + "Please Enter Your Webhook: " + Style.RESET_ALL)
        time = input(Fore.CYAN + "Please Enter Time Each Time Sent To Your Webhook(Second): " + Style.RESET_ALL)

        file_content = f'''getgenv().Time = {time}
getgenv().Webhook = "{webhook}"
loadstring(game:HttpGet("https://pastefy.app/dpe20wYA/raw"))()'''
        for directory in directories:
            if os.path.exists(directory):
                file_path = os.path.join(directory, "XeroHub_CheckFile.txt")
                with open(file_path, "w") as file:
                    file.write(file_content)

    except Exception as e:
        print(f"Error: {e}")

def delete_cache(package_name):
    try:
        cache_dir = f"/data/data/{package_name}/cache"
        if os.path.exists(cache_dir):
            for root, dirs, files in os.walk(cache_dir, topdown=False):
                for file in files:
                    os.remove(os.path.join(root, file))
                for dir in dirs:
                    os.rmdir(os.path.join(root, dir))
            os.rmdir(cache_dir)  # Delete the cache directory after removing all files and subdirectories
            print(Fore.GREEN + f"Deleted cache directory for {package_name}" + Style.RESET_ALL)
        else:
            print(Fore.YELLOW + f"Cache directory not found for {package_name}" + Style.RESET_ALL)
    except Exception as e:
        print(Fore.RED + f"Error deleting cache for {package_name}: {e}" + Style.RESET_ALL)

def delete_cookie_from_db(db_path):
    try:
        conn = sqlite3.connect(db_path)
        cursor = conn.cursor()

        cursor.execute("""DELETE FROM cookies WHERE host_key = '.roblox.com' AND name = '.ROBLOSECURITY'""")
        conn.commit()
        conn.close()
        print(Fore.GREEN + "Cookie deleted successfully from the database!" + Style.RESET_ALL)

    except sqlite3.OperationalError as e:
        print(Fore.RED + f"Database error during cookie deletion: {e}" + Style.RESET_ALL)
    except Exception as e:
        print(Fore.RED + f"Error deleting cookie from database: {e}" + Style.RESET_ALL)

def delete_cookie_from_storage(package_name):
    try:
        destination_db_dir = f"/data/data/{package_name}/app_webview/Default/"
        destination_appstorage_dir = f"/data/data/{package_name}/files/appData/LocalStorage/"

        if os.path.exists(destination_db_dir):
            db_file_path = os.path.join(destination_db_dir, "Cookies")
            if os.path.exists(db_file_path):
                os.remove(db_file_path)
                print(Fore.GREEN + f"Deleted Cookies file from {destination_db_dir}" + Style.RESET_ALL)

        if os.path.exists(destination_appstorage_dir):
            appstorage_file_path = os.path.join(destination_appstorage_dir, "appStorage.json")
            if os.path.exists(appstorage_file_path):
                os.remove(appstorage_file_path)
                print(Fore.GREEN + f"Deleted appStorage file from {destination_appstorage_dir}" + Style.RESET_ALL)

        delete_cache(package_name)

    except Exception as e:
        print(Fore.RED + f"Error deleting cookie files from storage for {package_name}: {e}" + Style.RESET_ALL)

def logout_all_packages():
    packages = get_roblox_packages()  
    if not packages:
        print(Fore.RED + "Roblox Game Not Found On Your Device!" + Style.RESET_ALL)
        return

    print(Fore.GREEN + "Available Roblox Package: " + Style.RESET_ALL)
    for idx, package in enumerate(packages, 1):
        print(f"{idx}. {package}")
    
    print(Fore.CYAN + "Please Enter Number In List Or Write All To Log Out: " + Style.RESET_ALL)
    user_input = input()

    if user_input.lower() == 'all':
        for package_name in packages:
            try:
                print(Fore.YELLOW + f"Account Log Out Process In Progress In Package Is: {package_name}..." + Style.RESET_ALL)
                db_path = f"/data/data/{package_name}/app_webview/Default/Cookies"
                delete_cookie_from_db(db_path)
                delete_cookie_from_storage(package_name)

            except Exception as e:
                print(Fore.RED + f"An Error Occurred While Logging Out Of Account In Package Is: {package_name}, Status Code Is: {e}" + Style.RESET_ALL)

        print(Fore.GREEN + "Logout completed for all packages." + Style.RESET_ALL)

    elif user_input.isdigit():
        package_idx = int(user_input) - 1
        if 0 <= package_idx < len(packages):
            package_name = packages[package_idx]
            try:
                print(Fore.YELLOW + f"Logging out from {package_name}..." + Style.RESET_ALL)
                db_path = f"/data/data/{package_name}/app_webview/Default/Cookies"
                delete_cookie_from_db(db_path)
                delete_cookie_from_storage(package_name)

                print(Fore.GREEN + f"Logout completed for {package_name}." + Style.RESET_ALL)

            except Exception as e:
                print(Fore.RED + f"Error logging out from {package_name}: {e}" + Style.RESET_ALL)
        else:
            print(Fore.RED + "Invalid package number!" + Style.RESET_ALL)
    else:
        print(Fore.RED + "Invalid input! Please enter a valid number or 'All'." + Style.RESET_ALL)

def check_cookie_validity(cookie):
    url = "https://users.roblox.com/v1/users/authenticated"
    headers = {
        "Cookie": f".ROBLOSECURITY={cookie}",
        "User-Agent": "Mozilla/5.0",
        "Content-Type": "application/json"
    }
    
    response = requests.get(url, headers=headers)
    
    if response.status_code == 200:
        print(f"{Fore.GREEN}Cookie is alive!")
        user_data = response.json()
        print(f"Logged in as: {user_data['name']} (User ID: {user_data['id']})")
        return True
    elif response.status_code == 401:
        print(f"{Fore.RED}Cookie is dead or invalid!")
        return False
    else:
        print(f"{Fore.YELLOW}Unexpected response. Status Code: {response.status_code}")
        print(f"Response: {response.text}")
        return False

def check_cookies_from_file(file_path):
    folder_name = "Cookies Checked"
    if not os.path.exists(folder_name):
        os.makedirs(folder_name)
    
    live_file_path = os.path.join(folder_name, 'live.txt')
    dead_file_path = os.path.join(folder_name, 'dead.txt')
    
    if not os.path.exists(file_path):
        print(f"{Fore.RED}File {file_path} doesn't exist. Creating one...")
        with open(file_path, 'w') as file:
            file.write("") 
        print(f"{Fore.GREEN}Created {file_path}. Add cookies in it with 'cookie' format and try again!")
        return
    
    with open(file_path, 'r') as file:
        cookies = file.readlines()

    open(live_file_path, 'w').close()  # Clear live.txt
    open(dead_file_path, 'w').close()  # Clear dead.txt
    
    total_cookies = len(cookies)
    live_cookies = 0
    dead_cookies = 0
    
    for idx, cookie in enumerate(cookies, 1):
        cookie = cookie.strip()
        
        if cookie:  # Ensure the line isn't empty
            print(f"Checking cookie {idx}...")
            
            if check_cookie_validity(cookie):  
                live_cookies += 1
                with open(live_file_path, 'a') as live_file:
                    live_file.write(f"{cookie}\n")
            else:  
                dead_cookies += 1
                with open(dead_file_path, 'a') as dead_file:
                    dead_file.write(f"{cookie}\n")
        else:
            print(f"{Fore.RED}Invalid format in line {idx}. Expected format 'cookie'.")

    print(f"--------------------------------------------------")
    print(f"\n{Fore.CYAN}Total Cookies: {total_cookies}")
    print(f"{Fore.GREEN}Live Cookies: {live_cookies}")
    print(f"{Fore.RED}Dead Cookies: {dead_cookies}")

def extract_error_message(response):
    try:
        return response.json()['errors'][0]['message']
    except:
        return 'Not Found'


def get_userid_from_cookie(session, cookie, userids):
    try:
        response = session.get(
            'https://users.roblox.com/v1/users/authenticated',
            cookies={'.ROBLOSECURITY': cookie},
            timeout=3
        )
        user_data = response.json()
        with lock:
            userids.append(user_data.get('id'))
    except requests.exceptions.RequestException as e:
        print(f"{FAILURE_COLOR}Failed to retrieve user ID: {e}{RESET_COLOR}")


def block_users(session, cookie, userids):
    global successful_blocks, failed_blocks

    try:
        response = session.post(
            'https://auth.roblox.com/v2/login',
            cookies={'.ROBLOSECURITY': cookie},
            timeout=3
        )
        csrf_token = response.headers.get('X-CSRF-TOKEN', '')

        names = session.get(
            'https://users.roblox.com/v1/users/authenticated',
            cookies={'.ROBLOSECURITY': str(cookie).strip()},
            timeout=3
        )
        name = names.json().get('name', 'Not Found')

        for userid in userids:
            try:
                response = session.post(
                    f'https://accountsettings.roblox.com/v1/users/{userid}/block',
                    cookies={'.ROBLOSECURITY': cookie},
                    headers={'X-CSRF-TOKEN': csrf_token},
                    timeout=3
                )

                with lock:
                    if response.status_code == 200:
                        successful_blocks += 1
                        print(f"{SUCCESS_COLOR}✓ SUCCESS: Account '{name}' blocked user with ID {userid}{RESET_COLOR}")
                    else:
                        failed_blocks += 1
                        error_message = extract_error_message(response)
                        print(f"{FAILURE_COLOR}✗ FAILURE: Account '{name}' could not block user with ID {userid}")
                        print(f'    Reason: {error_message}{RESET_COLOR}')

            except requests.exceptions.RequestException as e:
                print(f"{FAILURE_COLOR}Request error: {e}{RESET_COLOR}")

    except requests.exceptions.RequestException as e:
        print(f"{FAILURE_COLOR}Failed to authenticate: {e}{RESET_COLOR}")


def block_worker(cookie, userids):
    with requests.Session() as session:
        block_users(session, cookie, userids)


def user_id_worker(cookie, userids):
    with requests.Session() as session:
        get_userid_from_cookie(session, cookie, userids)


def block_accounts():
    start_time = datetime.now()

    if not os.path.exists('cookie.txt'):
        print(f"{FAILURE_COLOR}Error: 'cookie.txt' file not found!{RESET_COLOR}")
        return

    with open('cookie.txt', 'r') as file:
        cookies = []
        for line in file:
            parts = line.strip().split(':')
            if len(parts) == 4:
                cookies.append(':'.join(parts[2:]))
            else:
                cookies.append(line.strip())

    # Helper to divide cookies into chunks
    def chunkify(lst, chunk_size):
        for i in range(0, len(lst), chunk_size):
            yield lst[i:i + chunk_size]

    cookie_chunks = list(chunkify(cookies, 100))
    userids = []

    for chunk in cookie_chunks:
        userids = []
        threads = []

        for cookie in chunk:
            t = threading.Thread(target=user_id_worker, args=(cookie, userids))
            t.start()
            threads.append(t)

        for t in threads:
            t.join()

        threads = []

        for cookie in chunk:
            t = threading.Thread(target=block_worker, args=(cookie, userids))
            t.start()
            threads.append(t)

        for t in threads:
            t.join()

    end_time = datetime.now()
    elapsed_time = end_time - start_time

    print(f'{SUCCESS_COLOR}Total successful blocks: {successful_blocks}{RESET_COLOR}')
    print(f'{FAILURE_COLOR}Total failed blocks: {failed_blocks}{RESET_COLOR}')
    print(f'Time: {elapsed_time.total_seconds():.2f} seconds. Total cookies: {len(cookies)}')

def main():
    load_config()
    load_cache()

    cpu, ram, gpu = check_system_cpu_ram_gpu()
    print_header(cpu, ram, gpu)
    while True:
        cpu, ram, gpu = check_system_cpu_ram_gpu()
        print_header(cpu, ram, gpu)

        menu_options = [
            "Start Auto Rejoin Roblox Game",
            "Same Game ID Or Private Server Link",
            "Different Private Server Or Game ID",
            "Clear User IDs And/Or Private Server Links",
            "Automatically Set Up User ID For Roblox Games",
            "Automatically Same Hwid For Fluxus",
            "Automatically Send Webhook",
            "Automatically Login Account Using Cookies",
            "Automatically Log Out Of Account In Roblox",
            "Check Item In Blox Fruit Using Webhook",
            "Check Cookie",
            "List",
            "Exit"
        ]

        create_dynamic_menu(menu_options)

        setup_type = input(Fore.LIGHTMAGENTA_EX + "Enter choice: " + Style.RESET_ALL)

        if setup_type == "1":
            while True:
                disable_check_executor = input(Fore.CYAN + "Do You Want to Disable Executor UI Checking? (y/n): " + Style.RESET_ALL).strip().lower()

                if disable_check_executor == "y":
                    server_links = load_server_links()
                    accounts = load_accounts()

                    if not accounts:
                        print(Fore.RED + "No user IDs set up yet! Please set them up before proceeding." + Style.RESET_ALL)
                        continue
                    elif not server_links:
                        print(Fore.RED + "No game ID or private server link set up yet! Please set them up before proceeding." + Style.RESET_ALL)
                        continue

                    try:
                        force_rejoin_interval = int(input("Enter the force rejoin/kill Roblox interval in minutes: ")) * 60
                        if force_rejoin_interval <= 0:
                            raise ValueError("The interval must be a positive integer.")
                    except ValueError as ve:
                        print(Fore.RED + f"Invalid input: {ve}. Please enter a valid interval in minutes." + Style.RESET_ALL)
                        input(Fore.GREEN + "Press Enter to return to the menu..." + Style.RESET_ALL)
                        continue

                    package_statuses = {}
                    for package_name, server_link in server_links:
                        package_statuses[package_name] = {
                            "Status": Fore.LIGHTCYAN_EX + "Initializing" + Style.RESET_ALL,
                            "Username": get_username(accounts[server_links.index((package_name, server_link))][1]),
                        }

                    update_status_table(package_statuses)

                    # Kill Roblox processes and wait for 5 seconds
                    kill_roblox_processes()
                    time.sleep(5)

                    num_packages = len(server_links)

                    for package_name, server_link in server_links:
                        try:
                            package_statuses[package_name]["Status"] = Fore.LIGHTCYAN_EX + "Launching" + Style.RESET_ALL
                            update_status_table(package_statuses)
                            launch_roblox(package_name, server_link, num_packages, package_statuses)
                            package_statuses[package_name]["Status"] = Fore.GREEN + "Joined" + Style.RESET_ALL
                        except Exception as e:
                            print(Fore.RED + f"Error launching Roblox for {package_name}: {e}" + Style.RESET_ALL)
                            package_statuses[package_name]["Status"] = Fore.RED + "Launch failed" + Style.RESET_ALL
                        update_status_table(package_statuses)

                    start_time = time.time()

                    while True:
                        current_time = time.time()

                        try:
                            for package_name, user_id in accounts:
                                try:
                                    server_link = get_server_link(package_name, server_links)
                                    if not server_link:
                                        package_statuses[package_name]["Status"] = Fore.RED + "Server link not found" + Style.RESET_ALL
                                        update_status_table(package_statuses)
                                        continue

                                    username = get_username_from_id(user_id)
                                    presence_type, last_location_current = check_user_online(user_id)

                                    package_statuses[package_name]["Username"] = username

                                    if presence_type == 2:
                                        package_statuses[package_name]["Status"] = Fore.GREEN + "In-Game" + Style.RESET_ALL
                                    else:
                                        if not is_roblox_running(package_name):
                                            package_statuses[package_name]["Status"] = Fore.RED + "Process Crashed, Relaunching" + Style.RESET_ALL
                                            kill_roblox_process(package_name)
                                            time.sleep(2)
                                            launch_roblox(package_name, server_link, num_packages, package_statuses)
                                        else:
                                            if last_location_current == "Website":
                                                package_statuses[package_name]["Status"] = Fore.RED + "On Website, Rejoining" + Style.RESET_ALL
                                                kill_roblox_process(package_name)
                                                time.sleep(2)
                                                launch_roblox(package_name, server_link, num_packages, package_statuses)
                                            else:
                                                package_statuses[package_name]["Status"] = Fore.YELLOW + "Not In-Game, Recently Active" + Style.RESET_ALL

                                    update_status_table(package_statuses)
                                    time.sleep(25)

                                except Exception as e:
                                    print(Fore.RED + f"Error during rejoin process for {package_name}: {e}" + Style.RESET_ALL)
                                    package_statuses[package_name]["Status"] = Fore.RED + "General error" + Style.RESET_ALL
                                    update_status_table(package_statuses)

                            if current_time - start_time >= force_rejoin_interval:
                                print("Force killing Roblox processes due to time limit.")
                                kill_roblox_processes()
                                start_time = current_time
                                print(Fore.YELLOW + "Waiting for 5 seconds before starting the rejoin process..." + Style.RESET_ALL)
                                time.sleep(5)
                                for package_name, server_link in server_links:
                                    try:
                                        package_statuses[package_name]["Status"] = Fore.RED + "Rejoining" + Style.RESET_ALL
                                        update_status_table(package_statuses)
                                        launch_roblox(package_name, server_link, num_packages, package_statuses)

                                        package_statuses[package_name]["Status"] = Fore.GREEN + "Joined" + Style.RESET_ALL
                                    except Exception as e:
                                        print(Fore.RED + f"Error rejoining Roblox for {package_name}: {e}" + Style.RESET_ALL)

                                update_status_table(package_statuses)

                            time.sleep(90)

                        except Exception as e:
                            print(Fore.RED + f"Critical error in auto rejoin loop: {e}" + Style.RESET_ALL)
                            time.sleep(60)
                            continue
                elif disable_check_executor == "n":
                    detect_and_write_lua_script()
                    server_links = load_server_links()
                    accounts = load_accounts()

                    if not accounts:
                        print(Fore.RED + "No user IDs set up yet! Please set them up before proceeding." + Style.RESET_ALL)
                        continue
                    elif not server_links:
                        print(Fore.RED + "No game ID or private server link set up yet! Please set them up before proceeding." + Style.RESET_ALL)
                        continue

                    try:
                        force_rejoin_interval = int(input("Enter the force rejoin/kill Roblox interval in minutes: ")) * 60
                        if force_rejoin_interval <= 0:
                            raise ValueError("The interval must be a positive integer.")
                    except ValueError as ve:
                        print(Fore.RED + f"Invalid input: {ve}. Please enter a valid interval in minutes." + Style.RESET_ALL)
                        input(Fore.GREEN + "Press Enter to return to the menu..." + Style.RESET_ALL)
                        continue

                    if webhook_url and device_name and interval:
                        if webhook_thread is None or not webhook_thread.is_alive():
                            start_webhook_thread()

                    package_statuses = {}
                    for package_name, server_link in server_links:
                        package_statuses[package_name] = {
                            "Status": Fore.LIGHTCYAN_EX + "Initializing" + Style.RESET_ALL,
                            "Username": get_username(accounts[server_links.index((package_name, server_link))][1]),
                        }

                    update_status_table(package_statuses)

                    # Kill Roblox processes and wait for 5 seconds
                    kill_roblox_processes()
                    time.sleep(5)

                    num_packages = len(server_links)

                    for package_name, server_link in server_links:
                        try:
                            package_statuses[package_name]["Status"] = Fore.LIGHTCYAN_EX + "Launching" + Style.RESET_ALL
                            update_status_table(package_statuses)
                            launch_roblox(package_name, server_link, num_packages, package_statuses)
                            package_statuses[package_name]["Status"] = Fore.GREEN + "Joined" + Style.RESET_ALL

                            # Get the username for the executor check
                            username = get_username(accounts[server_links.index((package_name, server_link))][1])

                            # Reset the executor file before checking
                            reset_executor_file(username)

                            # Ensure the tool waits for the executor to load before proceeding to the next package
                            while True:
                                if check_executor_status(username, continuous=False):
                                    package_statuses[package_name]["Status"] = Fore.GREEN + f"Executor loaded successfully for {username}" + Style.RESET_ALL
                                    update_status_table(package_statuses)
                                    break  # Break the loop and proceed to the next package

                                # If the executor failed to load within 2 minutes, rejoin and retry
                                else:
                                    print(f"Executor did not load for {package_name} (username : {username}). Rejoining...")
                                    package_statuses[package_name]["Status"] = Fore.RED + "Executor failed, rejoining..." + Style.RESET_ALL
                                    update_status_table(package_statuses)
                                    kill_roblox_process(package_name)
                                    time.sleep(2)
                                    launch_roblox(package_name, server_link, num_packages, package_statuses)

                        except Exception as e:
                            # Handle subprocess or launch error
                            print(Fore.RED + f"Error launching Roblox for {package_name}: {e}" + Style.RESET_ALL)
                            package_statuses[package_name]["Status"] = Fore.RED + "Launch failed" + Style.RESET_ALL
                        update_status_table(package_statuses)

                    start_time = time.time()

                    while True:
                        current_time = time.time()

                        try:
                            for package_name, user_id in accounts:
                                try:
                                    # Retrieve the correct server_link for the package_name
                                    server_link = get_server_link(package_name, server_links)
                                    if not server_link:
                                        package_statuses[package_name]["Status"] = Fore.RED + "Server link not found" + Style.RESET_ALL
                                        update_status_table(package_statuses)
                                        continue

                                    # Get the username associated with the user ID or fallback to user ID
                                    username = get_username_from_id(user_id)
                                    presence_type, last_location_current = check_user_online(user_id)

                                    package_statuses[package_name]["Username"] = username

                                    if presence_type == 2:
                                        package_statuses[package_name]["Status"] = Fore.GREEN + "In-Game" + Style.RESET_ALL

                                        if not check_executor_status(username, continuous=False):  # If executor isn't detected as working
                                            print(f"Executor did not update for {package_name} (username: {username}). Rejoining...")
                                            package_statuses[package_name]["Status"] = Fore.RED + "Executor failed, rejoining..." + Style.RESET_ALL
                                            update_status_table(package_statuses)
                                            kill_roblox_process(package_name)
                                            time.sleep(2)
                                            launch_roblox(package_name, server_link, num_packages, package_statuses)

                                    else:
                                        if not is_roblox_running(package_name):
                                            package_statuses[package_name]["Status"] = Fore.RED + "Process Crashed, Relaunching" + Style.RESET_ALL
                                            kill_roblox_process(package_name)
                                            time.sleep(2)
                                            launch_roblox(package_name, server_link, num_packages, package_statuses)

                                            # Check executor status after relaunch
                                            if not check_executor_status(username, continuous=False):
                                                print(f"Executor did not load for {package_name} (username: {username}) after relaunch. Rejoining...")
                                                package_statuses[package_name]["Status"] = Fore.RED + "Executor failed, rejoining..." + Style.RESET_ALL
                                                kill_roblox_process(package_name)
                                                time.sleep(2)
                                                launch_roblox(package_name, server_link, num_packages, package_statuses)

                                        else:
                                            if last_location_current == "Website":
                                                package_statuses[package_name]["Status"] = Fore.RED + "On Website, Rejoining" + Style.RESET_ALL
                                                kill_roblox_process(package_name)
                                                time.sleep(2)
                                                launch_roblox(package_name, server_link, num_packages, package_statuses)

                                                # Check executor status after relaunch
                                                if not check_executor_status(username, continuous=False):
                                                    print(f"Executor did not load for {package_name} (username: {username}) after relaunch. Rejoining...")
                                                    package_statuses[package_name]["Status"] = Fore.RED + "Executor failed, rejoining..." + Style.RESET_ALL
                                                    update_status_table(package_statuses)
                                                    kill_roblox_process(package_name)
                                                    time.sleep(2)
                                                    launch_roblox(package_name, server_link, num_packages, package_statuses)

                                                # If executor loaded successfully after relaunch
                                                else:
                                                    package_statuses[package_name]["Status"] = Fore.GREEN + "Executor loaded successfully after rejoin" + Style.RESET_ALL
                                                    update_status_table(package_statuses)
                                            else:
                                                package_statuses[package_name]["Status"] = Fore.YELLOW + "Not In-Game, Recently Active" + Style.RESET_ALL

                                    update_status_table(package_statuses)
                                    time.sleep(25)  # Adjust the delay time as needed

                                except Exception as e:
                                    print(Fore.RED + f"Error during rejoin process for {package_name}: {e}" + Style.RESET_ALL)
                                    package_statuses[package_name]["Status"] = Fore.RED + "General error" + Style.RESET_ALL
                                    update_status_table(package_statuses)

                            if current_time - start_time >= force_rejoin_interval:
                                print("Force killing Roblox processes due to time limit.")
                                kill_roblox_processes()
                                start_time = current_time
                                print(Fore.YELLOW + "Waiting for 5 seconds before starting the rejoin process..." + Style.RESET_ALL)
                                time.sleep(5)
                                for package_name, server_link in server_links:
                                    try:
                                        package_statuses[package_name]["Status"] = Fore.RED + "Rejoining" + Style.RESET_ALL
                                        update_status_table(package_statuses)
                                        launch_roblox(package_name, server_link, num_packages, package_statuses)

                                        # Check executor status after relaunch
                                        if not check_executor_status(username, continuous=False):
                                            print(f"Executor did not load for {package_name} (username: {username}) after rejoin. Rejoining...")
                                            package_statuses[package_name]["Status"] = Fore.RED + "Executor failed, rejoining..." + Style.RESET_ALL
                                            kill_roblox_process(package_name)
                                            time.sleep(2)
                                            launch_roblox(package_name, server_link, num_packages, package_statuses)

                                        package_statuses[package_name]["Status"] = Fore.GREEN + "Joined" + Style.RESET_ALL
                                    except Exception as e:
                                        print(Fore.RED + f"Error rejoining Roblox for {package_name}: {e}" + Style.RESET_ALL)

                                update_status_table(package_statuses)

                            time.sleep(90)

                        except Exception as e:
                            print(Fore.RED + f"Critical error in auto rejoin loop: {e}" + Style.RESET_ALL)
                            time.sleep(60)
                            continue
                else:
                    print(Fore.RED + "Invalid input. Please enter 'yes' or 'no'." + Style.RESET_ALL)
            
        elif setup_type == "2":
            server_link = input("Enter the game ID or private server link: ")
            formatted_link = format_server_link(server_link)

            if formatted_link:
                packages = get_roblox_packages()
                server_links = [(package_name, formatted_link) for package_name in packages]
                save_server_links(server_links)
                print(Fore.GREEN + "Game ID or private server link saved successfully!" + Style.RESET_ALL)
                
            input(Fore.GREEN + "\nPress Enter to exit..." + Style.RESET_ALL)                 

        elif setup_type == "3":
            packages = get_roblox_packages()
            server_links = []

            for package_name in packages:
                server_link = input(f"Enter the game ID or private server link for {package_name}: ")
                formatted_link = format_server_link(server_link)

                if formatted_link:
                    server_links.append((package_name, formatted_link))

            save_server_links(server_links)  
            
            input(Fore.GREEN + "\nPress Enter to exit..." + Style.RESET_ALL) 
            
        elif setup_type == "4":
            clear_choice = input(Fore.GREEN + "What do you want to clear?\n1. Clear User IDs\n2. Clear Server Links\n3. Clear Both\nEnter choice: " + Style.RESET_ALL)

            if clear_choice == "1":
                if os.path.exists(ACCOUNTS_FILE):
                    os.remove(ACCOUNTS_FILE)
                    print(Fore.GREEN + "User IDs cleared successfully!" + Style.RESET_ALL)
                else:
                    print(Fore.YELLOW + f"No such file: '{ACCOUNTS_FILE}' found to clear." + Style.RESET_ALL)

            elif clear_choice == "2":
                if os.path.exists(SERVER_LINKS_FILE):
                    os.remove(SERVER_LINKS_FILE)
                    print(Fore.GREEN + "Server links cleared successfully!" + Style.RESET_ALL)
                else:
                    print(Fore.YELLOW + f"No such file: '{SERVER_LINKS_FILE}' found to clear." + Style.RESET_ALL)

            elif clear_choice == "3":
                if os.path.exists(ACCOUNTS_FILE):
                    os.remove(ACCOUNTS_FILE)
                    print(Fore.GREEN + "User IDs cleared successfully!" + Style.RESET_ALL)
                else:
                    print(Fore.YELLOW + f"No such file: '{ACCOUNTS_FILE}' found to clear." + Style.RESET_ALL)

                if os.path.exists(SERVER_LINKS_FILE):
                    os.remove(SERVER_LINKS_FILE)
                    print(Fore.GREEN + "Server links cleared successfully!" + Style.RESET_ALL)
                else:
                    print(Fore.YELLOW + f"No such file: '{SERVER_LINKS_FILE}' found to clear." + Style.RESET_ALL)
                    
            input(Fore.GREEN + "\nPress Enter to exit..." + Style.RESET_ALL) 
 
        elif setup_type == "5":
            print(Fore.GREEN + "Auto Setup User IDs from each package's appStorage.json..." + Style.RESET_ALL)
            packages = get_roblox_packages()
            accounts = []

            for package_name in packages:
                file_path = f'/data/data/{package_name}/files/appData/LocalStorage/appStorage.json'
                user_id = find_userid_from_file(file_path)
                
                if user_id:
                    accounts.append((package_name, user_id))
                    print(f"Found UserId for {package_name}: {user_id}")
                else:
                    print(Fore.RED + f"UserId not found for {package_name}. Make sure the file path is correct and the format is as expected." + Style.RESET_ALL)

            save_accounts(accounts)
            save_cache()
            print(Fore.GREEN + "User IDs saved from appStorage.json!" + Style.RESET_ALL)

            # Prompt for server link
            server_link = input("Enter the game ID or private server link: ")
            formatted_link = format_server_link(server_link)

            if formatted_link:
                server_links = [(package_name, formatted_link) for package_name in packages]
                save_server_links(server_links)
                print(Fore.GREEN + "Game ID or private server link saved successfully!" + Style.RESET_ALL)
            input(Fore.GREEN + "\nPress Enter to exit..." + Style.RESET_ALL) 
            
        elif setup_type == "6":
            new_hwid = input("Enter the new HWID you want to set for all Fluxus packages: ")

            # Fetch the Fluxus packages
            packages = get_roblox_packages()

            # Iterate over each package and update the HWID
            for package_name in packages:
                hwid_file_path = get_hwid_file_path(package_name)
                if hwid_file_path:
                    try:
                        with open(hwid_file_path, "w") as file:
                            file.write(new_hwid)
                        print(Fore.GREEN + f"HWID for {package_name} successfully updated to {new_hwid}" + Style.RESET_ALL)
                    except Exception as e:
                        print(Fore.RED + f"Error updating HWID for {package_name}: {e}" + Style.RESET_ALL)
                else:
                    print(Fore.RED + f"Failed to find HWID file for {package_name}. Skipping." + Style.RESET_ALL)

            input(Fore.CYAN + "Please Press Enter To Return To The Main Menu..." + Style.RESET_ALL)
            
        elif setup_type == "7":
            setup_webhook()

        elif setup_type == "8":  
            inject_cookies_and_appstorage()

            while True:
                user_input = input(Fore.CYAN + "Do You Want To Block Joining The Game On The Same Server? (y/n): " + Style.RESET_ALL).strip().lower()
               
                if user_input == "y":
                    block_accounts()
                    break
                elif user_input == "n":
                    print(Fore.YELLOW + "You chose not to block join same id." + Style.RESET_ALL)  
                    break
                else:
                    print(Fore.RED + "Invalid input. Please enter 'yes' or 'no'." + Style.RESET_ALL)

            input(Fore.CYAN + "Please Press Enter To Return To The Main Menu..." + Style.RESET_ALL)

        elif setup_type == "9":  
            logout_all_packages()
            input(Fore.CYAN + "Please Press Enter To Return To The Main Menu..." + Style.RESET_ALL)

        elif setup_type == "10": 
            create_check_file()
            input(Fore.CYAN + "Please Press Enter To Return To The Main Menu..." + Style.RESET_ALL)

        elif setup_type == "11": 
            check_cookies_from_file('cookie.txt')
            input(Fore.CYAN + "Please Press Enter To Return To The Main Menu..." + Style.RESET_ALL)
            
        elif setup_type == "12":
            accounts = load_accounts()
            server_links = load_server_links()

            if accounts and server_links:
                headers = ["Account", "Server", "Game ID", "Username"]
                rows = [(package, server, game_id, get_username(game_id)) for (package, game_id), (_, server) in zip(accounts, server_links)]
                create_dynamic_table(headers, rows)
            else:
                print(Fore.RED + "No accounts or server links to display." + Style.RESET_ALL)
            input(Fore.CYAN + "Please Press Enter To Return To The Main Menu..." + Style.RESET_ALL)

        elif setup_type == "13":
            global stop_webhook_thread
            stop_webhook_thread = True  
            break 

if __name__ == "__main__":
    load_cache()  # Load the cache at the start
    main()  # Run the main function
    save_cache()  # Save the cache before exiting
