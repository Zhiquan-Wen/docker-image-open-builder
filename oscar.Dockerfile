# registry.cn-hongkong.aliyuncs.com/wenzhiquan/oscar_env:1.0

FROM nvcr.io/nvidia/pytorch:20.12-py3

RUN pip install tqdm matplotlib requests scikit-image anytree regex boto3 pyyaml
# RUN pip --no-cache-dir install --force-reinstall -I pyyaml
