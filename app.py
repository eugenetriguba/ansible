import subprocess


def determine_operating_system():
    print("Supported Operating Systems")
    print("1. Ubuntu")
    print("2. macOS")
    os = int(input("OS to setup (number): "))
    
    if os == 1:
        return "ubuntu"
    elif os == 2:
        return "macos"
    else:
        print(f"{os} is not a supported option.")
        

def run_script(path: str):
    subprocess.call([path])


if __name__ == "__main__": 
    os = determine_operating_system()
    run_script(f"./operating_systems/{os}.sh")
