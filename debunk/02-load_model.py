from joblib import load
from pyprojroot import here

python_model = load(here("./python_model.joblib"))
