#!/bin/bash

python3 -m pip install --upgrade pip
python3 -m pip install jupyter nbconvert

python3 -m nbconvert --to notebook --execute --inplace notebooks/ternate.ipynb
python3 -m nbconvert --to notebook --execute --inplace notebooks/mybully.ipynb
python3 -m nbconvert --to notebook --execute --inplace notebooks/cmed.ipynb
python3 -m nbconvert --to notebook --execute --inplace notebooks/goemotions.ipynb
python3 -m nbconvert --to notebook --execute --inplace notebooks/metalearning.ipynb