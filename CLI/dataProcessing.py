import pandas as pd


def temporal_data_process(file):
    df = pd.read_csv(file.name)
    df = df.replace("\'", "\\'", regex=True)
    df = df.replace(";", "", regex=True)
    return df
