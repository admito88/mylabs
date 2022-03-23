import bash
directory = input('Enter full directory name: ')
venv = input('Enter venv name in: ' + directory + '/')
bash.bash('apt upgrade')
bash.bash('apt install software-properties-common apt-transport-https wget htop git net-tools -y')
bash.bash(
    'wget -q https://packagecloud.io/AtomEditor/atom/gpgkey -O- | apt-key add -')
bash.bash(
    'add-apt-repository "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main"')
bash.bash('apt install atom -y')
bash.bash(
    'apt install -y build-essential libssl-dev libffi-dev python3-dev python3.8-venv')
bash.bash('python3 - m pip install "python-lsp-server[all]"')
bash.bash('python3 -m pip install git+https://github.com/tomv564/pyls-mypy.git')
print('Make Dir for venv module')
bash.bash('mkdir ' + directory)
if venv is not None:
    bash.bash('cd ' + directory + ' ; python3 -m venv '
              + venv + ' ; cd ' + directory + venv)
else:
    print('No set venv name')
