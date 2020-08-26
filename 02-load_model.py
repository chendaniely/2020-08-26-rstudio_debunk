from joblib import load
from pyprojroot import here

python_model = load(here("./python_model.joblib"))
test_data = load(here("./test_data.joblib"))
