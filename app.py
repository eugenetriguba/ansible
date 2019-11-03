import subprocess
import distro


system = distro.linux_distribution(full_distribution_name=False)[0]

if system == 'darwin':
    subprocess.call(['./dotfiles/macOS/install.sh'])
elif system == 'ubuntu':
    subprocess.call(['./dotfiles/Ubuntu/install.sh'])
else:
    print(system + " is not supported.")
