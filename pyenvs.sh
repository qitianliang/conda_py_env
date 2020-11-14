for env_file in envs/*.yaml; do
    echo conda create from ${env_file}
    conda env create -f "${env_file}"
    env_name=$(awk -F: '/name/{print$2}' "$env_file" | tr -d '[:blank:]')
    conda activate ${env_name}
    python -m ipykernel install --user --name ${env_name} --display-name "${env_name}_env"
done
conda install -y jupyterlab
ip=0.0.0.0
port=10001
jupyter lab --allow-root --ip ${ip} --port ${port}