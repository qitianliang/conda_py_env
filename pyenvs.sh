# install conda in /home/user folder
cd ~
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p miniconda
rm miniconda.sh
echo ". ~/miniconda/etc/profile.d/conda.sh" >> ~/.bashrc
source ~/.bashrc
# change directory into envs folder
cd conda_py_env
for env_file in envs/*.yaml; do
    echo conda create from ${env_file}
    conda env create -f "${env_file}"
    env_name=$(awk -F: '/name/{print$2}' "$env_file" | tr -d '[:blank:]')
    conda activate ${env_name}
    python -m ipykernel install --user --name ${env_name} --display-name "${env_name}"
done